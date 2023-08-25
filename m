Return-Path: <bpf+bounces-8631-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D1E788C70
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 17:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 946D02818E4
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 15:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5340C107A8;
	Fri, 25 Aug 2023 15:28:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B52810787
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 15:28:01 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A2F2106
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 08:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=LwrhaGWz/QxRcuxkTbdJgWefl7NLyTOixUXQVKAoimo=; b=FrJ0jpa1bc/iJfAK3/zqgbKqWZ
	qV4ZdGJhDJ0DN9/44L/BvgyN2bDPo/DoqUw4P866tgcGRhA+jxvjw1LTOcZ2yhmeHMb3f53aL8dMR
	malicQtQ7JEJPteqk+HgNxMvDAtj2E0u9cwl6mgQUwbVNa83PDpt0lsPaPRxf96wM1E3g64MzzLHJ
	b9SvSfccl+eoZzqRBWE/OHuIGzo1sYZae5zptl0djKwuv+rNwFu39zz6srNIRZmHXEev6humgYiJn
	Q11ompbuigNWgNcu8j8q7SVx9ArfHNIaTnt4ktVFQoCe1+iHkCVxE0kZAV+ZLuAAslcwUQuH58iOR
	WZx8ZqOg==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qZYj7-0001OB-FR; Fri, 25 Aug 2023 17:27:57 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qZYj7-000Nkl-E2; Fri, 25 Aug 2023 17:27:57 +0200
Subject: Re: [PATCH bpf-next v3] libbpf: handle producer position overflow
To: Andrew Werner <awerner32@gmail.com>, bpf@vger.kernel.org
Cc: kernel-team@dataexmachina.dev, alexei.starovoitov@gmail.com,
 andrii@kernel.org, olsajiri@gmail.com, houtao@huaweicloud.com,
 void@manifault.com
References: <20230824220907.1172808-1-awerner32@gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <ce26e0c1-7d05-1572-dfc9-10d251fde86f@iogearbox.net>
Date: Fri, 25 Aug 2023 17:27:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230824220907.1172808-1-awerner32@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/27011/Fri Aug 25 09:40:47 2023)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/25/23 12:09 AM, Andrew Werner wrote:
> Before this patch, the producer position could overflow `unsigned
> long`, in which case libbpf would forever stop processing new writes to
> the ringbuf. Similarly, overflows of the producer position could result
> in __bpf_user_ringbuf_peek not discovering available data. This patch
> addresses that bug by computing using the signed delta between the
> consumer and producer position to determine if data is available; the
> delta computation is robust to overflow.
> 
> A more defensive check could be to ensure that the delta is within
> the allowed range, but such defensive checks are neither present in
> the kernel side code nor in libbpf. The overflow that this patch
> handles can occur while the producer and consumer follow a correct
> protocol.
> 
> Secondarily, the type used to represent the positions in the
> user_ring_buffer functions in both libbpf and the kernel has been
> changed from u64 to unsigned long to match the type used in the
> kernel's representation of the structure. The change occurs in the

Hm, but won't this mismatch for 64bit kernel and 32bit user space? Why
not fixate both on u64 instead so types are consistent?

> same patch because it's required to align the data availability
> calculations between the userspace producing ringbuf and the bpf
> producing ringbuf.
> 
> Not included in this patch, a selftest was written to demonstrate the
> bug, and indeed this patch allows the test to continue to make progress
> past the overflow. The shape of the self test was as follows:
> 
>   a) Set up ringbuf of 2GB size (the maximum permitted size).
>   b) reserve+commit maximum-sized records (ULONG_MAX/4) constantly as
>      fast as possible.
> 
> With 1 million records per second repro time should be about 4.7 hours.
> Such a test duration is impractical to run, hence the omission.
> 
> Additionally, this patch adds commentary around a separate point to note
> that the modular arithmetic is valid in the face of overflows, as that
> fact may not be obvious to future readers.
> 
> v2->v3:
>    - Changed the representation of the consumer and producer positions
>      from u64 to unsigned long in user_ring_buffer functions.
>    - Addressed overflow in __bpf_user_ringbuf_peek.
>    - Changed data availability computations to use the signed delta
>      between the consumer and producer positions rather than merely
>      checking whether their values were unequal.
> v1->v2:
>    - Fixed comment grammar.
>    - Properly formatted subject line.
> 
> Signed-off-by: Andrew Werner <awerner32@gmail.com>
> ---
>   kernel/bpf/ringbuf.c    | 11 ++++++++---
>   tools/lib/bpf/ringbuf.c | 16 +++++++++++++---
>   2 files changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
> index f045fde632e5..0c48673520fb 100644
> --- a/kernel/bpf/ringbuf.c
> +++ b/kernel/bpf/ringbuf.c
> @@ -658,7 +658,7 @@ static int __bpf_user_ringbuf_peek(struct bpf_ringbuf *rb, void **sample, u32 *s
>   {
>   	int err;
>   	u32 hdr_len, sample_len, total_len, flags, *hdr;
> -	u64 cons_pos, prod_pos;
> +	unsigned long cons_pos, prod_pos;
>   
>   	/* Synchronizes with smp_store_release() in user-space producer. */
>   	prod_pos = smp_load_acquire(&rb->producer_pos);
> @@ -667,7 +667,12 @@ static int __bpf_user_ringbuf_peek(struct bpf_ringbuf *rb, void **sample, u32 *s
>   
>   	/* Synchronizes with smp_store_release() in __bpf_user_ringbuf_sample_release() */
>   	cons_pos = smp_load_acquire(&rb->consumer_pos);
> -	if (cons_pos >= prod_pos)
> +
> +	/* Check if there's data available by computing the signed delta between
> +	 * cons_pos and prod_pos; a negative delta indicates that the consumer has
> +	 * not caught up. This formulation is robust to prod_pos wrapping around.
> +	 */
> +	if ((long)(cons_pos - prod_pos) >= 0)
>   		return -ENODATA;
>   
>   	hdr = (u32 *)((uintptr_t)rb->data + (uintptr_t)(cons_pos & rb->mask));
> @@ -711,7 +716,7 @@ static int __bpf_user_ringbuf_peek(struct bpf_ringbuf *rb, void **sample, u32 *s
>   
>   static void __bpf_user_ringbuf_sample_release(struct bpf_ringbuf *rb, size_t size, u64 flags)
>   {
> -	u64 consumer_pos;
> +	unsigned long consumer_pos;
>   	u32 rounded_size = round_up(size + BPF_RINGBUF_HDR_SZ, 8);
>   
>   	/* Using smp_load_acquire() is unnecessary here, as the busy-bit
> diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
> index 02199364db13..141030a89370 100644
> --- a/tools/lib/bpf/ringbuf.c
> +++ b/tools/lib/bpf/ringbuf.c
> @@ -237,7 +237,13 @@ static int64_t ringbuf_process_ring(struct ring *r)
>   	do {
>   		got_new_data = false;
>   		prod_pos = smp_load_acquire(r->producer_pos);
> -		while (cons_pos < prod_pos) {
> +
> +		/* Check if there's data available by computing the signed delta
> +		 * between cons_pos and prod_pos; a negative delta indicates that the
> +		 * consumer has not caught up. This formulation is robust to prod_pos
> +		 * wrapping around.
> +		 */
> +		while ((long)(cons_pos - prod_pos) < 0) {
>   			len_ptr = r->data + (cons_pos & r->mask);
>   			len = smp_load_acquire(len_ptr);
>   
> @@ -482,8 +488,7 @@ void user_ring_buffer__submit(struct user_ring_buffer *rb, void *sample)
>   void *user_ring_buffer__reserve(struct user_ring_buffer *rb, __u32 size)
>   {
>   	__u32 avail_size, total_size, max_size;
> -	/* 64-bit to avoid overflow in case of extreme application behavior */
> -	__u64 cons_pos, prod_pos;
> +	unsigned long cons_pos, prod_pos;
>   	struct ringbuf_hdr *hdr;
>   
>   	/* The top two bits are used as special flags */
> @@ -498,6 +503,11 @@ void *user_ring_buffer__reserve(struct user_ring_buffer *rb, __u32 size)
>   	prod_pos = smp_load_acquire(rb->producer_pos);
>   
>   	max_size = rb->mask + 1;
> +
> +	/* Note that this formulation is valid in the face of overflow of
> +	 * prod_pos so long as the delta between prod_pos and cons_pos is
> +	 * no greater than max_size.
> +	 */
>   	avail_size = max_size - (prod_pos - cons_pos);
>   	/* Round up total size to a multiple of 8. */
>   	total_size = (size + BPF_RINGBUF_HDR_SZ + 7) / 8 * 8;
> 


