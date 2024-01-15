Return-Path: <bpf+bounces-19551-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B9F82E03E
	for <lists+bpf@lfdr.de>; Mon, 15 Jan 2024 19:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25AFCB2120A
	for <lists+bpf@lfdr.de>; Mon, 15 Jan 2024 18:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1249B18AE1;
	Mon, 15 Jan 2024 18:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="V8S1POxK"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8569118C01
	for <bpf@vger.kernel.org>; Mon, 15 Jan 2024 18:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1889a512-779d-40d9-9d13-ce3ebaed0483@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705344695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j1I6aNMdOJ7wKAvrqRRV+n8asgi8CUSNX6V9vrfhXqE=;
	b=V8S1POxKa8WZGMpFX068VxcZaj45i/zv7bFZJpPGdp1rwFbhiL6DHdPGbwwEDZt88yXRMe
	1wOlvh0edE+44Oqvlo/2lWGndDb+eMGJZ3GqZ7j1XproAyej2IISxn7qsXGNUxJ5dFS752
	G/+SLYgmyZ166RmSloAuX9IUSTKA/4g=
Date: Mon, 15 Jan 2024 10:51:29 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v3] libbpf: Apply map_set_def_max_entries() for
 inner_maps on creation
Content-Language: en-GB
To: Hou Tao <houtao@huaweicloud.com>,
 Andrey Grafin <conquistador@yandex-team.ru>, bpf@vger.kernel.org
Cc: andrii@kernel.org
References: <20240115125914.28588-1-conquistador@yandex-team.ru>
 <6e0032a0-8a1f-6d9a-07b8-a3f312725949@huaweicloud.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <6e0032a0-8a1f-6d9a-07b8-a3f312725949@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 1/15/24 6:50 AM, Hou Tao wrote:
> Hi,
>
> On 1/15/2024 8:59 PM, Andrey Grafin wrote:
>> This patch allows to create BPF_MAP_TYPE_ARRAY_OF_MAPS and
>> BPF_MAP_TYPE_HASH_OF_MAPS with values of BPF_MAP_TYPE_PERF_EVENT_ARRAY.
>>
>> Previous behaviour created a zero filled btf_map_def for inner maps and
>> tried to use it for a map creation but the linux kernel forbids to create
>> a BPF_MAP_TYPE_PERF_EVENT_ARRAY map with max_entries=0.
>>
>> Signed-off-by: Andrey Grafin <conquistador@yandex-team.ru>
>> ---
>>   tools/lib/bpf/libbpf.c                        |  4 +++
>>   .../selftests/bpf/progs/test_map_in_map.c     | 23 +++++++++++++++
>>   tools/testing/selftests/bpf/test_maps.c       | 29 ++++++++++++++++++-
> It would be better to move the selftest into a separated patch, so the
> fix patch for libbpf could be backported alone.

+1. Please put the selftest into the second patch.
Also for the second patch commit message, please mention
the test run result. For example, command line './test_maps',
without the first patch:
   ...
   err ...
with the first patch:
   ...
   ... // everything is okay

>>   3 files changed, 55 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index e067be95da3c..8f4d580187aa 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -70,6 +70,7 @@
>>   
>>   static struct bpf_map *bpf_object__add_map(struct bpf_object *obj);
>>   static bool prog_is_subprog(const struct bpf_object *obj, const struct bpf_program *prog);
>> +static int map_set_def_max_entries(struct bpf_map *map);
>>   
>>   static const char * const attach_type_name[] = {
>>   	[BPF_CGROUP_INET_INGRESS]	= "cgroup_inet_ingress",
>> @@ -5212,6 +5213,9 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
>>   
>>   	if (bpf_map_type__is_map_in_map(def->type)) {
>>   		if (map->inner_map) {
>> +			err = map_set_def_max_entries(map->inner_map);
>> +			if (err)
>> +				return err;
>>   			err = bpf_object__create_map(obj, map->inner_map, true);
>>   			if (err) {
>>   				pr_warn("map '%s': failed to create inner map: %d\n",
>> diff --git a/tools/testing/selftests/bpf/progs/test_map_in_map.c b/tools/testing/selftests/bpf/progs/test_map_in_map.c
>> index f416032ba858..b393d2b8bd6f 100644
>> --- a/tools/testing/selftests/bpf/progs/test_map_in_map.c
>> +++ b/tools/testing/selftests/bpf/progs/test_map_in_map.c
>> @@ -21,6 +21,29 @@ struct {
>>   	__type(value, __u32);
>>   } mim_hash SEC(".maps");
>>   
>> +struct perf_event_array {
>> +	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
>> +	__type(key, __u32);
>> +	__type(value, __u32);
>> +} inner_map0 SEC(".maps"), inner_map1 SEC(".maps");
>> +
>> +struct {
>> +	__uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
>> +	__uint(max_entries, 2);
>> +	__type(key, __u32);
>> +	__array(values, struct perf_event_array);
>> +} mim_array_pe SEC(".maps") = {
>> +	.values = {&inner_map0, &inner_map1}};
>> +
>> +struct {
>> +	__uint(type, BPF_MAP_TYPE_HASH_OF_MAPS);
>> +	__uint(max_entries, 2);
>> +	__type(key, __u32);
>> +	__array(values, struct perf_event_array);
>> +} mim_hash_pe SEC(".maps") = {
>> +	.values = {&inner_map0, &inner_map1}};

This is tricky. I suggest to have max_entries to be
1 for BPF_MAP_TYPE_HASH_OF_MAPS and put only &inner_map0
in 'values'. If you have two buckets for the
hash table, actually it is not clear eventually
which map in which bucket.

>> +
>> +
>>   SEC("xdp")
>>   int xdp_mimtest0(struct xdp_md *ctx)
>>   {
>> diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/selftests/bpf/test_maps.c
>> index 7fc00e423e4d..03f4d448fd3b 100644
>> --- a/tools/testing/selftests/bpf/test_maps.c
>> +++ b/tools/testing/selftests/bpf/test_maps.c
>> @@ -1159,6 +1159,7 @@ static void test_map_in_map(void)
>>   	__u32 len = sizeof(info);
>>   	__u32 id = 0;
>>   	libbpf_print_fn_t old_print_fn;
>> +	int ret;
> Why not use err instead ?
>>   
>>   	obj = bpf_object__open(MAPINMAP_PROG);
>>   
>> @@ -1190,7 +1191,11 @@ static void test_map_in_map(void)
>>   		goto out_map_in_map;
>>   	}
>>   
>> -	bpf_object__load(obj);
>> +	ret = bpf_object__load(obj);
>> +	if (ret) {
>> +		printf("Failed to load test prog\n");
>> +		goto out_map_in_map;
>> +	}
>>   
>>   	map = bpf_object__find_map_by_name(obj, "mim_array");
>>   	if (!map) {
>> @@ -1226,6 +1231,28 @@ static void test_map_in_map(void)
>>   		goto out_map_in_map;
>>   	}
>>   
>> +	map = bpf_object__find_map_by_name(obj, "mim_array_pe");
>> +	if (!map) {
>> +		printf("Failed to load array of perf event array maps\n");
>> +		goto out_map_in_map;
>> +	}
>> +	mim_fd = bpf_map__fd(map);
>> +	if (mim_fd < 0) {
>> +		printf("Failed to get descriptor for array of perf event array maps\n");
>> +		goto out_map_in_map;
>> +	}
>> +
>> +	map = bpf_object__find_map_by_name(obj, "mim_hash_pe");
>> +	if (!map) {
>> +		printf("Failed to load hash of perf event array maps\n");
>> +		goto out_map_in_map;
>> +	}
>> +	mim_fd = bpf_map__fd(map);
>> +	if (mim_fd < 0) {
>> +		printf("Failed to get descriptor for array of perf event array maps\n");
> array -> hash ?
>> +		goto out_map_in_map;
>> +	}

The above change is really not necessary. If program loading is successful, all the
maps should be created properly. I think your above bpf_object__load test should be
good enough.

>> +
>>   	close(fd);
>>   	fd = -1;
>>   	bpf_object__close(obj);
>

