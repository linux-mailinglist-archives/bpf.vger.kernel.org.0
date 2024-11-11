Return-Path: <bpf+bounces-44551-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0259A9C4935
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 23:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AA18B23F3D
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 22:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BF57F477;
	Mon, 11 Nov 2024 22:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWcAaGWl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0174B178368
	for <bpf@vger.kernel.org>; Mon, 11 Nov 2024 22:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731364321; cv=none; b=HMRMdsEGcVzi0KfrwzFHl3SIxZsEp7EitrxxqVftdIt9W52Wc0hfX3a9vzgo4jYFSHOoQ24C4iFqKWlun2YiPpvCnUt60w8bzC6OglIPLB/QNhEjBwbg8MkQYWqLiu8ElOarn0jiCHjs8cZck8umnJfHt+Y4xP9oYqYZiHARZXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731364321; c=relaxed/simple;
	bh=+B2jCHqovMbEZCOQbKeewbgdIgWOpiU6BZsU3IadQWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GD57nfkrgQUH5cyjJ2UAqE2K8tWR3Fh95HnJ6DavqiB8W0veGQ5UJd1InAi/AIEzgpgVLflk4o6BtxUuJDHH5y27VJ5x4m9B/qGWmnM9Ss4J6EiHdhREQNkifLlPB0ockthOJOlovZu2QxPBoVjr2tc6Wbe96FQMHf1HWDTL62Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iWcAaGWl; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37d4ac91d97so4724695f8f.2
        for <bpf@vger.kernel.org>; Mon, 11 Nov 2024 14:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731364318; x=1731969118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=whMLfkFhmB0kTQ5n1EwyjhoJFLIXX49NP6R8v2awvxM=;
        b=iWcAaGWlCrub/F6toO5OxsfVfbsRbIUJoNTnNPbDx0AcSZG3irJyhIpkPTiKsqhN34
         kkd+bYJUbGZbrUbtMBiakDpYB5CrHYXkeWSybQg8FzJOQEDrIfX+vZyjpiBavqqT6e8Z
         45kmR4pBwvmROC6/Ej1XJ8fa5uQQkPLoCuYwiTMdFSDNfjnup2I7435gTbmIPzTMTg3h
         S+I260XOoUnPVgSh30nS6szVxLIkwmSZMMVUxeFL+o6Vougn86Ylz2EvJJpRZWH1TlCR
         8EQ3sdLkku0+f0xzWgGSPZOkfZ+Uj/W3gW3RjsDsR7wu+cVA7ahBWRgv0uehBF1Ey4ys
         emQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731364318; x=1731969118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=whMLfkFhmB0kTQ5n1EwyjhoJFLIXX49NP6R8v2awvxM=;
        b=NIq1OexPgPLnsxV+Rfb/L0fFaTAovJ3/7u21ER9f5+8jMJ7WrfgzbPSTFUZgg0nSFZ
         OqCf5wCCHSKM0BqK6EY9KwkPJIeQp2bw36SWLHbirqiJyiS1ERwCLYoQAOGOC8B6YTq1
         ji4KX37R2IWQSMBTFQASV/lUmraptBMIYUZdHWj0skVfJx4o1NnUu1VZI/HwPFrlb7YT
         8/hukeRzM6ScLklsX6T2cAOXYFsbVP9OwrIyilmEPfV0zge7ths3L5kvOwX1dcSKe0/m
         Hyd1tbKGl2eFzZANiS17QACD6+3d/JmQZuaHOmccR0AEKbmR61M1LBG164PNVjachJZy
         ZHTA==
X-Forwarded-Encrypted: i=1; AJvYcCVUrmrsLjuyExK+PRRGlxRxXcPF326Ze/66Mmwm8LIfRJ0ynIEySpKOnIROrCgaPJk+k7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNlp/ULtwwpoTW7EifX1yT/txehO5zmKMPeafsZRat+MB6JPQP
	nv8Wc+1qlIQLpc69LFnI5nmAm0BCz+GFBHwf+RKs7RdMy7wjGthqQR6bE2Na/pdITl6HqA1g0Er
	bi/vHJXs/g72bnm2GC/C7g+6F7T0=
X-Google-Smtp-Source: AGHT+IFsAstlz1EEodBK6P6tvOAUuJLaeixNIQLBhVbhM0Y/A6pTiFlD1pxQnOc1LKJgGzsacE4FRr5Iw2ta8LNw0xQ=
X-Received: by 2002:a05:6000:1543:b0:37d:95a7:9e57 with SMTP id
 ffacd0b85a97d-381f1866efamr15177668f8f.2.1731364318053; Mon, 11 Nov 2024
 14:31:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030235057.1984848-1-andrii@kernel.org> <CAADnVQ+pShXOS9WnDSA5CjrGvNRC7NS-MQrgr_X_Obo5zLs8yA@mail.gmail.com>
 <CAEf4BzZMObcOs5NzHqY-v3scjv7zHL2oKf=zn36LsAXhYuwn8Q@mail.gmail.com>
 <CAEf4BzYks_vSzoYMxSCED=kTJ6n9WHY5daJTwPam6KXaWv0feg@mail.gmail.com> <CAEf4BzZGmi=zqAB032eLjGZZ1b4bq2jTdFsF_qiMwSJEZrB2Zg@mail.gmail.com>
In-Reply-To: <CAEf4BzZGmi=zqAB032eLjGZZ1b4bq2jTdFsF_qiMwSJEZrB2Zg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 11 Nov 2024 14:31:47 -0800
Message-ID: <CAADnVQLE9x8Oy_BdBs804rW=M=Sm6EJjf7uej9uGAVmCoZGHmA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: use common instruction history across all states
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>, 
	Eduard Zingerman <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 2:19=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Nov 11, 2024 at 1:56=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Mon, Nov 11, 2024 at 1:53=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Mon, Nov 11, 2024 at 10:46=E2=80=AFAM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Wed, Oct 30, 2024 at 4:51=E2=80=AFPM Andrii Nakryiko <andrii@ker=
nel.org> wrote:
> > > > >
> > > > > Async callback state enqueing, while logically detached from pare=
nt
> > > >
> > > > typo. enqueuing
> > >
> > > yep, tricky word :) should be "enqueueing", fixed
> > >
> > > >
> > > > > -static int get_prev_insn_idx(struct bpf_verifier_state *st, int =
i,
> > > > > -                            u32 *history)
> > > > > +static int get_prev_insn_idx(const struct bpf_verifier_env *env,
> > > > > +                            struct bpf_verifier_state *st,
> > > > > +                            int insn_idx, u32 hist_start, u32 *h=
ist_endp)
> > > > >  {
> > > > > -       u32 cnt =3D *history;
> > > > > +       u32 hist_end =3D *hist_endp;
> > > > > +       u32 cnt =3D hist_end - hist_start;
> > > > >
> > > > > -       if (i =3D=3D st->first_insn_idx) {
> > > > > +       if (insn_idx =3D=3D st->first_insn_idx) {
> > > > >                 if (cnt =3D=3D 0)
> > > > >                         return -ENOENT;
> > > > > -               if (cnt =3D=3D 1 && st->jmp_history[0].idx =3D=3D=
 i)
> > > > > +               if (cnt =3D=3D 1 && env->insn_hist[hist_end - 1].=
idx =3D=3D insn_idx)
> > > > >                         return -ENOENT;
> > > > >         }
> > > >
> > > > I think the above bit would be easier to understand if it was
> > > > env->insn_hist[hist_start].
> > > >
> > > > When cnt=3D=3D1 it's the same as hist_end-1, but it took me more ti=
me
> > > > to grok that part. With [hist_start] would have been easier.
> > > > Not a big deal.
> > >
> > > yep, I agree. Originally I didn't pass hist_start directly, so I woul=
d
> > > have to use st->insn_hist_start, and it felt too verbose. But now
> > > that's not a problem, I'll use hist_start everywhere.
> > >
> > > >
> > > > Another minor suggestion...
> > > > wouldn't it be cleaner to take hist_start/end from 'st' both
> > > > in get_prev_insn_idx() and in get_insn_hist_entry() ?
> > > >
> > > > So that __mark_chain_precision() doesn't need to reach out into
> > > > details of 'st' just to pass hist_start/end values into other helpe=
rs.
> > >
> > > Note that for get_prev_insn_idx() we modify (but only locally!)
> > > hist_end, as we process instruction history for the currently
> > > processed state (we do a virtual stack pop for each entry). So we
> > > can't just use st->insn_hist_end, we need a local copy for hist_end
> > > that will be updated without touching the actual insn_hist_end. That'=
s
> > > the reason I have `u32 hist_end =3D st->insn_hist_end;`, to pass
> > > &hist_end into get_prev_insn_idx().
> > >
> > > Having said that, if you prefer, I can fetch insn_hist_{start, end}
> > > from st, always, but then maintain local hist_cnt as input argument
> > > for get_insn_hist_enrty() and in/out argument for get_prev_insn_idx()=
.
> > > Would you prefer that? something like below:
> > >
> >
> > Argh, gmail messed this up. See [0] for better formatting.
> >
> >   [0] https://gist.github.com/anakryiko/25228b0ae2760f78b7ae7f0160faa5c=
1
>
> I had a tiny bug in get_prev_insns_idx(), fixing which makes
> get_prev_insn_idx() a bit verbose if using this hist_cnt approach:
>
> static int get_prev_insn_idx(const struct bpf_verifier_env *env,
>                              struct bpf_verifier_state *st,
>                              int insn_idx, u32 *hist_cntp)
> {
>   u32 cnt =3D *hist_cntp;
>
>   if (insn_idx =3D=3D st->first_insn_idx) {
>     if (cnt =3D=3D 0)
>       return -ENOENT;
>       if (cnt =3D=3D 1 && env->insn_hist[st->insn_hist_start].idx =3D=3D =
insn_idx)
>         return -ENOENT;
>   }
>
>   if (cnt && env->insn_hist[st->insn_hist_start + hist_cnt - 1].idx =3D=
=3D
> insn_idx) {
>     *hist_cntp =3D cnt - 1;
>     return env->insn_hist[st->insn_hist_start + hist_cnt - 1].prev_idx;
>   } else {
>     return insn_idx - 1;
>   }
> }
>
>
> I mean that `env->insn_hist[st->insn_hist_start + hist_cnt - 1]` in
> last if/else. But let me know which way you prefer it anyways.

Ohh. I missed that decrement is local to __mark_chain_precision().
Original version is probably better than when it passes start/end around.
This hist_cnt approach is harder to read.

So pls resend with typo fixed.

