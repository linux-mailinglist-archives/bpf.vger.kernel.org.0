Return-Path: <bpf+bounces-19851-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE7983225F
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 00:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0675B21C84
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 23:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB051EA78;
	Thu, 18 Jan 2024 23:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="WZIabCyr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="dcZEE0uX"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDB51E4BD
	for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 23:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705621562; cv=none; b=d1ncdkEIaA3TgPqkrD2o+F0Nf10Noz7dXO76BnS5H4EL4FUAoMfmxtWuNtN7WKLANUvDEWvPztV6wNn/A92M9WU0qbzUdytYjGQrhxiFVEqXNTy7XNLbH6YHrmqRnvNS0+v8jn7ts0QETS1CKppt0drozP9HLMpYy+Xtw92Ab+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705621562; c=relaxed/simple;
	bh=7CkwApv1eeqCiH094mtHnkOhS/NrBlOaNfCKPeMCsnA=;
	h=Date:From:To:Cc:Message-ID:References:MIME-Version:In-Reply-To:
	 Subject:Content-Type; b=WDjFqJ9Oy2jc2cO+EIKUxmIkfn2glU0ho2A1wbgNSzZWRTz1mWgBvmo1LQbI0q7/qe/yzmykGW0/LYbtdRpPWd37FqIjb8ZDSDxcOmArQBg8E68eTZjU+qR1+Duiysh9wp5uHJpUfLOJLHFesp9LaArwQlVbDaNDogI62dgrtOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=WZIabCyr; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=dcZEE0uX; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 09D47C14CF1D
	for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 15:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1705621560; bh=7CkwApv1eeqCiH094mtHnkOhS/NrBlOaNfCKPeMCsnA=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=WZIabCyr+qzZC2/7RqB+etkLd2NkfsYA7Ohx0Nyy8zFLgaCxi3qovqpuj2JDbQ+Er
	 JCUDmBhL74XUV8kuWMjsRlAZdUomsrB3hif+qBQSZkffn8ob6P8Kh/DUkN8c16JgCd
	 BPwP+wifGln+AGiSr43KA4wtffXMXaC+ajkZ0MtI=
X-Mailbox-Line: From bpf-bounces@ietf.org  Thu Jan 18 15:45:59 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id DF30AC14F6E4;
	Thu, 18 Jan 2024 15:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1705621559; bh=7CkwApv1eeqCiH094mtHnkOhS/NrBlOaNfCKPeMCsnA=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=dcZEE0uXR91Hv/TR7ZaR/jo8+g09R+bAMJ4mTTK0Q3NotWSLK7Po54oqTqWIMfSxp
	 lUE7BJh1w+gzAVBJp0z+BvPE/10F4z8GFwkuxPtgjgQPylGI7+JoGVNUmIiun/+UhJ
	 8d/Qe6xxBtO5EytDObpr1M/w9cvnhoFPq9SiX2gk=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 94CBAC14F738
 for <bpf@ietfa.amsl.com>; Thu, 18 Jan 2024 15:45:58 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.407
X-Spam-Level: 
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MKqHcGb4sXLv for <bpf@ietfa.amsl.com>;
 Thu, 18 Jan 2024 15:45:54 -0800 (PST)
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com
 [209.85.167.175])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 65662C14F602
 for <bpf@ietf.org>; Thu, 18 Jan 2024 15:45:52 -0800 (PST)
Received: by mail-oi1-f175.google.com with SMTP id
 5614622812f47-3bb9d54575cso182204b6e.2
 for <bpf@ietf.org>; Thu, 18 Jan 2024 15:45:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705621551; x=1706226351;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lD1WcXOmAacBezmh0ne+DCmg7yQK+EEyNaUDf1ah3c0=;
 b=EUlh59XREkjHUuT//pPOJ1/FjEcQ+lXUm/+4sePZuBqP7g30AoZYnWaSThFjQMii8M
 06pJUNlVDiu5jLTFsTV3ooGicikluLuwPcfYwiLIoULYYllVNL5wDLSx7DLTuTi9XbH9
 7o1uv+NDgep5KRavxmYvaROj6BnSMf7N6OS/HHzZXHKIFnQqEFZJDaSZEEq7VrgGz23D
 7Qt8/bhOpIaU9BgYehKF0JBnjKYnVFL40pVQHj2Zd93yVf873p/04bQLRHQgkX9j6FG6
 1wbJZjsgPqruWqyDtzTjqbO5+bBfKLWJn/u8MfbVTWIEWF6AgtORgq6UYgfUHP8iWYN7
 92gw==
X-Gm-Message-State: AOJu0YzwypzapoKShbHbNOojVdPJfQJ/fi4s0RauxcP0wnE1gTRX8vTE
 ZFFJstd+AStVK4b7DleQrzzrSZ2XBsEvQ559XuIPG5yNZGrrzDqJ
X-Google-Smtp-Source: AGHT+IFMZFuMqplydlVFsKEo5oZ02dOzRxnUN8VVDq4akmfcmB88XbNEAd+eOuICsqOuoyJ9TnL69g==
X-Received: by 2002:a05:6808:1287:b0:3bd:9800:522c with SMTP id
 a7-20020a056808128700b003bd9800522cmr1847985oiw.3.1705621551562; 
 Thu, 18 Jan 2024 15:45:51 -0800 (PST)
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
 by smtp.gmail.com with ESMTPSA id
 he23-20020a05622a601700b0042a09928c10sm2555346qtb.33.2024.01.18.15.45.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 15:45:50 -0800 (PST)
Date: Thu, 18 Jan 2024 17:45:48 -0600
From: David Vernet <void@manifault.com>
To: Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>
Cc: bpf@vger.kernel.org, bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>
Message-ID: <20240118234548.GA879563@maniforge>
References: <20240118232954.27206-1-dthaler1968@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240118232954.27206-1-dthaler1968@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/CuEzpN0LcIjB0x70rYV8fQpPHaM>
Subject: Re: [Bpf] [PATCH bpf-next] bpf,
 docs: Clarify that MOVSX is only for BPF_X not BPF_K
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: multipart/mixed; boundary="===============0344829766216758031=="
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>


--===============0344829766216758031==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lcMjBK8GJPtDYmvr"
Content-Disposition: inline


--lcMjBK8GJPtDYmvr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 03:29:54PM -0800, Dave Thaler wrote:
> Per discussion on the mailing list at
> https://mailarchive.ietf.org/arch/msg/bpf/uQiqhURdtxV_ZQOTgjCdm-seh74/
> the MOVSX operation is only defined to support register extension.
>=20
> The document didn't previously state this and incorrectly implied
> that one could use an immediate value.
>=20
> Signed-off-by: Dave Thaler <dthaler1968@gmail.com>

Acked-by: David Vernet <void@manifault.com>

--lcMjBK8GJPtDYmvr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZam4LAAKCRBZ5LhpZcTz
ZOQHAP9jnnEL4ycoLA7xRNG9ulw63+NnQRtlJAuql2vC4p4V0QD/WQxPmYpC4p81
uZ6Crcy2OkJqIlOE5AdFBoN9iQBcnAI=
=zQ1F
-----END PGP SIGNATURE-----

--lcMjBK8GJPtDYmvr--


--===============0344829766216758031==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

--===============0344829766216758031==--


