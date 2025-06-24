Return-Path: <bpf+bounces-61453-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F8AAE7210
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 00:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E122A7A333E
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 22:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7A525A624;
	Tue, 24 Jun 2025 22:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSyQLaSr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D2F307483
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 22:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750802835; cv=none; b=ZIRpeBJT0A+0BgNZOS47zWCmmT0wnsOmBAknigNI1V6GJUlgJlvLMHihFlXbjJ18ckHSRVcH9STotU4U6TUc6AuDnI7ZXOSDspg/vMmGtmSZlIuBNxw1I/kyzzejx3bfaYrVpsAPrlMFkprS/TA0X20M3eRE2c6PI/f8ERY67fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750802835; c=relaxed/simple;
	bh=JyRIxXpGKrQoVZFa7L3MzxyIw5x1GX7XHf0ZHyNS2Lc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lwUkPyQaOncH5li8UBbH4kEr9xtecFmC3op6xwOrgqol6rptdu3l4WfU/lYDv4MRyJfT+douCqwyn0J+UofoVYhRXfLMWk7WqMohRwinKFMk9fPSb4SfM49tpEaUxiGIczCSSwYvQClW1dUfP5rjDBZTQxpCSoimdqJRqmi6lE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WSyQLaSr; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-747fc77bb2aso4559548b3a.3
        for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 15:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750802833; x=1751407633; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yetRafmNsPbsJXCOaSs+LmghSUEvFykf6/3syoGxU5U=;
        b=WSyQLaSrNds1FWvKazJs64uY4XBo7kbQ4qutbGUxZ0M3bKLzvHandT0moyrDrfxkyg
         LwbZ3eOb/0LsWnCTN4ZniCxBTntnY9FzixyWzgmNTBKKWVp4skCgaM0jB3B1Ww/6JtY7
         swUZVUJd8hjpzsQRkbimKVY4It9cHznY/Z/HOlfN5HwqEuTj45kOPTozS4bleIjSJcvn
         mN+dUbBDa0D58mLepYh7SHATJeRYsN9lT5wkb7tikDQuUlqUXt3mguxHhg50qr31KRgu
         cUw/xLUaJf3QIx/gQgqKJY9Y0Wvvj6Es7A00boaRwQ8GCmhJ6mWgcwshZp96raNU9+Gs
         tapQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750802833; x=1751407633;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yetRafmNsPbsJXCOaSs+LmghSUEvFykf6/3syoGxU5U=;
        b=kXVXsemEnDgqvNGtnevMpQBrnKkZnTG5+BmgQCkZEGCiE75SFaBI9h+5NQjZU8ujQw
         YDAN0ZzmF18tGozc0gPsZ5PdJPGZ9Iwn/c3SbuP9X6UTT40G931uHChmI9fRPnd6GqTx
         kGnePCTAdsWr+zzqtU5vSqEggCf4oNobB+zf44blzOANw4tKWXAd/8M76EV1yOzG52hQ
         maBL6h4sPJEpuJX2EnAtyV1vRSiYqfly2/PsXYedZo89SvCS3mL7se5bNf4ctn64V6HV
         5lAbWjWfqk9s+Ah2oNSBbwBR1xMIoRuS+yCEurJezJdbEH/g1nwv+8jdT/UvUVv/vDpX
         M/9Q==
X-Gm-Message-State: AOJu0YzQnw8YIScLi86vfEeBt3jrgiJFD3fKBROIUyHJ9qSTNUpLVfcs
	JoO/2MTJpGjaEshIeWnbn3NN1oCPJJMFVf1kWX/F3mqTLDb4qNykWUnl
X-Gm-Gg: ASbGnctxRAfrQqNUfIrVm0157BNBUCWrWj2rv+2fzsBtqILkpd32kIMQabPQ8WAhwLJ
	zp/H428KhDVItVA2UpGotUvgp5DVI6UyNK+nz2KUWv0/loH7e9hHsEfhGsTHmd6ms1guxniJiQ3
	wVIEiXKiOvEnaRwCrExokRRr6IOG1KqEpWadUtLhdj5+74izSlz5RSQTwLbbgYQA2DqkRBs4pdU
	g5Rmi9t+j2dXBrQyWAIoIMUspqzKfyiawWVe8qy4xrne9nCKG+rYTck9q3GA2HGosbsUo/6S8Ep
	sl1rXlEcarRKsQ6Nu65+VxyeFGw+pfPhALoa9wT2pHAyOkxehVm1Kr0bZ9q5/fvjQniT73+3Jbu
	ZH02I00Imtw==
X-Google-Smtp-Source: AGHT+IEtVitaQD98MwoZO35lnX0vpcUJEOtGhD2U7aa/SDSpml519wauCnjQiYSFZ4cMTffzyjIAig==
X-Received: by 2002:a05:6a00:2e99:b0:740:6f69:dce9 with SMTP id d2e1a72fcca58-74ad42bd7efmr1060727b3a.0.1750802833081;
        Tue, 24 Jun 2025 15:07:13 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:9b77:d425:d62:b7ce? ([2620:10d:c090:500::6:f262])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-749c8872203sm2597616b3a.157.2025.06.24.15.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 15:07:12 -0700 (PDT)
Message-ID: <9eb94c7757593de354faec9f0d228023f4428307.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 2/4] bpf: add bpf_features enum
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau	 <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>,
 Yonghong Song	 <yonghong.song@linux.dev>
Date: Tue, 24 Jun 2025 15:07:11 -0700
In-Reply-To: <CAADnVQK=ML6A7OwQ4aQSgiRku83tgkKiNdAnKMYq=iDNe-7dRA@mail.gmail.com>
References: <20250624191009.902874-1-eddyz87@gmail.com>
	 <20250624191009.902874-3-eddyz87@gmail.com>
	 <CAADnVQK=ML6A7OwQ4aQSgiRku83tgkKiNdAnKMYq=iDNe-7dRA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-06-24 at 14:59 -0700, Alexei Starovoitov wrote:

[...]

> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 8fd65eb74051..01050d1f7389 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -44,6 +44,11 @@ static const struct bpf_verifier_ops * const bpf_ver=
ifier_ops[] =3D {
> >  #undef BPF_LINK_TYPE
> >  };
> >=20
> > +enum bpf_features {
> > +       BPF_FEAT_RDONLY_CAST_TO_VOID =3D 0,
> > +       BPF_FEAT_TOTAL,
>=20
> I don't see the value of 'total', but not strongly against it.
> But pls be consistent with __MAX_BPF_CMD, __MAX_BPF_MAP_TYPE, ...
> Say, __MAX_BPF_FEAT ?
>=20
>=20
> Also it's better to introduce this enum in some earlier patch,
> and then always add BTF_FEAT_... to this enum
> in the same patch that adds the feature to make
> sure backports won't screw it up.
> Another rule should be to always assign a number to it.
>=20
> At the end with random backports the __MAX_BPF_FEAT
> won't be accurate, but whatever.

Ack. Andrii asked to add MAX for people willing to do broken kind of
feature detection and just in case.

