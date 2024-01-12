Return-Path: <bpf+bounces-19483-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E4E82C5F6
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 20:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8C31287130
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 19:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B023C16418;
	Fri, 12 Jan 2024 19:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kRHc3TwH"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547211640D
	for <bpf@vger.kernel.org>; Fri, 12 Jan 2024 19:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <61159c7c-007a-42b8-a582-6dab246a4af6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705088387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CZwVByqmKpuWKlLbiloZBLcX+3kre7YYlu5NoJPskxo=;
	b=kRHc3TwHB+XgN/fAvlxU37fVWIaOCSCCNFsGDciC/8If9Bb8wGk9zvaHAV90hafVHaCucq
	dkcsuKet39cdUhvlmNrbYmAcqxFlSuarNXvvKycdIqtbDt2tIB9gcrXBjyDTGO599941/T
	s4sfiLz1aanrnFyQ1j9OghfoEpHjtX8=
Date: Fri, 12 Jan 2024 11:39:43 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v2] libbpf: Apply map_set_def_max_entries() for
 inner_maps on creation
Content-Language: en-GB
To: Andrey Grafin <conquistador@yandex-team.ru>, bpf@vger.kernel.org
Cc: andrii@kernel.org
References: <20240112121051.17325-1-conquistador@yandex-team.ru>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240112121051.17325-1-conquistador@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 1/12/24 4:10 AM, Andrey Grafin wrote:
> This patch allows to create BPF_MAP_TYPE_ARRAY_OF_MAPS and
> BPF_MAP_TYPE_HASH_OF_MAPS with values of BPF_MAP_TYPE_PERF_EVENT_ARRAY.
>
> Previous behaviour created a zero filled btf_map_def for inner maps and
> tried to use it for a map creation but the linux kernel forbids to create
> a BPF_MAP_TYPE_PERF_EVENT_ARRAY map with max_entries=0.
>
> A simple bpf snippet to reproduce:
>    struct inner_map {
>      __uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
>      __uint(key_size, sizeof(int));
>      __uint(value_size, sizeof(u32));
>    } inner_map0 SEC(".maps"), inner_map1 SEC(".maps");
>
>    struct {
>      __uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
>      __uint(max_entries, 2);
>      __type(key, u32);
>      __array(values, struct inner_map);
>    } outer_map SEC(".maps") = {
>      .values = {&inner_map0, &inner_map1}};
>    ...

What I mean is to add a selftest in tools/testing/selftests/bpf/ directory,
not a test with partial code in the commit message. You can add another
subtest in tools/testing/selftests/bpf/progs/map_in_map.c.

>
> Previous behaviour:
>    # sudo bpftool prog load ./bpf_sample.elf /sys/fs/bpf/test
>      libbpf: map 'outer_map': failed to create inner map: -22
>      libbpf: map 'outer_map': failed to create: Invalid argument(-22)
>      libbpf: failed to load object './bpf_sample.elf'
>      Error: failed to load object file
>
>    # sudo strace -e bpf bpftool prog load ./bpf_sample.elf /sys/fs/bpf/test
>    ...
>    bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_PERF_EVENT_ARRAY, key_size=4,
>      value_size=4, max_entries=16, map_flags=0, inner_map_fd=0,
>      map_name="inner_map0", map_ifindex=0, btf_fd=0, btf_key_type_id=0,
>      btf_value_type_id=0, btf_vmlinux_value_type_id=0, map_extra=0}, 72) = 4
>    bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_PERF_EVENT_ARRAY, key_size=4,
>      value_size=4, max_entries=16, map_flags=0, inner_map_fd=0,
>      map_name="inner_map1", map_ifindex=0, btf_fd=0, btf_key_type_id=0,
>      btf_value_type_id=0, btf_vmlinux_value_type_id=0, map_extra=0}, 72) = 5
>    bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_PERF_EVENT_ARRAY, key_size=4,
>      value_size=4, max_entries=0, map_flags=0, inner_map_fd=0,
>      map_name="outer_map.inner", map_ifindex=0, btf_fd=0,
>      btf_key_type_id=0, btf_value_type_id=0, btf_vmlinux_value_type_id=0,
>      map_extra=0}, 72) = -1 EINVAL (Invalid argument)
>
> New behaviour:
>    # sudo strace -e bpf bpftool prog load ./bpf_sample.elf /sys/fs/bpf/test
>    ...
>    bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_PERF_EVENT_ARRAY, key_size=4,
>      value_size=4, max_entries=16, map_flags=0, inner_map_fd=0,
>      map_name="inner_map0", map_ifindex=0, btf_fd=0, btf_key_type_id=0,
>      btf_value_type_id=0, btf_vmlinux_value_type_id=0, map_extra=0}, 72) = 4
>    bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_PERF_EVENT_ARRAY, key_size=4,
>      value_size=4, max_entries=16, map_flags=0, inner_map_fd=0,
>      map_name="inner_map1", map_ifindex=0, btf_fd=0, btf_key_type_id=0,
>      btf_value_type_id=0, btf_vmlinux_value_type_id=0, map_extra=0}, 72) = 5
>    bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_PERF_EVENT_ARRAY, key_size=4,
>      value_size=4, max_entries=16, map_flags=0, inner_map_fd=0,
>      map_name="outer_map.inner", map_ifindex=0, btf_fd=0, btf_key_type_id=0,
>      btf_value_type_id=0, btf_vmlinux_value_type_id=0, map_extra=0}, 72) = 6
>    bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_ARRAY_OF_MAPS, key_size=4,
>      value_size=4, max_entries=2, map_flags=0, inner_map_fd=6,
>      map_name="outer_map", map_ifindex=0, btf_fd=0, btf_key_type_id=0,
>      btf_value_type_id=0, btf_vmlinux_value_type_id=0, map_extra=0}, 72) = 7
>    bpf(BPF_MAP_UPDATE_ELEM, {map_fd=7, key=0x7ffc89f2de54,
>      value=0x7ffc89f2de58,flags=BPF_ANY}, 32) = 0
>    bpf(BPF_MAP_UPDATE_ELEM, {map_fd=7, key=0x7ffc89f2de54,
>      value=0x7ffc89f2de58, flags=BPF_ANY}, 32) = 0
>    ...
>    +++ exited with 0 +++
>
> Signed-off-by: Andrey Grafin <conquistador@yandex-team.ru>
> ---
>   tools/lib/bpf/libbpf.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index e067be95da3c..8f4d580187aa 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -70,6 +70,7 @@
>   
>   static struct bpf_map *bpf_object__add_map(struct bpf_object *obj);
>   static bool prog_is_subprog(const struct bpf_object *obj, const struct bpf_program *prog);
> +static int map_set_def_max_entries(struct bpf_map *map);
>   
>   static const char * const attach_type_name[] = {
>   	[BPF_CGROUP_INET_INGRESS]	= "cgroup_inet_ingress",
> @@ -5212,6 +5213,9 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
>   
>   	if (bpf_map_type__is_map_in_map(def->type)) {
>   		if (map->inner_map) {
> +			err = map_set_def_max_entries(map->inner_map);
> +			if (err)
> +				return err;
>   			err = bpf_object__create_map(obj, map->inner_map, true);
>   			if (err) {
>   				pr_warn("map '%s': failed to create inner map: %d\n",

