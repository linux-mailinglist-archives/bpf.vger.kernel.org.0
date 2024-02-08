Return-Path: <bpf+bounces-21562-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C096D84EC4D
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 00:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E61D91C22BD4
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 23:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FA050268;
	Thu,  8 Feb 2024 23:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="QmMKFjE3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="QmMKFjE3"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828B250245
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 23:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707434027; cv=none; b=Ov+9YzCXEjjurfpTw7p1aRofKYVzLfxdaPYFgdJ14OhdBbZ3xgFHTOq+2/STBp3Zxb4MJbIsKqSUrHYmAYbvYrf6n3Cr7qLoa4X9pehb1UZWkSVjIhRtfP3dDQALZQFE5dWox85rvDXjIfX0deYhZOzTHJkjXIKjjivdbe7lUc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707434027; c=relaxed/simple;
	bh=Aq15URv6COHIznvE58Mq9dA4Q48mR3A9U37B9kYNcN0=;
	h=Date:From:To:Cc:Message-ID:References:MIME-Version:In-Reply-To:
	 Subject:Content-Type; b=VCOvRyBCPbf5OTVpe4kRZCka1qFeDbjYBeGRYf2iAcwpFrjuSBUJkx49Br4GOuk7spdWO/8C4jOkEplNOpGDhA2SX2eiiSOFo5+JOj5wZTIB+Uc/Gio/wORpW608Xyi7+iGazaRegxiFFm0fQr63iSxjy4dxzI8bhPmlX2AEHbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=QmMKFjE3; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=QmMKFjE3; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id E49C1C1CAF40
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 15:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1707434024; bh=Aq15URv6COHIznvE58Mq9dA4Q48mR3A9U37B9kYNcN0=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=QmMKFjE3TF8eBR09tOgtZiILPS3wuWcIatCsj5aGauqLpG4ggFP21hpQBOFiriXHY
	 E0pEwvnmJFFFevpMGogfPL6f6Wfp2NJPvrIwu3M3EDParbqDYTCGLp/MK43s+6v/do
	 LeCyAugZ9UYYUJiMip17LRmjT99Byp11pocZlqdE=
X-Mailbox-Line: From bpf-bounces@ietf.org  Thu Feb  8 15:13:44 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id A50AFC1CAF27;
	Thu,  8 Feb 2024 15:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1707434024; bh=Aq15URv6COHIznvE58Mq9dA4Q48mR3A9U37B9kYNcN0=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=QmMKFjE3TF8eBR09tOgtZiILPS3wuWcIatCsj5aGauqLpG4ggFP21hpQBOFiriXHY
	 E0pEwvnmJFFFevpMGogfPL6f6Wfp2NJPvrIwu3M3EDParbqDYTCGLp/MK43s+6v/do
	 LeCyAugZ9UYYUJiMip17LRmjT99Byp11pocZlqdE=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id ED48EC1CAF27
 for <bpf@ietfa.amsl.com>; Thu,  8 Feb 2024 15:13:42 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.408
X-Spam-Level: 
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id J8xWesLZFmjp for <bpf@ietfa.amsl.com>;
 Thu,  8 Feb 2024 15:13:41 -0800 (PST)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com
 [209.85.222.45])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 512F2C1CAF26
 for <bpf@ietf.org>; Thu,  8 Feb 2024 15:13:36 -0800 (PST)
Received: by mail-ua1-f45.google.com with SMTP id
 a1e0cc1a2514c-7d5cbc4a585so120346241.3
 for <bpf@ietf.org>; Thu, 08 Feb 2024 15:13:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707434015; x=1708038815;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vmvYoTRVGkpbw6I/4s7nR94bpI+sqaWfNwXudh0lI/Y=;
 b=ja1SZ5iMulaMHJpgh5Chk3ZSVWG++/OhZVqiZa4M601ycPIukSW1Y6/VrdHYeQi9w7
 IhYI2xEz6cF2k92xvJY3wEJnOl/5Ffuq+B90U6npxUfve98M9dANQbEPII1Hc2hH2jA0
 mY+cCjm5JIBZ41SXJ7xXC1yGN6NfczAqTYwJFH8WQgtndtdKOgRMqsGhGXtwC5rz4zNZ
 xzbh64/tA2uZ5LzMft2mDdy7KHB+TZcTBvAvV8GOY03yVuqDcyIWXk9hbe2bNB4ztinf
 pS9vw9v/2FepjBSmJEGd6gelR8NAP41hIB2KikhY5LdBS8zqOF4fmrU+oTsIOQpBpaLL
 v1Tw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVF66r22NB4jOpq8NoaajktrP+0sP0Q8P+M7MEg/q5OgkFGUhi1FvtmBI/sNMGYzA1Gl/xD7yH6lIT+3Vk=
X-Gm-Message-State: AOJu0YxWrGQk/Bt3Preyhv5R2m013MSMc6sPPJ6r3S2M5bR3pb6prVXX
 w/mkEG8hZk1jKl5fJTUzkKwt8RXp0oC5UGG4/FRGc3xxVkm1eWm4S75hQhEpjY8=
X-Google-Smtp-Source: AGHT+IHrgvWJTcf/vSwztkbsVW1a/C8Lr0tIftA41IqOTMHxPpnzxa26uYFhA1YgOY2B+nXMdAxjXg==
X-Received: by 2002:a1f:e042:0:b0:4bd:7bf5:934c with SMTP id
 x63-20020a1fe042000000b004bd7bf5934cmr76499vkg.4.1707434015095; 
 Thu, 08 Feb 2024 15:13:35 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUSCl/QOE4NMvO3Bwgkyr3xBgcid0l8Z5Zx9J9GOi9GFIOOKTqDe9IHBGA1kTGZM+UhmC6XQzvaZexW1YjUVyboGfFDas6Zoulky63FNMODqa4pqQ==
Received: from maniforge.lan (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
 by smtp.gmail.com with ESMTPSA id
 kf3-20020a056214524300b0068cc289c936sm248022qvb.31.2024.02.08.15.13.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Feb 2024 15:13:34 -0800 (PST)
Date: Thu, 8 Feb 2024 17:13:32 -0600
From: David Vernet <void@manifault.com>
To: Dave Thaler <dthaler1968@googlemail.com>
Cc: bpf@vger.kernel.org, bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>
Message-ID: <20240208231332.GA3488427@maniforge.lan>
References: <20240208221449.12274-1-dthaler1968@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240208221449.12274-1-dthaler1968@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/g7wd0kPRfLWqA2ct6-jBoZfPNXk>
Subject: Re: [Bpf] [PATCH bpf-next] bpf, docs: Update ISA document title
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: multipart/mixed; boundary="===============4725919122076264668=="
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>


--===============4725919122076264668==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FMSKXUZyyNt3i7q2"
Content-Disposition: inline


--FMSKXUZyyNt3i7q2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 08, 2024 at 02:14:49PM -0800, Dave Thaler wrote:
> * Use "Instruction Set Architecture (ISA)" instead of "Instruction Set
>   Specification"
> * Remove version number
>=20
> As previously discussed on the mailing list at
> https://mailarchive.ietf.org/arch/msg/bpf/SEpn3OL9TabNRn-4rDX9A6XVbjM/
>=20
> Signed-off-by: Dave Thaler <dthaler1968@gmail.com>

Acked-by: David Vernet <void@manifault.com>

--FMSKXUZyyNt3i7q2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZcVgHAAKCRBZ5LhpZcTz
ZFC/AQCcRjT2NDna7nS8G86pK5FYQDmoRyJuPvpczFRKXVL+egD+JKn7tA79Bzbb
8HX9tSXrmykI2aBY2R8L6ZU/ix52aws=
=3wXO
-----END PGP SIGNATURE-----

--FMSKXUZyyNt3i7q2--


--===============4725919122076264668==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

--===============4725919122076264668==--


