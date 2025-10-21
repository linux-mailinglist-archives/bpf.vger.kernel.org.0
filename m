Return-Path: <bpf+bounces-71620-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E77BF846C
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 21:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6EBCB356A1C
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 19:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4102921FF4D;
	Tue, 21 Oct 2025 19:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmL2+WkO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618A3350A04
	for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 19:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761075381; cv=none; b=ftrttVGZhzwz50NgrMbqPHhBaWjvJ335HmuEqWTuW+A1RzNo3lrhCWCuns65ybRe65fh+XxcYvM8CTFPyZuKzySY5CpOiuOxwUqwbX/wBly4ktRFlFDCpTpEAyq6V+pzF3sx0YfM2G6o6mpR9TE23/C8xueTEOTQcWuI6t7/IIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761075381; c=relaxed/simple;
	bh=a6C7xGSxxXI5TSXJrJJ8fjRBAdMfv0WuUvEOYXx17k4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fpWLmhVDOaEIwkXi4AZNvaH8wcnXCDK7iu/k48Aa8pMPtY8tUhJFOf/jE8Ah4McMymBC0bGr6Qlib33a+Rpl7VGZD9wKl/1xfng92d4a4lMvJPdiG66rOD5IomdqGDtOtbd/DQyH4ZH1Wrd3AsRo0287qzd6t2z9r58CW1PQRfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GmL2+WkO; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b608df6d2a0so5321493a12.1
        for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 12:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761075379; x=1761680179; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=za+gukgTkrJeN9HnlJpUcosef+r+/NavAeAxE8M9AEQ=;
        b=GmL2+WkOmxHma4Xz/Xg+NHJtjcAnNbF/qvKHPbPUaZHPN0TR7HWyZgHrII0iTk2636
         Axq1sy6x9mL/OJlHpRFPBf5Vd5MH/VjykrviempXkDuV9KMe99PYoZKZANOxiLUfWj0N
         9nc7aeFwqelH/FQdmMrvszcEHhZd67pJeGR+NKWYiVx30mUx6Op7xsxlo+LYZhUY1/G5
         z4X5W0zKnJJy9i+j7UqUYgFy0Z8DuJboV7mERcg37DzWFCnH6OPIZlUavOUegbDcxjjs
         +2PV4mfoJXnLyLYIS5/E3K+Ll8J3MJMZthMigXXJ+aYuHdpmCNh65XcRHcTVIsY2PgHf
         nfeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761075379; x=1761680179;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=za+gukgTkrJeN9HnlJpUcosef+r+/NavAeAxE8M9AEQ=;
        b=a5sYdT0OfTYHEdmtslt0T8yngds01KOAe+lbJ4Gr3dvA0DAirJZagki52FPyFyM90O
         bvU8G+LgYZvf67OsYBAHARPml4/b4wBqWaoNj01xwR39ZJlTcVS8okO4KZNGdBfI1psL
         YD3JmbbjbrVZs/mgmO/1xvbT7LDlTZWFTyv1nsXam+laM64yOs5KANd0ZPprjpeKKSLe
         SyipxpAs1WATAaLeF+4ACB+xu3ibeJuelLtLqJHSDEoK2ebPTMmcunWZLVb/SfAe940r
         I+piUa8IbIFWpTHnNzANtPM/By3Skcc84CkN/2+ySCn2J2YEeK2/39EnaYIzOJ75Q4Zn
         Ev0Q==
X-Gm-Message-State: AOJu0Yyd/+gTqiGdwUUshx2cvL2APg2dtlPMJld9swy9Y9KKsou1ST74
	c/+B2UVDQ4PpcdW03KRIiGo4G3HxQOCIJIqkL3hUbgbjWP1ML3d4i5t1
X-Gm-Gg: ASbGncup8L/ToSvy8vby7XJP1w1EbEKeOyJgx78Cv0XSF0pu+AXhhm103eHujiETamO
	bm42fdmD0oxpdDA3WE65/qldpV9GdGhyrtdwmmySZXZtMR1iuXigQDCuA6zL9dpSYpS/70M+cdh
	c4T1SfmpGseEUBkqr9Fas9Ma55I2aAQpuOcECYLOBo1GGFc+p7riR9QgV77w9cCdNmMC1gomEL4
	PjLGsG7FfFNVQyqakpMvAdCgVjcVlD2DDM6CNFaDoZ/OmWr7/V3muKNVC1bQ3kE03jQkghm0d0i
	2fTcDRfvOshJvIYOcdRaBW94i+Y9izzcNH6pxsTWF6xfu6Htbk9eKxJPJuSaMW9h/k2Jxzz4b2f
	Gn0vF9h+oAd5LwVgfXn7O9yfbfoS6mt/HAXBljp6ytrDEsCp6t6Cou+8J6sqXW40Fc50MduFZZx
	WR/OiPUemFLaH8ezVWbWmNPMAy
X-Google-Smtp-Source: AGHT+IFckvo4yGU2aaNI2ef3A+i1ObdpYL6ndWlUIwZHcinWgz9UAerufIu0guzhB2bi++eGnHhWPA==
X-Received: by 2002:a17:902:f687:b0:28e:7567:3c4b with SMTP id d9443c01a7336-290c9d1b922mr243149965ad.16.1761075379452;
        Tue, 21 Oct 2025 12:36:19 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:84fc:875:6946:cc56? ([2620:10d:c090:500::7:6bbb])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e2240e3c4sm334448a91.16.2025.10.21.12.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 12:36:19 -0700 (PDT)
Message-ID: <0c18d017a9faeef2dfdf970683b0fe7b9d63faa1.camel@gmail.com>
Subject: Re: [PATCH v6 bpf-next 12/17] bpf, docs: do not state that indirect
 jumps are not supported
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko	 <andrii@kernel.org>, Anton Protopopov <aspsk@isovalent.com>,
 Daniel Borkmann	 <daniel@iogearbox.net>, Quentin Monnet <qmo@kernel.org>,
 Yonghong Song	 <yonghong.song@linux.dev>
Date: Tue, 21 Oct 2025 12:36:17 -0700
In-Reply-To: <aPffwozAdFGGgyc3@mail.gmail.com>
References: <20251019202145.3944697-1-a.s.protopopov@gmail.com>
	 <20251019202145.3944697-13-a.s.protopopov@gmail.com>
	 <83225612f07f1d0f2f488efaee9c075b44e8cc03.camel@gmail.com>
	 <aPffwozAdFGGgyc3@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-10-21 at 19:32 +0000, Anton Protopopov wrote:
> On 25/10/21 12:15PM, Eduard Zingerman wrote:
> > On Sun, 2025-10-19 at 20:21 +0000, Anton Protopopov wrote:
> > > The linux-notes.rst states that indirect jump instruction "is not
> > > currently supported by the verifier". Remove this part as outdated.
> > >=20
> > > Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> > > ---
> > >  Documentation/bpf/linux-notes.rst | 8 --------
> > >  1 file changed, 8 deletions(-)
> > >=20
> > > diff --git a/Documentation/bpf/linux-notes.rst b/Documentation/bpf/li=
nux-notes.rst
> > > index 00d2693de025..64ac146a926f 100644
> > > --- a/Documentation/bpf/linux-notes.rst
> > > +++ b/Documentation/bpf/linux-notes.rst
> > > @@ -12,14 +12,6 @@ Byte swap instructions
> > > =20
> > >  ``BPF_FROM_LE`` and ``BPF_FROM_BE`` exist as aliases for ``BPF_TO_LE=
`` and ``BPF_TO_BE`` respectively.
> > > =20
> > > -Jump instructions
> > > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > -
> > > -``BPF_CALL | BPF_X | BPF_JMP`` (0x8d), where the helper function
> > > -integer would be read from a specified register, is not currently su=
pported
> > > -by the verifier.  Any programs with this instruction will fail to lo=
ad
> > > -until such support is added.
> > > -
> > >  Maps
> > >  =3D=3D=3D=3D
> > > =20
> >=20
> > Nit: bpf/standardization/instruction-set.rst needs an update,
> >      we don't have anything about `JA|X|JMP` in the "Jump instructions"
> >      section there.
>=20
> Ah yes, thanks.
>=20
> Also, there is a limitation listed in the llvm doc that -O0
> can't be used due to absence of indirect jumps. I wonder if
> there should be more limitations introduced since the doc
> was written. (I've tried, briefly, to compile selftests with -O0,
> but this fails for other reasons, and I didn't have time to dig
> into this.)

Lets fill this section as we go.
From the top of my head, I can't say what will or will not happen to
verifier if O0 is used. Things that don't happen at O0 include:
- SROA (variables are always on stack);
- constant propagation;
- inlining;
- loop unrolling.

In theory, none of that should confuse verifier in its current state.
But I'm sure there are special cases.

