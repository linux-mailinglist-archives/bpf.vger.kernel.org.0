Return-Path: <bpf+bounces-61460-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30DB5AE727F
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 00:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1072E1BC53FE
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 22:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627FE25B1F6;
	Tue, 24 Jun 2025 22:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nfCyCxiW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBE6259C98
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 22:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750805481; cv=none; b=ICYdaVbx4KjRIvBEhE5NGq7apSuWst/5HQVugBEcEt33AA2AxvT+1ee/SLoPuFH4J2GvvHy0JmF0BbJ8R1TjhUpYSusfDQsNfbcb/VtuIaUujI0lPtKy4cLuxq3mXFg1E0mBggM0BykBSodRpHKRNgz/IK14uNHAckNWSrEFFVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750805481; c=relaxed/simple;
	bh=86ysEQzPzYMfVehk70QiMjIAm22TpTWDiKnwk76MLIo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JfjvAQAxN2VzODSqxJL9UR4eBSnaoPEZoAIVJLUVuKZhm4XpMMJjsp/1wVH/uOIlG6kFLqSR59b0VRO+NJ5OLK4gnT+ZS1A/a4PTsamVkGw9n/vjEUbBMfvfn8og1o7ZHCbmOJRQTFunsRGfJ3+THGUaE1hNyKtt1WqS6kjbVMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nfCyCxiW; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7390d21bb1cso631737b3a.2
        for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 15:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750805480; x=1751410280; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=azpQSizrAKxkEl7z9bAw3rDnUJBczToElGEbUnvh6BQ=;
        b=nfCyCxiW8JzQ36R3X4ZDVvkpla8stX5TRf2ykxmUxtC5mj2C+qscQTeb6jtjoLHCqu
         5IwfMzzChJS7ENIgZDlNuua2hNTon1779fYEsNe535woqoSx7toQfbj/6cnFNR2y1kmE
         OUmweEV6JSUhibdKcun7U2gzi9cxJ/9IDPksi3w4584MbivvxxQymS4svZ0a5zFRJfIH
         DTTbRjDSq304Z80GkdJPEuAY/7frCIbLDEGSH1kwQ5lDGEhUZVTqiBLLZm32a9Yuu0wU
         +ZocpiNrEO7nu4ePGOx5N+P+IRLJ51m25DK0d55PROIcCtp8foQ0zIyj1swFSlzuQAUV
         hbSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750805480; x=1751410280;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=azpQSizrAKxkEl7z9bAw3rDnUJBczToElGEbUnvh6BQ=;
        b=dyU0FYnG/a8bQkAt3eaSeLtKuPySM0gGoaoUNkxW2OLpnqipLpujEWI/zH45SZkubn
         vG0jod7+ch1rcuDiSXsY9z1JiU0rImQrLAXWzdELCIzYa1Qu8cqLiksQjTsANYYwKGlG
         6RnxO+OIo0GCWbVq1ML2ThgkC6d+4ceXSjAEloSxdJYOnTYaDldUI05uC2ORjesCQkLl
         AngRFIkwhySP0SUjLagRn65sY/mF2vDLuAh5HghYdN/X7piW3KoKCKJvtr5VR/Zv9zrg
         GPnC29ZvM6wzSfpKjmWdvLna9t/WMhtBk1si7rsmbON5pDaVyiWrNx6GGCOyq31cnPvv
         IY8g==
X-Forwarded-Encrypted: i=1; AJvYcCVPKJZaqhdfR7uVb1w3u3oGk9WLtKD1js5KdlPNmll8Qo5cKk2u+VjODUOgudxtCFBvj6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgBoAtv3rFO++Dl2K9tWdsh7tzjas0pCv3SHzFiqrnBXbrQyk9
	f35KiDYVkkxEhIZ7Sc1Ug+fss8gRLYiPqWcMmDLjhOkJxPgcLOTRzOb8
X-Gm-Gg: ASbGncv89oMxL5Z5bEBlik5PRun2E4P49Pb60fpM3ddUeftu8FDxmLo/kM9wuWSfGM5
	nvr1uDLy79Y36uisIj3NumINuOrA4wDOq14jJZg9afO/Z1Nr0gr+tXQJj3cm2RIo2myrJdSBQkD
	TMEsqVQuCa3mUqx46+PAOKoLB7lQnzyjzgYQlAL2Ti5m8LC1LYmt2C71j07Dz1FpwrMJu1PXxiy
	9vRrCt4NfdY8pGTq4Mfu9Y6fcTjyH5vVsoN1z5xh5vTgE639+uA0r1au07W1K0rwTBChzmRCnF/
	HKeAOjqM/WlaMTCzikToVWeqquNrlyBixLyVFCnZE7Rn2qlxzUt60Kxgzz5iK3t6coQAyp5BnFf
	gfBT6+E0nfg==
X-Google-Smtp-Source: AGHT+IHjvnP5xPlcbswT4n3Z5LKp+U5wHK3PDdOQSVUH3PDNVFK7qqqoHsC3dCcH3FhVy9WxxrOy9w==
X-Received: by 2002:a05:6a00:3d0f:b0:748:f41d:69d2 with SMTP id d2e1a72fcca58-74ad43d7ed2mr1306814b3a.4.1750805479784;
        Tue, 24 Jun 2025 15:51:19 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:9b77:d425:d62:b7ce? ([2620:10d:c090:500::6:f262])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-749c88530d8sm2718424b3a.120.2025.06.24.15.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 15:51:19 -0700 (PDT)
Message-ID: <ff1f998703f75627e1fe939cdc45cf921387c1a7.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/2] selftests/bpf: Add tests for BPF_NEG
 range tracking logic
From: Eduard Zingerman <eddyz87@gmail.com>
To: Song Liu <songliubraving@meta.com>
Cc: Song Liu <song@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
  Kernel Team <kernel-team@meta.com>, "andrii@kernel.org"
 <andrii@kernel.org>, "ast@kernel.org"	 <ast@kernel.org>,
 "daniel@iogearbox.net" <daniel@iogearbox.net>,  "martin.lau@linux.dev"	
 <martin.lau@linux.dev>
Date: Tue, 24 Jun 2025 15:51:17 -0700
In-Reply-To: <323C8849-FE4F-47A7-ACF1-D30FC066111F@meta.com>
References: <20250624220038.656646-1-song@kernel.org>
	 <20250624220038.656646-3-song@kernel.org>
	 <9c18fcc83b4fa0c5685519bfb80f102436bcd675.camel@gmail.com>
	 <323C8849-FE4F-47A7-ACF1-D30FC066111F@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-06-24 at 22:49 +0000, Song Liu wrote:
>=20
> > On Jun 24, 2025, at 3:18=E2=80=AFPM, Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
> >=20
> > On Tue, 2025-06-24 at 15:00 -0700, Song Liu wrote:
> >=20
> > [...]
> >=20
> > > +SEC("lsm.s/socket_connect")
> > > +__success __log_level(2)
> > > +__msg("0: (b7) r0 =3D 1")
> > > +__msg("1: (84) w0 =3D -w0")
> >=20
> > Sorry, my previous comment probably was ambiguous.
> > What I meant is that you can match verifier output for "w0 =3D -w0 ; R0=
=3D-1",
> > thus checking that inferred value for "w0".
>=20
> Ah, I removed that part because I found some other __msg doesn=E2=80=99t =
have
> the whole line. Let me add it back.=20

Note: if you need to shorten the matched line you can use regexs
      inside __msg strings: __msg("... {{regex-here}} ...")

> Thanks,
> Song
>=20
> >=20
> > > +__msg("mark_precise: frame0: last_idx 2 first_idx 0 subseq_idx -1")
> > > +__msg("mark_precise: frame0: regs=3Dr0 stack=3D before 1: (84) w0 =
=3D -w0")
> > > +__msg("mark_precise: frame0: regs=3Dr0 stack=3D before 0: (b7) r0 =
=3D 1")
> > > +__naked int bpf_neg_2(void)
> > > +{
> > > + /*
> > > + * lsm.s/socket_connect requires a return value within [-4095, 0].
> > > + * Returning -1 is allowed
> > > + */
> > > + asm volatile (
> > > + "r0 =3D 1;"
> > > + "w0 =3D -w0;"
> > > + "exit;"
> > > + ::: __clobber_all);
> > > +}
> >=20
> > [...]

