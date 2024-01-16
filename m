Return-Path: <bpf+bounces-19622-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DBD82F490
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 19:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9977028509A
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 18:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790781CF8F;
	Tue, 16 Jan 2024 18:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NlYZVQXj"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E2110A09
	for <bpf@vger.kernel.org>; Tue, 16 Jan 2024 18:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705430978; cv=none; b=mCqsdusUBmAuRIiTo8bPzBvCdbNO3fj68eNdEKB9r1CV3swjHFi+6Hg9C+48vy6UK3Doyln1WBrUsbnpu/Sm1NyXaboRI1GKQ9V3PZdTAubJ5gtDB8L0nXneUQ+xtlk6f3BTdF0paiuTDtZwzqtxCeEfnmE4rmfkzrdlJh4bLtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705430978; c=relaxed/simple;
	bh=F4g6ZxZrjH/OTRmTH4U+RdrhLTMH89jMVIwIDmbk9P0=;
	h=Message-ID:DKIM-Signature:Date:MIME-Version:Subject:
	 Content-Language:To:Cc:References:X-Report-Abuse:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Migadu-Flow; b=dQ/dbKxA51FDlIKV2G1l3uEoFZ3yW1uFFlmX7j8rs9e5AuaOoN+N1teWpS8K2fce16SjkHpuicQ70XL0ht61RQPnZEhWiB6mgCk/GkWbxvbRm9X+bxysjoSYEbrRgklH8op8uAQ/7Q5FkfD7Bb0jo69IePrZ9EQ98nndb4grpzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NlYZVQXj; arc=none smtp.client-ip=95.215.58.182
Message-ID: <381b6550-f0e2-4e2f-81d8-4a95a763ec2f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705430975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZNeyzsWgjW20sW8IfWzp8eWAm8PQYIiFFSXSw2iIO+k=;
	b=NlYZVQXj3/BVKZl8eN7gO5W+LReVvnWa7FQ4jt0oykHyvpRML012vKG2+7x1HlfzNFkhEm
	A3tNqP96Nid2eKljZsb9tt5rGz53WNpeU7Mty0B0LAzctm59EXW2tAPqesqXLK4thGqat/
	ZF4yDDjNuyd2leHUtJTSVWlorkvx8tc=
Date: Tue, 16 Jan 2024 10:49:32 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v4 2/2] selftest/bpf: Add map_in_maps with
 BPF_MAP_TYPE_PERF_EVENT_ARRAY values
Content-Language: en-GB
To: Andrey Grafin <conquistador@yandex-team.ru>, bpf@vger.kernel.org
Cc: andrii@kernel.org
References: <20240116140131.24427-1-conquistador@yandex-team.ru>
 <20240116140131.24427-2-conquistador@yandex-team.ru>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240116140131.24427-2-conquistador@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 1/16/24 6:01 AM, Andrey Grafin wrote:
> Check that bpf_object__load() successfully creates map_in_maps
> with BPF_MAP_TYPE_PERF_EVENT_ARRAY values.
> These changes cover fix in the previous patch
> "libbpf: Apply map_set_def_max_entries() for inner_maps on creation".
>
> A command line output is:
> - w/o fix
> $ sudo ./test_maps
> libbpf: map 'mim_array_pe': failed to create inner map: -22
> libbpf: map 'mim_array_pe': failed to create: Invalid argument(-22)
> libbpf: failed to load object './test_map_in_map.bpf.o'
> Failed to load test prog
>
> - with fix
> $ sudo ./test_maps
> ...
> test_maps: OK, 0 SKIPPED
>
> Signed-off-by: Andrey Grafin <conquistador@yandex-team.ru>

Ack with a nit below.

Acked-by: Yonghong Song <yonghong.song@linux.dev>

> ---
>   .../selftests/bpf/progs/test_map_in_map.c     | 23 +++++++++++++++++++
>   tools/testing/selftests/bpf/test_maps.c       |  6 ++++-
>   2 files changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/progs/test_map_in_map.c b/tools/testing/selftests/bpf/progs/test_map_in_map.c
> index f416032ba858..54ce1f4bdc7b 100644
> --- a/tools/testing/selftests/bpf/progs/test_map_in_map.c
> +++ b/tools/testing/selftests/bpf/progs/test_map_in_map.c
> @@ -21,6 +21,29 @@ struct {
>   	__type(value, __u32);
>   } mim_hash SEC(".maps");
>   

To avoid confusion for users looking at code why
the following three maps are not used. Maybe add
a comment below like:

/* The following three maps are used to test
  * perf_event_array map can be an inner
  * map of hash/array_of_maps.
  */

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
> +	__uint(max_entries, 1);
> +	__type(key, __u32);
> +	__array(values, struct perf_event_array);
> +} mim_hash_pe SEC(".maps") = {
> +	.values = {&inner_map0}};
> +
> +
>   SEC("xdp")
>   int xdp_mimtest0(struct xdp_md *ctx)
>   {
> diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/selftests/bpf/test_maps.c
> index 7fc00e423e4d..e0dd101c9f2b 100644
> --- a/tools/testing/selftests/bpf/test_maps.c
> +++ b/tools/testing/selftests/bpf/test_maps.c
> @@ -1190,7 +1190,11 @@ static void test_map_in_map(void)
>   		goto out_map_in_map;
>   	}
>   
> -	bpf_object__load(obj);
> +	err = bpf_object__load(obj);
> +	if (err) {
> +		printf("Failed to load test prog\n");
> +		goto out_map_in_map;
> +	}
>   
>   	map = bpf_object__find_map_by_name(obj, "mim_array");
>   	if (!map) {

