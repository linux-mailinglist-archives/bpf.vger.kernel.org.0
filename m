Return-Path: <bpf+bounces-55185-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2DF6A797B9
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 23:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C68E3ACC38
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 21:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5E61F3BA2;
	Wed,  2 Apr 2025 21:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VEJcHQKL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A83B15CD46;
	Wed,  2 Apr 2025 21:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743629741; cv=none; b=O1IJFAShbF0J/5L4XB4ekBu7WX9HQAI85UQBE3gGvbPyBWEosNN5L6Sb8CW81A9sZXYx5RI6qAnZhFHOkHgWnWAaKqo3rOFvcFh2K2MKVyTK58XLm/M5nMoBo2P/G1EEe87ONLqPVaadAB7ErRdMU7BnyNlIWlQpzS+1vx1okrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743629741; c=relaxed/simple;
	bh=fELnDgadF/0/43n/edjADETjqssxNy6wjdtsiuOzTA0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bRBXaVYVcC1fThykxp1xEZbrGQ4WM0Mw/IK7gQc+ahOs3mI17tociYVMhCiGTs8jF/QP5FXYAr4f8g6To1/yVITmHhxomadfx3MYkzY01l7aRmIK/pbz55Ngql0CfJK2vPfICfrBP99Bmb6TuVnJCdekoN0223F3CvXDRYD5v/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VEJcHQKL; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3912d2c89ecso237218f8f.2;
        Wed, 02 Apr 2025 14:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743629738; x=1744234538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=brdLyVda3kWWnBCMv/AMprmRoNH4Xu8Od2pJUYpkx9M=;
        b=VEJcHQKLMtUZSSodz71amQLDvxpu+KkFE9wglynETvWTgZp3JKZtxLr7sK8RYIQmDa
         NMbc4WC280SAmlk8MYRZyX/aquTY6uOrP07GKY89rkqPdAZbXar0dLyj5yxi/q009+iF
         mP73SyOUAYBry3sOg/5kN93BgpUGkNfQ9MNFYoyB35QogoyztUefMwyO5kcqMVkNwsjH
         MXVss5jfN3CI74NC8DB1A3/VRw4VMnlLNklnuiLu5MNrNaLiz5VvXvn9fU3ww7HXtxZH
         uWlEWmirybOpLa8qnm0uBwaQFkhyV1W+bZBFBGZLqoSjEkNS/1SEh0plrNTfhU1Lgi8T
         DgHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743629738; x=1744234538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=brdLyVda3kWWnBCMv/AMprmRoNH4Xu8Od2pJUYpkx9M=;
        b=RW4n+8OLgxI6F2V4aJRSWdh0BhkAvHI4kQhrok3MODjKmYHhSZpLqYKYRFF87DLJgp
         nnjrSs9n+pRNao4AlwPxe/Kz9d+gcRUiudzYN+YLi7/TaNGoWP1UjtBRsa0wGjtveopJ
         tdIYT8IH3idJXDJfPk78z99qIvciHoy3Xhotd57ttlC4VWYIQh3jMe5IdqQmQ/Wcff9M
         7mByJ62dMcio0afcGH38UvEhE/W9Oio5uOtqQ1cCnnEFAhPTwN414o9Anpr5ag4b0pCk
         uyiDZeK/mlr4wfjC9rlhsZKvPx3H52cxSm5ZxWvVdwWSLklfCHzNYTsAcelOcmehvB75
         gDAg==
X-Forwarded-Encrypted: i=1; AJvYcCVuiC6oKWntHDcpaXIruOEd+EBuDFlGHweyCqcNGXlVwV4fXygacDaZm8mJSjg2USVWu6o=@vger.kernel.org, AJvYcCW7ke+TwqQ6Hj1TnpXB4picTfj/7BZ0vdriff8wRhWM+R9OcOCstaNW3n7HU8K/CGNfmxeZknoz7nX2soVC@vger.kernel.org
X-Gm-Message-State: AOJu0YzX9QR62ZmkiwmMMqGRxVwNbAIhn6xMnmxla7hKHpS3WBslqXzL
	aIzC2Z7l3AwtgAv6CcWsxoWh0Lb8LagAOMA58HDXdvVIzJW9Ogv79UB9I0NhfEcXMkLMlf4wd1G
	oirS92Rc9kfK5233lx/5jIVBT04E=
X-Gm-Gg: ASbGncvXSgnkpQ45lAkUEBD+TEuyjbQoWUiOyMoUGrsRY84BVJlgiDzoDNmIv1/Udb0
	+QaHA4OpfErDwGuHxJbZ567XLbkGuZABuwC3vOF62gAb4YYPgb6ZFLxPXBbFEcagYVolt52/BWu
	XwD+Bn4SPyy5iM38EkByqWib1pCzsMWIzdKS9LlBPjtQ==
X-Google-Smtp-Source: AGHT+IEh9khh+XQxrrKzL3uCJcHHvKQ0W3+YC2DI86Fj1nx/H0McXWdoZl2jTZBX0khsEyydafgJXVelhh6XrjkK4I4=
X-Received: by 2002:a05:6000:184e:b0:39c:12ce:6a0 with SMTP id
 ffacd0b85a97d-39c12ce0a88mr15273076f8f.21.1743629738008; Wed, 02 Apr 2025
 14:35:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250401005134.14433-1-alexei.starovoitov@gmail.com>
 <20250402073032.rqsmPfJs@linutronix.de> <62dd026d-1290-49cb-a411-897f4d5f6ca7@suse.cz>
In-Reply-To: <62dd026d-1290-49cb-a411-897f4d5f6ca7@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 2 Apr 2025 14:35:26 -0700
X-Gm-Features: AQ5f1JreU4qniINicaLDIO4I4wqpWG0ejlHxOSbuNTXbXoAmlEP09YUm-6nmaPI
Message-ID: <CAADnVQLce4pH4DJW2WW6W2-ct-17OnQE7D8q7KiwdNougis2BQ@mail.gmail.com>
Subject: Re: [PATCH] locking/local_lock, mm: Replace localtry_ helpers with
 local_trylock_t type
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, 
	bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Michal Hocko <mhocko@suse.com>, linux-mm <linux-mm@kvack.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 2, 2025 at 2:02=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wro=
te:
>
> On 4/2/25 09:30, Sebastian Andrzej Siewior wrote:
> > On 2025-03-31 17:51:34 [-0700], Alexei Starovoitov wrote:
> >> From: Alexei Starovoitov <ast@kernel.org>
> >>
> >> Partially revert commit 0aaddfb06882 ("locking/local_lock: Introduce l=
ocaltry_lock_t").
> >> Remove localtry_*() helpers, since localtry_lock() name might
> >> be misinterpreted as "try lock".
> >
> > So we back to what you suggested initially. I was more a fan of
> > explicitly naming things but if this is misleading so be it. So
> >
> > Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> >
> > While at it, could you look at the hunk below and check if it worth it?
> > The struct duplication and hoping that the first part remains the same,
> > is hoping. This still relies that the first part remains the same but=
=E2=80=A6
>
> I've updated your fixups to v2
> https://lore.kernel.org/all/20250401205245.70838-1-alexei.starovoitov@gma=
il.com/

Sebastian, Vlastimil,
Thanks for the fixups. Folded.

> and to support runtime local_trylock_init(), and it's at the end of my e-=
mail
>
> But I also thought we could go all the way with removing casting in
> that way and stop relying on the same layout implicitly.
>
> So I rewrote this:
>
> #define __local_lock_acquire(lock)                                      \
>         do {                                                            \
>                 local_trylock_t *tl;                                    \
>                 local_lock_t *l;                                        \
>                                                                         \
>                 _Generic((lock),                                        \
>                         local_lock_t *: ({                              \
>                                 l =3D this_cpu_ptr(lock);                =
 \
>                         }),                                             \
>                         local_trylock_t *: ({                           \
>                                 tl =3D this_cpu_ptr(lock);               =
 \
>                                 l =3D &tl->llock;                        =
 \
>                                 lockdep_assert(tl->acquired =3D=3D 0);   =
   \
>                                 WRITE_ONCE(tl->acquired, 1);            \
>                         }),                                             \
>                         default:(void)0);                               \
>                 local_lock_acquire(l);                                  \
>         } while (0)
>
> But I'm getting weird errors:
>
> ./include/linux/local_lock_internal.h:107:36: error: assignment to =E2=80=
=98local_trylock_t *=E2=80=99 from incompatible pointer type =E2=80=98local=
_lock_t *=E2=80=99 [-Wincompatible-pointer-types]
>   107 |                                 tl =3D this_cpu_ptr(lock);       =
         \
>
> coming from the guard expansions. I don't understand why it goes to the
> _Generic() "branch" of local_trylock_t * with a local_lock_t *.

This is because the macro specifies the type:
DEFINE_GUARD(local_lock, local_lock_t __percpu*,

and that type is used to define two static inline functions
with that type,
so by the time our __local_lock_acquire() macro is used
it sees 'local_lock_t *' and not the actual type of memcg.stock_lock.

Your macro can be hacked with addition of:
local_lock_t *l =3D NULL;
...
l =3D (void *)this_cpu_ptr(lock);
...
tl =3D (void *)this_cpu_ptr(lock);
...
DEFINE_GUARD(local_lock, void __percpu*,

then
guard(local_lock)(&memcg_stock.stock_lock);

will compile without warnings with both
typeof(stock_lock) =3D local_lock_t and local_trylock_t,

but the generated code will take default:(void)0) path
and will pass NULL into local_lock_acquire(NULL);

In other words guard(local_lock) can only support one
specific type. It cannot be made polymorphic with _Generic() trick.
This is an unfortunate tradeoff with this approach.
Thankfully there are no users of it in the tree:
git grep 'guard(local'|wc -l
0

so I think it's ok that guard(local_lock) can only be used with local_lock_=
t.

