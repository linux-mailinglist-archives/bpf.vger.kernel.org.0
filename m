Return-Path: <bpf+bounces-13673-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 489117DC5D6
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 06:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03547281752
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 05:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78E9D279;
	Tue, 31 Oct 2023 05:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJKEn3+k"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADA6CA7C
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 05:20:12 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE8DB7
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 22:20:10 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-5437269a661so428231a12.0
        for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 22:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698729609; x=1699334409; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UsZ0gnn+oCN/pJj0QQjRcgdf/5AJy3eTJlhB+KItz4k=;
        b=RJKEn3+ktFFW1Eo+EWLMkJydjmHV+NbUf1ReVTCjPlNu/h1VK8K5PMkvApNeVhjttq
         f8dNgCTBt9jtZyFCZk4knVAmmIDwldCbS/7TMQuHXYNXtme3i3CqEVP5f+fTT6M6CULo
         XKPdZxWkg8Vs9qFKVFYDHMLisHlAxEEPFonyfcr7499fcp7aFjN9TbhLvkHSpGdxOux1
         VAfudayHMo0SSAPUVUqwmZDVywN/wIeQVuNo2yUu0DDlsbVnHWvAVx/Ywh3nS5mRYD/q
         VdlrsK9hYdqQtacEdUtivLP2bkObcIbgNbvSsqdBwJcX9Suq3ORKT1TbuQSrAWhNamfR
         XUrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698729609; x=1699334409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UsZ0gnn+oCN/pJj0QQjRcgdf/5AJy3eTJlhB+KItz4k=;
        b=L5M87CDeLRgTIPP+wxBSYed32mFEEmAAe4LrVvja2bhqf6E5vtNYebl708RxvB3tMD
         p7MO2qcdNeUDcjNO0f8q1YnM4wb1T6yPzLuiqn5imXP6ZXnNeMXIFeu5Uo0syUCQr34F
         RqO6eYjYf1NjoPwwS5TT5fGJ9mjMzHuYgJ5OoZefrppJwEu/aPFR+7o0zvDr+Ior1aNw
         DR3gJr+b1ipuXnGbKhWsV5g9qHfARnvEeYjT8AOdTABJ8wSe3G4uv7hYJdYGYKGogPOu
         ZPNx0KfO96Qih0COyZ4Q9EzGQcyhRsMmWg9NEgQIgVapmPsnj5icv/9MsR0pPIyLl5St
         yMfg==
X-Gm-Message-State: AOJu0YxuPCPMCmggRApJrxEDiWQNwTIvup54wcjJdKruwgPDlMtTxCes
	Kdg6SPTARPuUyUJvbVPZOgUv6QbwIfqOaUk0GI8=
X-Google-Smtp-Source: AGHT+IEAEqnUcyF+qGgdEWqftDoP0qeA/fTvJl2vHEziVwqmnXR9ajgxWfJjmpl+oqVETI+bisWaEYtVBoYwqK6mPBY=
X-Received: by 2002:a17:907:94c6:b0:9b2:be5e:3674 with SMTP id
 dn6-20020a17090794c600b009b2be5e3674mr1233715ejc.36.1698729609060; Mon, 30
 Oct 2023 22:20:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231027181346.4019398-1-andrii@kernel.org> <20231027181346.4019398-12-andrii@kernel.org>
 <20231030193957.poqagefzsxqfputp@macbook-pro-49.dhcp.thefacebook.com>
In-Reply-To: <20231030193957.poqagefzsxqfputp@macbook-pro-49.dhcp.thefacebook.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 30 Oct 2023 22:19:57 -0700
Message-ID: <CAEf4BzZtwMDWnyZMCtH05wiGyzxePM9N6ubTOfmwb+WZFL2nRg@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 11/23] bpf: rename is_branch_taken reg
 arguments to prepare for the second one
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2023 at 12:40=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Oct 27, 2023 at 11:13:34AM -0700, Andrii Nakryiko wrote:
> > Just taking mundane refactoring bits out into a separate patch. No
> > functional changes.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  kernel/bpf/verifier.c | 107 +++++++++++++++++++++---------------------
> >  1 file changed, 53 insertions(+), 54 deletions(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index f5fcb7fb2c67..aa13f32751a1 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -14169,26 +14169,25 @@ static void find_good_pkt_pointers(struct bpf=
_verifier_state *vstate,
> >       }));
> >  }
> >
> > -static int is_branch32_taken(struct bpf_reg_state *reg, u32 val, u8 op=
code)
> > +static int is_branch32_taken(struct bpf_reg_state *reg1, u32 val, u8 o=
pcode)
> >  {
> > -     struct tnum subreg =3D tnum_subreg(reg->var_off);
>
> Looks like accidental removal that breaks build.
>

Yeah, sorry, there was *a lot* of rebasing involved to split all this
up. I'll fix it, thanks for spotting!

> >       s32 sval =3D (s32)val;
> >
> >       switch (opcode) {
> >       case BPF_JEQ:
> >               if (tnum_is_const(subreg))
> >                       return !!tnum_equals_const(subreg, val);

