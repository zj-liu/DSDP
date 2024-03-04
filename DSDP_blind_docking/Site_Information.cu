#include "Site_Information.cuh"
static bool _cmp(const int3_float& a, const int3_float& b)
{
	if (a.w > b.w)
	{
		return true;
	}
	else
	{
		return false;
	}
}

void SITE_INFORMATION::Initial(const char* site_npy_name,const int desired_point_numbers, int npy_length)
{
	this->npy_length = npy_length;
	selected_point.clear();
	half_length_of_npy_box = (float)npy_length-1.f;
	mesh.resize(npy_length*npy_length*npy_length);

	FILE* mesh_in = fopen(site_npy_name, "rb");
	fseek(mesh_in, 128, SEEK_SET);//npy format, jump 128 bytes

	for (int x = 0; x < npy_length; x = x + 1)
	{
		for (int y = 0; y < npy_length; y = y + 1)
		{
			for (int z = 0; z < npy_length; z = z + 1)
			{
				v_float4 temp;
				temp.x = (float)scale_factor * x - half_length_of_npy_box;
				temp.y = (float)scale_factor * y - half_length_of_npy_box;
				temp.z = (float)scale_factor * z - half_length_of_npy_box;
				fread(&temp.w, sizeof(float), 1, mesh_in);

				int3_float temp2 = { x,y,z,temp.w };
				mesh[(size_t)npy_length * npy_length * x + (size_t)npy_length * y + z] = temp2;
				if (x < 2 || x > npy_length-3 || y < 2 || y > npy_length-3 || z < 2 || z > npy_length-3)
				{
					mesh[(size_t)npy_length * npy_length * x + (size_t)npy_length * y + z].w = -1.f; //不讨论靠近边界的点
				}
			}
		}
	}//xyz˳����npy��¼�Ķ�Ӧ

	fclose(mesh_in);
	std::sort(std::begin(mesh), std::end(mesh), _cmp);
	//double time_start = omp_get_wtime();
	selected_point.resize(desired_point_numbers);//select ǰn�� as searching point space

	for (int i = 0; i < desired_point_numbers; i = i + 1)
	{
		selected_point[i] = { mesh[i].int_x,mesh[i].int_y,mesh[i].int_z };
	}
	cluster.Initial({ npy_length,npy_length,npy_length }, selected_point);
	cluster.Build_Standard_Cluster();
	//cluster.Cluster_Standard_Extend();

}
