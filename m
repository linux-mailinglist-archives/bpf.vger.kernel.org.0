Return-Path: <bpf+bounces-39094-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1FB996E827
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 05:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48624B22E6D
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 03:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91EF21EB35;
	Fri,  6 Sep 2024 03:21:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F4E2233B;
	Fri,  6 Sep 2024 03:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725592869; cv=none; b=rlgf1TRVDOt0iMy200C4TOnwJUZ1TUon/HwCQmAp0EVckQPBX/9TfhmAhs21z6Nh2/MvCKlQnkW/a3M9fc9P0MvqOVv3Rv7KHoV4+Ny4OJpEAoTa94AT0KdmkXkyB4ZMWC5WQOrLyOA0uvU8FOlYTUJmCRDkjnpOVxjhFuSswLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725592869; c=relaxed/simple;
	bh=lkUEIs3Vj51e0baBIH0ImGISwWmjl3aVQKG25LjrFfw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=JhcB8jyaMAzzZU06IhwzVrZgyTrXPtG5pxEHAzyTsEHMrluteeYU8LZCeXaAaiVkD3Sk0rKaHTrkaDgYHY+eCq93dYFrBYWWclMc1MKx37sIDHdwCoQY7ef1qp6S0I7KL5m/aAO1k8yIUgEj8RKdAKhHT+3vU3kq1781y8Scu6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4X0M1p5z65z4f3jjk;
	Fri,  6 Sep 2024 11:20:46 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 390891A158B;
	Fri,  6 Sep 2024 11:20:57 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgCHu8cVddpmAf0YAg--.14627S2;
	Fri, 06 Sep 2024 11:20:57 +0800 (CST)
Subject: Re: [RFC PATCH bpf-next] bpf: Check percpu map value size first
To: Tao Chen <chen.dylane@gmail.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>
References: <20240905171406.832962-1-chen.dylane@gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <fab1c1c1-a973-a32c-8936-d0d885d4b5af@huaweicloud.com>
Date: Fri, 6 Sep 2024 11:20:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240905171406.832962-1-chen.dylane@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgCHu8cVddpmAf0YAg--.14627S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr18AFWxJFWrKrW5tr15CFg_yoW8KFyUpF
	Z3GFyUtr4jqwn293y5t3W8C3yrXwn8Ja47G3Z8JFy0vr47Gwn7Kr1qgFWUWFyavF1qkr40
	yas0qayFk3yjvrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU92b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x07UAwIDUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 9/6/2024 1:14 AM, Tao Chen wrote:
> Percpu map is often used, but the map value size limit often ignored,
> like issue: https://github.com/iovisor/bcc/issues/2519. Actually,
> percpu map value size is bound by PCPU_MIN_UNIT_SZIE, so we

s/SZIE/SIZE
> can check the value size whether it exceeds PCPU_MIN_UNIT_SZIE first,

The same typo here.
> like percpu map of local_storage. Maybe the error message seems clearer
> compared with "cannot allocate memory".
>
> the test case we create a percpu map with large value like:
> struct test_t {
>         int a[100000];
> };
> struct {
>         __uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
>         __uint(max_entries, 1);
>         __type(key, u32);
>         __type(value, struct test_t);
> } start SEC(".maps");
>
> test on ubuntu24.04 vm:
> libbpf: Error in bpf_create_map_xattr(start):Argument list too long(-7).
> Retrying without BTF.

Could you please convert it into a separated bpf selftest patch ?
>
> Signed-off-by: Tao Chen <chen.dylane@gmail.com>
> ---
>  kernel/bpf/arraymap.c | 3 +++
>  kernel/bpf/hashtab.c  | 3 +++
>  2 files changed, 6 insertions(+)
>
> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> index a43e62e2a8bb..7c3c32f156ff 100644
> --- a/kernel/bpf/arraymap.c
> +++ b/kernel/bpf/arraymap.c
> @@ -73,6 +73,9 @@ int array_map_alloc_check(union bpf_attr *attr)
>  	/* avoid overflow on round_up(map->value_size) */
>  	if (attr->value_size > INT_MAX)
>  		return -E2BIG;
> +	/* percpu map value size is bound by PCPU_MIN_UNIT_SIZE */
> +	if (percpu && attr->value_size > PCPU_MIN_UNIT_SIZE)
> +		return -E2BIG;
>  
>  	return 0;
>  }

Make sense. However because the map passes round_up(attr->value_size, 8)
to bpf_map_alloc_percpu(). Is it more reasonable to check
round_up(value_size) > PCPU_MIN_UNIT_SIZE instead ?
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 45c7195b65ba..16d590fe1ffb 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -462,6 +462,9 @@ static int htab_map_alloc_check(union bpf_attr *attr)
>  		 * kmalloc-able later in htab_map_update_elem()
>  		 */
>  		return -E2BIG;
> +	/* percpu map value size is bound by PCPU_MIN_UNIT_SIZE */
> +	if (percpu && attr->value_size > PCPU_MIN_UNIT_SIZE)
> +		return -E2BIG;
>  

The percpu allocation logic is the same as the array map:
round_up(value_size, 8) is used.
>  	return 0;
>  }


