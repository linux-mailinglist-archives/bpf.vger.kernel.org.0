Return-Path: <bpf+bounces-19768-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9738310C2
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 02:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CDFA1C23D6C
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 01:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF67184C;
	Thu, 18 Jan 2024 01:14:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FC117C3
	for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 01:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705540470; cv=none; b=cmVhR0DA13VlZVbhMoH1jeMn8zbpWVqO0uEj5LZGxmHJu3tCwF5rDqGOUXAJ5b0YboIikcl779SeSmem/yeJN5jmmxp4qTGQmF621sRFlF2z6AiBcLkvpuQpJjQvEgshW1ZONppeXXAbxUxn/utSeg2MzcNVDdE0RXfsmlb2Bj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705540470; c=relaxed/simple;
	bh=4ehsLSm1eD+kCCqGIML2pKMtKLg7IzohAimVbPQ1dA4=;
	h=Received:Received:Received:Subject:To:Cc:References:From:
	 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:Content-Language:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo; b=kZRfbvsrZmskqIAfTahGnVTlOIUvgzzn7o0MFvjUnWGUipf6Nu5MxcMitkRU1NTOwlDp1Og0vuFe2rFJrcqsqf5xJ+8/Eq+rjSDRXr0CdXYcl6ZGvlmAJ3x2+b1OOPID4hSdaZ7EzAxtg6tS6yKm/jwgvSf27U6OubuyopmT4Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TFlBy4kTvz4f3lfH
	for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 09:14:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id C3C811A08CC
	for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 09:14:24 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgBXqmxue6hl0iSzBA--.56896S2;
	Thu, 18 Jan 2024 09:14:24 +0800 (CST)
Subject: Re: [PATCH bpf v5 2/2] selftest/bpf: Add map_in_maps with
 BPF_MAP_TYPE_PERF_EVENT_ARRAY values
To: Andrey Grafin <conquistador@yandex-team.ru>, bpf@vger.kernel.org
Cc: andrii@kernel.org
References: <20240117130619.9403-1-conquistador@yandex-team.ru>
 <20240117130619.9403-2-conquistador@yandex-team.ru>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <e025d40d-d521-6450-77f5-c422642a2a3c@huaweicloud.com>
Date: Thu, 18 Jan 2024 09:14:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240117130619.9403-2-conquistador@yandex-team.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgBXqmxue6hl0iSzBA--.56896S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xr18Aw4DKr17WFyxAF45trb_yoW3uFXEkF
	s7Cwn7uFn8tr1FgwnFyFZ3AFWDGr1rAr1UWryDWFnrWw43ArZ8Jr4Fvr18Z3W5urnIvF1Y
	q3WfXFWY9r4I9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbzAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04
	k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
	7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUwmhFDUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/



On 1/17/2024 9:06 PM, Andrey Grafin wrote:
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
> Fixes: 646f02ffdd49 ("libbpf: Add BTF-defined map-in-map support")
> Signed-off-by: Andrey Grafin <conquistador@yandex-team.ru>

Acked-by: Hou Tao <houtao1@huawei.com>


