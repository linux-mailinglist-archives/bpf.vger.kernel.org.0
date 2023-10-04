Return-Path: <bpf+bounces-11346-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7AE77B76E5
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 05:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 93A692814BE
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 03:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C291109;
	Wed,  4 Oct 2023 03:33:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E56610F8
	for <bpf@vger.kernel.org>; Wed,  4 Oct 2023 03:33:48 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2AAA9
	for <bpf@vger.kernel.org>; Tue,  3 Oct 2023 20:33:47 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-406619b53caso15305905e9.1
        for <bpf@vger.kernel.org>; Tue, 03 Oct 2023 20:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696390426; x=1696995226; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xZNyQvbZEOc7eeTdv3gBGZsi7Kn1eMnY0PaALXgPaYM=;
        b=IynS84LaRNblzL3hL/RMm+w7hM6BbqYw1dxQw5d5dpHr8zvFDuUhEaXtQYLH33aQ0P
         ceRlBF+cGU3zkD/N6rE+loXk0NeVzn2ct4NpV07vhhSHFGcIk/2SB8udkSATABma4Aws
         s/fwFuEBPOtLyosWqJVl7fGH6/VnLuBTPJd7T5QUe7CxJ5roMSzr2SoHpPjtdGBVJO6+
         mFDnVrhLxP66ZSi5P7lrgMo+79sJFCih4iPYsx3g/ScBUxxLmn2haVBnFuNJgaOaNi3i
         jo9ppovlzTLmD+qU4xUw3t3rAN7ROQAd5a2h6BJE3qKGx5noGWMpLMkQwW1Y3YXuMaGl
         /ITw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696390426; x=1696995226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xZNyQvbZEOc7eeTdv3gBGZsi7Kn1eMnY0PaALXgPaYM=;
        b=XSWU00wHLsAtAJXLV6Y5paSrFtraDqMN6AKpzums+6Sf0z+h+ZbpCKNxqvv4gJ31jA
         Qy8u1zfJnnFIvQIEn6hJt6HxEdD6h8i8GcSuDc8pRrQez+yQhT2ZNqa48LQ3aRS6Jkpd
         MN4tPKk6tOr+2kjeH8/mDtn85vb3VOyphWFo9VbBdODZWTDK4G7WkH/VyCzoUdXK+WAd
         WC9X9bspYdFWU48ymC2L033aditUi1BgWL7MMEWFoxwVvJry8DwIqqDZBoBIsUtkYwTY
         HPicgQFy/C5iHTXR9NPu8LVKGJHuPwAwRQC9Fj5Cqx0/9b8+T0c/l7Q0LTtyWUbgYucE
         ktAw==
X-Gm-Message-State: AOJu0YxXyka1grhFHF7De4+mryvZiPo8AIKuPRA56V07PwBLg2oM0QhW
	oparHtGsTviQIn4W62zXXdT+i16eUJCfQ6HxHiw=
X-Google-Smtp-Source: AGHT+IGIGv6DesgwC8OWGOQZDAoz/SctOqUXn70aTSEWBGortk3piqLkZ1EMWUnH0HUera9FLOs+pYVheczWRng6M3Q=
X-Received: by 2002:adf:fc09:0:b0:31c:7ada:5e05 with SMTP id
 i9-20020adffc09000000b0031c7ada5e05mr787853wrr.51.1696390425523; Tue, 03 Oct
 2023 20:33:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231004004350.533234-1-song@kernel.org> <CAEf4BzbM6yvBwT3-_7NkzKgqdoXc_G3+_5Fnv96b_2U68=Hunw@mail.gmail.com>
In-Reply-To: <CAEf4BzbM6yvBwT3-_7NkzKgqdoXc_G3+_5Fnv96b_2U68=Hunw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 3 Oct 2023 20:33:34 -0700
Message-ID: <CAADnVQKMxUg3Djh8UjRPdw7RE6yOiNUgYGjG_eCPqMtnguO+fA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] bpf: Avoid unnecessary -EBUSY from htab_lock_bucket
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@meta.com>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 3, 2023 at 8:08=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Oct 3, 2023 at 5:45=E2=80=AFPM Song Liu <song@kernel.org> wrote:
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
> > Similarly, use raw_spin_unlock() and local_irq_restore() in
> > htab_unlock_bucket().
> >
> > Suggested-by: Tejun Heo <tj@kernel.org>
> > Signed-off-by: Song Liu <song@kernel.org>
> >
> > ---
> > Changes in v2:
> > 1. Use raw_spin_unlock() and local_irq_restore() in htab_unlock_bucket(=
).
> >    (Andrii)
> > ---
> >  kernel/bpf/hashtab.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
>
> Now it's more symmetrical and seems correct to me, thanks!
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>
> > diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> > index a8c7e1c5abfa..fd8d4b0addfc 100644
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

Song,

take a look at s390 crash in BPF CI.
I suspect this patch is causing it.

Ilya,

do you have an idea what is going on?

