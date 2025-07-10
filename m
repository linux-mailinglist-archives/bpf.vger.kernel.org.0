Return-Path: <bpf+bounces-62882-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C269AFF97F
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 08:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B5411C23B59
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 06:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DA62877E2;
	Thu, 10 Jul 2025 06:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxrAYy8Y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339542877CF
	for <bpf@vger.kernel.org>; Thu, 10 Jul 2025 06:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752127984; cv=none; b=FwveMuHfq5NNjlfZwCLFpSpBBftZ8s8J5Znhp8iQM+V3RXrpg0RcQp2wAAFxmYzCqOL15lxuyCEfUX3nm7cZ4+j3GMVa1jt6FpiIu2Md9WQUVSiA4FFGBs9odpwmZk5IVT4s9PGgJanZ5AjFutG6OV2BkaNKQc0xdFU1unKrUgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752127984; c=relaxed/simple;
	bh=WrQQiz4lhMnBtea4zg1jvX0Opg89hOcWY/NvbAjd7pg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bkD2GvzAEMPvw6CDO2tgVicyUtbJZ3f4sa6GBMYMmI+ElJUoAUSelv9FpJLtBQibHfhSxE5ihrf7XzTi5ISHeps46QV9BGH0Yd7g9O6ayY+79+pC27+YiCsAawsYwkoP2G/FSy6QboRqkySaycERc4GauVf44ESm6/qto+UYylw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fxrAYy8Y; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-749068b9b63so462312b3a.0
        for <bpf@vger.kernel.org>; Wed, 09 Jul 2025 23:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752127982; x=1752732782; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JPn6JmhskPoU4QJXE8q+rB/hQ0fJtC3XiBRjK0ou6Ws=;
        b=fxrAYy8YIpIE2AdwwvJpbLU5SHFRFwfDATaSbFjiHFxQ6ObS8Gq66xiTIoq6FOD7sk
         GqgQ2kuNcb/4UjjKsvK/nQMeFb4jQ7D1CPEKjYdYmqbE5SXd02l7/5epEiAbTb62gJG0
         kO9wlElkYVEuMvyY2PaGOIpabqkXOIcwBJVh1aztAGWp2bGh/hGuMVqmYmr0Vh+ot/F9
         fXwX/67OEtq898Vl1nDAeI2tLRhJbR2GPaiN5UQykOvsvwSia/zOTH0Xp/yIhiXYyqda
         GaINuEq3Goq7jSHI7+EUwkFrgUywHo8Pj5Ap5XSydhYcNAiH5AX/45UJYCcV41o34+84
         2aCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752127982; x=1752732782;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JPn6JmhskPoU4QJXE8q+rB/hQ0fJtC3XiBRjK0ou6Ws=;
        b=vnKBYpiaNCHAjlr86ZQg0H4a9iBIjGoqV0OAC30K2iXYOQ5iiQUuC9PGH6YjVr3Y2I
         OVKwky1AOKEJ7HiQufPieyH3OKcBpy0d9fonvGsdHrjW6XnTO3jFJUBJutkhJZDXe8b5
         MywJe0cMRY/ndSg1Cduax/bkpRbI0NV1Tj9B+QRDiHnnQ5zGIsZCFjoFG9BQ0hn8VF3p
         c0B0JofBiFzsa3uCISf6fXiXwFDoYATcEn6rIBZnd2b2mrmi/8nfNfk62gdljlH04l2D
         PkZqCaIprfi7SeoYjcQpKLzB4QQeE5V1I2g5//ZTm1i7SeG1n9kVf2rPpf/kfs5STd7D
         /xOA==
X-Forwarded-Encrypted: i=1; AJvYcCWrSUCd/zI63IIbXHo+FfBPInD8nRR2/ELysdh0YmQ5Wr+Ip0ifhwho3s3Ib41TILUOtGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLnuI4E+eh17eCD7VCVK+anfiFOlLVBxmp0xjbHAxnSLCEQaCl
	RJUM8QuLGjXo4BQlDLyDbFDZZ+NUjkU8vlMwo41nLT+sC8/QHh9V+YY0
X-Gm-Gg: ASbGnctRiMxwLiujOobRbA7pQt9DMhhNJkoBk3KhWsKm/8qsfn5up7+BrvtBKYdPA82
	Kkv+7PnsTR9YSAM/hiLN1K7TKmrWS/M+dzbf+fvEbi2u/hS2MYRmJChRt5n45/iTGZ0iD7B0Pww
	V11Fz7q+NUElga0KPRiugBfJ21L3pvRkXZ5Nt+sblfMQIj0k4fgYLFrHUxFVvsKyiLekptgymJS
	p/BnOAwlsjTcXNcatHqAxDhTYt/FY9BbJqU7UgbswN/HOGFfTRysmWw4tShHYtBR5dNM0xt57d3
	MtmtQvCFX6lj+ha51jJqa/L8OIuVtJc+ceoXXBGbO9HsO70MN9fGTNJcVA==
X-Google-Smtp-Source: AGHT+IHEFIs9vWunjybM8bJbvI4fOxAbSEGOCts2o/dB7AdajAhY+CoNuQ/R4F9G2PCrs0nzlnfD1g==
X-Received: by 2002:a05:6a00:2353:b0:748:ff39:a0f7 with SMTP id d2e1a72fcca58-74ea645f1bbmr7640823b3a.9.1752127982462;
        Wed, 09 Jul 2025 23:13:02 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9e06537sm1049008b3a.43.2025.07.09.23.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 23:13:02 -0700 (PDT)
Message-ID: <54224bfd1537d53a1d0450794de70b37e09c1951.camel@gmail.com>
Subject: Re: [RFC bpf-next 8/9] libbpf: support llvm-generated indirect jumps
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf
 <bpf@vger.kernel.org>,  Alexei Starovoitov	 <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Anton Protopopov	 <aspsk@isovalent.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Quentin Monnet	 <qmo@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>
Date: Wed, 09 Jul 2025 23:13:00 -0700
In-Reply-To: <aG9ZXg6z3HC2ycZq@mail.gmail.com>
References: <20250615085943.3871208-1-a.s.protopopov@gmail.com>
	 <20250615085943.3871208-9-a.s.protopopov@gmail.com>
	 <CAADnVQKhVyh4WqjUgxYLZwn5VMY6hSMWyLoQPxt4TJG1812DcA@mail.gmail.com>
	 <690335c5969530cb96ed9b968ce7371fb1f0228a.camel@gmail.com>
	 <aG3/MWCOwdk5z0mp@mail.gmail.com>
	 <f90ea7ec00265ab842e373a69f0ffdbb374f7614.camel@gmail.com>
	 <f38d1a6ff69991230b929f2cad5776f500a2a57c.camel@gmail.com>
	 <6254d58b01b255943269948ba4853afdcb9e9318.camel@gmail.com>
	 <aG9ZXg6z3HC2ycZq@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-07-10 at 06:10 +0000, Anton Protopopov wrote:
> On 25/07/09 10:11PM, Eduard Zingerman wrote:
> > On Wed, 2025-07-09 at 01:38 -0700, Eduard Zingerman wrote:
> > > On Tue, 2025-07-08 at 22:58 -0700, Eduard Zingerman wrote:
> > >=20
> > > [...]
> > >=20
> > > > This seems to work:
> > > > https://github.com/eddyz87/llvm-project/tree/separate-jumptables-se=
ction.1
> >=20
> > [...]
> >=20
> > > I think this is a correct form, further changes should be LLVM
> > > internal.
> >=20
> > Pushed yet another update. Jump table entries computation was off by 1.
> > Here is a comment from the commit:
> >=20
> > --- 8< --------------------------------
> >=20
> > Emit JX instruction anchor label:
> >=20
> >        .reloc 0, FK_SecRel_8, BPF.JT.0.0
> >        gotox r1
> >   .LBPF.JX.0.0:                          <--- this
> >=20
> > This label is used to compute jump table entries:
> >=20
> >                  .--- basic block label
> >                  v
> >   .L0_0_set_7 =3D LBB0_7 - .LBPF.JX.0.0    <---- JX anchor label
> >   ...
> >   BPF.JT.0.0:                            <---- JT definition
> >        .long   .L0_0_set_7
> >=20
> > The anchor needs to be placed after gotox to follow BPF
> > jump offset rules: dest_pc =3D=3D jump_pc + off + 1.
> > For example:
> >=20
> >   1: gotox r1 // suppose r1 value corresponds to to LBB0_7
> >      ...
> >   5: <insn>   // LBB0_7 physical address
> >=20
> > In order to jump to 5 from 1 offset read from jump table has to be 3,
> > hence anchor should be placed at 2.
> >=20
> > -------------------------------- >8 ---
> >=20
> > Please let me know if this works end-to-end.
>=20
> Thanks! I will be testing this today with my patchset.

I just realized that /8 is also necessary for table values.
Will push an update in an hour.

