Return-Path: <bpf+bounces-43488-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3652B9B5A2C
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 04:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEA0D1F24308
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 03:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F42198A07;
	Wed, 30 Oct 2024 03:03:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F54A194C6C
	for <bpf@vger.kernel.org>; Wed, 30 Oct 2024 03:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730257431; cv=none; b=tdb7Mj0k9Dq/m4QiiTDLweb/gOlF2oQJ9P+z80Zk23sHiz7feGxiLM3tsQ12vdeVfv3AEIXsPC+Zjyv/abG63sOuZBT5e0AurAy+6cnzOxi0GOQfy7Hxd2zS1hNnWXxFT19fij0FrVUe8doDPxcKfBba9CUppX1D1UU0KDpY670=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730257431; c=relaxed/simple;
	bh=BYkAeRQUWIIXUvw5N20rH8919lN5OiKAtp2UOT0yo/s=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=HLDdGsxPku+u+BokQ0fMvxPNoFx4GzUaVTt9fx9rNIRVfwqF6ECcguy3kZ3bcscyKzVkys6AsjfMvbDbwuMn/YPpNuM1sHzXv3Uv0vYczwWELnmersOTGeJIRPh225PtU/pEUXTovWYKm3CuxCVwxJKKI6onvrgeUEqVG5aXR0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XdX4m1M0Sz4f3l22
	for <bpf@vger.kernel.org>; Wed, 30 Oct 2024 11:03:20 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id B161B1A018D
	for <bpf@vger.kernel.org>; Wed, 30 Oct 2024 11:03:38 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgBH8bIIoiFnb_tLAQ--.21181S2;
	Wed, 30 Oct 2024 11:03:38 +0800 (CST)
Subject: Re: [PATCH bpf v3 4/5] bpf: Use __u64 to save the bits in bits
 iterator
To: bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
 Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Yafang Shao
 <laoar.shao@gmail.com>, xukuohai@huawei.com
References: <20241025013233.804027-1-houtao@huaweicloud.com>
 <20241025013233.804027-5-houtao@huaweicloud.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <3fe8a9f9-bb63-5cbc-5a41-e0eb5eeff23e@huaweicloud.com>
Date: Wed, 30 Oct 2024 11:03:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241025013233.804027-5-houtao@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgBH8bIIoiFnb_tLAQ--.21181S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJFWfXrW8KF4rZF1kCFy3urg_yoW5try7pr
	45Gwn0yrW8trW2yw1avrWUGFy5A3s3JayUGFZ7KrW5GF17Xrn3WryUK345Xa1DCrykXF42
	vryY93sIkayUJa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUF1v3UUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/



On 10/25/2024 9:32 AM, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
>
> On 32-bit hosts (e.g., arm32), when a bpf program passes a u64 to
> bpf_iter_bits_new(), bpf_iter_bits_new() will use bits_copy to store the
> content of the u64. However, bits_copy is only 4 bytes, leading to stack
> corruption.
>

SNIP
>
> Fix it by changing the type of both bits and bit_count from unsigned
> long to u64. However, the change is not enough. The main reason is that
> bpf_iter_bits_next() uses find_next_bit() to find the next bit and the
> pointer passed to find_next_bit() is an unsigned long pointer instead
> of a u64 pointer. For 32-bit little-endian host, it is fine but it is
> not the case for 32-bit big-endian host. Because under 32-bit big-endian
> host, the first iterated unsigned long will be the bits 32-63 of the u64
> instead of the expected bits 0-31. Therefore, in addition to changing
> the type, swap the two unsigned longs within the u64 for 32-bit
> big-endian host.
>
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  kernel/bpf/helpers.c | 33 ++++++++++++++++++++++++++++++---
>  1 file changed, 30 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index daec74820dbe..824718349958 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2855,13 +2855,36 @@ struct bpf_iter_bits {
>  
>  struct bpf_iter_bits_kern {
>  	union {
> -		unsigned long *bits;
> -		unsigned long bits_copy;
> +		__u64 *bits;
> +		__u64 bits_copy;
>  	};
>  	int nr_bits;
>  	int bit;
>  } __aligned(8);
>  
> +/* On 64-bit hosts, unsigned long and u64 have the same size, so passing
> + * a u64 pointer and an unsigned long pointer to find_next_bit() will
> + * return the same result, as both point to the same 8-byte area.
> + *
> + * For 32-bit little-endian hosts, using a u64 pointer or unsigned long
> + * pointer also makes no difference. This is because the first iterated
> + * unsigned long is composed of bits 0-31 of the u64 and the second unsigned
> + * long is composed of bits 32-63 of the u64.
> + *
> + * However, for 32-bit big-endian hosts, this is not the case. The first
> + * iterated unsigned long will be bits 32-63 of the u64, so swap these two
> + * ulong values within the u64.
> + */
> +static void swap_ulong_in_u64(u64 *bits, unsigned int nr)
> +{
> +#if !defined(CONFIG_64BIT) && defined(__BIG_ENDIAN)
> +	unsigned int i;
> +
> +	for (i = 0; i < nr; i++)
> +		bits[i] = (bits[i] >> 32) | ((u64)(u32)bits[i] << 32);
> +#endif
> +}
> +

Just find out the bitmap_from_arr64() API from lib/bitmap.  However the
API assumes the memories for dst and src are not overlapped, so it is a
pity that we can not use it. According to the implementation
ofbitmap_from_arr64(), I think it would be better to use "BITS_PER_LONG
== 32" instead of "defined(CONFIG_64BIT) " in swap_ulong_in_u64().
>  /**
>   * bpf_iter_bits_new() - Initialize a new bits iterator for a given memory area
>   * @it: The new bpf_iter_bits to be created
> @@ -2906,6 +2929,8 @@ bpf_iter_bits_new(struct bpf_iter_bits *it, const u64 *unsafe_ptr__ign, u32 nr_w
>  		if (err)
>  			return -EFAULT;
>  
> +		swap_ulong_in_u64(&kit->bits_copy, nr_words);
> +
>  		kit->nr_bits = nr_bits;
>  		return 0;
>  	}
> @@ -2924,6 +2949,8 @@ bpf_iter_bits_new(struct bpf_iter_bits *it, const u64 *unsafe_ptr__ign, u32 nr_w
>  		return err;
>  	}
>  
> +	swap_ulong_in_u64(kit->bits, nr_words);
> +
>  	kit->nr_bits = nr_bits;
>  	return 0;
>  }


