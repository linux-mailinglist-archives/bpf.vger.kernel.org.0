Return-Path: <bpf+bounces-18554-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0494581BDEC
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 19:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 291BD1C20E01
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 18:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2CA634EE;
	Thu, 21 Dec 2023 18:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XMbhKZXU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFCD58224
	for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 18:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33666fb9318so948383f8f.2
        for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 10:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703182065; x=1703786865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hhu0n5dQs91ax8jUiKYYzDKvsmWCAp0z1GhCwjdcvxE=;
        b=XMbhKZXULB6XBDVq3o+f+/Ag1F94LAO/lfdK9n3PnJPdH4oEh44cZTEoeqRzHZ+ew0
         DaMwPszOlL9EUQPENHSGGGy8msOnw/sjrCmxplmHLL3ORR2LXDsLo0vfv+iVBFQtTObz
         yGxkRFSIlc7CstzR3hwAlb0meENo1T5gotFP58l0eWS82A5QOLHaqOvmxSXshI1+9Aw0
         92VfRrLocr9+2C2nGUwUNPM1ZYHJdGAB4rnzEQoeyZMnHCd4qT5iT5Z0M6XHM+xMT6Nq
         0IMS9QQQAeCEBPGUPFrgZrsh/7OHgoMuGuJ1rWcRDgAmVtTWKhL0aLEOAvPuJeAdU/c3
         4L7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703182065; x=1703786865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hhu0n5dQs91ax8jUiKYYzDKvsmWCAp0z1GhCwjdcvxE=;
        b=i0uBwm2KahZx/EtEnWwl4+Y3Lf4b8gTqtRLcpFLpORupfpzpWXJuJ4sELtbz+4s0jM
         Y+EGCSXI/8i2lV3YKKHz+pd8lMm9Y/sRoSP3yX59xrnbiYjktqZjiyGwobbnfvmiHU0R
         kBaShZxu53/Bgj4B+nOXvf1U83niLEt20+HIUjQP245a0L47N4ZjsC3D2iZhKkO3GkuM
         R7hdjWgSQbA1zxBboBv/BhTV7iLmlx4JLIoMkDLDRzPQTpLUUEgXxm//QVhrCJCaKhXt
         KXLjbrI8BgsbZPNFFrQZbNIBYCq+QUzXHLp54rjI+vP6QDgHB4MGm76+onBzhOasU24P
         5Uew==
X-Gm-Message-State: AOJu0YzY1e+Xeivdf7tG03R8xtzQJCeR0PGiA/ZZx5/36I5Uqs8BOYUa
	GSZcBSlnWVZRxPpk5YB5xIKesKCyP1K6TCdv/hk=
X-Google-Smtp-Source: AGHT+IF3nfSUgNOsvbzkdUDpli7S0Vi5UxnKA4UguK362q1eRdk4AI1V2R7Gl+cvI7qXHEGbgDd4dmPBInQglLA4JYs=
X-Received: by 2002:adf:ec8a:0:b0:336:431c:8db7 with SMTP id
 z10-20020adfec8a000000b00336431c8db7mr84247wrn.47.1703182065191; Thu, 21 Dec
 2023 10:07:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <421d18942d6ad28625530a8b3247595dc05eb100.1703110747.git.dxu@dxuuu.xyz>
 <62ytcwvqvnd5wiyaic7iedfjlnh5qfclqqbsng3obx7rbpsrqv@3bjpvcep4zme>
 <ZYP40EN9U9GKOu7x@krava> <CAADnVQJL7Yodi67f2A79Pah-Uek+WX66CVs=tAFAoYsh+t+3_Q@mail.gmail.com>
 <fecae4fe-b804-c7f5-1854-66af2f16a44a@oracle.com>
In-Reply-To: <fecae4fe-b804-c7f5-1854-66af2f16a44a@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 21 Dec 2023 10:07:33 -0800
Message-ID: <CAADnVQ+9PZvTc034oHa=7yQFPtyV=Yvjqef2+r97SyKFOgV=RA@mail.gmail.com>
Subject: Re: [PATCH dwarves] pahole: Inject kfunc decl tags into BTF
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Daniel Xu <dxu@dxuuu.xyz>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Quentin Monnet <quentin@isovalent.com>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 9:43=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> On 21/12/2023 17:05, Alexei Starovoitov wrote:
> > On Thu, Dec 21, 2023 at 12:35=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com>=
 wrote:
> >> you need to pick up only 'BTF_ID(func, ...)' IDs that belongs to SET8 =
lists,
> >> which are bounded by __BTF_ID__set8__<name> symbols, which also provid=
e size
> >
> > +1
> >
> >>>
> >>> Maybe we need a codemod from:
> >>>
> >>>         BTF_ID(func, ...
> >>>
> >>> to:
> >>>
> >>>         BTF_ID(kfunc, ...
> >>
> >> I think it's better to keep just 'func' and not to do anything special=
 for
> >> kfuncs in resolve_btfids logic to keep it simple
> >>
> >> also it's going to be already in pahole so if we want to make a fix in=
 future
> >> you need to change pahole, resolve_btfids and possibly also kernel
> >
> > I still don't understand why you guys want to add it to vmlinux BTF.
> > The kernel has no use in this additional data.
> > It already knows about all kfuncs.
> > This extra memory is a waste of space from kernel pov.
> > Unless I am missing something.
> >
> > imo this logic belongs in bpftool only.
> > It can dump vmlinux BTF and emit __ksym protos into vmlinux.h
> >
>
> If the goal is to have bpftool detect all kfuncs, would having a BPF
> kfunc iterator that bpftool could use to iterate over registered kfuncs
> work perhaps?

The kernel code ? Why ?
bpftool can do the same thing as this patch. Iterate over set8 in vmlinux e=
lf.

