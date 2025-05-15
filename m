Return-Path: <bpf+bounces-58371-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43071AB9230
	for <lists+bpf@lfdr.de>; Fri, 16 May 2025 00:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41D7D3A4D16
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 22:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271FE28AB0C;
	Thu, 15 May 2025 22:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LooUBX7d"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96721111BF;
	Thu, 15 May 2025 22:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747346945; cv=none; b=iFEIm7+4oz1XyiEmX9NV8uaLJTwny7JQdjoE0W9o8vteHCGnwRjTitYSbNnb+BHMf6emJ7X+L9aOu001acl7D43HdZV9DKVOwGFRM8VWqdgoLRrrxLFRS26ouvR99lnWSzshN/xpnAlFKDxURK5kGkJpMS4wJAen56e+G80G5r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747346945; c=relaxed/simple;
	bh=vTlG7bW65Ok7ET5LGiyJDLIbRa5aW61JZ/tK5bBDdSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oSVPh7YE867JLnZmvE2V7URpgqbw1nk/B9QXqs5yCBGjiOURsvej3J2Pra6Czyc6epjKrBSuVHAprI/+L+laDMnUiEhcpiCWLkoPHBJe9llNfkyadID98D2uu66ad3mpO1RK0nNIYOoRQeh1+p0dbnLF2xNXXWP/E2gpaqTVX/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LooUBX7d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2556DC4CEE7;
	Thu, 15 May 2025 22:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747346945;
	bh=vTlG7bW65Ok7ET5LGiyJDLIbRa5aW61JZ/tK5bBDdSg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LooUBX7dxfOwukJ8lPQw36DZUDAEOByaA7bTebM8sVgFtb/7kfH0H+4aHKsMD0VbL
	 Z/M4glKWvaTjZF1pzVrzAywXUKh0anbklwF3zwLd3nlZbHLFH5TXA+8cC4q5j6PJSZ
	 ecq9Nb1+03ekYnHfPJXZqVvTzzN6GnnVVsz21Tl/UaMEbFrx758XKuWh9sz/QW1nxF
	 G7MN06x7jo0Y5TcLJfMH2nfrWMH7UUWjteAOKd8Dygil0y4to9XKnYBPlriQytMuSf
	 zT0B6T/KnhMTq5i+0begaYcHwYDyLrHJhOycCYjZrSZ509d2fhLbEFECe4Ub4tpWa2
	 VMYDsUHFYV+kA==
Date: Fri, 16 May 2025 00:08:56 +0200
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
Subject: Re: [PATCHv2 22/22] man2: Add uprobe syscall page
Message-ID: <6elp7g4ne2pk3kai6f72ggkpi2eje7haptdisoraopkpf54n26@4sr54ptnwpex>
References: <20250515121121.2332905-1-jolsa@kernel.org>
 <20250515121121.2332905-23-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pifqnw6ycu3nbclf"
Content-Disposition: inline
In-Reply-To: <20250515121121.2332905-23-jolsa@kernel.org>


--pifqnw6ycu3nbclf
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
Subject: Re: [PATCHv2 22/22] man2: Add uprobe syscall page
References: <20250515121121.2332905-1-jolsa@kernel.org>
 <20250515121121.2332905-23-jolsa@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250515121121.2332905-23-jolsa@kernel.org>

Hi Jiri,

On Thu, May 15, 2025 at 02:11:19PM +0200, Jiri Olsa wrote:
> Changing uretprobe syscall man page to be shared with new
> uprobe syscall man page.
>=20
> Cc: Alejandro Colomar <alx@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

LGTM.


Have a lovely night!
Alex

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

--pifqnw6ycu3nbclf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmgmZfcACgkQ64mZXMKQ
wqkceQ/7Bb+KzoKdDAaf09Xgn3v/CKQZp6/++6O5NCi/XU9zW0gRKIAgqyuXjLdB
ZxkIAJ8b8+6SQePuEJIHasZs5LRlKPIQyW/rf36IRIuOCSWE9k4RzKpm4ODxHOig
Mss/Z288qN52D5j+3FYuoH+nRjv/Qq2Bc+DgYOwRN2FN2VzODIiDAxyh8rRSAqnB
ySQrcPTOv1uTjcQ4dNQO82zd3TswFtspzGj+h4hd8h7IFOYv+smNckgZLHVcr9bT
mVAjC5g3faAep/7i/jVMs6ZI0754sJrfWOdrXt7TrhnQPBots6vaYLjlpNnHbUn2
4ymhTPEcKdhxGMl6RG0d5JSpFmmiLlX1d5PYSOrr9948ON0WFmIoblmaNFwKkrSP
bQjLonBQUxGey5x0JxMFBiY4rvcuMJe5W5POaPT0Qfqb5yjjMSOvjFQAqv1TVY73
CpO0xgiERzEA9qUwHYiOU3OswEIhn/TZerpQQFG6cUbVihFPkiCJtIgndzZ9t+Me
pN1Q+a+S2kpYtR2bDrH21m+/1Ak9YGZaoEjHRB87Pz57Npk0SvLpqTUx0K/f0F9b
0wd7IXbwXfbY9KWkAVKNxWnrfLRfWfFcB+JIrmIP5dULNWiRJap5mLOMQjn16huE
Iapyp1diQhmx4O3KrqiNnc5rJs/p4mHPtkjXiRRjuh73x4/G7Q0=
=5zr5
-----END PGP SIGNATURE-----

--pifqnw6ycu3nbclf--

