Return-Path: <bpf+bounces-60528-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4BCAD7D5A
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 23:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E89E33A3E78
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 21:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571762D0292;
	Thu, 12 Jun 2025 21:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMEy7ppW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89230156C69
	for <bpf@vger.kernel.org>; Thu, 12 Jun 2025 21:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749763418; cv=none; b=CAWOeSaGRqDeJ7Ds6PmpFHa9bhPyH62/4H26ewam5Wneaa6I1J/Ib1mZJM/cUqzqVN/020muxbiPZettRmmvjTTREGieB6Y/dFN8Xv407Y0U/HMZsFSGApf6Xq5ybGoqhHCcndS07J+Dk4XBwW3PHJpmi3gCwEtHg+US/HpycAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749763418; c=relaxed/simple;
	bh=217JICQbQnHy8e5BCa1F4Cnciy8+hKsOyYf4wFnfZEE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GW5cIqGaaI26R+M5EvJ8gMa5PmVeNO3Y7JUIxBo3UzoxLJ78KrSaBDpXL3xhNJb9IzkoHUDP8U+rinwBSxE8X5wuuP2y+jiJLXV6+M1fBkflfaCKK31CAPn9ieYLNJwynZgX5WqdRKj0NiZvyeT1ODad+1veYyXMGg5s8OoHrpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NMEy7ppW; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-747fba9f962so1308658b3a.0
        for <bpf@vger.kernel.org>; Thu, 12 Jun 2025 14:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749763417; x=1750368217; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=217JICQbQnHy8e5BCa1F4Cnciy8+hKsOyYf4wFnfZEE=;
        b=NMEy7ppWXdrFOZBWOFigJ30xUvcs8YanajQSviU2Sp52PrAioqxF9l3qMICk3gT0+z
         GxoQyWM41q0o2Y9er8JHzRQPfhnTk59RtrXJ5VdJjjUVLp5d2vztJj2IpJ2+MfbM1MxH
         jp/n6aeKPJnvcsMToRIEkFZFifDGri1hmV1fXRzGmzdhRMRzdUAZCGnGBikOFxvKF+AZ
         JTNkJPB8Y/Fq3UsuccPXhpQFFv3yQsUCeXBtLjiFXxZwf78hKBA6J159AFW5DO+fiJ5z
         S3sGwvqCPEUMlDtK/N1Yc4r111o+lJqzwN32lILLaeZ3YuSTcEDSJEqKgwMRYDjVeZLw
         5KkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749763417; x=1750368217;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=217JICQbQnHy8e5BCa1F4Cnciy8+hKsOyYf4wFnfZEE=;
        b=tjm5jmq3XxkaV50k7UDkLHLceDkg+LKht7fSJ7x/OwSxnoisy6I9XBQPjDPCgMxWEd
         LjT/kKT5bBPOS1ZOctcxHWPUK5l47HBIcONoqFyCguXD1x1xcFoZ4gktEyyClT8p40oj
         XLy/dImEvkQXCmOqAS/eDmPtLN1b7bcqRL8Rk2KgvkgsOj/46QCWVw/jwc4JKaIWAvp9
         /ROtOKeU6FP2B+mYW/ZqV3Uxd2IeHwMysQUIOi/d4pH/mjCGGyyVDPheUhetyOv03Dus
         pOvGRRBOS/otYbBuquOeZdaBbBdCDTxuafyEGLSBCdQYiBvArfqdMvUIB04Z5YFkI2DR
         zWlA==
X-Forwarded-Encrypted: i=1; AJvYcCWx6unQRc3KANW/szvZ1Wzk48JsrqnalAv9FUmc9pCXoZwwwma4qnfmHUxqVgBvsNJb9yQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTt2i+XE8WKE6iFxolGTJ+ryHB8nu4BqR48JU++vIQ6AkHRHp8
	uNcviuIbvpE+D6SHo3id5hFDQPJ5NAn5TdTt2fMYR+5zxhefpPk3XsRS
X-Gm-Gg: ASbGncuRMD3QOtw/C842XXYCH4/3gSJAqHpwrixHhZppqTB4dfyrituZvyD3emkxPc6
	+Zwni7NGHUK9HrPGTVrsxdv84DYNELYdsfKwuZunGerWTWB7Bpah0D8eA2U5v3v1sWvTOpbGHGS
	EwE08xTWepUumlwdkDIwmwT279sHBfS2uxi8F4hNTOI3tjdDC/sZx4sSqT7Cxt2OI2XNVzDLnYR
	0n/mm4Q+xbLQfB1ZzbtxTCfWII81b5rOdI35CblAcjOTcfjBIJpAL4a3CkPHunAljB5DmZxmvvv
	aS+12ySSGZOOFhEYCo+PJHcweWdZBrmSp/VVB2XX7xxSFVkK7tPtRbawRk0=
X-Google-Smtp-Source: AGHT+IEXTsiXWXp1y4o5V0lEHBizqEd0AEHvGgeybZAaaPeo+m8z9GZyyS/0/pEa4xwDnJm8Wfa27A==
X-Received: by 2002:a05:6a00:858f:b0:746:1c67:f6cb with SMTP id d2e1a72fcca58-748918c7fcamr105170b3a.5.1749763416705;
        Thu, 12 Jun 2025 14:23:36 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748900b2d8asm203835b3a.132.2025.06.12.14.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 14:23:36 -0700 (PDT)
Message-ID: <61fbe598be5a9f1892cae289ad2a45187cf64485.camel@gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix some incorrect inline asm
 codes
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, "Jose E. Marchesi"
	 <jose.marchesi@oracle.com>, bpf <bpf@vger.kernel.org>, Alexei Starovoitov
	 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
	 <daniel@iogearbox.net>, Kernel Team <kernel-team@fb.com>, Martin KaFai Lau
	 <martin.lau@kernel.org>
Date: Thu, 12 Jun 2025 14:23:34 -0700
In-Reply-To: <CAADnVQKrrEFcUdUvagwSkrCLJSoud4Jv0=CM2rX7p5MYKYOC=Q@mail.gmail.com>
References: <20250612171938.2373564-1-yonghong.song@linux.dev>
	 <5341c8c05537d6f9a4d252f5c98ec895ade09430.camel@gmail.com>
	 <CAADnVQKNBps+MvPmHG3BGYtNV34ut6L8cF+wCNWCOLTiauuL0g@mail.gmail.com>
	 <cbc60943-783e-4444-9d46-3a25e71a6e63@linux.dev>
	 <b35717b7c65a0ee8baba9800dbbb2c9e58c62b32.camel@gmail.com>
	 <CAADnVQKrrEFcUdUvagwSkrCLJSoud4Jv0=CM2rX7p5MYKYOC=Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-06-12 at 14:15 -0700, Alexei Starovoitov wrote:
> On Thu, Jun 12, 2025 at 12:49=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.=
com> wrote:
> >=20
> > On Thu, 2025-06-12 at 12:29 -0700, Yonghong Song wrote:
> >=20
> > [...]
> >=20
> > > > Warning in llvm/gcc on imm32 > UINT_MAX is not correct either.
> > > > llvm should probably accept 0xffffFFFFdeadbeef as imm32.
> > >=20
> > > In llvm, the value is represented as an int64, we probably
> > > can just check the upper 32bit must be 0 or 0xffffFFFF.
> > > Otherwise, the value is out of range.
> >=20
> > I agree with Yonghong, supporting things like 0xffffFFFFdeadbeef and
> > rejecting things like 0x8000FFFFdeadbeef would require changes to the
> > assembly parser to behave differently for literals of length 8 (signe
> > extend them) and >8 (zero extend them), which might be surprising in
> > some other ways.
>=20
> Ok. So what's the summary?
> No selftest changes needed and we add a check to llvm
> to warn when upper 32 bits !=3D0 and !=3D 0xffffFFFF ?

I'd say yes.

