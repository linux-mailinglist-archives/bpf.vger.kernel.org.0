Return-Path: <bpf+bounces-13676-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 954707DC5EE
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 06:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DAB7281513
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 05:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C882BD28D;
	Tue, 31 Oct 2023 05:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WgoOBu+S"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D46D279
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 05:28:42 +0000 (UTC)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B50C1
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 22:28:41 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-507962561adso7637634e87.0
        for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 22:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698730119; x=1699334919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=He80OLYgdRzOrR6/UH/NQyWEBQ3OOxY16V3FWxT8qWg=;
        b=WgoOBu+S7++s0x11Sx5ZdqBhgaBBdsx+kN1LyrOjxpHrb6DL3udwZ361ZqT+NxDPzm
         p0I2zbcRAtrrR9mCZYi4MPyURzFG/1mbcB5Livbw9/axDytAkon97j9Qh2VRTgQ3Z6hT
         PxyzFcxb3/laxwDa+7bDDgT76Pz7udeQT+LZI8v5zmR1r3A8CJ2kdntWvOd3Io6Qjf3Q
         /YqrIkvuJJ6VcnS+mIpJwFNn1y9j6amKCWpugNmW5sVvsIuzzvTr4KyC6aO3Fy5U/n81
         PjXbllZNGQkr+VtZt8jJDln9AS5LqWtZxCNazuPhDFVnXNkwKs1P1122Oo61dFB4UKiB
         Z0dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698730119; x=1699334919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=He80OLYgdRzOrR6/UH/NQyWEBQ3OOxY16V3FWxT8qWg=;
        b=E9W6HpDNNEIPvHjmBDdnM2GsZDlGfHElIc/lNt4J+yrSQo5nygHC8nu0TC56mw0BXq
         rtdX/0w1OJu6ZE62TCTd/S+h8tPXgMHQoQ0Du5bpPLhYU0tJRJcG7MZgc7S3FedAUfmg
         AEQf9RrO1fMlyrgraIbd41q0Q1jxZ9uGvRxlJX2J76+nTzz/bp4FY0zIXxTlK8N5Z/37
         Rk/NG+1kibZgyn6LWH58NjG+X4giM9w06uWJ+qmMvkJzK5/av7DyfJd9adOSMODMEzax
         i2KGqnqnfD3lkQnxgzsoQ8wH3vm3KX39vCq0k+lgjh7ekyYlG4P0RloURhaw/67tQKPr
         B95Q==
X-Gm-Message-State: AOJu0YxcY/Vs0AoqF5gmJpQUiYH23YEy0+w/9C/0SiZy/1jjQh/aEZV8
	ertVyH6cTI64hsD20X3xZcHl9vKzqpzb99xloeQ=
X-Google-Smtp-Source: AGHT+IGSRPkT3x2WiZcLzMaq5yLQsVXtVmPUB2bhjXZkB6YcjCaXbsKp1i0FWLoLFOb6LXYdFbr9zRdDQNStua3bSLo=
X-Received: by 2002:a19:5517:0:b0:507:a5e2:7c57 with SMTP id
 n23-20020a195517000000b00507a5e27c57mr8908521lfe.18.1698730119073; Mon, 30
 Oct 2023 22:28:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231027181346.4019398-1-andrii@kernel.org> <20231027181346.4019398-16-andrii@kernel.org>
 <20231030195216.zpcntk47dxyissoi@macbook-pro-49.dhcp.thefacebook.com>
In-Reply-To: <20231030195216.zpcntk47dxyissoi@macbook-pro-49.dhcp.thefacebook.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 30 Oct 2023 22:28:27 -0700
Message-ID: <CAEf4BzZZfSW2+Xm+QsFyaNkmNcodpbPkhTQeoE-47+WYgMbtMw@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 15/23] bpf: unify 32-bit and 64-bit
 is_branch_taken logic
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2023 at 12:52=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Oct 27, 2023 at 11:13:38AM -0700, Andrii Nakryiko wrote:
> > Combine 32-bit and 64-bit is_branch_taken logic for SCALAR_VALUE
> > registers. It makes it easier to see parallels between two domains
> > (32-bit and 64-bit), and makes subsequent refactoring more
> > straightforward.
> >
> > No functional changes.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  kernel/bpf/verifier.c | 154 ++++++++++--------------------------------
> >  1 file changed, 36 insertions(+), 118 deletions(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index fedd6d0e76e5..b911d1111fad 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -14185,166 +14185,86 @@ static u64 reg_const_value(struct bpf_reg_st=
ate *reg, bool subreg32)
> >  /*
> >   * <reg1> <op> <reg2>, currently assuming reg2 is a constant
> >   */
> > -static int is_branch32_taken(struct bpf_reg_state *reg1, struct bpf_re=
g_state *reg2, u8 opcode)
> > +static int is_scalar_branch_taken(struct bpf_reg_state *reg1, struct b=
pf_reg_state *reg2,
> > +                               u8 opcode, bool is_jmp32)
> >  {
> > -     struct tnum subreg =3D tnum_subreg(reg1->var_off);
> > -     u32 val =3D (u32)tnum_subreg(reg2->var_off).value;
> > -     s32 sval =3D (s32)val;
> > +     struct tnum t1 =3D is_jmp32 ? tnum_subreg(reg1->var_off) : reg1->=
var_off;
> > +     u64 umin1 =3D is_jmp32 ? (u64)reg1->u32_min_value : reg1->umin_va=
lue;
> > +     u64 umax1 =3D is_jmp32 ? (u64)reg1->u32_max_value : reg1->umax_va=
lue;
> > +     s64 smin1 =3D is_jmp32 ? (s64)reg1->s32_min_value : reg1->smin_va=
lue;
> > +     s64 smax1 =3D is_jmp32 ? (s64)reg1->s32_max_value : reg1->smax_va=
lue;
> > +     u64 val =3D is_jmp32 ? (u32)tnum_subreg(reg2->var_off).value : re=
g2->var_off.value;
> > +     s64 sval =3D is_jmp32 ? (s32)val : (s64)val;
>
> Maybe use uval and sval to be consisten with umin/smin ?

Sure, I will update val to uval for consistency.

