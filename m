Return-Path: <bpf+bounces-8535-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A41787B9D
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 00:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E1522816E4
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 22:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F456BA38;
	Thu, 24 Aug 2023 22:46:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C777E
	for <bpf@vger.kernel.org>; Thu, 24 Aug 2023 22:46:09 +0000 (UTC)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245A81BF1
	for <bpf@vger.kernel.org>; Thu, 24 Aug 2023 15:46:05 -0700 (PDT)
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-64a8826dde2so2071676d6.1
        for <bpf@vger.kernel.org>; Thu, 24 Aug 2023 15:46:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692917164; x=1693521964;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UHeNcMMb6l7Z5f713mg1tv3XPXcQmXrAcI8oExdyRvg=;
        b=EUGg6qB+Rx3gsA2+MGsnDfJLqLqIcoT9FaQjOEopebvb30iSVf/Hi2IomFsjntRJOs
         3PWRVhs9CAO46UanBYb5L6SUzoTJBgKVcj15PsiMxCnQYVSztHNrYXpd9Lxul5uotN/a
         ZMLky+fiG4BaG7Tty+yLLOAcyEZBy1mWYhnxOuae44i8yiQTeJHgV2OLf340ZVLo6mVe
         gtSLtsb3c0W//68ADkmikEVgv+PzrTwKDqNijDJTxKuMcgvIiV6Fr5Jlkka6CGKRwMmx
         N3bnOyA9IH7gr8g9jN0zNlSEPZNKMtpoQM0BN6g3OZOm1xA6HzHfUuW0cJuUnzwsUIZC
         O45w==
X-Gm-Message-State: AOJu0YxWHwekvZN8R1LWEUwV935KqFTgfKWge5DKX9STvtxq5EG/TNH1
	J+8WGzz+Y2jPrYhL4BT37ZM=
X-Google-Smtp-Source: AGHT+IFb6zChmSra76B8/Z6zmciJLxcKLdmUti50tYzJsyr1VDPDdsSoi03UZIWVCeJ77zjn1GbOdw==
X-Received: by 2002:a05:6214:4807:b0:641:894e:90fe with SMTP id pa7-20020a056214480700b00641894e90femr17040085qvb.61.1692917164151;
        Thu, 24 Aug 2023 15:46:04 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:1df8])
        by smtp.gmail.com with ESMTPSA id e4-20020a0ce3c4000000b006262de12a8csm114176qvl.65.2023.08.24.15.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 15:46:03 -0700 (PDT)
Date: Thu, 24 Aug 2023 17:46:01 -0500
From: David Vernet <void@manifault.com>
To: Andrew Werner <awerner32@gmail.com>
Cc: bpf@vger.kernel.org, kernel-team@dataexmachina.dev,
	alexei.starovoitov@gmail.com, andrii@kernel.org, olsajiri@gmail.com,
	houtao@huaweicloud.com
Subject: Re: [PATCH bpf-next v3] libbpf: handle producer position overflow
Message-ID: <20230824224601.GC11642@maniforge>
References: <20230824220907.1172808-1-awerner32@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824220907.1172808-1-awerner32@gmail.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 24, 2023 at 06:09:08PM -0400, Andrew Werner wrote:
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
> same patch because it's required to align the data availability
> calculations between the userspace producing ringbuf and the bpf
> producing ringbuf.
> 
> Not included in this patch, a selftest was written to demonstrate the
> bug, and indeed this patch allows the test to continue to make progress
> past the overflow. The shape of the self test was as follows:
> 
>  a) Set up ringbuf of 2GB size (the maximum permitted size).
>  b) reserve+commit maximum-sized records (ULONG_MAX/4) constantly as
>     fast as possible.
> 
> With 1 million records per second repro time should be about 4.7 hours.
> Such a test duration is impractical to run, hence the omission.
> 
> Additionally, this patch adds commentary around a separate point to note
> that the modular arithmetic is valid in the face of overflows, as that
> fact may not be obvious to future readers.
> 
> v2->v3:
>   - Changed the representation of the consumer and producer positions
>     from u64 to unsigned long in user_ring_buffer functions. 
>   - Addressed overflow in __bpf_user_ringbuf_peek.
>   - Changed data availability computations to use the signed delta
>     between the consumer and producer positions rather than merely
>     checking whether their values were unequal.
> v1->v2:
>   - Fixed comment grammar.
>   - Properly formatted subject line.
> 
> Signed-off-by: Andrew Werner <awerner32@gmail.com>

Hey Andrew,

This LGTM, thanks for finding and fixing this. I left a comment below
about the cast >= vs. equality comparison, but I won't block on it given
that it's already been discussed on another thread. Here's my tag:

Reviewed-by: David Vernet<void@manifault.com>

> ---
>  kernel/bpf/ringbuf.c    | 11 ++++++++---
>  tools/lib/bpf/ringbuf.c | 16 +++++++++++++---
>  2 files changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
> index f045fde632e5..0c48673520fb 100644
> --- a/kernel/bpf/ringbuf.c
> +++ b/kernel/bpf/ringbuf.c
> @@ -658,7 +658,7 @@ static int __bpf_user_ringbuf_peek(struct bpf_ringbuf *rb, void **sample, u32 *s
>  {
>  	int err;
>  	u32 hdr_len, sample_len, total_len, flags, *hdr;
> -	u64 cons_pos, prod_pos;
> +	unsigned long cons_pos, prod_pos;
>  
>  	/* Synchronizes with smp_store_release() in user-space producer. */
>  	prod_pos = smp_load_acquire(&rb->producer_pos);
> @@ -667,7 +667,12 @@ static int __bpf_user_ringbuf_peek(struct bpf_ringbuf *rb, void **sample, u32 *s
>  
>  	/* Synchronizes with smp_store_release() in __bpf_user_ringbuf_sample_release() */
>  	cons_pos = smp_load_acquire(&rb->consumer_pos);
> -	if (cons_pos >= prod_pos)
> +
> +	/* Check if there's data available by computing the signed delta between
> +	 * cons_pos and prod_pos; a negative delta indicates that the consumer has
> +	 * not caught up. This formulation is robust to prod_pos wrapping around.
> +	 */
> +	if ((long)(cons_pos - prod_pos) >= 0)

I see that Andrii suggested doing it this way in [0] so I won't insist
on changing it, but IMO this is much less readable and more confusing
than just doing an if (cond_pos == prod_pos) with a comment. The way
it's written this way, it makes it look like there could be a situation
where cond_pos could be ahead of prod_pos, whereas that would actually
just be a bug elsewhere that we'd be papering over. I guess this is more
defensive. In any case, I won't insit on it needing to change.

[0]: https://lore.kernel.org/all/CAEf4BzZQQ=fz+NqFHhJcqKoVAvh4=XbH7HWaHKjUg5OOzi-PTw@mail.gmail.com/

>  		return -ENODATA;
>  
>  	hdr = (u32 *)((uintptr_t)rb->data + (uintptr_t)(cons_pos & rb->mask));
> @@ -711,7 +716,7 @@ static int __bpf_user_ringbuf_peek(struct bpf_ringbuf *rb, void **sample, u32 *s
>  
>  static void __bpf_user_ringbuf_sample_release(struct bpf_ringbuf *rb, size_t size, u64 flags)
>  {
> -	u64 consumer_pos;
> +	unsigned long consumer_pos;
>  	u32 rounded_size = round_up(size + BPF_RINGBUF_HDR_SZ, 8);
>  
>  	/* Using smp_load_acquire() is unnecessary here, as the busy-bit
> diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
> index 02199364db13..141030a89370 100644
> --- a/tools/lib/bpf/ringbuf.c
> +++ b/tools/lib/bpf/ringbuf.c
> @@ -237,7 +237,13 @@ static int64_t ringbuf_process_ring(struct ring *r)
>  	do {
>  		got_new_data = false;
>  		prod_pos = smp_load_acquire(r->producer_pos);
> -		while (cons_pos < prod_pos) {
> +
> +		/* Check if there's data available by computing the signed delta
> +		 * between cons_pos and prod_pos; a negative delta indicates that the
> +		 * consumer has not caught up. This formulation is robust to prod_pos
> +		 * wrapping around.
> +		 */
> +		while ((long)(cons_pos - prod_pos) < 0) {

Same here. Doing a != is much more clear, in my opinion. Not a blocker
though.

[...]

Thanks,
David

