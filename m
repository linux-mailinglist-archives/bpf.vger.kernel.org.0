Return-Path: <bpf+bounces-27466-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D79F78AD4F1
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 21:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 076D01C20CA0
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 19:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE0915533D;
	Mon, 22 Apr 2024 19:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="AZN6mXOa";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="AZN6mXOa"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEC6155330
	for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 19:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713814500; cv=none; b=asJNTgzbV8DYSaUfwUBYslX8YbHI/AfIPjyOvdaFVrWM4RKwU7Fp46j71fPlN5VppXKITYpzBzfKNM/l6z2hsmb0h0RVdmA0Rx8DUkKgeUyeqguosrrf8JGIjjsxA2ucWP7LPsHubiSB9MnptR2Oot38gGXbn1g7JHpWKhHQE7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713814500; c=relaxed/simple;
	bh=shwFQ2UnwZk4mTpgU2xpeFHpKPesI4gUYBqepv7XABY=;
	h=Date:From:To:Cc:Message-ID:References:MIME-Version:In-Reply-To:
	 Subject:Content-Type; b=Xx0EQZEglKTAm3tUdNS4D7GMCdKkpdkskcrRdY9fmGCq+/1zrkdXfILfgUTVvNCzXzmKlSzZmg6BBdTHCc4xaKD/ZdR/44/uXlsFnJbuzAX7Zm38FTQqO7yWoXsyAyLdPr+0LE7RsLmWbyLxLsMmhJeZIPqnPc0w4m5cyvLx+gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=AZN6mXOa; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=AZN6mXOa; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id D0299C1CAF53
	for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 12:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1713814497; bh=shwFQ2UnwZk4mTpgU2xpeFHpKPesI4gUYBqepv7XABY=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=AZN6mXOaNE/ZqIQLmCMo9N6/Zh24XSEziHHwNKE2Erd/r7+kYwkuPVFuOulJI/vQa
	 pquqoVkPmvd2Tf4HD1Z3P77QokyLTAmNfK2sJSuDidw+3xQrAq0lQ0SRYLOS6jh9fd
	 7Wg7NNwaGCVKL/CGXNgDwSwBHr6i6TO924cbxvMo=
X-Mailbox-Line: From bpf-bounces@ietf.org  Mon Apr 22 12:34:57 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 7FF5FC18DBB7;
	Mon, 22 Apr 2024 12:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1713814497; bh=shwFQ2UnwZk4mTpgU2xpeFHpKPesI4gUYBqepv7XABY=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=AZN6mXOaNE/ZqIQLmCMo9N6/Zh24XSEziHHwNKE2Erd/r7+kYwkuPVFuOulJI/vQa
	 pquqoVkPmvd2Tf4HD1Z3P77QokyLTAmNfK2sJSuDidw+3xQrAq0lQ0SRYLOS6jh9fd
	 7Wg7NNwaGCVKL/CGXNgDwSwBHr6i6TO924cbxvMo=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 3E87EC18DBB7
 for <bpf@ietfa.amsl.com>; Mon, 22 Apr 2024 12:34:56 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.65
X-Spam-Level: 
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E7uFVq45bkOh for <bpf@ietfa.amsl.com>;
 Mon, 22 Apr 2024 12:34:55 -0700 (PDT)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com
 [209.85.128.182])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 90C67C180B4E
 for <bpf@ietf.org>; Mon, 22 Apr 2024 12:34:55 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id
 00721157ae682-618874234c9so52553987b3.0
 for <bpf@ietf.org>; Mon, 22 Apr 2024 12:34:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713814495; x=1714419295;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NbOKLfN5QYpXJM53/nPTnezyWSyQwoe2Kg9efpf80jo=;
 b=crIG28I9ydx8jmltaHqy3LmxCLYemyMcC+PmO0ARzoP47WOsFWEig98DXcSaH+Q9TP
 LFqSsKsyif6zXNRSP6lZm3Oq3wdS4z1OszgpIMJ1QvRIM1+mkaE60s9L0QBNuxJXswXm
 icK6S2hdZmlIu7o0iOh7QP/iWxdxb33yxY1KTzdbA5MtX7dDj07GxkkIDCOmYkjSD3/+
 eKDAqOgXFysqtHfO6zFltBOXFsYaACJBl5fQC+URwVdOjxVVZKR4vkx6C9SvoFaD3i1z
 acWpaHyaJ/dB8WhiARcF5KFRek8i45TtxX6RAIUX5QzNiyrwW6zaqEWg913RQn/NR7Us
 bgXg==
X-Gm-Message-State: AOJu0YxuWg84M442gy0cJfkmzVclzzU9Tc2ZORRsQEcJfFxpqWBIVmm7
 0J7bcdtwgh7A/SHWYPuVW1LdLmmNdarYrdXSOC+qT5EC2ETz7HJ4
X-Google-Smtp-Source: AGHT+IG+wF7Lihy+nnQP4p8zP8L/i7OCHgDji0NYqH96PKVOn+7FdRfZtOG0Y8eTSlPWLgVWphqlFQ==
X-Received: by 2002:a05:690c:3388:b0:61a:c316:9953 with SMTP id
 fl8-20020a05690c338800b0061ac3169953mr12635735ywb.11.1713814494599; 
 Mon, 22 Apr 2024 12:34:54 -0700 (PDT)
Received: from maniforge (c-76-136-75-40.hsd1.il.comcast.net. [76.136.75.40])
 by smtp.gmail.com with ESMTPSA id
 n9-20020a81af09000000b0061abdf061ccsm2100878ywh.133.2024.04.22.12.34.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Apr 2024 12:34:53 -0700 (PDT)
Date: Mon, 22 Apr 2024 14:34:51 -0500
From: David Vernet <void@manifault.com>
To: dthaler1968@googlemail.com
Cc: bpf@ietf.org, bpf@vger.kernel.org
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
In-Reply-To: <149401da94e4$2da0acd0$88e20670$@gmail.com>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/IHiKm7_KTIit88DhZhuK4RGEKUw>
Subject: Re: [Bpf] BPF ISA Security Considerations section
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: multipart/mixed; boundary="===============6411011310757428155=="
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>


--===============6411011310757428155==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EFurulJL9vovypnS"
Content-Disposition: inline


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


--===============6411011310757428155==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

--===============6411011310757428155==--


