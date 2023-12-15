Return-Path: <bpf+bounces-17925-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA13813F26
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 02:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C511228382D
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 01:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A690B10EC;
	Fri, 15 Dec 2023 01:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lKHmABRP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94485ED4;
	Fri, 15 Dec 2023 01:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40c3ca9472dso1807475e9.2;
        Thu, 14 Dec 2023 17:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702603484; x=1703208284; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sFwupamHMRnoWcSsE7g89K86fdj1VPwLpTC2Tjqs9Fs=;
        b=lKHmABRPAI0PF4Svtm1EB1JvaSYirB79hgRGNACxXQ9cUJBYVXcdMWUy0tgpfT0LkU
         r5BBAXk77j2EOyPxCoZY8TVpCUFrT5/mCilIcfYTw4jFHRbkzZ4emO6Nq+XngiAaEnrN
         rdygUWx6wVOXuQD16VdBQTPnEk06CYvUV3XleZaxuNwinnUjn2yDczER9YPiXxVcJhSp
         4ISgvpots9ECwlzv7xWooSCVhp7t6gE2i3GqdUX0Dm4ufyFM0jUj8HdSzfNN5yaMurJr
         03gDFwX6kTzna8Lqryh/NCapEtbanwTzS0MWt/IUG1GuBSJnIsE5ZC/xdYB5HGA5oVZc
         L8dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702603484; x=1703208284;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sFwupamHMRnoWcSsE7g89K86fdj1VPwLpTC2Tjqs9Fs=;
        b=r9NxM+r78QQcsfgtfgZcEORjDL8fzl/h0ipla7XXIg9/D5lILqodPsqQpMFejIybgb
         oLSQwUtF/IfwrCsUXglgnxbA9/wF5Tz7nyfh6UDiTYusOw3BXJW/KrJ9G9fEsfE+9eqw
         l/AJ2IOdVbH8rWtU4hgiLFJjt+FqoloCE1N5ohgezeuC5tQjkEpyTnA9R0HB23STVxY2
         ngNw1dk8d98+I4X0f4ww63IT2ZYGTY+P3Cggt5GxDRZaMHNLELjYZkQzEoct8Kz+8LHb
         JmnQMfu7u1ZdVMvOsuc5tTzAU3p2n9WMVGPyMbYoObSy424xHQjd0+FCr5DRtOVogr0X
         nrnQ==
X-Gm-Message-State: AOJu0Yyyfwv66dxyoDh4oIHbUfUCW5CbvGHqGjBqxR3dBLNu3Jk1DLjZ
	R1/z9JeyGpzu2uX7avPP34k=
X-Google-Smtp-Source: AGHT+IF4RorCrtD+nwnHuisDKmQUg8rH8eyhl/Hl06c/bnhz7967oSmRICUzsaexW0gE+RKEQuWjwA==
X-Received: by 2002:a1c:4b05:0:b0:40b:5e1a:db92 with SMTP id y5-20020a1c4b05000000b0040b5e1adb92mr3762342wma.51.1702603483768;
        Thu, 14 Dec 2023 17:24:43 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id j17-20020a05600c1c1100b0040b48690c49sm26950842wms.6.2023.12.14.17.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 17:24:43 -0800 (PST)
Message-ID: <2b49b96de9f8a1cd6d78cc5aebe7c35776cd2c19.camel@gmail.com>
Subject: Re: [Bug Report] bpf: incorrectly pruning runtime execution path
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Hao Sun <sunhao.th@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>, Linux Kernel Mailing
 List <linux-kernel@vger.kernel.org>
Date: Fri, 15 Dec 2023 03:24:42 +0200
In-Reply-To: <526d4ac8f6788d3323d29fdbad0e0e5d09a534db.camel@gmail.com>
References: 
	<CACkBjsbj4y4EhqpV-ZVt645UtERJRTxfEab21jXD1ahPyzH4_g@mail.gmail.com>
	 <CAEf4BzZ0xidVCqB47XnkXcNhkPWF6_nTV7yt+_Lf0kcFEut2Mg@mail.gmail.com>
	 <CACkBjsaEQxCaZ0ERRnBXduBqdw3MXB5r7naJx_anqxi0Wa-M_Q@mail.gmail.com>
	 <480a5cfefc23446f7c82c5b87eef6306364132b9.camel@gmail.com>
	 <917DAD9F-8697-45B8-8890-D33393F6CDF1@gmail.com>
	 <9dee19c7d39795242c15b2f7aa56fb4a6c3ebffa.camel@gmail.com>
	 <73d021e3f77161668aae833e478b210ed5cd2f4d.camel@gmail.com>
	 <CAEf4BzYuV3odyj8A77ZW8H9jyx_YLhAkSiM+1hkvtH=OYcHL3w@mail.gmail.com>
	 <526d4ac8f6788d3323d29fdbad0e0e5d09a534db.camel@gmail.com>
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

On Fri, 2023-12-15 at 02:49 +0200, Eduard Zingerman wrote:
> On Thu, 2023-12-14 at 16:06 -0800, Andrii Nakryiko wrote:
> [...]
> > If you agree with the analysis, we can start discussing what's the
> > best way to fix this.
>=20
> Ok, yeap, I agree with you.=20
> Backtracker marks both registers in 'if' statement if one of them is
> tracked, but r8 is not marked at block entry and we miss r0.

The brute-force solution is to keep a special mask for each
conditional jump in jump history. In this mask, mark all registers and
stack slots that gained range because of find_equal_scalars() executed
for this conditional jump. Use this mask to extend precise registers set.
However, such mask would be prohibitively large: (10+64)*8 bits.

---

Here is an option that would fix the test in question, but I'm not
sure if it covers all cases:
1. At the last instruction of each state (first instruction to be
   backtracked) we know the set of IDs that should be tracked for
   precision, as currently marked by mark_precise_scalar_ids().
2. In jump history we can record IDs for src and dst registers when new
   entry is pushed.
3. While backtracking 'if' statement, if one of the recorded IDs is in
   the set identified at (1), add src/dst regs to precise registers set.

E.g. for the test-case at hand:

  0: (85) call bpf_get_prandom_u32#7    ; R0=3Dscalar()
  1: (bf) r7 =3D r0                       ; R0=3Dscalar(id=3D1) R7_w=3Dscal=
ar(id=3D1)
  2: (bf) r8 =3D r0                       ; R0=3Dscalar(id=3D1) R8_w=3Dscal=
ar(id=3D1)
  3: (85) call bpf_get_prandom_u32#7    ; R0=3Dscalar()
  --- checkpoint #1 r7.id =3D 1, r8.id =3D 1 ---
  4: (25) if r0 > 0x1 goto pc+0         ; R0=3Dscalar(smin=3Dsmin32=3D0,sma=
x=3Dumax=3Dsmax32=3Dumax32=3D1,...)
  --- checkpoint #2 r7.id =3D 1, r8.id =3D 1 ---
  5: (3d) if r8 >=3D r0 goto pc+3         ; R0=3D1 R8=3D0 | record r8.id=3D=
1 in jump history
  6: (0f) r8 +=3D r8                      ; R8=3D0
  --- checkpoint #3 r7.id =3D 1, r8.id =3D 0 ---
  7: (15) if r7 =3D=3D 0x0 goto pc+1

The precise set for checkpoint #3 state is {1}.
When insn (5) is backtracked r8.id would be in jump history and in
"precise set" =3D> r8 and r0 would be added to backtracker state.

But this seems a bit ad-hoc.

