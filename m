Return-Path: <bpf+bounces-27985-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A8F8B40FD
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 22:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45252B22411
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 20:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06EF82C6B7;
	Fri, 26 Apr 2024 20:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="ipvfl+f4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="uhR7e9mg"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70D81EEE9
	for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 20:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714165123; cv=none; b=Rlk3vNHS3X7jNxqBiWGNov4t6qiyqyn03PM9ZATJEg5YFy8CYO9dD57uagmEQYApDlsfrVx53KEfUryHRQ1lxQsSt4GiI1LpVp8CbGSM6IEAXCeBXdSf2rxQfJHWJB+y24QT/e0ulP8IVFzLozLzud76fEc3UQr5FI3IeOYBbeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714165123; c=relaxed/simple;
	bh=tS4s3bSgKMwGbrH3HC6rYQ6cX9l7HDa6zFKFSq10tGI=;
	h=Date:From:To:Cc:Message-ID:References:MIME-Version:In-Reply-To:
	 Subject:Content-Type; b=N/0471N1bzAXbqYSGHJtVlAfX7Yy4f8hc5UWmLzPCFl7YtRGJZ4tPqtIhIXSoA1V90X3DpXITSs0Qpd0Kuf0/XornsHN6yxkIAK8Kr5O+zI4Pa8kzEHULrRNch4SSxlpJUC/sQ3TD2J9wKVIEj2gJ7M869p7z8kOari8rnJGPmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=ipvfl+f4; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=uhR7e9mg; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 2EC37C180B56
	for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 13:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1714165121; bh=tS4s3bSgKMwGbrH3HC6rYQ6cX9l7HDa6zFKFSq10tGI=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=ipvfl+f4lhWSyMUJMM9dkQKbSM1XYkxgthvxU//xW8ybpTKF0Wo91yFAsJkhZ2fec
	 loblZrPERW3Zd4BzsVwAJK39Xhue/kKDWi341UCar6b57W57kL+NMGQjHAqso+c5NV
	 LpPqfButxEG5sOOIERr2yK3LWfm90ulTEDY1/qE8=
X-Mailbox-Line: From bpf-bounces@ietf.org  Fri Apr 26 13:58:41 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id CB02AC14F74A;
	Fri, 26 Apr 2024 13:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1714165120; bh=tS4s3bSgKMwGbrH3HC6rYQ6cX9l7HDa6zFKFSq10tGI=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=uhR7e9mgNHio//s7Jge8eJ0V/dk2DFDjJF/dnIh+Iv0WMaT5XDLauk5LLvrWNWy3B
	 hBiEH1NqXHo/LI6G3yVXT5EXKjLX5G6jBs+XTgmCrrTZXDSaep0M+CkrMRls4h7BAo
	 P8//Wh1DUkPuO3g6DlM7E62/7DNE+sjB8ZqQ8Z5k=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 4C260C14F6B7
 for <bpf@ietfa.amsl.com>; Fri, 26 Apr 2024 13:58:39 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -6.646
X-Spam-Level: 
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0Obh8MBij_Jc for <bpf@ietfa.amsl.com>;
 Fri, 26 Apr 2024 13:58:34 -0700 (PDT)
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com
 [209.85.166.174])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id CC2AFC14F680
 for <bpf@ietf.org>; Fri, 26 Apr 2024 13:58:34 -0700 (PDT)
Received: by mail-il1-f174.google.com with SMTP id
 e9e14a558f8ab-36b2adedec7so10988725ab.1
 for <bpf@ietf.org>; Fri, 26 Apr 2024 13:58:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714165114; x=1714769914;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IYwSlOs5D1E/5oGHU6TuvhldvjUiQWVdBukT+TzQUrA=;
 b=OAL6AHjBrSqF0AvkHQlZpQNp/fixOAWQ2Hh4lBwQUh9ybhAK9cyjKh8mguMB4Mtb9r
 g+qbG31cLw30k/sPkqcyZ6+aVElb9jKLS4pvSWZVOiW+o1RIcaZDVX/XD1Gpi1WXNzR+
 UFOzlNNinKMBwJtyR45DcpjHdy1TvQ1VQNW6QGo4wgEVCydXiiEzwjQoqgjMxWLpwCwO
 RJpU96Oc19IJywgXl0cfC52G17c0DMpp+K0xFjznRyVw5bq/CuiihVV3KseOHOpAN1Z8
 9zEDFP8yxR8F+5Y8oGBofp0aQQvjaA2gnK4apUxROC0nwjqJ8IOtbkLT5Frg9huCtB5F
 RF7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIn5VdnC7IH06bOTcLYPQel+nUG0EvFzr5d34VPJJdkjq8QreWrfzxC7iJF53yXVut8S9NqQCrh8m765s=
X-Gm-Message-State: AOJu0YwkRZ0thtwuDZY77XLmrYsGaT19qow+o/zyDnF50uMNCvGbl8h0
 dMXbSx+ufIvk21JCGveAOZp0EUFYvAnN00O/kmokzsH6FvLDkbiJ
X-Google-Smtp-Source: AGHT+IEs53Mu5VNRNFzZmI8Ysk5yA9QibVJwzcDHXNKlk8HHlBPPp/6Wgb3xLgtETFT9QEkqcM6ncw==
X-Received: by 2002:a05:6e02:1d19:b0:36a:63dd:7d49 with SMTP id
 i25-20020a056e021d1900b0036a63dd7d49mr1231018ila.20.1714165114052; 
 Fri, 26 Apr 2024 13:58:34 -0700 (PDT)
Received: from maniforge (c-76-136-75-40.hsd1.il.comcast.net. [76.136.75.40])
 by smtp.gmail.com with ESMTPSA id
 q4-20020a056e0220e400b0036a3986a47fsm4144091ilv.66.2024.04.26.13.58.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Apr 2024 13:58:33 -0700 (PDT)
Date: Fri, 26 Apr 2024 15:58:31 -0500
From: David Vernet <void@manifault.com>
To: Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>
Cc: bpf@vger.kernel.org, bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>,
 Dave Thaler <dthaler1968@googlemail.com>
Message-ID: <20240426205831.GA21308@maniforge>
References: <20240426201828.4365-1-dthaler1968@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240426201828.4365-1-dthaler1968@gmail.com>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/i4QdG8-uTRq-XClMW_p3HtLKox0>
Subject: Re: [Bpf] [PATCH bpf-next v2] bpf,
 docs: Clarify PC use in instruction-set.rst
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: multipart/mixed; boundary="===============2790850916431723904=="
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>


--===============2790850916431723904==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Yk8Jp1tlhYbPu4bg"
Content-Disposition: inline


--Yk8Jp1tlhYbPu4bg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 01:18:28PM -0700, Dave Thaler wrote:
> This patch elaborates on the use of PC by expanding the PC acronym,
> explaining the units, and the relative position to which the offset
> applies.
>=20
> v1->v2: reword per feedback from Alexei
>=20
> Signed-off-by: Dave Thaler <dthaler1968@googlemail.com>
> ---
>  Documentation/bpf/standardization/instruction-set.rst | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Docu=
mentation/bpf/standardization/instruction-set.rst
> index b44bdacd0..766f57636 100644
> --- a/Documentation/bpf/standardization/instruction-set.rst
> +++ b/Documentation/bpf/standardization/instruction-set.rst
> @@ -469,6 +469,12 @@ JSLT      0xc    any      PC +=3D offset if dst < sr=
c          signed
>  JSLE      0xd    any      PC +=3D offset if dst <=3D src         signed
>  =3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D  =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> +where 'PC' denotes the program counter, and the offset to increment by
> +is in units of 64-bit instructions relative to the instruction following
> +the jump instruction.  Thus 'PC +=3D 1' skips execution of the next
> +instruction if it's a basic instruction and fails verification if the
> +next instruction is a 128-bit wide instruction.

Should we say "results in undefined behavior" rather than "fails
verification"? I'm not sure if we should be dictating verifier semantics
in the ISA document.

> +
>  The BPF program needs to store the return value into register R0 before =
doing an
>  ``EXIT``.
> =20
> --=20
> 2.40.1
>=20
> --=20
> Bpf mailing list
> Bpf@ietf.org
> https://www.ietf.org/mailman/listinfo/bpf

--Yk8Jp1tlhYbPu4bg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZiwVdwAKCRBZ5LhpZcTz
ZMReAQDHZOWofi2uvndJVi6By3EvUrF3ETmn3hRaLloyARO8EwD+IvoDIOCY8wMD
jD8b4LzUQftwX3cjI+9a53NZThKpmgM=
=l4UO
-----END PGP SIGNATURE-----

--Yk8Jp1tlhYbPu4bg--


--===============2790850916431723904==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

--===============2790850916431723904==--


