Return-Path: <bpf+bounces-19545-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 934D782DBE7
	for <lists+bpf@lfdr.de>; Mon, 15 Jan 2024 15:53:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43F78280F32
	for <lists+bpf@lfdr.de>; Mon, 15 Jan 2024 14:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356E1175B9;
	Mon, 15 Jan 2024 14:50:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4010175AE
	for <bpf@vger.kernel.org>; Mon, 15 Jan 2024 14:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TDFRz6gcbz4f3jq0
	for <bpf@vger.kernel.org>; Mon, 15 Jan 2024 22:50:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 0E6B01A017A
	for <bpf@vger.kernel.org>; Mon, 15 Jan 2024 22:50:26 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgA3PG4uRqVlRve0Aw--.8790S2;
	Mon, 15 Jan 2024 22:50:25 +0800 (CST)
Subject: Re: [PATCH bpf v3] libbpf: Apply map_set_def_max_entries() for
 inner_maps on creation
To: Andrey Grafin <conquistador@yandex-team.ru>, bpf@vger.kernel.org
Cc: andrii@kernel.org
References: <20240115125914.28588-1-conquistador@yandex-team.ru>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <6e0032a0-8a1f-6d9a-07b8-a3f312725949@huaweicloud.com>
Date: Mon, 15 Jan 2024 22:50:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240115125914.28588-1-conquistador@yandex-team.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgA3PG4uRqVlRve0Aw--.8790S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAr1UAFWDGFyUuF4rGrW3ZFb_yoWruFy7pF
	W8uFWakrWxXF12q347Jayj9rWYqw1vg34j9F1Sq34jyr4DXr9rXF1xKFZrJFnxu39Yqw1f
	A3Wakr93uayktFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 1/15/2024 8:59 PM, Andrey Grafin wrote:
> This patch allows to create BPF_MAP_TYPE_ARRAY_OF_MAPS and
> BPF_MAP_TYPE_HASH_OF_MAPS with values of BPF_MAP_TYPE_PERF_EVENT_ARRAY.
>
> Previous behaviour created a zero filled btf_map_def for inner maps and
> tried to use it for a map creation but the linux kernel forbids to create
> a BPF_MAP_TYPE_PERF_EVENT_ARRAY map with max_entries=0.
>
> Signed-off-by: Andrey Grafin <conquistador@yandex-team.ru>
> ---
>  tools/lib/bpf/libbpf.c                        |  4 +++
>  .../selftests/bpf/progs/test_map_in_map.c     | 23 +++++++++++++++
>  tools/testing/selftests/bpf/test_maps.c       | 29 ++++++++++++++++++-

It would be better to move the selftest into a separated patch, so the
fix patch for libbpf could be backported alone.
>  3 files changed, 55 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index e067be95da3c..8f4d580187aa 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -70,6 +70,7 @@
>  
>  static struct bpf_map *bpf_object__add_map(struct bpf_object *obj);
>  static bool prog_is_subprog(const struct bpf_object *obj, const struct bpf_program *prog);
> +static int map_set_def_max_entries(struct bpf_map *map);
>  
>  static const char * const attach_type_name[] = {
>  	[BPF_CGROUP_INET_INGRESS]	= "cgroup_inet_ingress",
> @@ -5212,6 +5213,9 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
>  
>  	if (bpf_map_type__is_map_in_map(def->type)) {
>  		if (map->inner_map) {
> +			err = map_set_def_max_entries(map->inner_map);
> +			if (err)
> +				return err;
>  			err = bpf_object__create_map(obj, map->inner_map, true);
>  			if (err) {
>  				pr_warn("map '%s': failed to create inner map: %d\n",
> diff --git a/tools/testing/selftests/bpf/progs/test_map_in_map.c b/tools/testing/selftests/bpf/progs/test_map_in_map.c
> index f416032ba858..b393d2b8bd6f 100644
> --- a/tools/testing/selftests/bpf/progs/test_map_in_map.c
> +++ b/tools/testing/selftests/bpf/progs/test_map_in_map.c
> @@ -21,6 +21,29 @@ struct {
>  	__type(value, __u32);
>  } mim_hash SEC(".maps");
>  
> +struct perf_event_array {
> +	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
> +	__type(key, __u32);
> +	__type(value, __u32);
> +} inner_map0 SEC(".maps"), inner_map1 SEC(".maps");
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
> +	__uint(max_entries, 2);
> +	__type(key, __u32);
> +	__array(values, struct perf_event_array);
> +} mim_array_pe SEC(".maps") = {
> +	.values = {&inner_map0, &inner_map1}};
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_HASH_OF_MAPS);
> +	__uint(max_entries, 2);
> +	__type(key, __u32);
> +	__array(values, struct perf_event_array);
> +} mim_hash_pe SEC(".maps") = {
> +	.values = {&inner_map0, &inner_map1}};
> +
> +
>  SEC("xdp")
>  int xdp_mimtest0(struct xdp_md *ctx)
>  {
> diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/selftests/bpf/test_maps.c
> index 7fc00e423e4d..03f4d448fd3b 100644
> --- a/tools/testing/selftests/bpf/test_maps.c
> +++ b/tools/testing/selftests/bpf/test_maps.c
> @@ -1159,6 +1159,7 @@ static void test_map_in_map(void)
>  	__u32 len = sizeof(info);
>  	__u32 id = 0;
>  	libbpf_print_fn_t old_print_fn;
> +	int ret;

Why not use err instead ?
>  
>  	obj = bpf_object__open(MAPINMAP_PROG);
>  
> @@ -1190,7 +1191,11 @@ static void test_map_in_map(void)
>  		goto out_map_in_map;
>  	}
>  
> -	bpf_object__load(obj);
> +	ret = bpf_object__load(obj);
> +	if (ret) {
> +		printf("Failed to load test prog\n");
> +		goto out_map_in_map;
> +	}
>  
>  	map = bpf_object__find_map_by_name(obj, "mim_array");
>  	if (!map) {
> @@ -1226,6 +1231,28 @@ static void test_map_in_map(void)
>  		goto out_map_in_map;
>  	}
>  
> +	map = bpf_object__find_map_by_name(obj, "mim_array_pe");
> +	if (!map) {
> +		printf("Failed to load array of perf event array maps\n");
> +		goto out_map_in_map;
> +	}
> +	mim_fd = bpf_map__fd(map);
> +	if (mim_fd < 0) {
> +		printf("Failed to get descriptor for array of perf event array maps\n");
> +		goto out_map_in_map;
> +	}
> +
> +	map = bpf_object__find_map_by_name(obj, "mim_hash_pe");
> +	if (!map) {
> +		printf("Failed to load hash of perf event array maps\n");
> +		goto out_map_in_map;
> +	}
> +	mim_fd = bpf_map__fd(map);
> +	if (mim_fd < 0) {
> +		printf("Failed to get descriptor for array of perf event array maps\n");

array -> hash ?
> +		goto out_map_in_map;
> +	}
> +
>  	close(fd);
>  	fd = -1;
>  	bpf_object__close(obj);


