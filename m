Return-Path: <bpf+bounces-66254-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C156EB30307
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 21:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5133C1CE53CD
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 19:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A67331DD90;
	Thu, 21 Aug 2025 19:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mn1C/QQ2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EA12E9EC3;
	Thu, 21 Aug 2025 19:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755804920; cv=none; b=UESsWjIFfUJDBGCgudtJA4mIXhjUGOuzPGPvwQHfBW8E3KrrYz5PPr3bCUQ4TManKZomUBmwihE9NcV5CSIV3lTE7NGWhP0ILl9qlSsTOwe6fOfFOtxdBp0Ay94JI1/71IwbGIuEposDsN/bTnesGoNDQ6DAvDz4447khrBGgPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755804920; c=relaxed/simple;
	bh=zVYORrV3xvPzZC0lqZluOEBRUpi0x6/kImo0912h0oU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n7I1MAu6XhIK0Jc4fGJ0oqzeh97+4CBXfYjwIqhS79ZcVD34hHrOvKL4e0vOaRjnh6NA6mPv676y7b4/nRoFHPRsQdQJXcQHb8K5q0E30Bu9MeUEDDDO8f0WUKpj2YTU5lI93qFZ+Zjhx0KA3LnKBq++2ZV0bdA3uW1Tagm4h6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mn1C/QQ2; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-32326e06496so1459556a91.2;
        Thu, 21 Aug 2025 12:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755804918; x=1756409718; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KAz6RkEg0OrXkCTT4M/+ol/595xNRw+z2M9Ted0mLkc=;
        b=mn1C/QQ2GTHZllVQ5Zdq3ZIZCr4P7UcbxZZdzka2VmWj3iF3MwtpLpmngc0mvhAFkP
         RSLJ8u4I5Ebmo6bIsUCwS1DXAUsyYb5nh55l/Kg1Zi6ZgBGzrbFADMnbzkyeaHBaHdAB
         eH2xmEcniB7hGs1ISlOdV6wJ8KXkiSgcwpngzf5h59oyGGgf0gsxjVExf7Pe0uRXNDQB
         MQBoWxbv/sHjLel5KDKDNphVnbl3AHnZFpY0YWjTnsn1LnZViJ88+uzVxBSKBYEYXj/g
         8c8sTV2Qkdwiod+7k/EtpQwl52+JVBuKqRWaYEkCXZwGZNg4Gw25dor0fNnsEGdSehz2
         W1sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755804918; x=1756409718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KAz6RkEg0OrXkCTT4M/+ol/595xNRw+z2M9Ted0mLkc=;
        b=eXquaGtb1cOfJuh34J9mL3kaKCzNrGbXG/cQ6xNx1+lPB7SIqXSUoHTPHZDKjQw625
         xbwe+/Dd4PJFaSZ939aHr7q00q0/BvcT9IwZdXVGu68jgudadm6jLHXwn5Fp4XfqSZ4K
         UsxVQPb4Lh82j2rEPsGt69nCmOR65T7MrKWiedN6SnGeKLliA13kvD4hDNDeRBjOa0/0
         apLXtGZTZEE8YmuRjDgIx8wzSE3N2t6zHU3jNHeBOhmqGiyTRec/jc339CM5AuwDdrMx
         DRWxFGVw48n3JsHk+XkFoZgeTzXhqkWDPhTH4wvc8qFHA/JPPpTBnbe3nM9tlrWj/uaW
         3CCw==
X-Forwarded-Encrypted: i=1; AJvYcCUfFbzpYLc44ilqP+fedVtTr3EF96M39IfMt4ORLVhvj2+aQ+d/Nnyo9bYOLCwtnX863ZZD60Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaOeRjnzGIPbQKAA8pewQV6/O9xajdyww+dTp4qMkGjEu788+D
	EH0+i+Alf+wKWjMoSFTiCBtw3h2LHW5ICEiU4OnXlha7N7V5w94l9VKdkbI+TDdBUnv8pT7KaL9
	6loknlh5k6OS6qGWmnC/FfTtudYLrYzw=
X-Gm-Gg: ASbGncuHbANWAJqEvAxzjuyy5khWzH0sabCnymCVcURD1UTNPTodLXhDhhWXdrjb7CR
	QUE4kMFKtbeWo4sRrIk5jdpuargsyEcb2jbzboof92HyRq1d9IRJybA7hZbWY/+Kin/yjsarABd
	iIcRkqbYzv73d3pBSsUgCIZMXrT0PvXPwebknv5f1KRmhGbEtNi5eilQGQpxfBoVh/wz4jBwDCE
	l6SQ623kW5RodAnAAAlO3gngSvmNneJGQ==
X-Google-Smtp-Source: AGHT+IHD7OWk3rVL7m40pLNIkp4GQ+V5pYm/LbUYX/B5v6OXXdIWEV+3ghK8DSSgyfliBZRPc6ubcgmypP/upyJJgM4=
X-Received: by 2002:a17:90b:1b12:b0:312:1ae9:152b with SMTP id
 98e67ed59e1d1-32515eabbd5mr868214a91.23.1755804917588; Thu, 21 Aug 2025
 12:35:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821162600.1627359-1-memxor@gmail.com>
In-Reply-To: <20250821162600.1627359-1-memxor@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 21 Aug 2025 12:35:01 -0700
X-Gm-Features: Ac12FXzRK87Akw4wT6P8Fem4Aa-rklyf9XgglLVgh59mJB01fk2t3t_S60GeN5o
Message-ID: <CAEf4BzbktGvr4H+A20=aXbANvG5KwmSkxnx40=2y4xiMTYDdoA@mail.gmail.com>
Subject: Re: [PATCH bpf v1] bpf: Drop rqspinlock usage in ringbuf
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, kkd@meta.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 9:26=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> We noticed potential lock ups and delays in progs running in NMI context
> with the rqspinlock changes, which suggests more improvements need to be
> made before we can support ring buffer updates in such a context safely.
> Revert the change for now.
>
> Reported-by: Josef Bacik <josef@toxicpanda.com>
> Cc: stable@vger.kernel.org
> Fixes: a650d38915c1 ("bpf: Convert ringbuf map to rqspinlock")
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  kernel/bpf/ringbuf.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
>

patch bot seems to be ignoring this patch, it was applied to bpf tree, than=
ks!

> diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
> index 719d73299397..1499d8caa9a3 100644
> --- a/kernel/bpf/ringbuf.c
> +++ b/kernel/bpf/ringbuf.c
> @@ -11,7 +11,6 @@
>  #include <linux/kmemleak.h>
>  #include <uapi/linux/btf.h>
>  #include <linux/btf_ids.h>
> -#include <asm/rqspinlock.h>
>
>  #define RINGBUF_CREATE_FLAG_MASK (BPF_F_NUMA_NODE)
>
> @@ -30,7 +29,7 @@ struct bpf_ringbuf {
>         u64 mask;
>         struct page **pages;
>         int nr_pages;
> -       rqspinlock_t spinlock ____cacheline_aligned_in_smp;
> +       raw_spinlock_t spinlock ____cacheline_aligned_in_smp;
>         /* For user-space producer ring buffers, an atomic_t busy bit is =
used
>          * to synchronize access to the ring buffers in the kernel, rathe=
r than
>          * the spinlock that is used for kernel-producer ring buffers. Th=
is is
> @@ -174,7 +173,7 @@ static struct bpf_ringbuf *bpf_ringbuf_alloc(size_t d=
ata_sz, int numa_node)
>         if (!rb)
>                 return NULL;
>
> -       raw_res_spin_lock_init(&rb->spinlock);
> +       raw_spin_lock_init(&rb->spinlock);
>         atomic_set(&rb->busy, 0);
>         init_waitqueue_head(&rb->waitq);
>         init_irq_work(&rb->work, bpf_ringbuf_notify);
> @@ -417,8 +416,12 @@ static void *__bpf_ringbuf_reserve(struct bpf_ringbu=
f *rb, u64 size)
>
>         cons_pos =3D smp_load_acquire(&rb->consumer_pos);
>
> -       if (raw_res_spin_lock_irqsave(&rb->spinlock, flags))
> -               return NULL;
> +       if (in_nmi()) {
> +               if (!raw_spin_trylock_irqsave(&rb->spinlock, flags))
> +                       return NULL;
> +       } else {
> +               raw_spin_lock_irqsave(&rb->spinlock, flags);
> +       }
>
>         pend_pos =3D rb->pending_pos;
>         prod_pos =3D rb->producer_pos;
> @@ -443,7 +446,7 @@ static void *__bpf_ringbuf_reserve(struct bpf_ringbuf=
 *rb, u64 size)
>          */
>         if (new_prod_pos - cons_pos > rb->mask ||
>             new_prod_pos - pend_pos > rb->mask) {
> -               raw_res_spin_unlock_irqrestore(&rb->spinlock, flags);
> +               raw_spin_unlock_irqrestore(&rb->spinlock, flags);
>                 return NULL;
>         }
>
> @@ -455,7 +458,7 @@ static void *__bpf_ringbuf_reserve(struct bpf_ringbuf=
 *rb, u64 size)
>         /* pairs with consumer's smp_load_acquire() */
>         smp_store_release(&rb->producer_pos, new_prod_pos);
>
> -       raw_res_spin_unlock_irqrestore(&rb->spinlock, flags);
> +       raw_spin_unlock_irqrestore(&rb->spinlock, flags);
>
>         return (void *)hdr + BPF_RINGBUF_HDR_SZ;
>  }
> --
> 2.50.0
>

