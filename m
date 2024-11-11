Return-Path: <bpf+bounces-44550-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A509C492F
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 23:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C44E5B26160
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 22:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4260F155A30;
	Mon, 11 Nov 2024 22:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UrmsXIUR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A34A14600C
	for <bpf@vger.kernel.org>; Mon, 11 Nov 2024 22:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731363543; cv=none; b=UXOlDK70Cm0e0CDYh3E9KoJebtwU/Sp7B3vBeNjGykcC0Cw4+7eqI2kW3KWdzIJ4XlqlgGI7ahVs1Roqgpd5kgI6hfVmRb7qGizF5G1a9CTusIdXUoIooZu+NW2v3M2A4vk+KLRC5ri5772YkUig7d8MtJ06voxbgAfYFeiRJCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731363543; c=relaxed/simple;
	bh=VGD0dYVvepAx4vbof3Pk00K3hrFbpO9/Hg5sDg7aKKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SaFjk8EfG97lIlnq+aWY8w815oiN0yGnBukxSi7T8FhlxzZFolJsocftZh/0V+/AX8NervPZtqk2LTKXL+zUSHbvOFTz/2vp4Sv11QOHkbO7tEaVDeRPXRx7Gbq3WJls+TLdDyibV1L9hqp14yZMYd5AHFhHWYb5mK2mPsePS/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UrmsXIUR; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7ea9739647bso3443631a12.0
        for <bpf@vger.kernel.org>; Mon, 11 Nov 2024 14:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731363541; x=1731968341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ylo/NNlsduvND4y4VpVi9qVV32Aeeae6lrQBp35g7/I=;
        b=UrmsXIURJz2mrQg+vG+EJC90/+EYMsYn6YsER8Qq6I8nEMQM+SI8u0uEJYjmjiRon5
         6lMyA0w55yCqfaRc+rEtXaHrMkZBBB9kjC9MvdsEKae7kH/glyz2UupVIMD5kATpBOvj
         RbeuR5QliT/j1+Tvn6ljCxv5I/xiCgi0LlrhY2zah9S00XRGq3JQQDyojZ8teF0XuX6s
         eoKi7GqDR96MUJ8DbPiDDCE5BN0n2S5xDUc0OEV9c3CR7lZky/1CyEn5Paww91AahiMo
         QRMY6PxLcwt4MvAGPdiFwJlr12U0psA6FMDVtI0Ga38llOBlEG2ZccNmzvVOwNuyLDfy
         OZsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731363541; x=1731968341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ylo/NNlsduvND4y4VpVi9qVV32Aeeae6lrQBp35g7/I=;
        b=VQJM+HvaKawKCC7BaJhJFnfSCG88E5INBgq3uO4OdocDgbKvK40Wmzo2ckouWEZ1m0
         Pu82+q04nVrfCXpUEA8ys39kvibb4JoRPVOUASlJG2V4xrpjDjseITrvAVy+3n5gkOZB
         nG5H4JfurXylR3iWTbobhY/Rshdnb1x4RXZ0oF+zpdE7RWvF0m7uOPC5u+e6nZYC/pEM
         zk+7eZjAY+lv7vdeh/QhsQHzhf4/Vsd7Pl/9iJj79R7g8bqRKECk/a7XVVLijY20H9Xo
         ZCR6k5I6m77g2AEt7jBnJW0qAGnnk7OhdazwtPRTBbi6lKW/LOXLAC3JiiRG+uKLu28Q
         q3Bg==
X-Forwarded-Encrypted: i=1; AJvYcCUz9IDD0sin/DGQwRGOLXmRUaQtQq0D6mak0FyDdUUr6nP2uTa6uDKZf6mTRDz0F/3O+zo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB5ScQIrQrTCgJIeztu80+08tb890/N+lQJPXRKhGF4ovfe8JA
	544/0SS6SNm/wHyTXgoCfaYE4yuNTSlkpsQgMSW8KK1xdD1GrpDtPuojw/M/RUJQLusFePJ4qgD
	GSfGBbNXemT3I9oIdOws+UBeV5d8=
X-Google-Smtp-Source: AGHT+IH55CyHIOrPnOnFMABjAPvZnITmnpGA2lmxWsrZEQiGCWU0UVpsv5UJSxWsYALOPNLxOcUYSRvVGLU/pXAlIdE=
X-Received: by 2002:a17:90b:388f:b0:2e2:cd62:549c with SMTP id
 98e67ed59e1d1-2e9b17412a3mr22552485a91.22.1731363541324; Mon, 11 Nov 2024
 14:19:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030235057.1984848-1-andrii@kernel.org> <CAADnVQ+pShXOS9WnDSA5CjrGvNRC7NS-MQrgr_X_Obo5zLs8yA@mail.gmail.com>
 <CAEf4BzZMObcOs5NzHqY-v3scjv7zHL2oKf=zn36LsAXhYuwn8Q@mail.gmail.com> <CAEf4BzYks_vSzoYMxSCED=kTJ6n9WHY5daJTwPam6KXaWv0feg@mail.gmail.com>
In-Reply-To: <CAEf4BzYks_vSzoYMxSCED=kTJ6n9WHY5daJTwPam6KXaWv0feg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 11 Nov 2024 14:18:49 -0800
Message-ID: <CAEf4BzZGmi=zqAB032eLjGZZ1b4bq2jTdFsF_qiMwSJEZrB2Zg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: use common instruction history across all states
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>, 
	Eduard Zingerman <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 1:56=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Nov 11, 2024 at 1:53=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Mon, Nov 11, 2024 at 10:46=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Wed, Oct 30, 2024 at 4:51=E2=80=AFPM Andrii Nakryiko <andrii@kerne=
l.org> wrote:
> > > >
> > > > Async callback state enqueing, while logically detached from parent
> > >
> > > typo. enqueuing
> >
> > yep, tricky word :) should be "enqueueing", fixed
> >
> > >
> > > > -static int get_prev_insn_idx(struct bpf_verifier_state *st, int i,
> > > > -                            u32 *history)
> > > > +static int get_prev_insn_idx(const struct bpf_verifier_env *env,
> > > > +                            struct bpf_verifier_state *st,
> > > > +                            int insn_idx, u32 hist_start, u32 *his=
t_endp)
> > > >  {
> > > > -       u32 cnt =3D *history;
> > > > +       u32 hist_end =3D *hist_endp;
> > > > +       u32 cnt =3D hist_end - hist_start;
> > > >
> > > > -       if (i =3D=3D st->first_insn_idx) {
> > > > +       if (insn_idx =3D=3D st->first_insn_idx) {
> > > >                 if (cnt =3D=3D 0)
> > > >                         return -ENOENT;
> > > > -               if (cnt =3D=3D 1 && st->jmp_history[0].idx =3D=3D i=
)
> > > > +               if (cnt =3D=3D 1 && env->insn_hist[hist_end - 1].id=
x =3D=3D insn_idx)
> > > >                         return -ENOENT;
> > > >         }
> > >
> > > I think the above bit would be easier to understand if it was
> > > env->insn_hist[hist_start].
> > >
> > > When cnt=3D=3D1 it's the same as hist_end-1, but it took me more time
> > > to grok that part. With [hist_start] would have been easier.
> > > Not a big deal.
> >
> > yep, I agree. Originally I didn't pass hist_start directly, so I would
> > have to use st->insn_hist_start, and it felt too verbose. But now
> > that's not a problem, I'll use hist_start everywhere.
> >
> > >
> > > Another minor suggestion...
> > > wouldn't it be cleaner to take hist_start/end from 'st' both
> > > in get_prev_insn_idx() and in get_insn_hist_entry() ?
> > >
> > > So that __mark_chain_precision() doesn't need to reach out into
> > > details of 'st' just to pass hist_start/end values into other helpers=
.
> >
> > Note that for get_prev_insn_idx() we modify (but only locally!)
> > hist_end, as we process instruction history for the currently
> > processed state (we do a virtual stack pop for each entry). So we
> > can't just use st->insn_hist_end, we need a local copy for hist_end
> > that will be updated without touching the actual insn_hist_end. That's
> > the reason I have `u32 hist_end =3D st->insn_hist_end;`, to pass
> > &hist_end into get_prev_insn_idx().
> >
> > Having said that, if you prefer, I can fetch insn_hist_{start, end}
> > from st, always, but then maintain local hist_cnt as input argument
> > for get_insn_hist_enrty() and in/out argument for get_prev_insn_idx().
> > Would you prefer that? something like below:
> >
>
> Argh, gmail messed this up. See [0] for better formatting.
>
>   [0] https://gist.github.com/anakryiko/25228b0ae2760f78b7ae7f0160faa5c1

I had a tiny bug in get_prev_insns_idx(), fixing which makes
get_prev_insn_idx() a bit verbose if using this hist_cnt approach:

static int get_prev_insn_idx(const struct bpf_verifier_env *env,
                             struct bpf_verifier_state *st,
                             int insn_idx, u32 *hist_cntp)
{
  u32 cnt =3D *hist_cntp;

  if (insn_idx =3D=3D st->first_insn_idx) {
    if (cnt =3D=3D 0)
      return -ENOENT;
      if (cnt =3D=3D 1 && env->insn_hist[st->insn_hist_start].idx =3D=3D in=
sn_idx)
        return -ENOENT;
  }

  if (cnt && env->insn_hist[st->insn_hist_start + hist_cnt - 1].idx =3D=3D
insn_idx) {
    *hist_cntp =3D cnt - 1;
    return env->insn_hist[st->insn_hist_start + hist_cnt - 1].prev_idx;
  } else {
    return insn_idx - 1;
  }
}


I mean that `env->insn_hist[st->insn_hist_start + hist_cnt - 1]` in
last if/else. But let me know which way you prefer it anyways.

