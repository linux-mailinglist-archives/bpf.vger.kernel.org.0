Return-Path: <bpf+bounces-50842-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54328A2D367
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 04:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E77351691F3
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 03:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F44C15575C;
	Sat,  8 Feb 2025 03:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NmfzEatd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5325814EC73;
	Sat,  8 Feb 2025 03:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738984025; cv=none; b=HSxy4MNJNV523GurohNqlGQColzIW7h2p8REruDkbMUguO26ep0NaNmCFtGA6SKMGMs1bv6j0PxJa3qzAM/wjEtDX9VN+qaEZ0n0mx9J9SiOIqQ4vkgqriRmjm4v+0z/Ls0/0F/PZLd71BJzuWNv9dfLYJhAmtqFTosYIVsdrRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738984025; c=relaxed/simple;
	bh=eUN69pSE2p33cg/Ux0XHC7lzskJjFxo1sO+BxL2HRSY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QIx7jpOhbSwNJLD3paJDwjTfFU0bPBAVfDu0vE4vS5lvyV0yKJQo3clgLC3GxpDm0dJFMFJj/DpZ024ccdJ09FK8a1jSJJatHdiDJvzbihwz6rpkcmCbmlj8YvX2K76A7mfrRr3R3RBsDi8ehzOEQ7pIiZR65XChPwu+0O42kKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NmfzEatd; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-5de51a735acso1788070a12.0;
        Fri, 07 Feb 2025 19:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738984022; x=1739588822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MBox1Ru0/q1X9mfxYYqhzob8E2RrC/ujp4XTiHzvfE4=;
        b=NmfzEatdRl5jEEPHPFlCBZK4/MF/pxaXzmt0MJ5WKP7cv3ws4C39jvvzTI1HIGP6NR
         +9gr9jyH7CZnWZcCt2/UaEPe0pZ7vnPXBK4ysiQ3k+bsUeRPRLfR+XBPqq5lxLukhpCE
         WQtAjAMKEbRbfneWt6gSN637Kc54XHvLiCqLv3a0ycTZHoAHqzuJVVJaMXhTCcmOpkgh
         1qCY54rtFy9xBROd7YiLnuOvZ+bfIE06tgiC+lNn+0yAoBSvYSEWODgxEUujDohdY0iB
         vk4cNBSSa6KqvGK0fv7c5aYFOg51ACOU67lXAvnrLNkFu3vXJki2dRUnsklvyb5x53a1
         TIlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738984022; x=1739588822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MBox1Ru0/q1X9mfxYYqhzob8E2RrC/ujp4XTiHzvfE4=;
        b=OZ5wA1xWD1Zsds8Gc2teWOGSZvjZtjT/zUQfLzOV0BuuaUkUaRQu6csGdzWJuCpQzL
         JiAUluMwswq8G7Qfpm76tdysxXHzW+CuU25d58ZA/96mODyLo3+NK9E8+B8+kvrMZcl9
         ozcatPdJp0ChNhy9PSbmXmopNEubfIlqlwKjfKLdCD1Ny7TSnLgfoRaGh/2ixoOu2GX4
         XcNBb96fTZvwXXKbG3Pe0Pu2twFOc4hgL/WucS+E/0Ac4mneqLvwcdWJlW5WHDx3lK6I
         3ArgPzLDqggBdRAYDu8CwYUJMkrC8TMLI9957AGtoVNyJ1e3tugs/rdY2MRglKEscbjy
         PQ+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUn5B9MY0KxhlU87+Wz23Q83tHMJbqz7sbdoKrr+Bc4ZoaYTBMZg63KoFh9Lj2Rh9FcT9w8ZjvUGbOulVs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkTLfI7jQbqv5mIcc9KsScH9P1FirU4EUcfl0G1B5KH/2d9euL
	DELedRmOZVWYM/QRDMf0spB/TzCPaAPtmydg6EnOsJRScRGQMyYPWocVNx13SPgeOyXqyUoaSss
	mnHc7f4gzJwgT1FP4wlcTU1IADpQ=
X-Gm-Gg: ASbGncs/b7wEeM8kJl1xyJ4YaDGZUkfpMDhDzvN1rmGmYkjlOuKXThOzGIRGINSy+21
	zkTcoPu/7yQWEwhbunXhJc96XpbLV1TulFK3+43o77D+e+vCbGZOw8v5G2k8cnPcb3qKlpfWiNB
	E=
X-Google-Smtp-Source: AGHT+IE/yaD2Q6lmC5n7VIivqrMKarHxR7halFuBWdgQHjxnRem/0Src24G3aPVG9tKLdsgtnMmFxGpaJdRV2csNbJw=
X-Received: by 2002:a05:6402:4606:b0:5dc:d443:2460 with SMTP id
 4fb4d7f45d1cf-5de4508d723mr6339553a12.25.1738984021499; Fri, 07 Feb 2025
 19:07:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206105435.2159977-1-memxor@gmail.com> <20250206105435.2159977-20-memxor@gmail.com>
 <CAADnVQLNovQYGy6_zGDi75vmNHfZ-hKz4G=gWF4Bis8b6iTYew@mail.gmail.com>
In-Reply-To: <CAADnVQLNovQYGy6_zGDi75vmNHfZ-hKz4G=gWF4Bis8b6iTYew@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sat, 8 Feb 2025 04:06:24 +0100
X-Gm-Features: AWEUYZlxE5io8QCZeMIMt4H7zuhUJpJx7vxq6S4IL5pYrj3V1cbxu0WKSn3cq4M
Message-ID: <CAP01T75jGfMXRrqpff4y5B5wrGBQeiJtJpTu6BpSFMg+AV1jaw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 19/26] bpf: Convert hashtab.c to rqspinlock
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Will Deacon <will@kernel.org>, Waiman Long <llong@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>, Barret Rhoden <brho@google.com>, 
	Josh Don <joshdon@google.com>, Dohyun Kim <dohyunkim@google.com>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 8 Feb 2025 at 03:01, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Feb 6, 2025 at 2:55=E2=80=AFAM Kumar Kartikeya Dwivedi <memxor@gm=
ail.com> wrote:
> >
> > Convert hashtab.c from raw_spinlock to rqspinlock, and drop the hashed
> > per-cpu counter crud from the code base which is no longer necessary.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  kernel/bpf/hashtab.c | 102 ++++++++++++++-----------------------------
> >  1 file changed, 32 insertions(+), 70 deletions(-)
> >
> > diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> > index 4a9eeb7aef85..9b394e147967 100644
> > --- a/kernel/bpf/hashtab.c
> > +++ b/kernel/bpf/hashtab.c
> > @@ -16,6 +16,7 @@
> >  #include "bpf_lru_list.h"
> >  #include "map_in_map.h"
> >  #include <linux/bpf_mem_alloc.h>
> > +#include <asm/rqspinlock.h>
> >
> >  #define HTAB_CREATE_FLAG_MASK                                         =
 \
> >         (BPF_F_NO_PREALLOC | BPF_F_NO_COMMON_LRU | BPF_F_NUMA_NODE |   =
 \
> > @@ -78,7 +79,7 @@
> >   */
> >  struct bucket {
> >         struct hlist_nulls_head head;
> > -       raw_spinlock_t raw_lock;
> > +       rqspinlock_t raw_lock;
>
> Pls add known syzbot reports as 'Closes:' to commit log.

Ack, I've found [0] and [1], I will dig for more, see which ones this
applies to and add them to the commit log.

  [0]: https://lore.kernel.org/bpf/CAPPBnEZpjGnsuA26Mf9kYibSaGLm=3DoF6=3D12=
L21X1GEQdqjLnzQ@mail.gmail.com/
  [1]: https://lore.kernel.org/bpf/CAADnVQJVJADKw0KC6GzhSOjA8DJFammARKwVh+T=
eNAD7U3h91A@mail.gmail.com/

