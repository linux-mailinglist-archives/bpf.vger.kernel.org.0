Return-Path: <bpf+bounces-43639-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 832DA9B794B
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 12:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 473BC285B48
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 11:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA0A199FC2;
	Thu, 31 Oct 2024 11:03:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9B21993B2
	for <bpf@vger.kernel.org>; Thu, 31 Oct 2024 11:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730372618; cv=none; b=CoWGLGKaLNgCTwcE3a4NPcNeZw0l4IFBWvQmkxlnRNrj/CdoirqIAR7CEYDexWdtjhvic/hyyVZ5Z+ezZVcRuPeQhbWwDslUW3d41Z7ZDfZBC0wMxMFfijlaJkE0YeFmOR2zmOvhpFxZ2bEBHMI8NWeDdnGgYbSQdWikWiCaaX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730372618; c=relaxed/simple;
	bh=wpwY89pLW4fgxEac5PYLAXoJyRYLyRrYLkLSG3M1iLk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=YMvjYAoAR2XLqpZtjP+KpI89CLtji/8Fik177k/EUJjirR2rZCIIOzrYo4MXWJ3VThJWwzoeGX4ACN+fG9iSYIZMqaTeUPzMZ2MV8dswRhbVcGiX/yD662ZMISfrbl+czF8aEWu4FIrDF0ek3PXZ3eZrZQQh2YdoFTqn44h/qYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XfLgz46M9z4f3nKP
	for <bpf@vger.kernel.org>; Thu, 31 Oct 2024 19:03:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 23DB81A058E
	for <bpf@vger.kernel.org>; Thu, 31 Oct 2024 19:03:30 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgAX84b+YyNnOKrSAQ--.44264S2;
	Thu, 31 Oct 2024 19:03:29 +0800 (CST)
Subject: Re: [PATCH] bpf: smp_wmb before bpf_ringbuf really commit
To: zhongjinji@honor.com, ast@kernel.org
Cc: andrii@kernel.org, billy@starlabs.sg, bpf@vger.kernel.org,
 ramdhan@starlabs.sg, yipengxiang@honor.com, liulu.liu@honor.com,
 feng.han@honor.com
References: <20241031084246.20737-1-zhongjinji@honor.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <12bc3982-5738-5cf5-7dba-f3512a6dfac5@huaweicloud.com>
Date: Thu, 31 Oct 2024 19:03:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241031084246.20737-1-zhongjinji@honor.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgAX84b+YyNnOKrSAQ--.44264S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr43Gr13tr47JF17KF1rWFg_yoW8tr4xpw
	s8KF12krs7Zw1I9w1xCa18uryrWa9xAw4fKw4rJ3yrur1qyFyFgFsFkr4agr4rtrykAw1F
	krWq9as2q3sFyrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AK
	xVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UAwI
	DUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 10/31/2024 4:42 PM, zhongjinji@honor.com wrote:
> From: zhongjinji <zhongjinji@honor.com>
>
> To guarantee visibility of writing ringbuffer,it is necessary
> to call smp_wmb before ringbuffer really commit.
> for instance, when updating the data of buffer in cpu1,
> it is not visible for the cpu2 which may be accessing buffer. This may
> lead to the consumer accessing a incorrect data. using the smp_wmb
> before commmit will guarantee that the consume can access the correct data.
>
> CPU1:
>     struct mem_event_t* data = bpf_ringbuf_reserve();
>     data->type = MEM_EVENT_KSWAPD_WAKE;
>     data->event_data.kswapd_wake.node_id = args->nid;
>     bpf_ringbuf_commit(data);
>
> CPU2:
>     cons_pos = smp_load_acquire(r->consumer_pos);
>     len_ptr = r->data + (cons_pos & r->mask);
>     sample = (void *)len_ptr + BPF_RINGBUF_HDR_SZ;
>     access to sample

It seems you didn't use the ringbuf related APIs (e.g.,
ring_buffer__consume()) in libbpf to access the ring buffer. In my
understanding, the "xchg(&hdr->len, new_len)" in bpf_ringbuf_commit()
works as the barrier to ensure the order of committed data and hdr->len,
and accordingly the "smp_load_acquire(len_ptr)" in
ringbuf_process_ring() in libbpf works as the paired barrier to ensure
the order of hdr->len and the committed data. So I think the extra
smp_wmb() in the kernel is not necessary here. Instead, you should fix
your code in the userspace.
>
> Signed-off-by: zhongjinji <zhongjinji@honor.com>
> ---
>  kernel/bpf/ringbuf.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
> index e1cfe890e0be..a66059e2b0d6 100644
> --- a/kernel/bpf/ringbuf.c
> +++ b/kernel/bpf/ringbuf.c
> @@ -508,6 +508,10 @@ static void bpf_ringbuf_commit(void *sample, u64 flags, bool discard)
>  	rec_pos = (void *)hdr - (void *)rb->data;
>  	cons_pos = smp_load_acquire(&rb->consumer_pos) & rb->mask;
>  
> +	/* Make sure the modification of data is visible on other CPU's
> +	 * before consume the event
> +	 */
> +	smp_wmb();
>  	if (flags & BPF_RB_FORCE_WAKEUP)
>  		irq_work_queue(&rb->work);
>  	else if (cons_pos == rec_pos && !(flags & BPF_RB_NO_WAKEUP))


