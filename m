Return-Path: <bpf+bounces-58077-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B235BAB48E1
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 03:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 395C14A039C
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 01:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA6D17ADF8;
	Tue, 13 May 2025 01:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EmI7CQ/0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8B418C91F
	for <bpf@vger.kernel.org>; Tue, 13 May 2025 01:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747100506; cv=none; b=hHZw6HJtDn+fMQmihi9RHXV04xPuUUvTHsFPr6Rk28vf55XkIexUTMQQNBtKp+DlwG6zoYp1X15mMkSCvaeFu4f94aCqyne2owPnxPuDZGpRJGFHq9fL5MHZEqxCEE1diknP/nM42DuRcUy7Zwq9GpGycKqKT9MgbSF/BKQdYsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747100506; c=relaxed/simple;
	bh=iChrYjKqQXXqqiNorvDtlsC6QhW8wcIZyYcab5AX4Dw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YmONQObsu2E39fY8NFhu1qcL1fTJIMFWSXESyxY2r4Rkvk8Y1Cx0SYH7eLPgvMJyl9RxqqVBt7Tx0XDZ6S5F+NQpCgBd1/FdGLYSg/VkUCoMXq/0LNVO7LGtQkbVcVxHFUm0sJWFmTbDpe2nlLUkd4mLs6B7tz5kK9a0VaNObLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EmI7CQ/0; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-5fc5bc05f99so9791959a12.3
        for <bpf@vger.kernel.org>; Mon, 12 May 2025 18:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747100503; x=1747705303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8/7D5xb8jel/Ov6iLitSn0zZm4FeYyb+Ri6V2z51b+Y=;
        b=EmI7CQ/0URtRDL+AJW/6zGEcI7CXXX0B2qFXIOcqM0s5sxkAHpbv1FXui4bctY/rOl
         tAxInVwg9qN5RzZwnh1H/7OwLHcFph7aMqFT94gIiuMUGBynfL2ObDYG2M9sZSIGKiwA
         6mbt9XJNpWjvmMEoVwETJVtg1JeGOEfBs0HohpH8s4g4FTOYcCvxcF4jgQ7ONb6pzR23
         zhzUAquY9HbvCb8BJno3l8fcxprA62cBijgZyMnybuLuHT30Yfpn+mlUny6mZNEErq7n
         XlmXu72oW93Nn5vZC0VuM9JE9K6c4gCpsdUtG1/Ho03S5KLjA5RUblx2f+sXT6SWUi2r
         uuuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747100503; x=1747705303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8/7D5xb8jel/Ov6iLitSn0zZm4FeYyb+Ri6V2z51b+Y=;
        b=T8abwCqaoOAVHbsi9IFcDlR5O4XowYc2HfnOXNKlV0CMEplTDIIdHB7gXdnDUEjpkF
         ngMC/ep4WtmEZasj33yxcnl9Eq3JHfn4brK1AVLopx7BrxnMl7icKEyFmfJ8MwoW+fwJ
         Xn6C4ZgHGp8cIIL/5Xw+qFZqhlLaX2gnfJ1MWmCThGGJ//aM3POcR2saCvNcKKaOweCG
         +1WoG+Cg/FMMZITwK8qKW/c3Wwes+UZIyZWSV9uZVgj2J3YIJI4rJSrds9rKDRfbDH+x
         xBAoyWhSjtyrlcwYmqgA7z1T63MbGhWtr2JJHyVKZojaykl7ChzOwMZwLM7gYXmMVYV0
         LlCw==
X-Gm-Message-State: AOJu0YxkwzX8yhNvNGqVnhvwcCjaNLbbW9Z2tNDrusXM/Js0oKuZcoSY
	w7LaiBmnxFrJ72hatXR3irISBpRP7fP5ay2PAA52Ig94MzbJAmm24OWyhnQSR8mRwY/fjxCKPX/
	t6nIWDGDrZXfEvXz+UCMa6O67pFE=
X-Gm-Gg: ASbGncvJNzAwRkb8kSbc1Xqbz5lGrCZ4AaBNnw7in/WvCPJrXM8fbtmcdrwMqz1MUsw
	K6EQE5cPWsk16mxPQ/uCS/8SaM3QCYCY/oymscx0d9Pta43gZLLlh6w2u/DC93cazMD4GmMGw+H
	O+cOThQ0IMLt06+NgyDaZCDytASKoU5tc=
X-Google-Smtp-Source: AGHT+IETI08xsUOPIFEgsGgfgp0QqSlSm3GI7hUDd+D1W5A9EVUkBjeLJK60RVL+0JVAib82LJ8cXYZkqUTfMDmoT/w=
X-Received: by 2002:a17:907:874f:b0:ad4:e065:9412 with SMTP id
 a640c23a62f3a-ad4e0659790mr53259166b.51.1747100502824; Mon, 12 May 2025
 18:41:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512210246.3741193-1-memxor@gmail.com> <CAADnVQ+6vYFkBKvwbFMiALVCAOgC2mXd-oM2Xw26uioudMbZGg@mail.gmail.com>
In-Reply-To: <CAADnVQ+6vYFkBKvwbFMiALVCAOgC2mXd-oM2Xw26uioudMbZGg@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 12 May 2025 21:41:05 -0400
X-Gm-Features: AX0GCFuvIcMq8BU9xTzr0G__NIIyv_BHxJtqSrQuwhLpzYB0y8QeEhklQxgQDO0
Message-ID: <CAP01T75ryzGQtZ5uXn1CTzDQs_gAQSBkGRbkYk_JVgxfmFCK6w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1] bpf: Add __aux tag to pass in prog->aux
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Tejun Heo <tj@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, kkd@meta.com, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 12 May 2025 at 20:04, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, May 12, 2025 at 2:02=E2=80=AFPM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > Instead of hardcoding the list of kfuncs that need prog->aux passed to
> > them with a combination of fixup_kfunc_call adjustment + __ign suffix,
> > combine both in __aux suffix, which ignores the argument passed in, and
> > fixes it up to the prog->aux. This allows kfuncs to have the prog->aux
> > passed into them without having to touch the verifier.
> >
> > Cc: Tejun Heo <tj@kernel.org>
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  include/linux/bpf_verifier.h |  1 +
> >  kernel/bpf/helpers.c         |  4 ++--
> >  kernel/bpf/verifier.c        | 33 +++++++++++++++++++++++++++------
> >  3 files changed, 30 insertions(+), 8 deletions(-)
> >
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.=
h
> > index 9734544b6957..1d90e44a1d04 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
> > @@ -606,6 +606,7 @@ struct bpf_insn_aux_data {
> >         bool calls_callback;
> >         /* registers alive before this instruction. */
> >         u16 live_regs_before;
> > +       u16 arg_prog_aux;
> >  };
> >
> >  #define MAX_USED_MAPS 64 /* max number of maps accessed by one eBPF pr=
ogram */
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index fed53da75025..2b6bac4bf6e3 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -3012,9 +3012,9 @@ __bpf_kfunc int bpf_wq_start(struct bpf_wq *wq, u=
nsigned int flags)
> >  __bpf_kfunc int bpf_wq_set_callback_impl(struct bpf_wq *wq,
> >                                          int (callback_fn)(void *map, i=
nt *key, void *value),
> >                                          unsigned int flags,
> > -                                        void *aux__ign)
> > +                                        void *aux__aux)
>
> aux__aux is an odd name.
> "__aux" as a suffix also looks strange.
>

We can call it prog__aux.

> How about "__prog" suffix ?
> It will be similar to the existing "__map" suffix.

But it's a bit misleading, it's not the prog, it's prog->aux.

>
> We can also standardize the argument name as
> __bpf_kfunc int bpf_wq_set_callback_impl(.. , void *aux__prog)
>
> then the name is more or less explanatory.

You can call it foo__prog, the part before __ is arbitrary.

>
> >  {
> > -       struct bpf_prog_aux *aux =3D (struct bpf_prog_aux *)aux__ign;
> > +       struct bpf_prog_aux *aux =3D (struct bpf_prog_aux *)aux__aux;
>
> and here it will be:
>
> +       struct bpf_prog_aux *aux =3D (struct bpf_prog_aux *)aux__prog;
>
> which looks ok to me.

How about I rename the parameter to prog__aux?
Or __prog_aux as the tag name?

>
> pw-bot: cr

