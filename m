Return-Path: <bpf+bounces-17967-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3503D81428C
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 08:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5D091F23E3A
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 07:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CDEED515;
	Fri, 15 Dec 2023 07:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="n0HmTqYc"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B8B111A4
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 07:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1e5463b1-2291-4df2-8338-5d4011d24037@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702625921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lw4hkCrrZ1CINHAPeciKBZGZBjaRjzi/bRgmu2XpO6E=;
	b=n0HmTqYcxp8NavSGlUpdoGYWncm723ir89anR/YQ8tThCdXHUDwS/M2TwkhZ2KExcQmRii
	Ss9adsQ8x1vlA5Jm28f6lR6F4K4VGy3Q0uU5EvwsM9/PBvPUEzGvilKjw5dCSqqPVYYwvE
	ju0l0GtLdbFLthJJEnxv/pOW5Ao2enI=
Date: Thu, 14 Dec 2023 23:38:36 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 6/6] selftests/bpf: Cope with 512 bytes limit
 with bpf_global_percpu_ma
Content-Language: en-GB
To: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20231215001152.3249146-1-yonghong.song@linux.dev>
 <20231215001227.3254314-1-yonghong.song@linux.dev>
 <64834348-0758-e388-e57f-0b71d0be42c9@huaweicloud.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <64834348-0758-e388-e57f-0b71d0be42c9@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 12/14/23 7:33 PM, Hou Tao wrote:
> Hi,
>
> On 12/15/2023 8:12 AM, Yonghong Song wrote:
>> In the previous patch, the maximum data size for bpf_global_percpu_ma
>> is 512 bytes. This breaks selftest test_bpf_ma. Let us adjust it
>> accordingly. Also added a selftest to capture the verification failure
>> when the allocation size is greater than 512.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   .../selftests/bpf/progs/percpu_alloc_fail.c    | 18 ++++++++++++++++++
>>   .../testing/selftests/bpf/progs/test_bpf_ma.c  |  9 ---------
>>   2 files changed, 18 insertions(+), 9 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/progs/percpu_alloc_fail.c b/tools/testing/selftests/bpf/progs/percpu_alloc_fail.c
>> index 1a891d30f1fe..f2b8eb2ff76f 100644
>> --- a/tools/testing/selftests/bpf/progs/percpu_alloc_fail.c
>> +++ b/tools/testing/selftests/bpf/progs/percpu_alloc_fail.c
>> @@ -17,6 +17,10 @@ struct val_with_rb_root_t {
>>   	struct bpf_spin_lock lock;
>>   };
>>   
>> +struct val_600b_t {
>> +	char b[600];
>> +};
>> +
>>   struct elem {
>>   	long sum;
>>   	struct val_t __percpu_kptr *pc;
>> @@ -161,4 +165,18 @@ int BPF_PROG(test_array_map_7)
>>   	return 0;
>>   }
>>   
>> +SEC("?fentry.s/bpf_fentry_test1")
>> +__failure __msg("bpf_percpu_obj_new type size (600) is greater than 512")
>> +int BPF_PROG(test_array_map_8)
>> +{
>> +	struct val_600b_t __percpu_kptr *p;
>> +
>> +	p = bpf_percpu_obj_new(struct val_600b_t);
>> +	if (!p)
>> +		return 0;
>> +
>> +	bpf_percpu_obj_drop(p);
>> +	return 0;
>> +}
>> +
>>   char _license[] SEC("license") = "GPL";
>> diff --git a/tools/testing/selftests/bpf/progs/test_bpf_ma.c b/tools/testing/selftests/bpf/progs/test_bpf_ma.c
>> index b685a4aba6bd..68cba55eb828 100644
>> --- a/tools/testing/selftests/bpf/progs/test_bpf_ma.c
>> +++ b/tools/testing/selftests/bpf/progs/test_bpf_ma.c
>> @@ -188,9 +188,6 @@ DEFINE_ARRAY_WITH_PERCPU_KPTR(128);
>>   DEFINE_ARRAY_WITH_PERCPU_KPTR(192);
>>   DEFINE_ARRAY_WITH_PERCPU_KPTR(256);
>>   DEFINE_ARRAY_WITH_PERCPU_KPTR(512);
>> -DEFINE_ARRAY_WITH_PERCPU_KPTR(1024);
>> -DEFINE_ARRAY_WITH_PERCPU_KPTR(2048);
>> -DEFINE_ARRAY_WITH_PERCPU_KPTR(4096);
> Considering the update in patch "bpf: Avoid unnecessary extra percpu
> memory allocation", the definition of DEFINE_ARRAY_WITH_PERCPU_KPTR()
> needs update as well, because for 512-sized per-cpu kptr, the tests only
> allocate for (512 - sizeof(void *)) bytes. And we could do
> DEFINE_ARRAY_WITH_PERCPU_KPTR(8) test after the update. I could do that
> after the patch-set is landed if you don't have time to do that.
>
> A bit of off-topic, but it is still relevant. I have a question about
> how to forcibly generate BTF info for struct definition in the test ?
> Currently, I have to include  bin_data_xx in the definition of
> map_value, but I don't want to increase the size of map_value. I had
> tried to use BTF_TYPE_EMIT() in prog just like in linux kernel, but it
> didn't work.

Since you mentioned the btf generation issue, I did some investigation.
To workaround btf generation issue, we can use the method in
prog_tests/local_kptr_stash.c:

====
/* This is necessary so that LLVM generates BTF for node_data struct
  * If it's not included, a fwd reference for node_data will be generated but
  * no struct. Example BTF of "node" field in map_value when not included:
  *
  * [10] PTR '(anon)' type_id=35
  * [34] FWD 'node_data' fwd_kind=struct
  * [35] TYPE_TAG 'kptr_ref' type_id=34
  *
  * (with no node_data struct defined)
  * Had to do the same w/ bpf_kfunc_call_test_release below
  */
struct node_data *just_here_because_btf_bug;
struct refcounted_node *just_here_because_btf_bug2;
====

I have hacked the test_bpf_ma.c files and something like below
should work to generate btf types:

         struct bin_data_##_size { \
                 char data[_size - sizeof(void *)]; \
         }; \
+       /* See Commit 5d8d6634ccc, force btf generation for type bin_data_##_size */    \
+       struct bin_data_##_size *__bin_data_##_size; \
         struct map_value_##_size { \
                 struct bin_data_##_size __kptr * data; \
-               /* To emit BTF info for bin_data_xx */ \
-               struct bin_data_##_size not_used; \
         }; \
         struct { \
                 __uint(type, BPF_MAP_TYPE_ARRAY); \
@@ -40,8 +43,12 @@ int pid = 0;
         } array_##_size SEC(".maps")
  
  #define DEFINE_ARRAY_WITH_PERCPU_KPTR(_size) \
+       struct percpu_bin_data_##_size { \
+               char data[_size]; \
+       }; \
+       struct percpu_bin_data_##_size *__percpu_bin_data_##_size; \
         struct map_value_percpu_##_size { \
-               struct bin_data_##_size __percpu_kptr * data; \
+               struct percpu_bin_data_##_size __percpu_kptr * data; \
         }; \
         struct { \
                 __uint(type, BPF_MAP_TYPE_ARRAY); \

I have a prototype to ensure the type (for percpu kptr) removing these
'- sizeof(void *)' and enabling DEFINE_ARRAY_WITH_PERCPU_KPTR().
Once we resolved the check_obj_size() issue, I can then post v3.

>>   
>>   SEC("?fentry/" SYS_PREFIX "sys_nanosleep")
>>   int test_batch_alloc_free(void *ctx)
>> @@ -259,9 +256,6 @@ int test_batch_percpu_alloc_free(void *ctx)
>>   	CALL_BATCH_PERCPU_ALLOC_FREE(192, 128, 6);
>>   	CALL_BATCH_PERCPU_ALLOC_FREE(256, 128, 7);
>>   	CALL_BATCH_PERCPU_ALLOC_FREE(512, 64, 8);
>> -	CALL_BATCH_PERCPU_ALLOC_FREE(1024, 32, 9);
>> -	CALL_BATCH_PERCPU_ALLOC_FREE(2048, 16, 10);
>> -	CALL_BATCH_PERCPU_ALLOC_FREE(4096, 8, 11);
>>   
>>   	return 0;
>>   }
>> @@ -283,9 +277,6 @@ int test_percpu_free_through_map_free(void *ctx)
>>   	CALL_BATCH_PERCPU_ALLOC(192, 128, 6);
>>   	CALL_BATCH_PERCPU_ALLOC(256, 128, 7);
>>   	CALL_BATCH_PERCPU_ALLOC(512, 64, 8);
>> -	CALL_BATCH_PERCPU_ALLOC(1024, 32, 9);
>> -	CALL_BATCH_PERCPU_ALLOC(2048, 16, 10);
>> -	CALL_BATCH_PERCPU_ALLOC(4096, 8, 11);
>>   
>>   	return 0;
>>   }

