Return-Path: <bpf+bounces-8224-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F92783925
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 07:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0748B280F01
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 05:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C9F1FD9;
	Tue, 22 Aug 2023 05:16:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D481FA1
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 05:16:01 +0000 (UTC)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0BCDDB
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 22:15:59 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-50079d148aeso3228216e87.3
        for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 22:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692681358; x=1693286158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=igC1dQAIIzPzYds1gpe+w5vkYCOQIxb9+V+C3FfP0gY=;
        b=swdrUCoxtIbJ/UgiOcV1KYs6Sa74rHVijN/bC4JtbuX9OSj5uIi9TL46CI/sWksYtT
         xre2UYVz7zn7LSm0XWtMukPrbLpLHBcdGrP0IOy1ADogg5Ag/42gYPZMcmBIFmK2PqSG
         BeHf5xYomKdGyaoFmDjCc+xEZVt6wULz2O5a3jpERYzjbgIcGLxxoTHsrqwjQZ3Cb8FB
         9puOfxnHw6DlBVMc/oSh/T/koBbjpLqhj6cd9OLBiQfKRIOLJiNqXnT7Vjo1XeMxE+lk
         kZ7Zayqdt/QSX/Gnla0VvgW4UC+NtnedpENyLEyqzU6pryXEYkrtR4IFZ0Vd87YcA77/
         SmFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692681358; x=1693286158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=igC1dQAIIzPzYds1gpe+w5vkYCOQIxb9+V+C3FfP0gY=;
        b=kWxjuLH92N18qQ4sbuxgeXXXO8BRaFpEKE1x46CJKzIBGGtB7bVQbJims77Qpv2nHZ
         xDoERapYXwd7kgCYiqjX8rYKkPWA/1/YWPzzFrK5FW20cZRE4Guk61mRKFC1C66orSr3
         0k2FBOwX4Bc5vnUPPLl8O4Uqi1wuFsk4y0QTuX8pw97zgUC6BSE2BocpdHGNIJlNQint
         S+8paIjfW5r5hfXpwhLuk5D5B/wx4XjJxFAbd7TjP2zrx9wT7pruR/AXdFKSj3yFkRCh
         sDpcBRKK7Lx2QqbF/0YrAgreS/w/dMbvekTGNYMyqZFPyL3Kh/YDBf/iuBql5KPvmxE3
         jzrA==
X-Gm-Message-State: AOJu0Yzg3UQe2W/8+jmtvE3GHs68R2XTyxr6zdR84oqW65SMJBN5l8v0
	qev4KCTSJyj+oZXJ+JAGyTGMMNy+egUsoLGEmGHqQc9ahS8=
X-Google-Smtp-Source: AGHT+IHpPSVYbvHFZN1MDLh53k9DPl8RpNOc826i2d/Ks+9I/fUsimpQGzU1ufkk2pH52vSZnkanIBPzoShGyfvjy3c=
X-Received: by 2002:a05:6512:ad1:b0:4f8:e4e9:499e with SMTP id
 n17-20020a0565120ad100b004f8e4e9499emr6447525lfu.12.1692681357802; Mon, 21
 Aug 2023 22:15:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230724132404.1280848-1-awerner32@gmail.com>
In-Reply-To: <20230724132404.1280848-1-awerner32@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 21 Aug 2023 22:15:45 -0700
Message-ID: <CAEf4BzZQQ=fz+NqFHhJcqKoVAvh4=XbH7HWaHKjUg5OOzi-PTw@mail.gmail.com>
Subject: Re: [PATCH] libbpf: handle producer position overflow
To: Andrew Werner <awerner32@gmail.com>
Cc: bpf@vger.kernel.org, kernel-team@dataexmachina.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 24, 2023 at 6:24=E2=80=AFAM Andrew Werner <awerner32@gmail.com>=
 wrote:
>
> Before this patch, the producer position could overflow `unsigned
> long`, in which case libbpf would forever stop processing new writes to
> the ringbuf. This patch addresses that bug by avoiding ordered
> comparison between the consumer and producer position. If the consumer
> position is greater than the producer position, the assumption is that
> the producer has overflowed.
>
> A more defensive check could be to ensure that the delta is within
> the allowed range, but such defensive checks are neither present in
> the kernel side code nor in libbpf. The overflow that this patch
> handles can occur while the producer and consumer follow a correct
> protocol.

Yep, great find!

>
> A selftest was written to demonstrate the bug, and indeed this patch
> allows the test to continue to make progress past the overflow.
> However, the author was unable to create a testing environment on a
> 32-bit machine, and the test requires substantial memory and over 4

2GB of memory for ringbuf, right? Perhaps it would be good to just
outline the repro, even if we won't have it implemented in selftests.
Something along the lines of: a) set up ringbuf of 2GB size and
reserve+commit maximum-sized record (UMAX/4) constantly as fast as
possible. With 1 million records per second repro time should be about
4.7 hours. Can you please update the commit with something like that
instead of a vague "there is repro, but I won't show it ;)" ? Thanks!

> hours to hit the overflow point on a 64-bit machine. Thus, the test
> is not included in this patch because of the impracticality of running
> it.
>
> Additionally, this patch adds commentary around a separate point to note
> that the modular arithmetic is valid in the face of overflows, as that
> fact may not be obvious to future readers.
>
> Signed-off-by: Andrew Werner <awerner32@gmail.com>
> ---
>  tools/lib/bpf/ringbuf.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
> index 02199364db13..6271757bc3d2 100644
> --- a/tools/lib/bpf/ringbuf.c
> +++ b/tools/lib/bpf/ringbuf.c
> @@ -237,7 +237,11 @@ static int64_t ringbuf_process_ring(struct ring *r)
>         do {
>                 got_new_data =3D false;
>                 prod_pos =3D smp_load_acquire(r->producer_pos);
> -               while (cons_pos < prod_pos) {
> +
> +               /* Avoid signed comparisons between the positions; the pr=
oducer

"signed comparisons" is confusing and invalid, as cons_pos and
prod_pos are unsigned and comparison here is unsigned. What you meant
is inequality comparison, which is invalid when done naively (like it
is done in libbpf right now, sigh...), if counters can wrap around.

> +                * position can overflow before the consumer position.
> +                */
> +               while (cons_pos !=3D prod_pos) {

I'm wondering if we should preserve the "consumer pos is before
producer pos" check just for clarity's sake (with a comment about
wrapping around of counters, of course) like:

if ((long)(cons_pos - prod_pos) < 0) ?

BTW, I think kernel code needs fixing as well in
__bpf_user_ringbuf_peek (we should compare consumer/producer positions
directly, only through subtraction and casting to signed long as
above), would you be able to fix it at the same time with libbpf?
Would be good to also double-check the rest of kernel/bpf/ringbuf.c to
make sure we don't directly compare positions anywhere else.

>                         len_ptr =3D r->data + (cons_pos & r->mask);
>                         len =3D smp_load_acquire(len_ptr);
>
> @@ -498,6 +502,11 @@ void *user_ring_buffer__reserve(struct user_ring_buf=
fer *rb, __u32 size)
>         prod_pos =3D smp_load_acquire(rb->producer_pos);
>
>         max_size =3D rb->mask + 1;
> +
> +       /* Note that this formulation in the face of overflow of prod_pos
> +        * so long as the delta between prod_pos and cons_pos remains no
> +        * greater than max_size.
> +        */
>         avail_size =3D max_size - (prod_pos - cons_pos);
>         /* Round up total size to a multiple of 8. */
>         total_size =3D (size + BPF_RINGBUF_HDR_SZ + 7) / 8 * 8;
> --
> 2.39.2
>
>

