Return-Path: <bpf+bounces-60306-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A047AD4E69
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 10:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEB73189CCB2
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 08:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6853223ABAF;
	Wed, 11 Jun 2025 08:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jfwCpNrC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC98D221262;
	Wed, 11 Jun 2025 08:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749630642; cv=none; b=MBg/C2S8gxLfeOnfkt3SsixWkfPQm2gztfc56G3z2I+S7+rpLIcx29WhbMYVTa74LbhHHJHnZZDzuEatO5z2o3T9e3Mh2arplNoz2soy3wVbNqBrmPwrUB5a18DNdKbPJ9wNUEEYMwgt0s8LGs6l1HNXzQgLrJLsWJMwcGwHtKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749630642; c=relaxed/simple;
	bh=nG4MAcdamN7DYqmVn2ZlJNXQKWZHpSsi/rSOtqPEcyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MBX21LIuDcyoEECJ2AohHAPjuq1OiqlOTzSfg185IjdOrqCJ7mQQ3hK9Xegci+L841FxnAzk9KS3iYvTH3nHUjsbPqSEMUT2M2R0odrl43MRix8/JrlsVMNP5zV2NpMVDHK/JEJjwQvfx1tsjMFiCXlPFSp+/ryUp4suHSQsa5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jfwCpNrC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB381C4CEEE;
	Wed, 11 Jun 2025 08:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749630641;
	bh=nG4MAcdamN7DYqmVn2ZlJNXQKWZHpSsi/rSOtqPEcyY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jfwCpNrCcxqvPhKBaCbhYFsRFLlO18PPVHXLvw2HY9kVggJurf6gzE4REuwGtmzvm
	 ePt0eNwshe+wg4RUY6rMyiyDL7HAJLXGIN+hYutgjnbUvU2tSX4+QZRiJIQ9HiMkRG
	 Orv6XjeJ7JucWelpLZpaBUJ0GAN3IwPf6JyHXk0UaKtmP+QuEpyADkYEJ4jPGLobU0
	 925QkioSUiGC4JrKUws8vTjjvO9hHUR1mnG9aO2ZOp6AWegJHVzYd8u9SM/f5QPBB8
	 hnydKj2l4s9y/RJtJdjOBo1QJyT7ODPF4/rwj7YdZqhUP+4pcN4xe+a7HwOvucQSnJ
	 RQILoZkx/XSRQ==
Date: Wed, 11 Jun 2025 10:30:35 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, Song Liu <songliubraving@fb.com>, 
	Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, 
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Alan Maguire <alan.maguire@oracle.com>, 
	David Laight <David.Laight@aculab.com>, Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>, 
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCHv3 22/22] man2: Add uprobe syscall page
Message-ID: <k32xtpz5y4qdxe43fd6pgjypm3dvtn5lkokjkj7palxcqtxf5a@6crskezmzcch>
References: <20250605132350.1488129-1-jolsa@kernel.org>
 <20250605132350.1488129-23-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="adcwlsquorqhz652"
Content-Disposition: inline
In-Reply-To: <20250605132350.1488129-23-jolsa@kernel.org>


--adcwlsquorqhz652
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, Song Liu <songliubraving@fb.com>, 
	Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, 
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Alan Maguire <alan.maguire@oracle.com>, 
	David Laight <David.Laight@aculab.com>, Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>, 
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCHv3 22/22] man2: Add uprobe syscall page
References: <20250605132350.1488129-1-jolsa@kernel.org>
 <20250605132350.1488129-23-jolsa@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250605132350.1488129-23-jolsa@kernel.org>

On Thu, Jun 05, 2025 at 03:23:49PM +0200, Jiri Olsa wrote:
> Changing uretprobe syscall man page to be shared with new
> uprobe syscall man page.
>=20
> Cc: Alejandro Colomar <alx@kernel.org>

Reviewed-by: Alejandro Colomar <alx@kernel.org>

> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  man/man2/uprobe.2    |  1 +
>  man/man2/uretprobe.2 | 36 ++++++++++++++++++++++++------------
>  2 files changed, 25 insertions(+), 12 deletions(-)
>  create mode 100644 man/man2/uprobe.2
>=20
> diff --git a/man/man2/uprobe.2 b/man/man2/uprobe.2
> new file mode 100644
> index 000000000000..ea5ccf901591
> --- /dev/null
> +++ b/man/man2/uprobe.2
> @@ -0,0 +1 @@
> +.so man2/uretprobe.2
> diff --git a/man/man2/uretprobe.2 b/man/man2/uretprobe.2
> index bbbfb0c59335..df0e5d92e5ed 100644
> --- a/man/man2/uretprobe.2
> +++ b/man/man2/uretprobe.2
> @@ -2,22 +2,28 @@
>  .\"
>  .\" SPDX-License-Identifier: Linux-man-pages-copyleft
>  .\"
> -.TH uretprobe 2 (date) "Linux man-pages (unreleased)"
> +.TH uprobe 2 (date) "Linux man-pages (unreleased)"
>  .SH NAME
> +uprobe,
>  uretprobe
>  \-
> -execute pending return uprobes
> +execute pending entry or return uprobes
>  .SH SYNOPSIS
>  .nf
> +.B int uprobe(void);
>  .B int uretprobe(void);
>  .fi
>  .SH DESCRIPTION
> +.BR uprobe ()
> +is an alternative to breakpoint instructions
> +for triggering entry uprobe consumers.
> +.P
>  .BR uretprobe ()
>  is an alternative to breakpoint instructions
>  for triggering return uprobe consumers.
>  .P
>  Calls to
> -.BR uretprobe ()
> +these system calls
>  are only made from the user-space trampoline provided by the kernel.
>  Calls from any other place result in a
>  .BR SIGILL .
> @@ -26,22 +32,28 @@ The return value is architecture-specific.
>  .SH ERRORS
>  .TP
>  .B SIGILL
> -.BR uretprobe ()
> -was called by a user-space program.
> +These system calls
> +were called by a user-space program.
>  .SH VERSIONS
>  The behavior varies across systems.
>  .SH STANDARDS
>  None.
>  .SH HISTORY
> +.TP
> +.BR uprobe ()
> +TBD
> +.TP
> +.BR uretprobe ()
>  Linux 6.11.
>  .P
> -.BR uretprobe ()
> -was initially introduced for the x86_64 architecture
> -where it was shown to be faster than breakpoint traps.
> -It might be extended to other architectures.
> +These system calls
> +were initially introduced for the x86_64 architecture
> +where they were shown to be faster than breakpoint traps.
> +They might be extended to other architectures.
>  .SH CAVEATS
> -.BR uretprobe ()
> -exists only to allow the invocation of return uprobe consumers.
> -It should
> +These system calls
> +exist only to allow the invocation of
> +entry or return uprobe consumers.
> +They should
>  .B never
>  be called directly.
> --=20
> 2.49.0
>=20

--=20
<https://www.alejandro-colomar.es/>

--adcwlsquorqhz652
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmhJPqsACgkQ64mZXMKQ
wqm0/Q//W3YHaJa/TGiGlsMiUbKmmkHg/5ZAffu3BKgS+7NgyowntxwY5DAaC7Os
B3qeBQhmKwSrc/sJ1AqfV1TnIt/zjj0Ye9pKx4QE08JRCafo+lew5F4v/Op4mKhD
9LmiTUsPyojlXp+h/slFR+i58CWrrv4cltmiHgEkB9aj0UgjXrLr8SyMM5bT2WoF
YnG1QaxiZj0gWX1/05gMfu0GEJmqI/TXLbZ1I0JRQCo4Q2k76PdFTomNyAtnYh1w
SDICEh8zQhFqkDAC6pWp01gP+9L5LsSGpGxrtNtewrK62GBnWNECHJZcoTCHItlp
htZLgnyWMnjO3XWFH2d+bveD8+c0OinvF3RSAxb0BagoyH9OnOLa6tf2raAYkDkC
s3+1QHPbgLSlWlWfdJx8+wrYUlhR+eofikK/o5p8FtY6S8QhXEBalb+Tm+2/VJNP
0vEFBr0G53TjDG1rM/4xD633GxbCssRbiifHH04erwC/YVmu6ygb8DBwN76hWfRF
XXpFfDASRM9nFPWzCUTqRX1lcqQlAvqPSTyKpHCxF8eGyStOa7MooVClFYDvU94i
07jmvGiT4xRa3BeISdvubY4o/DG5HSkiDcjAyCwsITYliRIDfZhydu2icnRJZa3k
Wk4yqGz9sVv1G98JhoBvZ+G4CJS8aGjKolPzV3IAVTO0DaXogFg=
=6rmh
-----END PGP SIGNATURE-----

--adcwlsquorqhz652--

