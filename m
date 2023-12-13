Return-Path: <bpf+bounces-17741-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54642812393
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 00:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C01ED1F21653
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 23:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8969E79E1C;
	Wed, 13 Dec 2023 23:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PkVpsw2J"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B6B1A1;
	Wed, 13 Dec 2023 15:50:53 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-a22deb95d21so365362366b.3;
        Wed, 13 Dec 2023 15:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702511451; x=1703116251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Stx3HSyTFmSlHvWdmGz/VBTLpkzua9Mpif2ad6kPSY=;
        b=PkVpsw2JPyotYNIDKHBMWgIAuLBDQ5p8QWxs+ppn1XBs9nm+0pwzPiojNqrgwt7yBc
         /ksjR7bVx6tsSvHkEUN3drsiorfEZkswOn7NYNoYKySOAhSMZWSTMumJAfb3faQQN4Eg
         qtYhrC1OZB/Ylld8EpGran7x1XJjJ3RNqlPXDQ8qKunLtyolfueAFXj2hludqsc6O6KU
         xwGjG/1I5UyZBQc+e0Obk3OMlQosVtpg/bzCaLsqt53tajEkO7BmchbELzqbAYJ53cyy
         2VBZSr5lm8XKTM2HBi9K7FsCCgk9IQSqUWVhJMmEj9tEXtq4kN4cX8N3ZZFnUg9Rl6S6
         4gNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702511451; x=1703116251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Stx3HSyTFmSlHvWdmGz/VBTLpkzua9Mpif2ad6kPSY=;
        b=BjafL2bgecLhwwuZJ0zvMNVdLUdIMLgfHM+ZV76gDBWGRQGerQ12rFA84mTEw8teVz
         y00iKZYMZbSrcoC1Qx0hFQ6p6RV+yST+FHHBU4Cy9UAS9jlN/1HPiR7sEU9yCHGHjG/H
         W8Tt71xgaut/X+GDDCuXjClpO7PAfWHDEdVuhs6n3FYHtHhy9CetqaB+zlaspiPqkRe7
         Y9nIiv/qKts2H2qI3TuFW/PPkvxu4GrGtoHRSp5Vhozx+oixiObA14aA1Jyss8wSDWeh
         232isY9s58aeqIwViUMNVzt7SiCyEfPCuPTJBRUovO8gsJfeOuhHF+xgPBSjETYTI2wY
         gaAg==
X-Gm-Message-State: AOJu0YyI4tDGH7kS0OsSRps8SQrqRoRuVQ/H0/5r5BVBDl1bIz9v4V+B
	8FLbSDH7HKe80GOvQx98nVj4rvXcFVPZTXT0922lqW2I
X-Google-Smtp-Source: AGHT+IEHl2XIA7YRMI8oKJWShxuywwQfjqlqneamf2G3eLtUWEGhYoecsbHUXjCqSiA0j4cq1lIlP9NL8bMaRLpDTqE=
X-Received: by 2002:a17:906:b793:b0:a1c:be13:f0bc with SMTP id
 dt19-20020a170906b79300b00a1cbe13f0bcmr4930110ejb.109.1702511451517; Wed, 13
 Dec 2023 15:50:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACkBjsbj4y4EhqpV-ZVt645UtERJRTxfEab21jXD1ahPyzH4_g@mail.gmail.com>
 <CAEf4BzZ0xidVCqB47XnkXcNhkPWF6_nTV7yt+_Lf0kcFEut2Mg@mail.gmail.com>
 <CACkBjsaEQxCaZ0ERRnBXduBqdw3MXB5r7naJx_anqxi0Wa-M_Q@mail.gmail.com>
 <480a5cfefc23446f7c82c5b87eef6306364132b9.camel@gmail.com>
 <CAEf4BzbfF=aNa-jAkka6YrK6Vbisi=v7PFsEDR-RFuHtAub2Xw@mail.gmail.com> <3ba67d3e220c19c4a921e20f06e26bfe70ae8c80.camel@gmail.com>
In-Reply-To: <3ba67d3e220c19c4a921e20f06e26bfe70ae8c80.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 13 Dec 2023 15:50:39 -0800
Message-ID: <CAEf4BzbTCsP6ybmpWZ7mmb3CPGHB9WAD3xmd77YauMPuR1pSdA@mail.gmail.com>
Subject: Re: [Bug Report] bpf: incorrectly pruning runtime execution path
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Hao Sun <sunhao.th@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 3:47=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Wed, 2023-12-13 at 15:40 -0800, Andrii Nakryiko wrote:
> [...]
> > >     24: (18) r2 =3D 0x4                     ; R2_w=3D4
> > >     26: (7e) if w8 s>=3D w0 goto pc+5
> > >     mark_precise: frame0: last_idx 26 first_idx 22 subseq_idx -1
> > >     mark_precise: frame0: regs=3Dr5,r8 stack=3D before 24: (18) r2 =
=3D 0x4
> > >     ...                   ^^^^^^^^^^
> > >                           ^^^^^^^^^^
> > > Here w8 =3D=3D 15, w0 in range [0, 2], so the jump is being predicted=
,
> > > but for some reason R0 is not among the registers that would be marke=
d precise.
> >
> > It is, as a second step. There are two concatenated precision logs:
> >
> > mark_precise: frame0: last_idx 26 first_idx 22 subseq_idx -1
> > mark_precise: frame0: regs=3Dr0 stack=3D before 24: (18) r2 =3D 0x4
> > mark_precise: frame0: regs=3Dr0 stack=3D before 23: (bf) r5 =3D r8
> > mark_precise: frame0: regs=3Dr0 stack=3D before 22: (67) r4 <<=3D 2
> >
> >
> > The issue is elsewhere, see my last email.
>
> Oh, right, there are two calls to mark_chain_precision in a row, thanks

We should probably combine those two steps, though, backtrack_state
allows us that now (see how propagate_precision() is doing that in one
go). It used to be very hard to mark two registers at the same time,
but now it's trivial. So not a bad idea to improve this and remove
confusion, especially in big real-world programs.

