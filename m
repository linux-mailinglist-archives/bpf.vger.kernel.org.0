Return-Path: <bpf+bounces-37897-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E466E95C040
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 23:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3099285E1D
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 21:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B495E13B5A1;
	Thu, 22 Aug 2024 21:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MuL2Xl+a"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA0A1C9DCA;
	Thu, 22 Aug 2024 21:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724362219; cv=none; b=AqhhSbhSLX3kkxoHHume9u1agDIwGPBHgly49yAS5FtjcVPZiGnkuWbwAI+fSFQ5grmqNx/+qLiNMiww4SmWfmh5/eAQ4u50iHreaxu9/54cckl7aZJEp6Bqa4nkhpc0a3DryK5ie710hieh5+nOL+AzGfbakMjhaM/nWTGytW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724362219; c=relaxed/simple;
	bh=HxQ1ZKGfrzmZSG3KFUci/ypHgXDR1B2T1pTxSYdtIT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XQRigaBK1T01XuBhgAImxaWUqZIa/6Tsev3sn26YePnPyPhfRhqvofLOBvj77xrwK/QP3LHgYPLihFcM8/urCJju3w8WSJ8BxowHNJFH06/015TfjLsNjNmXuosaer6TWrJQr//bePb/ueVWtJmzLZU/eprQPZJq8VUCPB01Jdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MuL2Xl+a; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2d3bae081efso1038276a91.1;
        Thu, 22 Aug 2024 14:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724362217; x=1724967017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4+TJIlUwUJ9hgjBi9o/p5QhSSN2jZ8c5fYnfKIVc18I=;
        b=MuL2Xl+a3hZps4hDHBIYw8YvCZdHej+0mUKhXdXrYIeR7OJKb7yCEZydq8irRayjV2
         D4BEWE6dK1QGf4vlIbBaP/aYoxdtE3whySJoEcuLEYfmiW4IdgV9c2ZUTdfBhU0a2Bhb
         OAkolMpr6Tc65BBrcMj0YQ/w7KdkUocVqkRxvEWTBd7ywtbL8kuFglefuDTzQ+Si4f14
         tvH/8oIr0gWrFoNMVQJaXcPU0xUGKvc8Su7G75aW2j2gnF1cEHfFLkk3CarD/FuzHeq/
         kc5AyrxgLRBcroSYcOtJlPTrm5X8g0D288LK7R2oFXl4IMe7KRCX4xrA6hmXl2VsxZq9
         67KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724362217; x=1724967017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4+TJIlUwUJ9hgjBi9o/p5QhSSN2jZ8c5fYnfKIVc18I=;
        b=XuyFFBVr6L9lrOa7onvrjuqNdTxDd60LVk20hjKuSy/BzIuGyr+Rz2OMkaXfS3uzQT
         PjQUgvgi5160BGG8f445lmchSsF3wdxaXTOorFRoUzoXQUQYXjUlGKggNyzo74TvEe52
         f3m8ZVfqd/DLEx2X+SgyObwJaPF1hyllhLQouR5AB8c+IqPHR0LIcPViSgf3GIoSZhUN
         7IH5cAeb47aMyd5dq7nAmMsTSz9OinsCrYd1BtGnA/CBMpjbTW7WcKb2CTOH0BpxEg78
         /nhCxh+QCqYQlm9oYlIZB4hD9eUYZRa0j755qxlSqaT0GBlswXk93UEB08/0op9l2OvJ
         qIiA==
X-Forwarded-Encrypted: i=1; AJvYcCV63nLBBMIbNukuZxDYZeStd8JVcE78o3C9eX/2gTG7EDTJ7uK9CJWnFSRgjwR6r5Z1JhM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjKLpQHfBppxJJDYw8wes0tHv/EM9uXO0/SiJlZwi9QsgxVEQ6
	92k279G/YT16w4j2ubTmqNzMgLy5lgu9hYlnTp7ZzOjL8tsL+m+qFu44pUsB3SGVL5dED8Fswas
	KcTM02xAk6dKTgiMxnud0dPnd204=
X-Google-Smtp-Source: AGHT+IFEqrRzHUuEyLe9zbo/4AfBd953mD/498jLomE8D/bY9UqszP8t4hDgcUaCfdwDOdoGol7jBMMCejysr+Ht3Fs=
X-Received: by 2002:a17:90b:4a52:b0:2d4:6ef:cb14 with SMTP id
 98e67ed59e1d1-2d5e9ec9bf8mr7506979a91.28.1724362217126; Thu, 22 Aug 2024
 14:30:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822082519.216070-1-vmalik@redhat.com>
In-Reply-To: <20240822082519.216070-1-vmalik@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 22 Aug 2024 14:30:03 -0700
Message-ID: <CAEf4BzbY4XWLFKgH1cB+86jsr0snRU2gG_UNZ7O1+3mg0hb9eQ@mail.gmail.com>
Subject: Re: [PATCH] objpool: fix choosing allocation for percpu slots
To: Viktor Malik <vmalik@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Matt Wu <wuqiang.matt@bytedance.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 1:27=E2=80=AFAM Viktor Malik <vmalik@redhat.com> wr=
ote:
>
> objpool intends to use vmalloc for default (non-atomic) allocations of
> percpu slots and objects. However, the condition checking if GFP flags
> are equal to GFP_ATOMIC is wrong and causes kmalloc to be used in most

I was confused by this, because original code has no equality and it
looks like correct code. But in reality GFP_ATOMIC is a collection of
bits (__GFP_HIGH|__GFP_KSWAPD_RECLAIM), and so `pool->gfp &
GFP_ATOMIC` will be true if either bit is set, hence your change.
Also, GFP_ATOMIC and GFP_KERNEL share ___GFP_KSWAPD_RECLAIM bit
specifically, which is what causes the use of kmalloc_node(), always.

It would be nice to expand on that in the commit. Other than that LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> cases (even if GFP_KERNEL is requested). Since kmalloc cannot allocate
> large amounts of memory, this may lead to unexpected OOM errors.
>
> For instance, objpool is used by fprobe rethook which in turn is used by
> BPF kretprobe.multi and kprobe.session probe types. Trying to attach
> these to all kernel functions with libbpf using
>
>     SEC("kprobe.session/*")
>     int kprobe(struct pt_regs *ctx)
>     {
>         [...]
>     }
>
> fails on objpool slot allocation with ENOMEM.
>
> Fix the condition to truly use vmalloc by default.
>
> Fixes: b4edb8d2d464 ("lib: objpool added: ring-array based lockless MPMC"=
)
> Signed-off-by: Viktor Malik <vmalik@redhat.com>
> ---
>  lib/objpool.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/objpool.c b/lib/objpool.c
> index 234f9d0bd081..fd108fe0d095 100644
> --- a/lib/objpool.c
> +++ b/lib/objpool.c
> @@ -76,7 +76,7 @@ objpool_init_percpu_slots(struct objpool_head *pool, in=
t nr_objs,
>                  * mimimal size of vmalloc is one page since vmalloc woul=
d
>                  * always align the requested size to page size
>                  */
> -               if (pool->gfp & GFP_ATOMIC)
> +               if ((pool->gfp & GFP_ATOMIC) =3D=3D GFP_ATOMIC)
>                         slot =3D kmalloc_node(size, pool->gfp, cpu_to_nod=
e(i));
>                 else
>                         slot =3D __vmalloc_node(size, sizeof(void *), poo=
l->gfp,
> --
> 2.46.0
>
>

