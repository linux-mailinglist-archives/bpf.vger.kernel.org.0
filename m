Return-Path: <bpf+bounces-50475-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 106D5A281AE
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 03:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E1D1164219
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 02:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28CD20E316;
	Wed,  5 Feb 2025 02:19:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0005825A65D
	for <bpf@vger.kernel.org>; Wed,  5 Feb 2025 02:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738721965; cv=none; b=b4vHaK9Y0xNsJeEwG3KiVZ4REaHIWN6GMleN9D1AoHhDc8WEjeAnNVEvBMu/8g5BdYZ+R5QAedUi86CAnYdfun4faeeCnpdKGh12WEjyM96wabSwv/upN4LGSFlt0QpsrcFZQslXmNoypwXuPBhuX1+EirIXMzWxFk6MfpPjzHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738721965; c=relaxed/simple;
	bh=otNHFguU2Z3VTf3hhXA66LhmbITSotmyefNImQHmgYk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=HvlszRrKfgg7t/DDFfwyvVB7m3SbBkkfMQhafXjNpFoKAn2U6XzAljFRmyPLFT2RCyrEeh3wJHzUDZAUymoRix+TErT/MH/mYFuZfEbcVTOXnIPA7eofIhIQbFW+fsFNhABmS66k4LaisIiV95OBwXFgaX71PVflG+vVyiR7GyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YnkSQ34g7z4f3jqj
	for <bpf@vger.kernel.org>; Wed,  5 Feb 2025 10:19:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 45DDA1A12F8
	for <bpf@vger.kernel.org>; Wed,  5 Feb 2025 10:19:18 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgAninqiyqJnbvydCw--.14062S2;
	Wed, 05 Feb 2025 10:19:18 +0800 (CST)
Subject: Re: handling EINTR from bpf_map_lookup_batch
To: Yan Zhai <yan@cloudflare.com>, bpf@vger.kernel.org
Cc: kernel-team@cloudflare.com
References: <Z6JXtA1M5jAZx8xD@debian.debian>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <d8893a20-4211-2fd6-e9d1-b65e81367950@huaweicloud.com>
Date: Wed, 5 Feb 2025 10:19:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Z6JXtA1M5jAZx8xD@debian.debian>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgAninqiyqJnbvydCw--.14062S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KFyDWr4fJryDXF4fJF4fXwb_yoW8uryxpF
	W8GFnrJrnYgw18Zws7X34kCFWYqw4rJws0ka4kX3s0yrnxCr9akr1IgFyYyFWagr4xZr1a
	va10qF93ua1jga7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyCb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
	k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 2/5/2025 2:08 AM, Yan Zhai wrote:
> I am getting EINTR when trying to use bpf_map_lookup_batch on an
> array_of_maps. The error happens when there is a "hole" in the array.
> For example, say the outer map has max entries of 256, each inner map
> is used for a transport protocol, and I only populated key 6 and
> 17 for TCP and UDP. Then when I do batch lookup, I always get EINTR.
> This so far seems to only happen with array of maps. Does it make
> sense to allow skipping to the next key for this map type? Something
> like:
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index c420edbfb7c8..83915a8059ef 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -2027,6 +2027,8 @@ int generic_map_lookup_batch(struct bpf_map *map,
>                                          attr->batch.elem_flags);
>
>                 if (err == -ENOENT) {
> +                       if (IS_FD_ARRAY(map)
> +                               goto next_key;

It seems only BPF_MAP_TYPE_ARRAY_OF_MAPS supports batched operation, so
map->map_type == BPF_MAP_TYPE_ARRAY_OF_MAPS will be enough. It is also
better to reset err as 0, otherwise generic_map_lookup_batch may return
-ENOENT.
>                         if (retry) {
>                                 retry--;
>                                 continue;
> @@ -2048,6 +2050,7 @@ int generic_map_lookup_batch(struct bpf_map *map,
>                         goto free_buf;
>                 }
>
> +next_key:
>                 if (!prev_key)
>                         prev_key = buf_prevkey;
>

Make sense.  Please add a selftest for it. Another way is to return id 0
for these non-existent values in the fd array, but it may break existed
prog. Just skipping the empty array slot is better.
> Also the context about my scenario if anyone is curious: I am trying
> to associate each map to a userspace service in a multi tenant
> environment. This is an addition to cgroup accounting, in case the
> creator cgroup goes away, e.g. systemd service restarts always
> recreate cgroups. And we also want to monitor the utilization level of
> non-prealloc maps of different tenants. When dealing with inner maps,
> it is not always trivial. To connect dots I choose to read these IDs
> periodically and link them to the tenant of the outer map, that's
> where this EINTR occurred.
>
> best
> Yan
>
> .


