Return-Path: <bpf+bounces-17739-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC35812380
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 00:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4602B21220
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 23:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147B079E16;
	Wed, 13 Dec 2023 23:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HAIhzLsZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13324C9;
	Wed, 13 Dec 2023 15:47:39 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3364514fe31so246937f8f.1;
        Wed, 13 Dec 2023 15:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702511257; x=1703116057; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DzX45WvCsgZhpc7rT6V8I3XpK+GcadypFiCWho8hSpQ=;
        b=HAIhzLsZPa72wLsgEb1jSuEm3t8gTuV/ZPQzu63n8tkWcWZ6m6tLzyHhqJanvI/AiD
         rBFcCKqJRrNDwOv24f6aoql0vRogSIKCWBFDAUm69JOjactyBvaAzp03B1tRqJwOiFl5
         KBrwpiVKg3tAvNFzNl2nSkfEt9BjIDmzOMlECA3r5aYxhFUd/fHtTdTZgzLjylDNEq6Y
         b29w4cq8hi3vlXx6s4V62wcyLRXPr6EJ+8ggPGbAA8Xft0R6FH3LrNae8/YP1++Gtcw+
         X/tjGXgn35eoLff1tyOs/FoOwIiqF5mG7TUylt4xfcMvnPuwa0z3hziiw3zWRjfGaDzB
         h8mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702511257; x=1703116057;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DzX45WvCsgZhpc7rT6V8I3XpK+GcadypFiCWho8hSpQ=;
        b=rvLE9AXhvFjOyQWMmI0ZdidofdejZGxBGxwwA9RzinQvmHp5q9y4jykykYP4zFZPnG
         cvdQXKDo3cZU26YVnVpehC7bVw2foDfsEyafvorC02HTohNnIk+S6YJ+O0qBo24CRoKT
         Xim+vFH14dK1oJYgKHntAA63aOhEOs4wgJmUVYF7kiKqH6zBriW1vYbyK20ePdViiVSg
         phUl46wl+SDgKvQ8E9SZuybqU8hJSZD/Msxd+F2BdkDwCTpDek4gbByadvp17MsJbmme
         +fLfnLWG4JjhmZMDxUYauCiqSWKCOblN04EjZHrhbjcX61WOKmuBGA56zzZ0/qBg+d26
         AShA==
X-Gm-Message-State: AOJu0Yxh+JHzU0rXRFjFlHFSjRfp+a6JNUh+b0MBtQpD1GGNPzlDZRDT
	OKJan3YfywKMjxBhz7JKujA+HfFMSzUe3Q==
X-Google-Smtp-Source: AGHT+IFTJa3nggUwEvu3DevQK/zBr+UnrycCV6yK6Jko/3dlmj5Gs6jAYLql3oaN3mDpk1cL+Wd8Lw==
X-Received: by 2002:a5d:4a47:0:b0:336:35f2:9d60 with SMTP id v7-20020a5d4a47000000b0033635f29d60mr1628250wrs.39.1702511257365;
        Wed, 13 Dec 2023 15:47:37 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id g12-20020a5d46cc000000b003335c061a2asm14496338wrs.33.2023.12.13.15.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 15:47:36 -0800 (PST)
Message-ID: <3ba67d3e220c19c4a921e20f06e26bfe70ae8c80.camel@gmail.com>
Subject: Re: [Bug Report] bpf: incorrectly pruning runtime execution path
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Hao Sun <sunhao.th@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>, Linux Kernel Mailing
 List <linux-kernel@vger.kernel.org>
Date: Thu, 14 Dec 2023 01:47:35 +0200
In-Reply-To: <CAEf4BzbfF=aNa-jAkka6YrK6Vbisi=v7PFsEDR-RFuHtAub2Xw@mail.gmail.com>
References: 
	<CACkBjsbj4y4EhqpV-ZVt645UtERJRTxfEab21jXD1ahPyzH4_g@mail.gmail.com>
	 <CAEf4BzZ0xidVCqB47XnkXcNhkPWF6_nTV7yt+_Lf0kcFEut2Mg@mail.gmail.com>
	 <CACkBjsaEQxCaZ0ERRnBXduBqdw3MXB5r7naJx_anqxi0Wa-M_Q@mail.gmail.com>
	 <480a5cfefc23446f7c82c5b87eef6306364132b9.camel@gmail.com>
	 <CAEf4BzbfF=aNa-jAkka6YrK6Vbisi=v7PFsEDR-RFuHtAub2Xw@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2023-12-13 at 15:40 -0800, Andrii Nakryiko wrote:
[...]
> >     24: (18) r2 =3D 0x4                     ; R2_w=3D4
> >     26: (7e) if w8 s>=3D w0 goto pc+5
> >     mark_precise: frame0: last_idx 26 first_idx 22 subseq_idx -1
> >     mark_precise: frame0: regs=3Dr5,r8 stack=3D before 24: (18) r2 =3D =
0x4
> >     ...                   ^^^^^^^^^^
> >                           ^^^^^^^^^^
> > Here w8 =3D=3D 15, w0 in range [0, 2], so the jump is being predicted,
> > but for some reason R0 is not among the registers that would be marked =
precise.
>=20
> It is, as a second step. There are two concatenated precision logs:
>=20
> mark_precise: frame0: last_idx 26 first_idx 22 subseq_idx -1
> mark_precise: frame0: regs=3Dr0 stack=3D before 24: (18) r2 =3D 0x4
> mark_precise: frame0: regs=3Dr0 stack=3D before 23: (bf) r5 =3D r8
> mark_precise: frame0: regs=3Dr0 stack=3D before 22: (67) r4 <<=3D 2
>=20
>=20
> The issue is elsewhere, see my last email.

Oh, right, there are two calls to mark_chain_precision in a row, thanks

