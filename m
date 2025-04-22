Return-Path: <bpf+bounces-56377-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C06FA95EC8
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 09:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7240D3A4A0B
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 07:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F55822D4C0;
	Tue, 22 Apr 2025 07:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u3vozAG4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F343BCA64;
	Tue, 22 Apr 2025 07:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745305227; cv=none; b=HQlm8zb9QX1G+BPWw4DdkmTZRthbfDESt3i9hJ3Hftb7JcK1YFSH2RnCVjzLCS1udDgpBHwi8Rz6nQEifWuL5E+Nj7PCYuON/7JpSGtxqbwZaXEF6kPJpYn0kYB7GMgvMKh9dmOeLdF0mP12Q8/1vmbe/tSW4ogZGyQ6yPTA12s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745305227; c=relaxed/simple;
	bh=9UlJ4qWtAN1HujoOVpR0ZontGjwWd/yVLwxzn+LakOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RA2bUrOP0M4JbgjzqzGvdU0ccZWlusQpfktpCEDaTWK7/t3d91jyeyVDBEczGWJZP7EI4rs9pDqH/CVbimelG9cnj9mZtaGPw/Eq4LDKgq8aXqDdqf36PX4iWgfULSkzEenWJHqrlcXzErHaXHH0MpL5ygQT/8UUznZCWaN6Ruo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u3vozAG4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67C63C4CEEA;
	Tue, 22 Apr 2025 07:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745305226;
	bh=9UlJ4qWtAN1HujoOVpR0ZontGjwWd/yVLwxzn+LakOo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u3vozAG4K/lyUG2o9UmOfmxzYlzQ7ZOkcFnRK0HFG/fdMVPHTI9PSMeKHepsLLmLV
	 DM8twuZcqbhtHAEhWOF+6d+UgJ88HUjNt/00s4v47CZXMW6QYLTYRJEB8zcFnBw+aw
	 fcnz6Lk0JO/QnKvEDUrLbxlC8We8jmBLcKVluIseOZIVRWL8iDBCH65qTqGyKPRbuM
	 LSQ+PEeOdOtZKGTjgNOjmjcg3X8eTA6iOchxY+hUR6/z9mZexWDP1pJy9tXv4PDo7Z
	 THT4msqE2adqjD2EIue3S6quKxY0cbskeB7A8dgBpHlALahfSVrr1Es27NRxklK8/S
	 XGhiZ7qP2TRow==
Date: Tue, 22 Apr 2025 09:00:17 +0200
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
Subject: Re: [PATCH 22/22] man2: Add uprobe syscall page
Message-ID: <42yzod7olktnj4meijj57j5peiojywo2d47d5gefnbmbwxfz4b@5ek6puondmck>
References: <20250421214423.393661-1-jolsa@kernel.org>
 <20250421214423.393661-23-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gecymmelcfbq645p"
Content-Disposition: inline
In-Reply-To: <20250421214423.393661-23-jolsa@kernel.org>


--gecymmelcfbq645p
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
Subject: Re: [PATCH 22/22] man2: Add uprobe syscall page
References: <20250421214423.393661-1-jolsa@kernel.org>
 <20250421214423.393661-23-jolsa@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250421214423.393661-23-jolsa@kernel.org>

Hi Jiri,

On Mon, Apr 21, 2025 at 11:44:22PM +0200, Jiri Olsa wrote:
> Adding man page for new uprobe syscall.
>=20
> Cc: Alejandro Colomar <alx@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  man/man2/uprobe.2    | 49 ++++++++++++++++++++++++++++++++++++++++++++
>  man/man2/uretprobe.2 |  2 ++
>  2 files changed, 51 insertions(+)
>  create mode 100644 man/man2/uprobe.2
>=20
> diff --git a/man/man2/uprobe.2 b/man/man2/uprobe.2
> new file mode 100644
> index 000000000000..2b01a5ab5f3e
> --- /dev/null
> +++ b/man/man2/uprobe.2
> @@ -0,0 +1,49 @@
> +.\" Copyright (C) 2024, Jiri Olsa <jolsa@kernel.org>
> +.\"
> +.\" SPDX-License-Identifier: Linux-man-pages-copyleft
> +.\"
> +.TH uprobe 2 (date) "Linux man-pages (unreleased)"
> +.SH NAME
> +uprobe
> +\-
> +execute pending entry uprobes
> +.SH SYNOPSIS
> +.nf
> +.B int uprobe(void);
> +.fi
> +.SH DESCRIPTION
> +.BR uprobe ()
> +is an alternative to breakpoint instructions
> +for triggering entry uprobe consumers.

What are breakpoint instructions?

> +.P
> +Calls to
> +.BR uprobe ()
> +are only made from the user-space trampoline provided by the kernel.
> +Calls from any other place result in a
> +.BR SIGILL .
> +.SH RETURN VALUE
> +The return value is architecture-specific.
> +.SH ERRORS
> +.TP
> +.B SIGILL
> +.BR uprobe ()
> +was called by a user-space program.
> +.SH VERSIONS
> +The behavior varies across systems.
> +.SH STANDARDS
> +None.
> +.SH HISTORY
> +TBD
> +.P
> +.BR uprobe ()
> +was initially introduced for the x86_64 architecture
> +where it was shown to be faster than breakpoint traps.
> +It might be extended to other architectures.
> +.SH CAVEATS
> +.BR uprobe ()
> +exists only to allow the invocation of entry uprobe consumers.
> +It should
> +.B never
> +be called directly.
> +.SH SEE ALSO
> +.BR uretprobe (2)

The pages are almost identical.  Should we document both pages in the
same page?

> diff --git a/man/man2/uretprobe.2 b/man/man2/uretprobe.2
> index bbbfb0c59335..bb8bf4e32e5d 100644
> --- a/man/man2/uretprobe.2
> +++ b/man/man2/uretprobe.2
> @@ -45,3 +45,5 @@ exists only to allow the invocation of return uprobe co=
nsumers.
>  It should
>  .B never
>  be called directly.
> +.SH SEE ALSO
> +.BR uprobe (2)
> --=20
> 2.49.0


How about something like the diff below?


Have a lovely day!
Alex

---
diff --git i/man/man2/uretprobe.2 w/man/man2/uretprobe.2
index bbbfb0c59..df0e5d92e 100644
--- i/man/man2/uretprobe.2
+++ w/man/man2/uretprobe.2
@@ -2,22 +2,28 @@
 .\"
 .\" SPDX-License-Identifier: Linux-man-pages-copyleft
 .\"
-.TH uretprobe 2 (date) "Linux man-pages (unreleased)"
+.TH uprobe 2 (date) "Linux man-pages (unreleased)"
 .SH NAME
+uprobe,
 uretprobe
 \-
-execute pending return uprobes
+execute pending entry or return uprobes
 .SH SYNOPSIS
 .nf
+.B int uprobe(void);
 .B int uretprobe(void);
 .fi
 .SH DESCRIPTION
+.BR uprobe ()
+is an alternative to breakpoint instructions
+for triggering entry uprobe consumers.
+.P
 .BR uretprobe ()
 is an alternative to breakpoint instructions
 for triggering return uprobe consumers.
 .P
 Calls to
-.BR uretprobe ()
+these system calls
 are only made from the user-space trampoline provided by the kernel.
 Calls from any other place result in a
 .BR SIGILL .
@@ -26,22 +32,28 @@ .SH RETURN VALUE
 .SH ERRORS
 .TP
 .B SIGILL
-.BR uretprobe ()
-was called by a user-space program.
+These system calls
+were called by a user-space program.
 .SH VERSIONS
 The behavior varies across systems.
 .SH STANDARDS
 None.
 .SH HISTORY
+.TP
+.BR uprobe ()
+TBD
+.TP
+.BR uretprobe ()
 Linux 6.11.
 .P
-.BR uretprobe ()
-was initially introduced for the x86_64 architecture
-where it was shown to be faster than breakpoint traps.
-It might be extended to other architectures.
+These system calls
+were initially introduced for the x86_64 architecture
+where they were shown to be faster than breakpoint traps.
+They might be extended to other architectures.
 .SH CAVEATS
-.BR uretprobe ()
-exists only to allow the invocation of return uprobe consumers.
-It should
+These system calls
+exist only to allow the invocation of
+entry or return uprobe consumers.
+They should
 .B never
 be called directly.


$ MANWIDTH=3D64 diffman-git
--- HEAD:man/man2/uretprobe.2
+++ ./man/man2/uretprobe.2
@@ -1,24 +1,30 @@
-uretprobe(2)          System Calls Manual          uretprobe(2)
+uprobe(2)             System Calls Manual             uprobe(2)
=20
 NAME
-       uretprobe - execute pending return uprobes
+       uprobe,  uretprobe - execute pending entry or return up=E2=80=90
+       robes
=20
 SYNOPSIS
+       int uprobe(void);
        int uretprobe(void);
=20
 DESCRIPTION
+       uprobe() is an alternative  to  breakpoint  instructions
+       for triggering entry uprobe consumers.
+
        uretprobe() is an alternative to breakpoint instructions
        for triggering return uprobe consumers.
=20
-       Calls  to  uretprobe() are only made from the user=E2=80=90space
-       trampoline provided by the kernel.  Calls from any other
-       place result in a SIGILL.
+       Calls to these system calls are only made from the user=E2=80=90
+       space trampoline provided by the kernel.  Calls from any
+       other place result in a SIGILL.
=20
 RETURN VALUE
        The return value is architecture=E2=80=90specific.
=20
 ERRORS
-       SIGILL uretprobe() was called by a user=E2=80=90space program.
+       SIGILL These  system  calls  were called by a user=E2=80=90space
+              program.
=20
 VERSIONS
        The behavior varies across systems.
@@ -27,16 +33,20 @@
        None.
=20
 HISTORY
-       Linux 6.11.
+       uprobe()
+              TBD
+
+       uretprobe()
+              Linux 6.11.
=20
-       uretprobe() was initially introduced for the x86_64  ar=E2=80=90
-       chitecture  where  it was shown to be faster than break=E2=80=90
-       point traps.  It might be extended  to  other  architec=E2=80=90
-       tures.
+       These system calls were  initially  introduced  for  the
+       x86_64  architecture  where they were shown to be faster
+       than breakpoint traps.  They might be extended to  other
+       architectures.
=20
 CAVEATS
-       uretprobe()  exists  only to allow the invocation of re=E2=80=90
-       turn uprobe consumers.  It should never  be  called  di=E2=80=90
-       rectly.
+       These system calls exist only to allow the invocation of
+       entry  or return uprobe consumers.  They should never be
+       called directly.
=20
-Linux man=E2=80=90pages (unreleased) (date)                uretprobe(2)
+Linux man=E2=80=90pages (unreleased) (date)                   uprobe(2)

--=20
<https://www.alejandro-colomar.es/>

--gecymmelcfbq645p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmgHPnoACgkQ64mZXMKQ
wqlClQ//Y7kkJ5hcR1998Pwe4aa6Mhwv059UBO9KejAyrGyUMKN/QkSiSZBJWYmd
S24z6ahnNCQiHfwld+4jtDr9ah4PuWyLzR5urQT/ciRCSgqtiS4+vmhqlejTBxfP
pfN9vkjL2GhtWn1RDvKvhBeavf8o9x+eisUq3yxrIfwZyBmkBbGsfdVtys8wytAQ
TB4YHpuiLpHnUYRjo7nzvY7eJoytWJxkyApJrNT81TW75kGdrOhmBDA4K0tOWZfx
TGgnfVUV15dUFKnCchE4yvKUlfLWNBZ06ecB8iN6xTwQ13cryrimmujaTYBMQxuX
p4lvPKoH5IIKI8fv4Cj7GghgPnX7BMZJvcsM4SJYE6pw5tSBe5M5P772Kg2tiDHI
4fM7HsNv/nvqpOqaRSYEtXfA2V6ObvsX9+uHtUzbxhEWSZtJt8T5B4idobUip67q
uMkymezMlHVC78nmaPQxgvG68iEcU7SuuJJnWm0FjIa5bru39sg9SMdSo7W/Y/7P
bSO8is507dRkenY9MOB4/n3Hsf64eB5atbF91vqywT3ADT1duu/fHPq+QYJWgX7w
0c1/Ix0gf4gNfuiiipq22+MHtkgSViv6O2p+hkdaaFjYbzKLnyQBFb2kZsgsUEDq
A1oF23V/hM+plakIUTzztBj00JtAHYDRR5CyCU8u1C/om8AnY94=
=VS/A
-----END PGP SIGNATURE-----

--gecymmelcfbq645p--

