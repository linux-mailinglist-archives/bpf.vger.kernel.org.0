Return-Path: <bpf+bounces-11322-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BB07B742B
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 00:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id CBB6BB20979
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 22:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524D03D3A5;
	Tue,  3 Oct 2023 22:37:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F064C379
	for <bpf@vger.kernel.org>; Tue,  3 Oct 2023 22:37:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AC90C433D9
	for <bpf@vger.kernel.org>; Tue,  3 Oct 2023 22:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696372641;
	bh=KxmEzSzxbEP3c6J4I4EALWwf02oTZOOOjhiXL5jE1Mc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IIbezD1mc91A116S8nYUCVSmA0hlSzp213AKDvYkT4pM/XMBua6f7e4TNgUfdDp5F
	 C0GEhu4Cm7QPM8ylaaGu0lZ50O/e94fECjQuEjiqVqdRH6/N13E6GQkJB0D6zmUM3V
	 ZCxswon8VXoORDXHk7KkfuRUOOthjezYNVXk8up1t4F9KOX6VqOL7RIjQFMZ2kUePF
	 HCAuE26QjNulZA5CuG55q6Ma9dNqV4QblU5dD9FqNXCqFPCb0wRisLekd4eu8Zip0N
	 R5/j/BFBjHN4nft8UgRpqn8sU6eF2Rr3HjGdrkFSXwNLS4Eu82SO7PBHxeFcEf38rc
	 UvY5+G+tZbBIw==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2c15463ddd4so16331861fa.3
        for <bpf@vger.kernel.org>; Tue, 03 Oct 2023 15:37:21 -0700 (PDT)
X-Gm-Message-State: AOJu0YzqLrFKGmAoH26gg+vtI9wqZRhYsaIWiVWT/rrYdP8OpIHMWR5y
	aMAK205+g5JvtrdVHYWMGOSgVNkXZnJrFzi+GGY=
X-Google-Smtp-Source: AGHT+IHuZ+veBmYkdY01lI9Ik73ekTRL1mKsB2FtR+3tapRT7WNj2d89touH4L1ZIWtmgHVes3dqkFOAhG8ijCYyd9Y=
X-Received: by 2002:a05:6512:2118:b0:503:18c3:d87a with SMTP id
 q24-20020a056512211800b0050318c3d87amr445589lfr.21.1696372639673; Tue, 03 Oct
 2023 15:37:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231003200434.3154797-1-song@kernel.org> <CAEf4BzZ3iWhdtGSR326zKx0CUUHkO4mQA4ie2sY51SSTUqHM=g@mail.gmail.com>
In-Reply-To: <CAEf4BzZ3iWhdtGSR326zKx0CUUHkO4mQA4ie2sY51SSTUqHM=g@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Tue, 3 Oct 2023 15:37:07 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6-ZgttuDGaf1gTZmqkQRyvsYd7FUfrAWQRL5ie1+fRPw@mail.gmail.com>
Message-ID: <CAPhsuW6-ZgttuDGaf1gTZmqkQRyvsYd7FUfrAWQRL5ie1+fRPw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Avoid unnecessary -EBUSY from htab_lock_bucket
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@kernel.org, kernel-team@meta.com, 
	Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 3, 2023 at 3:31=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Oct 3, 2023 at 1:05=E2=80=AFPM Song Liu <song@kernel.org> wrote:
> >
> > htab_lock_bucket uses the following logic to avoid recursion:
> >
> > 1. preempt_disable();
> > 2. check percpu counter htab->map_locked[hash] for recursion;
> >    2.1. if map_lock[hash] is already taken, return -BUSY;
> > 3. raw_spin_lock_irqsave();
> >
> > However, if an IRQ hits between 2 and 3, BPF programs attached to the I=
RQ
> > logic will not able to access the same hash of the hashtab and get -EBU=
SY.
> > This -EBUSY is not really necessary. Fix it by disabling IRQ before
> > checking map_locked:
> >
> > 1. preempt_disable();
> > 2. local_irq_save();
> > 3. check percpu counter htab->map_locked[hash] for recursion;
> >    3.1. if map_lock[hash] is already taken, return -BUSY;
> > 4. raw_spin_lock().
> >
> > Suggested-by: Tejun Heo <tj@kernel.org>
> > Signed-off-by: Song Liu <song@kernel.org>
> > ---
> >  kernel/bpf/hashtab.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> > index a8c7e1c5abfa..347af4476662 100644
> > --- a/kernel/bpf/hashtab.c
> > +++ b/kernel/bpf/hashtab.c
> > @@ -155,13 +155,15 @@ static inline int htab_lock_bucket(const struct b=
pf_htab *htab,
> >         hash =3D hash & min_t(u32, HASHTAB_MAP_LOCK_MASK, htab->n_bucke=
ts - 1);
> >
> >         preempt_disable();
> > +       local_irq_save(flags);
> >         if (unlikely(__this_cpu_inc_return(*(htab->map_locked[hash])) !=
=3D 1)) {
> >                 __this_cpu_dec(*(htab->map_locked[hash]));
> > +               local_irq_restore(flags);
> >                 preempt_enable();
> >                 return -EBUSY;
> >         }
> >
> > -       raw_spin_lock_irqsave(&b->raw_lock, flags);
> > +       raw_spin_lock(&b->raw_lock);
> >         *pflags =3D flags;
> >
>
> I might be wrong, but I think it's dangerous to have raw_spin_lock() +
> raw_spin_unlock_irqrestore() (in htab_unlock_bucket). Looking at the
> implementation of raw_spin_lock_irqsave() and
> raw_spin_unlock_irqrestore(), they do their own
> preempt_disable/preempt_enable, and so with your change I think we
> have imbalance, one preempt_disable() in htab_lock_bucket(), but two
> preempt_enable (one explicit in htab_unlock_bucket, and one implicit
> inside raw_spin_unlock_irqrestore).
>
> I'd say let's use plain raw_spin_unlock() + explicit
> local_irq_restore(flags) in htab_unlock_bucket?

Yeah, there is actually a similar window in htab_unlock_bucket(). Let's
also close that.

Thanks,
Song

>
>
> >         return 0;
> > --
> > 2.34.1
> >

