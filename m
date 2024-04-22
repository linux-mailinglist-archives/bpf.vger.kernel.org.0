Return-Path: <bpf+bounces-27461-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A488AD49F
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 21:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45DB32814CD
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 19:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD66A15533F;
	Mon, 22 Apr 2024 19:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="NgS9WYjn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C168155338
	for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 19:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713812761; cv=none; b=rlWw+i35eyKJ/Cjo3OXTGejpQ3j5bnYNzTWAt+Ff4YCEErOap3+GzmrQBsBHvRoyrkgyFmhYEs+qRkYapmj6YXXiSAv+q8JoOX/Er2yf2sA4cWBF9wBYdF6zSEivEZzR9r1nvVQiz21LjNdWCWEJGPVoqdnwYAw7cAUxmj2RkbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713812761; c=relaxed/simple;
	bh=wsHaXBjTA7hCRyjHqUrFEB/n+csR/RFsdQXajUpDcwc=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=lrY8ugzF0MckID0AV1J9svQ1cpP1Oj/ag3NDaqyoCoH6RH3Sd5dvGjFjXLtd9CG11kQuTIpoxDr2hoblSJY0PwKpWZoI1bHhQE8NOL7YEmm8AIF62qVIEJ223Kly03+btt46P/x90qZ/EsCwlMYcmz2CSu1ry2tev1/6fYvKGQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=NgS9WYjn; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6edc61d0ff6so4783269b3a.2
        for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 12:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1713812759; x=1714417559; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=yNds/3XriKnoMzKRIOjk4mym3GCRF/+b+SL9UQdmBcA=;
        b=NgS9WYjny5+S/uD0/Vnxs2qWsdSwouSBIdWgL+vD6iUHxuUUA61MSNiTS5cMnLPsUh
         308D2VGjXSu/0KrnMvmJ/4RvLWnaj9gzNKZlhPYVcQFupPzVkt/YNrn/STE86DSjrzSF
         pBfb77aEhfSVeJxPtEAmbraOhG0yWu/yCPfJIHEHpysjP/UflSHZRNhOgiUcVZ56L32D
         Twhhd4wZA3QFOBxBrd361z/uTRF9yvMvH6nLDaM5imPXple6bAHFkdFH2LDy3M594aRG
         0Z0KiAPtPbdBhXJ0vUmVu4Sw8mxl663B8NrqCi3ndL90hNlQTB8jpICToX/VVEu3rDmt
         aCdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713812759; x=1714417559;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yNds/3XriKnoMzKRIOjk4mym3GCRF/+b+SL9UQdmBcA=;
        b=nKq5N0PcgmVjEr1J1xvW1MmPyyP6veCj7H+ko2rcJXeKcbjXkqZ5OucWnQkSXR2QMV
         Ty7cS+ys5Y75Ij3XPmPrGUjVOC5RltYQ54z9lZPDL6w3n1aOCe0l/QOemZQmy/Ev7SUw
         G7qaM+t3yxgvYiorwP821BDQrNpNkPlwp7vCeTijyzZbQ4e8o+OypAbMu+I2NgxiO1Q4
         Eu9EDgvXj9CPUzKyTIAqosQZubPcL+lc9iB6vol55igkLauW/1bGxtpDUEXWJ1UKd7eL
         fnO2Ajel+XieWSvRr8K5vbqk7KdSjLuew5H0SzuumVaEtdzO7Xz6fPIgCH2o4V1A0M/c
         BkKg==
X-Forwarded-Encrypted: i=1; AJvYcCVfFHksepWVyhaoik6uErtEK5KYXuIay/br30QGfWEuFaIgsw2fvtDWjKcokWpx0BuPBcgCMt4olCf9HA4GxDK023F/
X-Gm-Message-State: AOJu0YwIJIYL7lrhphDyjw2U8XJwDParMaZSCPBXD1TITrfV9vrLy4Lk
	8oSyRG68/1FZVfDngM+H0IazV2B2QC2qwqcTkVHDXC6fLcDyfZ6ulWZ3Y417
X-Google-Smtp-Source: AGHT+IF5UON05abLTAAbAQNK8RFOtuHoX93xAO4TpEBG0WikCVlleKBSDulNclfcv7ahwMKbU8NO6w==
X-Received: by 2002:a05:6a00:2181:b0:6e8:f66f:6b33 with SMTP id h1-20020a056a00218100b006e8f66f6b33mr13880081pfi.4.1713812759355;
        Mon, 22 Apr 2024 12:05:59 -0700 (PDT)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net. [67.170.74.237])
        by smtp.gmail.com with ESMTPSA id b1-20020aa78ec1000000b006ece7bb5636sm8152692pfr.134.2024.04.22.12.05.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2024 12:05:59 -0700 (PDT)
From: dthaler1968@googlemail.com
X-Google-Original-From: <dthaler1968@gmail.com>
To: "'Watson Ladd'" <watsonbladd@gmail.com>
Cc: <bpf@ietf.org>,
	<bpf@vger.kernel.org>
References: <093301da933d$0d478510$27d68f30$@gmail.com> <CACsn0ckPptm05-G6tXPaJJSvKmP3e-nCKPJJCdkmzZOYkQX-Tw@mail.gmail.com>
In-Reply-To: <CACsn0ckPptm05-G6tXPaJJSvKmP3e-nCKPJJCdkmzZOYkQX-Tw@mail.gmail.com>
Subject: RE: [Bpf] BPF ISA Security Considerations section
Date: Mon, 22 Apr 2024 12:05:57 -0700
Message-ID: <151e01da94e8$1c391f00$54ab5d00$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIuELsBo+B+UsoJNRbSlFOn1N3FrQGJMFTgsMFkZeA=
Content-Language: en-us

> -----Original Message-----
> From: Watson Ladd <watsonbladd@gmail.com>
> Sent: Monday, April 22, 2024 12:02 PM
> To: dthaler1968=3D40googlemail.com@dmarc.ietf.org
> Cc: bpf@ietf.org; bpf@vger.kernel.org
> Subject: Re: [Bpf] BPF ISA Security Considerations section
>=20
> On Sat, Apr 20, 2024 at 9:09=E2=80=AFAM
> <dthaler1968=3D40googlemail.com@dmarc.ietf.org> wrote:
> >
> > Per
> > =
https://authors.ietf.org/en/required-content#security-considerations,
> > the BPF ISA draft is required to have a Security Considerations
> > section before it can become an RFC.
> >
> > Below is strawman text that tries to strike a balance between
> > discussing security issues and solutions vs keeping details out of
> > scope that belong in other documents like the "verifier expectations
> > and building blocks for allowing safe execution of untrusted BPF
> > programs" document that is a separate item on the IETF WG charter.
> >
> > Proposed text:
> >
> > > Security Considerations
> > >
> > > BPF programs could use BPF instructions to do malicious things =
with
> > memory,
> > > CPU, networking, or other system resources. This is not
> > > fundamentally
> > different
> > > from any other type of software that may run on a device. =
Execution
> > environments
> > > should be carefully designed to only run BPF programs that are
> > > trusted or
> > verified,
> > > and sandboxing and privilege level separation are key strategies =
for
> > limiting
> > > security and abuse impact. For example, BPF verifiers are =
well-known
> > > and
> > widely
> > > deployed and are responsible for ensuring that BPF programs will
> > > terminate within a reasonable time, only interact with memory in
> > > safe ways, and
> > adhere to
> > > platform-specified API contracts. The details are out of scope of
> > > this
> > document
> > > (but see [LINUX] and [PREVAIL]), but this level of verification =
can
> > > often
> > provide a
> > > stronger level of security assurance than for other software and
> > > operating
> > system
> > > code.
>=20
> I would put a reference to the other deliverable to say more. If we =
think that's
> suboptimal for publication strategy, maybe we can be more generic =
about it.

There's nothing that can be referenced yet.  One can only say it's left =
for future work,
would you prefer that?

> Often BPF programs are executed on the other side of a reliability =
boundary, e.g. if
> you execute a BPF filter saying drop all on your network card, have =
fun. This isn't
> different from firewalls and the like, but it's a new risk that people =
aren't expecting. I
> think we might also need to call out that BPF security assurance =
requires careful
> design and thought about what is exposed via BPF.
>=20
> Sincerely,
> Watson

Do you have proposed text?

Dave


