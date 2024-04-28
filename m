Return-Path: <bpf+bounces-28051-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D412D8B4E6D
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 00:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BA9E281178
	for <lists+bpf@lfdr.de>; Sun, 28 Apr 2024 22:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C312810961;
	Sun, 28 Apr 2024 22:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="UvMGTkRD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="UvMGTkRD"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82096DDC4
	for <bpf@vger.kernel.org>; Sun, 28 Apr 2024 22:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714341683; cv=none; b=JNvwPAZ+r0Vf7gxo/aiIF2kxRu3KbJZZ25syimVQxAMR4MMIKo+5500au3v8lul50NqpQ36fW/+0HFzAh9aa+l6oC7INA5bYYfTbF1UoigFFLYEh2VZ8bGYjkSYqiWM7eNEi0tZ1G5r4HL/dDJzun0xwtv3DyBeSgyEvy36Lg/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714341683; c=relaxed/simple;
	bh=zbGsDxsXieDrsyvKI23Lc9tmNK8KCGgSP6DkRqC56Ss=;
	h=Date:From:To:Cc:Message-ID:References:MIME-Version:In-Reply-To:
	 Subject:Content-Type; b=JD4zRnXjLDAoaPzJKHQTq+khDPnxlVAUpmRhK0S/GjC29m2Fx5ee7Ah7vUN/nIrejY0Aj2IVlfyPajrFzTgkkgIGqWta0ZT5pWa5tP+iBoNJhvG3AGTMjHFTz2ePCB7JH+tE7354By19zYMRXtSGVsfMSETClI56AyQezpbn3Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=UvMGTkRD; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=UvMGTkRD; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id CF5D0C14F6EF
	for <bpf@vger.kernel.org>; Sun, 28 Apr 2024 15:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1714341674; bh=zbGsDxsXieDrsyvKI23Lc9tmNK8KCGgSP6DkRqC56Ss=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=UvMGTkRDiUeXZNA4zwAQxNcti4eZNJPjaboaj49ydTKXwC6NxTC1PfiUnHRghhU2i
	 fznOKLn3q9Zooa2GcPHpacIWyLh1mKPO9wsuDJWPNNxDj9hNab0KNtRa5li7kGiB/V
	 pHOBNlNSA2pawPHx3bsUY7cr/6j1D29iVHWpfafg=
X-Mailbox-Line: From bpf-bounces@ietf.org  Sun Apr 28 15:01:14 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id BA541C14F6A9;
	Sun, 28 Apr 2024 15:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1714341674; bh=zbGsDxsXieDrsyvKI23Lc9tmNK8KCGgSP6DkRqC56Ss=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=UvMGTkRDiUeXZNA4zwAQxNcti4eZNJPjaboaj49ydTKXwC6NxTC1PfiUnHRghhU2i
	 fznOKLn3q9Zooa2GcPHpacIWyLh1mKPO9wsuDJWPNNxDj9hNab0KNtRa5li7kGiB/V
	 pHOBNlNSA2pawPHx3bsUY7cr/6j1D29iVHWpfafg=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id E08DAC14F696
 for <bpf@ietfa.amsl.com>; Sun, 28 Apr 2024 15:01:13 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.647
X-Spam-Level: 
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kL9FIpn-zclf for <bpf@ietfa.amsl.com>;
 Sun, 28 Apr 2024 15:01:13 -0700 (PDT)
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com
 [209.85.166.42])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 2252EC14F602
 for <bpf@ietf.org>; Sun, 28 Apr 2024 15:01:13 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id
 ca18e2360f4ac-7d9e70f388fso161635539f.2
 for <bpf@ietf.org>; Sun, 28 Apr 2024 15:01:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714341672; x=1714946472;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1rSEZ0uJLMLS6TADaoKbbKJSQj1pHqO0QBkdngdbebQ=;
 b=htBFxIMmzwiTJ14XlVzpZ4xzArk8tiAu3yKLnIhvi9n0DBivl0UZBr0gsbEP0/6wJP
 0hRekABixLFq41LxbDjHsVwmjAYs+U9AJAsl8YWFNCwSbjU6HLyXnsx6GRyNcjwMCpWC
 pP5OR7lffknUkkDZjPDM7G98E8MDDSqNOO4f/CgqSLyQRO+a+3hzLF61msNURNNEr/8Z
 CiPKxn2JF1b88vo36qkwyHubE+KuQlntR9r2Jh3gfVQ7gAaB1C2QI2/iDUXLhZ9E9kyj
 aDJJX5brJ3z0mDm9jiPo/4rTVKf5wPIle95rleem0OnOHNVSF9p8HEwKF/7nEMwjjZXQ
 fNrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjwIsTz7b25G8AjNBKj1xmKMPy7uJxhT8yKOTIOjMB00mXvA3jZNGxiGaPg1ohQiOXAVLpmUGNTi/8Meo=
X-Gm-Message-State: AOJu0YwYUMhH1QrakC/Yg5ChnC+dPaPeJmQIoqQVLNB311mWvv36BCnF
 B0MavsEO7gRrSFnb4nUBFkdLbuc17RTKB2eIt+afD3IpmNPZ6OtImnlqRQ==
X-Google-Smtp-Source: AGHT+IHgt6RN8ipT5cwAmYfDxMriZycZUdurc65/N+C556e5XdPU6TLS/thpptRI1OS3/u7lJbps/A==
X-Received: by 2002:a5d:8e16:0:b0:7da:bccd:c3ec with SMTP id
 e22-20020a5d8e16000000b007dabccdc3ecmr10564903iod.5.1714341672311; 
 Sun, 28 Apr 2024 15:01:12 -0700 (PDT)
Received: from maniforge (c-76-136-75-40.hsd1.il.comcast.net. [76.136.75.40])
 by smtp.gmail.com with ESMTPSA id
 iv15-20020a056638868f00b0048792a75bb1sm830354jab.111.2024.04.28.15.01.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Apr 2024 15:01:11 -0700 (PDT)
Date: Sun, 28 Apr 2024 17:01:08 -0500
From: David Vernet <void@manifault.com>
To: Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>
Cc: bpf@vger.kernel.org, bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>,
 Dave Thaler <dthaler1968@googlemail.com>
Message-ID: <20240428220108.GB21308@maniforge>
References: <20240426231126.5130-1-dthaler1968@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240426231126.5130-1-dthaler1968@gmail.com>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/AQ2fd0D9NavztHtL_QXitkW7HOQ>
Subject: Re: [Bpf] [PATCH bpf-next v3] bpf,
 docs: Clarify PC use in instruction-set.rst
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: multipart/mixed; boundary="===============9110653178213340436=="
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>


--===============9110653178213340436==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jLF0M3BlpDlPplJb"
Content-Disposition: inline


--jLF0M3BlpDlPplJb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 04:11:26PM -0700, Dave Thaler wrote:
> This patch elaborates on the use of PC by expanding the PC acronym,
> explaining the units, and the relative position to which the offset
> applies.
>=20
> v1->v2: reword per feedback from Alexei
>=20
> v2->v3: reword per feedback from David Vernet
>=20
> Signed-off-by: Dave Thaler <dthaler1968@googlemail.com>

Reviewed-by: David Vernet <void@manifault.com>

> ---
>  Documentation/bpf/standardization/instruction-set.rst | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Docu=
mentation/bpf/standardization/instruction-set.rst
> index b44bdacd0..997560aba 100644
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
> +instruction if it's a basic instruction or results in undefined behavior
> +if the next instruction is a 128-bit wide instruction.
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

--jLF0M3BlpDlPplJb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZi7HJAAKCRBZ5LhpZcTz
ZByRAQC2QFtgliqW/7CMUHUnEnVIs+TfZFayYWZEElNx/y37RAD/QLAGp3E+LDUL
3ZVkVeVLSvnSnvu4qDWkjdkEyWDUqAU=
=YSPW
-----END PGP SIGNATURE-----

--jLF0M3BlpDlPplJb--


--===============9110653178213340436==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

--===============9110653178213340436==--


