Return-Path: <bpf+bounces-28481-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDBA88BA2FA
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 00:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 155B11C20BE2
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 22:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7AAD57CA7;
	Thu,  2 May 2024 22:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xz2nzq1s"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E74157C94;
	Thu,  2 May 2024 22:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714687593; cv=none; b=Q/d6tevbaxQ0RXEaOW6r+aEgMkMCl41WkP8JnRlk+6LIPgb02Q+m7raqHLL39hyyahSnbPJUuivUDIM7Iqucu8O4tNmRECMc638u9KVv1gWNbSV9Ltrn0hBbcxlkoMK/BJTfMqco07CLnmbU83+nIY/0yID4SoYet+6y4PmYucw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714687593; c=relaxed/simple;
	bh=syfFdI9oig8Vhc/96bXStdHXCWO+OS9oOsgISmm950E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EZNboEo6gPpuGSJ0GI07n5TB3/gMmO5mRAWIcqAllAR3BnJVg3J8Y7oPhbnmAIZ8BxhxE3xYHVIAwq7qHUiNyZouf7tToxWhWUjQiyfP3cyiMpVxzdBshcN5tAuP52VJS/9VGLNGHS4puJoVOTtyzD2N2UWslaxt1dcAfrHSu2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xz2nzq1s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5895EC113CC;
	Thu,  2 May 2024 22:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714687592;
	bh=syfFdI9oig8Vhc/96bXStdHXCWO+OS9oOsgISmm950E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xz2nzq1sLtikjGzD9kfULQLCNfapBQ+334N2Mm/AFOaoamdMN2HE2QKlgZF/Wy+aT
	 A/6U4lFq4IFUwavZDkYghfgGykoX53x59pA38cbOKR3R3aE+73sZhDo7L2TA2WBA4c
	 bLWkewleSRnC6e9iqv+nQ2MOILQD7sJ/rIadgVMoAXVVcC33HT0aktQCDr3IP1+/V8
	 d7ytvO0sTGgQAqf2efFbjURfKbL0Zx7Veh0mgaTC/c4uatQrYN9TVWgegbVNNd8r9n
	 BQ4UiOPNAEWdC2HZ/7rp2nF6VslyRk3IjgU4gjNz5K95oLKWli62UUwDrfZsb4DPnk
	 Do6N+MA5bQwDQ==
Date: Fri, 3 May 2024 00:06:25 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	linux-man@vger.kernel.org, x86@kernel.org, bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCHv4 7/7] man2: Add uretprobe syscall page
Message-ID: <ZjQOYplF4EbsfQ0v@debian>
References: <20240502122313.1579719-1-jolsa@kernel.org>
 <20240502122313.1579719-8-jolsa@kernel.org>
 <ZjOYf_g2qRrhDoQD@debian>
 <ZjPz2PWrW2BjXxlw@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ek6osrwvrJr1a4yE"
Content-Disposition: inline
In-Reply-To: <ZjPz2PWrW2BjXxlw@krava>


--Ek6osrwvrJr1a4yE
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Fri, 3 May 2024 00:06:25 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	linux-man@vger.kernel.org, x86@kernel.org, bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCHv4 7/7] man2: Add uretprobe syscall page

Hi Jiri,

On Thu, May 02, 2024 at 10:13:12PM +0200, Jiri Olsa wrote:
> > You could add a HISTORY section.
>=20
> ok, IIUC for this syscall it should contain just kernel version where
> it got merged, right?

Yep.

>=20
> >=20
> > Have a lovely day!
>=20
> thanks for review,
> jirka

Thanks for the page.

Have a lovely night!
Alex

--=20
<https://www.alejandro-colomar.es/>
A client is hiring kernel driver, mm, and/or crypto developers;
contact me if interested.

--Ek6osrwvrJr1a4yE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmY0DmEACgkQnowa+77/
2zJBMg/+PU0T3fJzB+wZdvQff5c7oLjdndWW+DkZtasvCkeVOUiqBI7ePfBI7DXT
VRFsrYMOoYnlTLS2suag2r0O/zf+QzvyRM83sp2l2/PqLBwHRWBVaDv2VEa/JBXf
FrMaSI1BeRPpsdIJdOchHPzfbOB5Hlmqqyfc6tMJlffECGkcLIceZ1sE3U1lUWv5
CBMOlzoWyB4wTUqUuHtgsxk2nChoH+oQ0xD00oY7GLHVkgjKIfTJGx78wsyBnFI6
1kZ0xRoHKWBOzy/UHuR1A4vbcND0B2BxDPmgEUibAI4rrjsw1rpeDyXaamJA5HlT
A33e4OVbJYXKl9lZjzBroY0knpZVpXltDCCAYcKGAtHeD1TDDF1581M7BZqDGTnQ
o4MUIml7+pQQlFmwYKFiEIoHDpijlhf8m9rHI/kSrwtQO4t5ajyc3y86L4XzkYiG
ENyMJ/VWE82qvv1WIW81xpsjA+3RA6cGLaLt8p6dEw5dD9PHDDl5KNHkypgviJEo
oB3mN/1cNijOJ5I0vs5F2Wwm8CP1VGQQuCyeSanGeKcSBUksKvdQHuEMzcu2CRKP
jqUYYbyqqGyrimuEeibJBqWGB3PtfMJNk6FNURQh8sKkJlrFzN7P3zhvWXViwzTJ
oY2Bdz5wczHpsnj+9uqwvc0KTMW1GJHyXRHX79ztNxJIz9cFbjE=
=Nvto
-----END PGP SIGNATURE-----

--Ek6osrwvrJr1a4yE--

