Return-Path: <bpf+bounces-27465-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BD68AD4F0
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 21:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 105D0281044
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 19:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4929155335;
	Mon, 22 Apr 2024 19:34:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB2D155330
	for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 19:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713814497; cv=none; b=scXTPun0xKWdOyn7M/ZBg+ZcY0DaBOvEkdhdYBNjBdqRHLpquEcz3voIpiGbXktqqGdH9dswP+ErrroZaklEWyEtJykPrv2YE7tiUvywDMUVIwoyai5dys+tuzGMscmJAehUBG2nwbC638rZeuI6gtPKSDCmoBkiCGxlGNQmMEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713814497; c=relaxed/simple;
	bh=v5BAP9rbAw+amr9xfr2NJYpuPfICex9WdnU5tsOWCgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qXq3h2c6Rffy/AI8c8V65rf5EFoaqPCL18ruDP21RsVnIXq8iDRovE72KjxO2NUR7bns+dXWGJsSpqTxJjwVyE9JAhfa3Ulrqqgjgh6ZTd8+dga4jphnwDFcoWDnjTh8GbsdYGWhZe4OXh605p6gQmPgYNPBjDLLYjOORKr59EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-61b4387ae4fso29771017b3.2
        for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 12:34:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713814495; x=1714419295;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NbOKLfN5QYpXJM53/nPTnezyWSyQwoe2Kg9efpf80jo=;
        b=rAo9qYAFgK1Ccug6VrqrYXxOIjYoVEsWrfAQU3w5AMitpzLUF9USMo/QHo74QMeLRY
         WBw2vQXUj69L4T+3CrKPu0N8djl5HII0M0n5x4r9JrKhHsF8fWTxwuAxyFVHZUadqlgd
         WuexOKRR9FvrqYsBHeqHqnruEV/faMw3m5a63RMhGIg+BFcEnBvu1cfPlk+QsnwyfeFL
         bdvBU181Mpdu3tMTLR9cpaZKdMy0AxGqtmUA8sdx2+hEJqr1met5VdzRtaDCOnVkols7
         0LbOedVPzjKXF5AoXBeKN7DRD5N2jwCeTkv1HdUJ1nVDjLWwpF6sQYwFf274OI8S1Ccp
         LMig==
X-Forwarded-Encrypted: i=1; AJvYcCWWbajWW3B95Iglbqw5fwilIUQPyU4r4cEggg+I+Dle717mta7sdqCmPmh+GWg6fuNoJ38CH0mRMZ1jxCaJaVPHQOb4
X-Gm-Message-State: AOJu0Yw4cqa7FhRNVJFiJJL9wL/ADvtL7uwzaJ4fy54icmpWsRVyJdre
	wdAW3s/jBOIlshJ3gInGfmuFLFLdaApgLjgB1fqk69CxlIVk0aKnhktZZg==
X-Google-Smtp-Source: AGHT+IG+wF7Lihy+nnQP4p8zP8L/i7OCHgDji0NYqH96PKVOn+7FdRfZtOG0Y8eTSlPWLgVWphqlFQ==
X-Received: by 2002:a05:690c:3388:b0:61a:c316:9953 with SMTP id fl8-20020a05690c338800b0061ac3169953mr12635735ywb.11.1713814494599;
        Mon, 22 Apr 2024 12:34:54 -0700 (PDT)
Received: from maniforge (c-76-136-75-40.hsd1.il.comcast.net. [76.136.75.40])
        by smtp.gmail.com with ESMTPSA id n9-20020a81af09000000b0061abdf061ccsm2100878ywh.133.2024.04.22.12.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 12:34:53 -0700 (PDT)
Date: Mon, 22 Apr 2024 14:34:51 -0500
From: David Vernet <void@manifault.com>
To: dthaler1968@googlemail.com
Cc: bpf@ietf.org, bpf@vger.kernel.org
Subject: Re: BPF ISA Security Considerations section
Message-ID: <20240422193451.GA18561@maniforge>
References: <093301da933d$0d478510$27d68f30$@gmail.com>
 <20240421165134.GA9215@maniforge>
 <109c01da9410$331ae880$9950b980$@gmail.com>
 <149401da94e4$2da0acd0$88e20670$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EFurulJL9vovypnS"
Content-Disposition: inline
In-Reply-To: <149401da94e4$2da0acd0$88e20670$@gmail.com>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--EFurulJL9vovypnS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 11:37:48AM -0700, dthaler1968@googlemail.com wrote:
> David Vernet <void@manifault.com> wrote:
> > > Thanks for writing this up. Overall it looks great, just had one
> > > comment
> > below.
> > >
> > > > > Security Considerations
> > > > >
> > > > > BPF programs could use BPF instructions to do malicious things
> > > > > with memory, CPU, networking, or other system resources. This is
> > > > > not fundamentally different  from any other type of software that
> > > > > may run on a device. Execution environments should be carefully
> > > > > designed to only run BPF programs that are trusted or verified,
> > > > > and sandboxing and privilege level separation are key strategies
> > > > > for limiting security and abuse impact. For example, BPF verifiers
> > > > > are well-known and widely deployed and are responsible for
> > > > > ensuring that BPF programs will terminate within a reasonable
> > > > > time, only interact with memory in safe ways, and adhere to
> > > > > platform-specified API contracts. The details are out of scope of
> > > > > this document (but see [LINUX] and [PREVAIL]), but this level of
> > > > > verification can often provide a stronger level of security
> > > > > assurance than for other software and operating system code.
> > > > >
> > > > > Executing programs using the BPF instruction set also requires
> > > > > either an interpreter or a JIT compiler to translate them to
> > > > > hardware processor native instructions. In general, interpreters
> > > > > are considered a source of insecurity (e.g., gadgets susceptible
> > > > > to side-channel attacks due to speculative execution) and are not
> > > > > recommended.
> > >
> > > Do we need to say that it's not recommended to use JIT engines?
> > > Given that this is explaining how BPF programs are executed, to me
> > > it reads a bit as saying, "It's not recommended to use BPF." Is it
> > > not sufficient to just explain the risks?
> >=20
> > It says it's not recommended to use interpreters.  I couldn't tell
> > if your comment was a typo, did you mean interpreters or JIT
> > engines?  It should read as saying it's recommended to use a JIT
> > engine rather than an interpreter.

Sorry, yes, I meant to say interpreters. What I really meant though is
that discussing the safety of JIT engines vs. interpreters seems a bit
out of scope for this Security Considerations section. It's not as
though JIT is a foolproof method in and of itself.

> > Do you have a suggested alternate wording?

How about this:

Executing programs using the BPF instruction set also requires either an
interpreter or a JIT compiler to translate them to hardware processor
native instructions. In general, interpreters and JIT engines can be a
source of insecurity (e.g., gadgets susceptible to side-channel attacks
due to speculative execution, or W^X mappings), and should be audited
carefully for vulnerabilities.

> How about:
>=20
> OLD: In general, interpreters are considered a
> OLD: source of insecurity (e.g., gadgets susceptible to side-channel atta=
cks
> due to speculative execution)
> OLD: and are not recommended.
>=20
> NEW: In general, interpreters are considered a
> NEW: source of insecurity (e.g., gadgets susceptible to side-channel atta=
cks
> due to speculative execution)
> NEW: so use of a JIT compiler is recommended instead.

This is fine too. My only worry is that there have also been plenty of
vulnerabilities exploited against JIT engines as well, so it might be
more prudent to just warn the reader of the risks of interpreters/JITs
in general as opposed to prescribing one over the other.

What do you think?

Thanks,
David

--EFurulJL9vovypnS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZia72wAKCRBZ5LhpZcTz
ZMNYAQDqUhazqTs4NoPBBhB+k/DZXQVbbPh7pi5Xp0914o88vwEAg9Fxn6QJKjdb
sWb/qZeDOREqZJlU6TZvUwI/SqSR9QQ=
=1TQx
-----END PGP SIGNATURE-----

--EFurulJL9vovypnS--

