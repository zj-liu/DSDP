#ifndef SITE_INFORMATION_CUH
#define SITE_INFORMATION_CUH
#include "common.cuh"
#include "stdio.h"
#include "math.h"
#include "stdlib.h"
#include "string.h"
#include <vector>
#include <algorithm>


#include <omp.h>
#include "CLUSTER.h"

#ifndef DEF_VECTOR
#define DEF_VECTOR
struct int3_float
{
	int int_x;
	int int_y;
	int int_z;
	float w;
};

struct v_float4
{
	float x;
	float y;
	float z;
	float w;
};

#endif
struct SITE_INFORMATION
{
//coefficient for transform from npy array to point coordinate
	//const int npy_length=36;
	float scale_factor=2.f;
	float half_length_of_npy_box;
	
	
        CLUSTER cluster;
	int last_modified_time = 20230216;
	std::vector<VECTOR> site_point;

	int point_numbers = 0;
	std::vector<int3_float> mesh;
	std::vector<INT_VECTOR>selected_point;
	VECTOR box_min;//����site_pointʵ���Ƽ���������������Ŀǰ������0.5(point_min+max)Ϊ���ģ��߳�Ϊbox_length�ķ�����
	VECTOR box_max;

	void Initial(const char* site_npy_name,const int desired_point_numbers,int npy_length);
	
};
#endif //SITE_INFORMATION_CUH
