Return-Path: <bpf+bounces-21440-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B8884D596
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 23:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 905001F24ECC
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 22:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161C31353FA;
	Wed,  7 Feb 2024 21:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="m3nR3fmM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="m3nR3fmM"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1AA128831
	for <bpf@vger.kernel.org>; Wed,  7 Feb 2024 21:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707343006; cv=none; b=j0J0HEB8p68I2ttRChsa5qkLcICWJkLkIeFbVuCx9cNBn9vF5VrjgcZcYnYFZtd25kxqpXt1/tCdhGEVY5rXSlXlXBVwVsKLDLExcfNdm78Zp2atlKPAS6c7PPA+tu38xVyASz97SzejpmDcn8AndI38Bh9o4l+2PZH20R68HE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707343006; c=relaxed/simple;
	bh=CA+bVZUIAB4Cmt8K7aXiRaLKS0tjuBu08nIUc5MSBDY=;
	h=Date:From:To:Cc:Message-ID:References:MIME-Version:In-Reply-To:
	 Subject:Content-Type; b=W9p03wO1G60TU52bZwKoTQxWR7k3NT0zER4HEtL1kZtrzeLgtrLiygFYa3yo2i4lfwYZeO1t9I/HapNl0AmI8iUgiZxxl0x5VXLBwe3kYywL8RPB7gOh53ioqzYE/dEfa+pon4fBwJTBTYA8FQKgyQbnfqnHBuLFoj2y7OuLyjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=m3nR3fmM; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=m3nR3fmM; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 31E7FC151092
	for <bpf@vger.kernel.org>; Wed,  7 Feb 2024 13:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1707343004; bh=CA+bVZUIAB4Cmt8K7aXiRaLKS0tjuBu08nIUc5MSBDY=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=m3nR3fmMiGj6/uMrKXHH3ig9Eh6YbSTNyyTMneEUFukRPhOTBELNNQul8PDkBIxue
	 3SWia0UJAoqRL9+GDUbPSIfqJj7SJ4Tr7hhG+qQjbsrNtrwkEjuUZ5HzGQuanRuaqr
	 Oc6Y64eaVt1/mYHa+6PghUVb8jelxPcKNvQfAtus=
X-Mailbox-Line: From bpf-bounces@ietf.org  Wed Feb  7 13:56:44 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id E8745C14F616;
	Wed,  7 Feb 2024 13:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1707343004; bh=CA+bVZUIAB4Cmt8K7aXiRaLKS0tjuBu08nIUc5MSBDY=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=m3nR3fmMiGj6/uMrKXHH3ig9Eh6YbSTNyyTMneEUFukRPhOTBELNNQul8PDkBIxue
	 3SWia0UJAoqRL9+GDUbPSIfqJj7SJ4Tr7hhG+qQjbsrNtrwkEjuUZ5HzGQuanRuaqr
	 Oc6Y64eaVt1/mYHa+6PghUVb8jelxPcKNvQfAtus=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 7CEFAC14CF1F
 for <bpf@ietfa.amsl.com>; Wed,  7 Feb 2024 13:56:42 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.41
X-Spam-Level: 
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cmWK1jbH0f0i for <bpf@ietfa.amsl.com>;
 Wed,  7 Feb 2024 13:56:41 -0800 (PST)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com
 [209.85.219.41])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id EDD94C14F616
 for <bpf@ietf.org>; Wed,  7 Feb 2024 13:56:41 -0800 (PST)
Received: by mail-qv1-f41.google.com with SMTP id
 6a1803df08f44-68c4300518bso5689976d6.3
 for <bpf@ietf.org>; Wed, 07 Feb 2024 13:56:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707343001; x=1707947801;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bg2P+nAlDQNpEHQ+LQLQYmHmXjg4pcyUd5qZttno0P0=;
 b=VI+gv2UrYGo4WEA14+CTlRi7hGTXL7XE2Lh6SXUbQ8FjFpdJaRd/AIPTzS9mE1piOk
 JCiD5IASkMPENGeuSZ4s4WlmZ35MG2SY/tEzuHGWNYU0hFOBB+TdisZccwB11UR2i3K0
 +68y3t41q3a6SV/M3HUHY6qAySaV7ZS5ADg3s7KI8rRo/28COM5wiUvt54k6R3gWr2Mf
 20XvRgr4vaFtbcFbmOITJvTK+xvjObRgV7V5cpN5XFzyHLQFCC1VSX4GMdx3KKjlIkWV
 MnbkRXFkqgZrnPu3NXUP+UPpLJ2C19doxWFQ2kmTa4YjB+ejMvpcDAEvvoxqFy0uLAfW
 K5+Q==
X-Gm-Message-State: AOJu0YzFZfGsRzpHMKC3XTVlWtuJlzMduxqfyUriUGHPLtLjU7pzvsMN
 m1of33uxmRh4slo/e0BfJHzzPatZuXFJ7H13LwWSYQk+4JB3qDDd
X-Google-Smtp-Source: AGHT+IEopWPDKZL+TxqqWBCQwz+doNz54tR3AovKB0uz9wb2W4XYyGp5E5KxBQpan7ZpZAaNo81I+Q==
X-Received: by 2002:a0c:e487:0:b0:685:8ac0:c027 with SMTP id
 n7-20020a0ce487000000b006858ac0c027mr6124477qvl.23.1707343000858; 
 Wed, 07 Feb 2024 13:56:40 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCU5X/xo0s9/zT3MMymAAa6Fp8Pb/4bMgaNvnk+apoiI6RST1nBfs0vG/16bZgbLaNMcqJO6CnC0wI1/4A4=
Received: from maniforge.lan (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
 by smtp.gmail.com with ESMTPSA id
 d10-20020a056214184a00b0068c4b445991sm971651qvy.67.2024.02.07.13.56.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Feb 2024 13:56:40 -0800 (PST)
Date: Wed, 7 Feb 2024 15:56:38 -0600
From: David Vernet <void@manifault.com>
To: dthaler1968=40googlemail.com@dmarc.ietf.org
Cc: 'bpf' <bpf@vger.kernel.org>, bpf@ietf.org
Message-ID: <20240207215638.GF2087132@maniforge.lan>
References: <134701da5a0e$2c80c710$85825530$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <134701da5a0e$2c80c710$85825530$@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/xQwszyzAWl4U77ApKzVfCm-YU70>
Subject: Re: [Bpf] ISA document title question
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: multipart/mixed; boundary="===============1933428991852939351=="
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>


--===============1933428991852939351==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ojOD+1PuRbswj7c9"
Content-Disposition: inline


--ojOD+1PuRbswj7c9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 07, 2024 at 01:39:47PM -0800, dthaler1968=3D40googlemail.com@dm=
arc.ietf.org wrote:
> The Internet Draft filename is draft-ietf-bpf-isa-XX, and the charter has:
> > [PS] the BPF instruction set architecture (ISA) that defines the
> > instructions and low-level virtual machine for BPF programs,
>=20
> That is, "instruction set architecture (ISA)", but the document itself ha=
s:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > BPF Instruction Set Specification, v1.0
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > This document specifies version 1.0 of the BPF instruction set.
>=20
> Notably, no "architecture (ISA)".   Also, we now have a mechanism
> to extend it with conformance groups over time, so "v1.0" seems
> less relevant and perhaps not important given there's only one
> version being standardized at present.

Not only this, but we may extend individual conformance groups to new
versions, while leaving others the same. So versioning this document
seems like the wrong granularity. If we want to version anything as 1.0,
we should probably version the conformance groups.

>=20
> What do folks think about changing the doc to say:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > BPF Instruction Set Architecture
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > This document specifies the BPF instruction set architecture (ISA).
> ?

+1

Thanks,
David

--ojOD+1PuRbswj7c9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZcP8lgAKCRBZ5LhpZcTz
ZHOIAQDTAXkEIano23KsMwbhejXxWvejzWCOiYQFzMYe4yC59wD+PGyg3+NJDn7z
y9J6NVv8kPRckGGsIp7OLpo5FL4HaQI=
=YpgB
-----END PGP SIGNATURE-----

--ojOD+1PuRbswj7c9--


--===============1933428991852939351==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

--===============1933428991852939351==--


