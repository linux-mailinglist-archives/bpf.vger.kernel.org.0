Return-Path: <bpf+bounces-19721-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C958303B1
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 11:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E22651C2473D
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 10:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D371B814;
	Wed, 17 Jan 2024 10:33:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FF41BF25
	for <bpf@vger.kernel.org>; Wed, 17 Jan 2024 10:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705487614; cv=none; b=LyfIhMrUwrKzhkT2Nolo2fD6tAQCKqOxLLu899oIepMVa0evpdgWHjBuHiO8qLQGRHWF/TsxBKETE+QVhRZ0XI2QN4BRZS+Aqnfm54m0j9KtzP7PZv5Rc5SAm9NMvFX749FvwxbB2/zIjRylB27TJ6kV9e0cwOe/15mhMNLf5GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705487614; c=relaxed/simple;
	bh=vIQIFnRBADcKS52eS3pATHCmJYx0Hqvnu4/OovdedgI=;
	h=Received:Received:Received:Subject:To:Cc:References:From:
	 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:Content-Language:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo; b=oTK+fJefa1iMcfDyw8ivuJiJkXrQXMeLR+x/ggEImUwVFKff0aUcUNj1b3aDdn150sLo/6EL9MPlHEPoSg2iMqmcS+9bKu+ITMeTEam1+Ap5/opXDE7IWqHCcvRdO+EQihjZ6es1agEDmNg2nyCz0K4xD2Ab9MtD/SoH5P3HiUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TFMfW5QqCz4f3jMb
	for <bpf@vger.kernel.org>; Wed, 17 Jan 2024 18:33:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 7C7C51A0BFC
	for <bpf@vger.kernel.org>; Wed, 17 Jan 2024 18:33:27 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgBnNxD1rKdlLA5rBA--.50122S2;
	Wed, 17 Jan 2024 18:33:27 +0800 (CST)
Subject: Re: [PATCH bpf v4 2/2] selftest/bpf: Add map_in_maps with
 BPF_MAP_TYPE_PERF_EVENT_ARRAY values
To: Andrey Grafin <conquistador@yandex-team.ru>, bpf@vger.kernel.org
Cc: andrii@kernel.org
References: <20240116140131.24427-1-conquistador@yandex-team.ru>
 <20240116140131.24427-2-conquistador@yandex-team.ru>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <be352828-d0c8-6953-ce1c-fcba42a349b7@huaweicloud.com>
Date: Wed, 17 Jan 2024 18:33:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240116140131.24427-2-conquistador@yandex-team.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgBnNxD1rKdlLA5rBA--.50122S2
X-Coremail-Antispam: 1UD129KBjvJXoWxurW7tryDWw47Xry5ZF1xuFg_yoW5XFWDpa
	y8AFWYkFWIqF12gw12yay7WFWSqr1kWayUAr1rtry2yr4kJr97Xr1IgFWDGFnxWrWFvw1f
	A34SgryfWaykJFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1wL05UUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 1/16/2024 10:01 PM, Andrey Grafin wrote:
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
> ---
>  .../selftests/bpf/progs/test_map_in_map.c     | 23 +++++++++++++++++++
>  tools/testing/selftests/bpf/test_maps.c       |  6 ++++-
>  2 files changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/progs/test_map_in_map.c b/tools/testing/selftests/bpf/progs/test_map_in_map.c
> index f416032ba858..54ce1f4bdc7b 100644
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

It seems the reproduce of the failure doesn't need two inner maps, so I
think only using one inner map just like min_hash_pe does is enough.
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
>  SEC("xdp")
>  int xdp_mimtest0(struct xdp_md *ctx)
>  {
> diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/selftests/bpf/test_maps.c
> index 7fc00e423e4d..e0dd101c9f2b 100644
> --- a/tools/testing/selftests/bpf/test_maps.c
> +++ b/tools/testing/selftests/bpf/test_maps.c
> @@ -1190,7 +1190,11 @@ static void test_map_in_map(void)
>  		goto out_map_in_map;
>  	}
>  
> -	bpf_object__load(obj);
> +	err = bpf_object__load(obj);
> +	if (err) {
> +		printf("Failed to load test prog\n");
> +		goto out_map_in_map;
> +	}
>  
>  	map = bpf_object__find_map_by_name(obj, "mim_array");
>  	if (!map) {


