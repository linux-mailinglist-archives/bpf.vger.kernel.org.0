Return-Path: <bpf+bounces-27468-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FAC8AD4FA
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 21:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24FE41F226D4
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 19:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A0D15538A;
	Mon, 22 Apr 2024 19:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="jwKFdPfX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="jwKFdPfX"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA85155385
	for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 19:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713814738; cv=none; b=So21pB6aHloIyOYXHsoUTZ2Sd7gnrxJpPTxm4zzRIn3Zb2r3mgAfoMay4Rjyv4AvKLgl2V1tASY/tRRNYcSxXnlNahQEHTrgbB6U6efFxmZmA/1MIuH2A5nj/kvZFlqLfZyT42OwxpTlsGLgsAR7kRHaU0deKRfI6l0nPYrqI4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713814738; c=relaxed/simple;
	bh=i+GP0EGUbtBUojNWty553sMr22J2XkleZRp7FoGXgXo=;
	h=Date:From:To:Cc:Message-ID:References:MIME-Version:In-Reply-To:
	 Subject:Content-Type; b=MH3UTgZ9Mt+EFHjNmdSmfcw9aIJekQ4ioHka02SvyI+H0SGW6g161fNiECPXpx+Y0gaO7pb8ayvGdkamJ7G1g3ttxK8ZzCp6tJPkdCB/ZaMBR4u4ju4aaTTtY+vt3hBQffB1fVrq71OZqEWUidOZGOQ0JCndx8krkYtFFSWIwlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=jwKFdPfX; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=jwKFdPfX; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 456ACC1CAF5D
	for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 12:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1713814736; bh=i+GP0EGUbtBUojNWty553sMr22J2XkleZRp7FoGXgXo=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=jwKFdPfX1DOYJBvjJpKAKzECJ9xLLPyXBALTQJk58oaIeWJ++nVjyB8jicNgRrM2B
	 FuwIRrKaKkXnj5R7YvOavzIcGe/0WKcOIntt6OrzRIfTPybNhwtc1L26KYVsp0tIP1
	 vgP5WY9P6J+4abD3kOpmVNOznXoB5PQfsmb+8uEk=
X-Mailbox-Line: From bpf-bounces@ietf.org  Mon Apr 22 12:38:56 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 0F8E7C18DBB7;
	Mon, 22 Apr 2024 12:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1713814736; bh=i+GP0EGUbtBUojNWty553sMr22J2XkleZRp7FoGXgXo=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=jwKFdPfX1DOYJBvjJpKAKzECJ9xLLPyXBALTQJk58oaIeWJ++nVjyB8jicNgRrM2B
	 FuwIRrKaKkXnj5R7YvOavzIcGe/0WKcOIntt6OrzRIfTPybNhwtc1L26KYVsp0tIP1
	 vgP5WY9P6J+4abD3kOpmVNOznXoB5PQfsmb+8uEk=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id EFF6EC151097
 for <bpf@ietfa.amsl.com>; Mon, 22 Apr 2024 12:38:54 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.646
X-Spam-Level: 
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iBWi1Y2nGTCT for <bpf@ietfa.amsl.com>;
 Mon, 22 Apr 2024 12:38:51 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com
 [209.85.219.182])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 3F4D3C18DBB7
 for <bpf@ietf.org>; Mon, 22 Apr 2024 12:38:51 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id
 3f1490d57ef6-de4640ec49fso5010080276.2
 for <bpf@ietf.org>; Mon, 22 Apr 2024 12:38:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713814730; x=1714419530;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VEBGdHu7pues5aIj8L/m4SpnO+cRtOw1iKcBcs8MCVs=;
 b=gQ4p5Sp0OyuvDrLTAA92cg8koVk1C/fM7c/SflJlVD/IThXy//FQVDjcNUeu6kadck
 NIOnIkTTa9aLfHM/lYhaz4xfKhUwpYne2YhZEjX2L09opj67IIXuZKZ4ydBO1NzLp1sq
 AjfIQfCZ/XqJY4scXySCISqBfBpYDkH/+WtweeXNvoLxxvOyKHDfbuuKmJeoHNIvDFCD
 DSAfsabOuOtwuptWdNXXxfvXjTVslqVYESFZEQjpwOFe4Fxi6CVCI62SXf6Qh/uANclI
 isVv/dchBER2w0AZzLa5RAD5tpdHmNDdTueaoJHKD3bWO2Ck6Ktg+dcSCRBSSiTGnNyR
 N3dw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2vPFqcJqDaShUW9jdV83nKSuRxzBUe4KhzmLizGw+mBuEZMCIpNxmtaCftkmOU2Vzs/cRbK/5BG6ef8A=
X-Gm-Message-State: AOJu0YzSJufSXQrQ5Rj7KBbfx1xMN/mOM4119Oh8CnW1wdALm6MZRWHp
 0cndDAf2dD6mNiTmJwhch2Wd1Z7IR/TmZD9q/2mUc9+9FnjucdR5
X-Google-Smtp-Source: AGHT+IEki3iam8MD2m3eNX7SlyCAsv1ygau1fUpOiTaJxtIawP89cBJgfr/xPuIR4SvWLd22vhqUhg==
X-Received: by 2002:a25:d00d:0:b0:de4:6bf7:d848 with SMTP id
 h13-20020a25d00d000000b00de46bf7d848mr11053139ybg.33.1713814730188; 
 Mon, 22 Apr 2024 12:38:50 -0700 (PDT)
Received: from maniforge (c-76-136-75-40.hsd1.il.comcast.net. [76.136.75.40])
 by smtp.gmail.com with ESMTPSA id
 s90-20020a25aa63000000b00dcc70082018sm2196675ybi.37.2024.04.22.12.38.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Apr 2024 12:38:49 -0700 (PDT)
Date: Mon, 22 Apr 2024 14:38:47 -0500
From: David Vernet <void@manifault.com>
To: Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>
Cc: bpf@vger.kernel.org, bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>
Message-ID: <20240422193847.GB18561@maniforge>
References: <20240422190942.24658-1-dthaler1968@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240422190942.24658-1-dthaler1968@gmail.com>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/3XYSduW9SZHtowywcn6PzN0DkYM>
Subject: Re: [Bpf] [PATCH bpf-next] bpf,
 docs: Add introduction for use in the ISA Internet Draft
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: multipart/mixed; boundary="===============3289059320012636497=="
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>


--===============3289059320012636497==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8RhQd7bHZMF35SjI"
Content-Disposition: inline


--8RhQd7bHZMF35SjI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 12:09:42PM -0700, Dave Thaler wrote:
> The proposed intro paragraph text is derived from the first paragraph
> of the IETF BPF WG charter at https://datatracker.ietf.org/wg/bpf/about/
>=20
> Signed-off-by: Dave Thaler <dthaler1968@gmail.com>
> ---
>  Documentation/bpf/standardization/instruction-set.rst | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Docu=
mentation/bpf/standardization/instruction-set.rst
> index d03d90afb..b44bdacd0 100644
> --- a/Documentation/bpf/standardization/instruction-set.rst
> +++ b/Documentation/bpf/standardization/instruction-set.rst
> @@ -5,7 +5,11 @@
>  BPF Instruction Set Architecture (ISA)
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> -This document specifies the BPF instruction set architecture (ISA).
> +eBPF (which is no longer an acronym for anything), also commonly
> +referred to as BPF, is a technology with origins in the Linux kernel
> +that can run untrusted programs in a privileged context such as an

Perhaps this should be phrased as:

=2E..that can run untrusted programs in privileged contexts such as the
operating system kernel.

Not sure if that's actually a grammar correction but it sounds more
correct in my head. Wdyt?

Regardless:

Acked-by: David Vernet <void@manifault.com>

> +operating system kernel. This document specifies the BPF instruction
> +set architecture (ISA).
> =20
>  Documentation conventions
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> --=20
> 2.40.1
>=20
> --=20
> Bpf mailing list
> Bpf@ietf.org
> https://www.ietf.org/mailman/listinfo/bpf

--8RhQd7bHZMF35SjI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZia8xwAKCRBZ5LhpZcTz
ZOxtAQCC8mL+DePpWppZXI1Z0mMOZMMCw7YA7kumKNMNqImIfwEApR2e+CndkHPw
PmKFAhUNpPyiIEbcTPAs6hBY1cuiEws=
=pj/+
-----END PGP SIGNATURE-----

--8RhQd7bHZMF35SjI--


--===============3289059320012636497==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

--===============3289059320012636497==--


