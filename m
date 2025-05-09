Return-Path: <bpf+bounces-57923-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F22AB1DB0
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 22:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20AAE52214D
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 20:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D8625E83E;
	Fri,  9 May 2025 20:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MOOWOs16"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE5F21A45C
	for <bpf@vger.kernel.org>; Fri,  9 May 2025 20:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746821238; cv=none; b=i1wIzgkAXCi1GOcCYZGPloxWTzNXIl19UGi1+BbKTDlU5YK/R2AAxQjgEJg2BoVEZEVXAS5dSYBUL2+Y2tbmlRFgqkalNGY/Rr4K53pfEQetdQeUS4yteUkNVkQNZ8J/hSTiuRg7OQZWPiZ1kXH8vWvCSHKylPUONIQnavpZchg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746821238; c=relaxed/simple;
	bh=rMKgUDyemaKRv0zcy/DXws6hNbNk+50DDO/J0ryyOJw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MN7L2B5HJLpHjQjDafi1Xm4RFp3nKixj21GolNDDD2wkl+5GZ3zRXS7AQvvB+7vRQYAGk1HvklZdIpAJceAKdNDcsp6pJuqQSo0QFZE8PxMDGJb2gqPOmkwuLDvdTTti79juUjjNMTYyQ2r+7bJidPQrAg5WhCmKiWu5NfORIQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MOOWOs16; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-73bf1cef6ceso2669571b3a.0
        for <bpf@vger.kernel.org>; Fri, 09 May 2025 13:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746821236; x=1747426036; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F8VeWO2Ffbdj9gdoWovA3XKkHloLN+Lip1VxaGbMPn0=;
        b=MOOWOs165PpYaIaOkpZaFYAyXxBvwadCSA8dUzSKJ9Bpz/PMMW4pixf0Q7RWOxwNwY
         LNkRh8F3qlT3pk4r1glq38wp5Qbr67yfloqkKZMVO2iG/uJNO25Y64W+CdrZ5n8noEd7
         Jdd0sso17Iwd15pOLYpnqB33k4g7Udu8CwZGzQWV7OtSBvkxyFGrMIwwiOZRc2+KGFVQ
         quVvJR4aCT7eRMRIXZMH9qKI2Y+He9xS22LYoGzC3Kjm9yi+RGb3pm02Y95YfNchV0Ez
         hlNPfVomxAcX4YLwfaHmsmiE5EWfr19mCMsDwK18/yJNtpOtW9HQauBbLR8SfZcLPypV
         cGUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746821236; x=1747426036;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F8VeWO2Ffbdj9gdoWovA3XKkHloLN+Lip1VxaGbMPn0=;
        b=ExFUdBDqHM7v1HavB2UDqz59tOizBbIaIdPFXBqkSqp1iKU/iM/8P8n87qPoXMGxiZ
         wkaDkVScZHnD7GyyYOCOR3cFfwj8MgGHliWarhX+jtSaKSkiJSO4/ycYQu2XMX3tQpcf
         9IDk6TpA8/f036lkqboaWRaIkHvbIyja0zteQwknAutkvlGaRBWoYybETja3Xq5pcCO2
         V5lTS/mYmHGDsIrGZ5P1r9zyp1/GG44FraPSdERFscdrCZr2PfhZtdtYHPHP0P0a9H02
         WsQl+Y8FdgVsq95QKeYVjvtqeH/Vt3GWDOmGP/YWM1VHuOe24YGC6Z1paaYL9PdHiDp+
         owkg==
X-Gm-Message-State: AOJu0YyYfIFBXPoPDe4GvxPQNgxlY2Cb4ttNvEumqWyyZGNAfIV69tC+
	nkhTzKKc0/Em2q6nCuqeHcTyFb9yEJuCpLeZ/VTbNjVe4WsRRkxg
X-Gm-Gg: ASbGncuH2nrYWM67y8N6pvPzEEaqEUsNOf1jYELp6O8btI68AhxJJefmeH0AIlSNn8H
	RD1ZIOXNcVm1CVAlLAU690J4VuWoSnOz0a+Lh5rMkjP3Z3Hlzk1fo/3ZvULKgZFth8UvbCbB3yq
	1X7h4lClBsTmCiz6aJ5HOXWTttCnniWfTd4DZ4HPIfMitsEcNZ/MFIDdvybWtn4iI4opS7QTXA0
	05nPHFv4qX77UGk2Gw0VELKUgXicvrGF83SPCLEsxVVojgFQWqz8mg/YPPgh1yBPBJYROPjbEuf
	ZQAPsh4eDjiRiEK+mabgvNOeWA6yJHqcVPuQVWPsAlIfuRc=
X-Google-Smtp-Source: AGHT+IGmvQfpeoREK+9YC6Y63/v+wEWPc2MW5SCkdLfAR66la1qdcRYmLHJmt8HnBqTY9lqzdaXV7Q==
X-Received: by 2002:a17:902:ecc2:b0:22e:9f5:6f17 with SMTP id d9443c01a7336-22fc8b32d0amr53204585ad.13.1746821235936;
        Fri, 09 May 2025 13:07:15 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc75469d3sm21519735ad.41.2025.05.09.13.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 13:07:15 -0700 (PDT)
Message-ID: <e78b2cf09f6931ec8e7791e35c8b49f19bf1d4b5.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 08/11] bpf: Report arena faults to BPF stderr
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko	 <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau	 <martin.lau@kernel.org>, Emil Tsalapatis
 <emil@etsalapatis.com>, Barret Rhoden	 <brho@google.com>, Matt Bobrowski
 <mattbobrowski@google.com>, kkd@meta.com, 	kernel-team@meta.com
Date: Fri, 09 May 2025 13:07:13 -0700
In-Reply-To: <CAP01T74uq5Uyy6VHXyA_yVeO9rdU7svnQv90Z7auerApjbRfQA@mail.gmail.com>
References: <20250507171720.1958296-1-memxor@gmail.com>
	 <20250507171720.1958296-9-memxor@gmail.com>
	 <a071c33a195642de5530f897880e44bc1416a86b.camel@gmail.com>
	 <CAP01T74uq5Uyy6VHXyA_yVeO9rdU7svnQv90Z7auerApjbRfQA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-05-09 at 22:01 +0200, Kumar Kartikeya Dwivedi wrote:

[...]

> > >  bool ex_handler_bpf(const struct exception_table_entry *x, struct pt=
_regs *regs)
> > >  {
> > > -     u32 reg =3D x->fixup >> 8;
> > > +     u32 arena_reg =3D (x->fixup >> 8) & 0xff;
> > > +     bool is_arena =3D !!arena_reg;
> > > +     u32 reg =3D x->fixup >> 16;
> > > +     unsigned long addr;
> > > +
> > > +     /* Read here, if src_reg is dst_reg for load, we'll write 0 to =
it. */
> > > +     if (is_arena)
> > > +             addr =3D *(unsigned long *)((void *)regs + arena_reg);
> >=20
> > Is it necessary to also take offset into account when calculating addre=
ss?
> >=20
>=20
> Not sure what you mean? "arena_reg" is basically the offset of the
> register holding the arena address within pt_regs.

Arena access is translated as an instruction with three operands, e.g.:

  `movzx <dst>, byte ptr [<src> + r12 + <off>]`

As far as I understand the code, currently `addr` takes into account
`<src>` value, but not the `<off>` value.

[...]


