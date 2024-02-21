Return-Path: <bpf+bounces-22450-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B67585E521
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 19:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A51E6B24BF3
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 18:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF4685260;
	Wed, 21 Feb 2024 18:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="PywWOh7M";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="PywWOh7M"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6684584FAD
	for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 18:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708538603; cv=none; b=i89ORKDCTFnV6nd75LJ5aTJUZUnBRNpDK/J+OpOcd3cKnlDBe7Ojn6JFFG/iuFu80rErbXISGm9/4e5cvRJzHDd96tnYMvfWwazxSepLEWw/lC5yN3EG5OdyudQvh5qgQOWNWG5l7ZBFibHwiBdSO+gmJwE1Y2kqFWtVPheEROU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708538603; c=relaxed/simple;
	bh=9o2q5FEhOgSTF5HPZZUOXogNtO4mIUa+ShO3TY7UJ7c=;
	h=Date:From:To:Cc:Message-ID:References:MIME-Version:In-Reply-To:
	 Subject:Content-Type; b=AxikMNTJpn1OVBUoAaeLaAV5r2/bwgopQXMNhTWePLaulzPHPrxVustZ0cQAyH/MeZ38IIDsi1pmJQEr4ph61HsErDpOFEdKAvUsEHl1bYbjjaOKXyihBTNAXi+zeBdORg4GbNS3vQi+7n/v0WY7+tAriuEd0dJ1L24ssTUJUcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=PywWOh7M; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=PywWOh7M; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id BFC8CC151989
	for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 10:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1708538600; bh=9o2q5FEhOgSTF5HPZZUOXogNtO4mIUa+ShO3TY7UJ7c=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=PywWOh7Mp5I3IX/KxHaDqyCfGf28QHy+XzWbUS32ja1wREkAj+2f4FzgAFFL1AP9u
	 YIl5yPLL11U8bBM/B1nrjh2gQiOg/rmO+Z8PT48gWUr0/j6scOiYtZyjCgiwYPiYSu
	 yy54jB/UHtE+kQAztWDxUBdqjf6n1QM/ddHZRcpM=
X-Mailbox-Line: From bpf-bounces@ietf.org  Wed Feb 21 10:03:20 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 7D398C14F738;
	Wed, 21 Feb 2024 10:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1708538600; bh=9o2q5FEhOgSTF5HPZZUOXogNtO4mIUa+ShO3TY7UJ7c=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=PywWOh7Mp5I3IX/KxHaDqyCfGf28QHy+XzWbUS32ja1wREkAj+2f4FzgAFFL1AP9u
	 YIl5yPLL11U8bBM/B1nrjh2gQiOg/rmO+Z8PT48gWUr0/j6scOiYtZyjCgiwYPiYSu
	 yy54jB/UHtE+kQAztWDxUBdqjf6n1QM/ddHZRcpM=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 0BDEBC14F738
 for <bpf@ietfa.amsl.com>; Wed, 21 Feb 2024 10:03:19 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -6.407
X-Spam-Level: 
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tuBYGAiUk18v for <bpf@ietfa.amsl.com>;
 Wed, 21 Feb 2024 10:03:14 -0800 (PST)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com
 [209.85.160.179])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id AD61DC14F682
 for <bpf@ietf.org>; Wed, 21 Feb 2024 10:03:14 -0800 (PST)
Received: by mail-qt1-f179.google.com with SMTP id
 d75a77b69052e-42a31b90edcso48212281cf.0
 for <bpf@ietf.org>; Wed, 21 Feb 2024 10:03:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708538593; x=1709143393;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/5zOHo30ZABTIQWugBpCfU2/JqQeCkdcTj1Rd2b2xwQ=;
 b=F1+u1tz3Xwl4D800izTYeZWmiQA4SRFEopGqIEVAg4y2DMYEHv9CHFAsv7IMQcSCUX
 eJmeKxw4afjadiYhdljk1LXUqtXEytphEbQoENy1yXKj8FKzW+PzeMdyxmPGToEv1edW
 UfiCTpr7mDp451TP7jseFEYK/Y8o7H0iC9jHYy2C9wT9NzI+V1Dp7HuI154tiKdu3p+z
 yrn4ivDebG8NBbXmTJLPlu2Us0kj1LoLsI+qenKvpOFtvoi9te2gJYvxmXi6Tj1LlJ6S
 uCdVd7nOTF0WSK9+aCBzAlz7IzKUj1SxQ3B++Gnoy3jaVFQwnUhafVawXp7RovyuUYkw
 vbww==
X-Forwarded-Encrypted: i=1;
 AJvYcCUv0KhqsSwZ3DFW+xHWOiN43Jri7iBdie3R011Fz6LzL+qv73gdoUbh8T16Wh0jK31oa66Ixvd54qh4jEA=
X-Gm-Message-State: AOJu0YwciiAJRdJBf3jiXOLKmtNYKDLd+jfhcrrCBVDFksEz5TipdakW
 miZ/g1rOjncF2aFLBiZeOZlYJFUFvBbmt8ygDPZmJG21X40szh/G
X-Google-Smtp-Source: AGHT+IFfeP2LdMKuPixsokLo6A//yCGmedYS7sMF0CJ0+sDO3VSRD20VBcVlfX9fvsX/oizLSW93JA==
X-Received: by 2002:a05:622a:613:b0:42e:74b:c4da with SMTP id
 z19-20020a05622a061300b0042e074bc4damr11152640qta.5.1708538593529; 
 Wed, 21 Feb 2024 10:03:13 -0800 (PST)
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
 by smtp.gmail.com with ESMTPSA id
 c21-20020ac853d5000000b0042e1950d591sm2496113qtq.70.2024.02.21.10.03.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Feb 2024 10:03:12 -0800 (PST)
Date: Wed, 21 Feb 2024 12:03:09 -0600
From: David Vernet <void@manifault.com>
To: Dave Thaler <dthaler1968@googlemail.com>
Cc: bpf@vger.kernel.org, bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>
Message-ID: <20240221180309.GB57258@maniforge>
References: <20240221175419.16843-1-dthaler1968@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240221175419.16843-1-dthaler1968@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/zW0NUY8mWzeZrbyFuC1-PQdX8Vw>
Subject: Re: [Bpf] [PATCH bpf-next] bpf,
 docs: specify which BPF_ABS and BPF_IND fields were zero
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: multipart/mixed; boundary="===============5864988129798692577=="
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>


--===============5864988129798692577==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RAHwcC+l7ubUDf/s"
Content-Disposition: inline


--RAHwcC+l7ubUDf/s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 09:54:19AM -0800, Dave Thaler wrote:
> Specifying which fields were unused allows IANA to only list as deprecated
> instructions that were actually used, leaving the rest as unassigned and
> possibly available for future use for something else.
>=20
> Signed-off-by: Dave Thaler <dthaler1968@gmail.com>

Seems reasonable -- guess there's no harm in leaving ourselves the
option of using them in the future.

Acked-by: David Vernet <void@manifault.com>

> ---
>  Documentation/bpf/standardization/instruction-set.rst | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Docu=
mentation/bpf/standardization/instruction-set.rst
> index 868d9f617..597a086c8 100644
> --- a/Documentation/bpf/standardization/instruction-set.rst
> +++ b/Documentation/bpf/standardization/instruction-set.rst
> @@ -658,6 +658,7 @@ Legacy BPF Packet access instructions
>  BPF previously introduced special instructions for access to packet data=
 that were
>  carried over from classic BPF. These instructions used an instruction
>  class of BPF_LD, a size modifier of BPF_W, BPF_H, or BPF_B, and a
> -mode modifier of BPF_ABS or BPF_IND.  However, these instructions are
> +mode modifier of BPF_ABS or BPF_IND.  The 'dst_reg' and 'offset' fields =
were
> +set to zero, and 'src_reg' was set to zero for BPF_ABS.  However, these =
instructions are
>  deprecated and should no longer be used.  All legacy packet access
>  instructions belong to the "legacy" conformance group.
> --=20
> 2.40.1
>=20
>=20

--RAHwcC+l7ubUDf/s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZdY63QAKCRBZ5LhpZcTz
ZFDhAQCi5aIgk/evr4NQLFZKDbPG2nrO2u8X8yZrNOt/M45mQgD9HL6SBG4NNkys
C2TaQtNkKFa0HUR4qS/2iHr0cmPl9w0=
=gDK5
-----END PGP SIGNATURE-----

--RAHwcC+l7ubUDf/s--


--===============5864988129798692577==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

--===============5864988129798692577==--


