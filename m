Return-Path: <bpf+bounces-58080-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BCF9AB48F0
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 03:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D7C81B41AC7
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 01:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889D6191484;
	Tue, 13 May 2025 01:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lr7JpY2S"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504422AF03
	for <bpf@vger.kernel.org>; Tue, 13 May 2025 01:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747100978; cv=none; b=E8LEiXTbqivyoGldVfgeY1tNFm4cUCGeCPUmZLA9mQAzejXLz/u2DuvxUPkw4fDm/Eaowy6zqN5J4lZ9PJ5o2VdeP2g5Ep6dHiEd15YenV4UpOQ41eMrYeq4MjFFNwvNvGFbsHKj/5Om8KNbFg1ukH6kXtWueX/pA9GAMbZw470=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747100978; c=relaxed/simple;
	bh=+mB10WxawEw5s9kzyuBFIBL5FdHKVTvrDZpVMDbqX7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uPgwBoMO18T9MhHMA7aUEFqC5H3UQ3q+tsZ50jL/pl1z69NVwdwv1kxXglQlKzC4FCxCP85rcMRnESlMQfSYHsR3HYkRVL/a43NbWJa9/XbiwuiAYra3LsesODCA8leUntvs3d/NEoF6fC6nL1TZmMwj996ywOlBRYGW5hiF11M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lr7JpY2S; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a1f8c85562so2402783f8f.1
        for <bpf@vger.kernel.org>; Mon, 12 May 2025 18:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747100974; x=1747705774; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jJEyg15IJ/ZOLSaSmaVgWXhun3eVOePnoZu5U0RDEA0=;
        b=Lr7JpY2SJR/rfADRHGlTIzQgfRcGgs9DtAjAEnBM0Wzh3o9r5SSHwlKuEiIdA+ZOZh
         +Zc2N3k3xYTGc2ZKmnrGVvtIQXlx70y/JHcXWPIurade2HDCg+hqjDh7uhGxSoOeJSpT
         ZBhfW8yK4FgNxgdARSmihyt3bkWaU3g6vmPz4NCqAoalnmBNMa0bh8TRg7ryn6E1MRc5
         Nb6UexANK+G8gHqCu/19V58qTjhCttEm318SNvGUbQ+uHfkJGfG+MCG6s39a1ck4873g
         dDKqPNXg49GEWMmCPMG5KFGMLu8dW8snLqiQSiqcmZy9ambARjbrKBYlI3u7oI/pOm7C
         +eYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747100974; x=1747705774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jJEyg15IJ/ZOLSaSmaVgWXhun3eVOePnoZu5U0RDEA0=;
        b=QquasAZfXTfr8tDbCv3kvRb4NM3e4lgTETTBL8pwSpcgdr/les4NvCySZ8ZdMP7ylz
         +qFTC8JjH4zrTROUPKCstQEab7z9G3GP0Ne+xrVWIJDz7r56C+aW0y+xnhQYDNgM24J8
         6WjoOc47yEcQ//T+sBt9qBBB2lGrg1mz8Fpgm23RQgK6vR8S1TDQPDUtxRbAfliqpRYa
         EZm2eZy09kRTrXGn4p1rO8Ajx4/FtG+li+KZv6kDrShEc4Wn8c3heg5EtPNa8r6QTWYw
         jFI6Dir6GJYsvf1blSThGeJvFGm8hhXUnRmgi+H5Rim3ZqkdID4SP/PHixEztrOorLZF
         uMow==
X-Gm-Message-State: AOJu0YyGZoAEkjuMrHKPb60stMzDw0h6HPU5+OAOcphlr3aJqMS5PCFe
	PvGy1OOwOIxV3fmLFjgf2Ugmw2bkoLn3eKfogKSgar7YMyaMgwNEAf+RYAM5F+uNxCIJioLBha6
	+OIaFpk9DiG4YEPrJBgKUXTlkipo=
X-Gm-Gg: ASbGncsarkfKnhwDOjZk+slUUj7nmDSyYIBGd1tp6nqDrOr73LP9VPNkMfQZdsho1TJ
	TXbQEPxgL1unGGpfLqBjYNQZjPe0rWUl2PDQ1dWBlVL+9AVJH6Amze2g0vxy9sNSX1X1MRwpRqy
	Uz3AhpSPo8ib5Lmx0PRXhr6XtWZmPVpLxWQNjJbQ6tNn/lrQcil1WmhL3kRrMUjw==
X-Google-Smtp-Source: AGHT+IETe6ZIDzI1xGqmiHEroTiS3osGSGD73Gfss1xUCU4Uf4PKe+XTtvdL0av51cO5YTmI4xh1kRLOJAMxEckibis=
X-Received: by 2002:a05:6000:2cf:b0:390:e853:85bd with SMTP id
 ffacd0b85a97d-3a1f649bbabmr11931958f8f.48.1747100974237; Mon, 12 May 2025
 18:49:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512210246.3741193-1-memxor@gmail.com> <CAADnVQ+6vYFkBKvwbFMiALVCAOgC2mXd-oM2Xw26uioudMbZGg@mail.gmail.com>
 <CAP01T75ryzGQtZ5uXn1CTzDQs_gAQSBkGRbkYk_JVgxfmFCK6w@mail.gmail.com>
In-Reply-To: <CAP01T75ryzGQtZ5uXn1CTzDQs_gAQSBkGRbkYk_JVgxfmFCK6w@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 12 May 2025 18:49:23 -0700
X-Gm-Features: AX0GCFtNmpaNRa7wRq5_7s3fwruUdX-DslvHfd0nKRV_OCa_fE4GoFYX_cSwzaU
Message-ID: <CAADnVQ+qGJ6-_NfMZsBWoXDVWJK-t2hpfooCu9tdtYa-y3wPcw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1] bpf: Add __aux tag to pass in prog->aux
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Tejun Heo <tj@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, kkd@meta.com, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025 at 6:41=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Mon, 12 May 2025 at 20:04, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, May 12, 2025 at 2:02=E2=80=AFPM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > >
> > > Instead of hardcoding the list of kfuncs that need prog->aux passed t=
o
> > > them with a combination of fixup_kfunc_call adjustment + __ign suffix=
,
> > > combine both in __aux suffix, which ignores the argument passed in, a=
nd
> > > fixes it up to the prog->aux. This allows kfuncs to have the prog->au=
x
> > > passed into them without having to touch the verifier.
> > >
> > > Cc: Tejun Heo <tj@kernel.org>
> > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > ---
> > >  include/linux/bpf_verifier.h |  1 +
> > >  kernel/bpf/helpers.c         |  4 ++--
> > >  kernel/bpf/verifier.c        | 33 +++++++++++++++++++++++++++------
> > >  3 files changed, 30 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifie=
r.h
> > > index 9734544b6957..1d90e44a1d04 100644
> > > --- a/include/linux/bpf_verifier.h
> > > +++ b/include/linux/bpf_verifier.h
> > > @@ -606,6 +606,7 @@ struct bpf_insn_aux_data {
> > >         bool calls_callback;
> > >         /* registers alive before this instruction. */
> > >         u16 live_regs_before;
> > > +       u16 arg_prog_aux;
> > >  };
> > >
> > >  #define MAX_USED_MAPS 64 /* max number of maps accessed by one eBPF =
program */
> > > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > > index fed53da75025..2b6bac4bf6e3 100644
> > > --- a/kernel/bpf/helpers.c
> > > +++ b/kernel/bpf/helpers.c
> > > @@ -3012,9 +3012,9 @@ __bpf_kfunc int bpf_wq_start(struct bpf_wq *wq,=
 unsigned int flags)
> > >  __bpf_kfunc int bpf_wq_set_callback_impl(struct bpf_wq *wq,
> > >                                          int (callback_fn)(void *map,=
 int *key, void *value),
> > >                                          unsigned int flags,
> > > -                                        void *aux__ign)
> > > +                                        void *aux__aux)
> >
> > aux__aux is an odd name.
> > "__aux" as a suffix also looks strange.
> >
>
> We can call it prog__aux.
>
> > How about "__prog" suffix ?
> > It will be similar to the existing "__map" suffix.
>
> But it's a bit misleading, it's not the prog, it's prog->aux.

prog or prog->aux is the same thing. It's a pointer to prog.
bpf_prog is read only part of it.
bpf_prog_uax is writeable.

>
> >
> > We can also standardize the argument name as
> > __bpf_kfunc int bpf_wq_set_callback_impl(.. , void *aux__prog)
> >
> > then the name is more or less explanatory.
>
> You can call it foo__prog, the part before __ is arbitrary.
>
> >
> > >  {
> > > -       struct bpf_prog_aux *aux =3D (struct bpf_prog_aux *)aux__ign;
> > > +       struct bpf_prog_aux *aux =3D (struct bpf_prog_aux *)aux__aux;
> >
> > and here it will be:
> >
> > +       struct bpf_prog_aux *aux =3D (struct bpf_prog_aux *)aux__prog;
> >
> > which looks ok to me.
>
> How about I rename the parameter to prog__aux?
> Or __prog_aux as the tag name?

I still prefer aux__prog.

