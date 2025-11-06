Return-Path: <bpf+bounces-73871-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FCEC3C9FA
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 17:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 755FC62170A
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 16:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFFA2D5425;
	Thu,  6 Nov 2025 16:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iz31QQrT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D922D0C64
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 16:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762447789; cv=none; b=rX+EiRq/9jOBtUEhct/UtBa2fgBz5F5ApM/TdF2HaAxwiS1RkifGn3m03gv5FiCZaTQAaYcsDEkv+wcHfZ28t4pqIE4hqF9WXE38g+AROxafpXCz9FQ09ricUCmqK6j6y22q8jBumWUpSZ5e8FrnGQJqNJI4ZmRneXS+cHPDRCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762447789; c=relaxed/simple;
	bh=n2XXN0Bjr6+9ntALT3xMFin90euQ3nppe5P7QRqcaww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XGNrKY64sf8YwFTlMLaICuxTi/7UeEvQYZBZ7APoMaiP3BoM9jc8ko4PNugrHe/YAfvj9rQQZKmsYqNa2d29KdQFqqcIYazxNkL3uK2ZCMjJZ94AM0AmG/AR3VwGemLhHQMbMqkG/QSU9vhrbQEp7UatAKnA7j8VGFyarNfbTVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iz31QQrT; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4711b95226dso14015965e9.0
        for <bpf@vger.kernel.org>; Thu, 06 Nov 2025 08:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762447786; x=1763052586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dw7JKGjBvE7rQKfutT85u2w4UGLf4tM7Sm2WK5FX608=;
        b=iz31QQrTDo8AQgjQEMFgoQK7M/TwwUB3eVIBGM8vmwcTLQNQ7+WexYrq8GZ/vb/ar5
         hvW6hEUNdLfYQHIzl6s3F03QBHcKOQDuWWTiv3HMCuCaUA63BZoF0W+98vjXIBhTz5J/
         HBOoSPf4cBhVhrj3yMvm09oEizYIG1Z2cwHmKS9yH03BRBRlFmgWHva1vsWe7RqrqB39
         a/X0QLDTqp+YinI3hLn86TKWn8dQs7yVovTmT6tBMEPCmhpltCkTFt6d2IS/8NjL4r4y
         aWm5/yxao5oTkoXohRIqdDK28WLa4xBgIFYpBcwO4SV/iemsAWTzZEAqLOPlSYL8x9/Q
         MMiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762447786; x=1763052586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dw7JKGjBvE7rQKfutT85u2w4UGLf4tM7Sm2WK5FX608=;
        b=bmnysMRri34YFpXlGRBgQqBNs7WRmNhtb+bXja2xIvUKLkDRhDJjzys+8jqUlXAMYY
         hyBnVJpJ+G5J+vs6P7+BMHWqBgtiiILs9x1hGhMJscxKfnbfnPKVwNP5pgx8TrfjUtt0
         NWLjxcQ0rTaZ/zbINR5IMQpuVBms7XMxiJKFBmMr/o3Gp4RlUZevWLrZdwC4wlotMBuy
         DP5/Fl3Z62ptJq6Ybq8Ltbzdp3JQhZJUe8TqdF2QuiXfrNkwuVn2LMF/ZE7zhF5Gp5Kd
         06ktte4XJ+B0GUJ9TKSDTD9mtT1pcbUtZHt4TJAOSNepG5WDbOWw0kzv5cvD3kIejzbW
         smjQ==
X-Gm-Message-State: AOJu0Yyd6Deti0uUTBI8LU1NT3m/NyEG7R2yLVFn9dDnthOQ+AtOT6iW
	zjkDnpxSgClH0LNJz9hd94dBtfQ2zSy5unrTS2P0YvTk4AuN2qy0lFi4tPB+AdtihQE8yKpR1Vj
	2ExakRadnomwe09FZnEoFPHZyRqHMyRI=
X-Gm-Gg: ASbGncveObPThX7aobx4zOth5302cdP7Foe57tC/K4j4HKidrTRUZTRaa1WocavsXlq
	xYYcKljoHwgnLqLVAxSIVOZD7voBkercxavqFkkawLnylQpjkLc57Xwe9tNaVXQ2Gpzs3wHOyox
	TFEr1B+gZXFxOQxAI2DAq06wUr/vcZ6M7OLTCs4EcjwD0VLn1YlAX/dmnkaJjn9YiYAizznqCsQ
	whIhT4Rf+to6wqks3yKgaf0nw7b25paJi2G3NgvPbfCQvCLzMK3PB8ok0RC8y72wLksPiAAFkYk
	o9+fKNyyM/JrPWjsdGngHg==
X-Google-Smtp-Source: AGHT+IE96h1dvzltd/0HPIybmFtJjf4bA38ij/9gfaS7gFr55US7q6gFY73v6h+TSKblo99FxIrdjx/afwZI5sxsB/4=
X-Received: by 2002:a05:6000:3107:b0:3eb:9447:b97a with SMTP id
 ffacd0b85a97d-429e330d7f9mr7340738f8f.54.1762447786186; Thu, 06 Nov 2025
 08:49:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106162935.7146-1-puranjay@kernel.org>
In-Reply-To: <20251106162935.7146-1-puranjay@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 6 Nov 2025 08:49:33 -0800
X-Gm-Features: AWmQ_bnGw4wRgfWGSzKDNrzQPaXJIEasZi6MTKE9pBkMvh7OKl7wXUAf5Ig18Ok
Message-ID: <CAADnVQKRAVPmmUrS6VAiPm13P3XgwkOqmd7kDurbTR8jcFqD4g@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Use kmalloc_nolock() in range tree
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Puranjay Mohan <puranjay12@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 8:29=E2=80=AFAM Puranjay Mohan <puranjay@kernel.org>=
 wrote:
>
> The range tree uses bpf_mem_alloc() that is safe to be called from all
> contexts and uses a pre-allocated pool of memory to serve these
> allocations.
>
> Replace bpf_mem_alloc() with kmalloc_nolock() as it can be called safely
> from all contexts and is more scalable than bpf_mem_alloc().
>
> Remove the migrate_disable/enable pairs as they were only needed for
> bpf_mem_alloc() as it does per-cpu operations, kmalloc_nolock() doesn't
> need this.
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  kernel/bpf/range_tree.c | 22 +++++++---------------
>  1 file changed, 7 insertions(+), 15 deletions(-)
>
> diff --git a/kernel/bpf/range_tree.c b/kernel/bpf/range_tree.c
> index 37b80a23ae1a..2f28886f3ff7 100644
> --- a/kernel/bpf/range_tree.c
> +++ b/kernel/bpf/range_tree.c
> @@ -2,7 +2,6 @@
>  /* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
>  #include <linux/interval_tree_generic.h>
>  #include <linux/slab.h>
> -#include <linux/bpf_mem_alloc.h>
>  #include <linux/bpf.h>
>  #include "range_tree.h"
>
> @@ -21,7 +20,7 @@
>   * in commit 6772fcc8890a ("xfs: convert xbitmap to interval tree").
>   *
>   * The implementation relies on external lock to protect rbtree-s.
> - * The alloc/free of range_node-s is done via bpf_mem_alloc.
> + * The alloc/free of range_node-s is done via kmalloc_nolock().
>   *
>   * bpf arena is using range_tree to represent unallocated slots.
>   * At init time:
> @@ -150,9 +149,8 @@ int range_tree_clear(struct range_tree *rt, u32 start=
, u32 len)
>                         range_it_insert(rn, rt);
>
>                         /* Add a range */
> -                       migrate_disable();
> -                       new_rn =3D bpf_mem_alloc(&bpf_global_ma, sizeof(s=
truct range_node));
> -                       migrate_enable();
> +                       new_rn =3D kmalloc_nolock(sizeof(struct range_nod=
e), __GFP_ACCOUNT,
> +                                               NUMA_NO_NODE);

bpf_global_ma would consistently charge root memcg, since it is
saved at init time, while above kmalloc_nolock() will charge
random current task.
Let's drop __GFP_ACCOUNT.
The rest looks good.

pw-bot: cr

