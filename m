Return-Path: <bpf+bounces-30287-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA268CBFC6
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 13:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09D661C21BC9
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 11:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748FA824A3;
	Wed, 22 May 2024 10:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rfCayVRX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D681C811FB;
	Wed, 22 May 2024 10:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716375593; cv=none; b=XddNN+Ib6sgLfkobDkNEGrn8PRhoweRmhGIaRL6X75SzdWWzjZbI4jx3qWjY0AOqY6K1NxutHSKhx+lly+K/K5+tRhRVLj5qBJu1LNLUgzgbwBUJIbloKWP2hdaVlbY5oqt1u4OG0vYGQrQmasmTYR9YiyrL+qlAuydVPK/QL/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716375593; c=relaxed/simple;
	bh=XaYc48nWQB8aUx5U/Gx056TfLX/HyLCwVB+Go/sd0LU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ms318d4mQ/ElncX/FXSGoHpFJfQe6Aol8BzDQNCea2D474jC7K8DrL7ugpX4oK/UL/DEv7G+OOuL8bEUqifIaeuLmHB+cc43vX5B5GSzouYt8iBJSjUPyLpIEmrMkd40Dqu7qpgB7im1HXNzVW+41GJI4ypoQYTiUJ4Gd69WGQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rfCayVRX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44C89C2BD11;
	Wed, 22 May 2024 10:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716375592;
	bh=XaYc48nWQB8aUx5U/Gx056TfLX/HyLCwVB+Go/sd0LU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rfCayVRXLu7f1ARZtR4PKS7x50GnD3g4npuB1isGy4VpvuQyXQk+E4kkFKZESF42S
	 cwkfrPSlpZvX8oQEDMDqZwzs1wPgQo1RbXKXCRTvKhMPATgKhYNgBopZYq1C5DcQZT
	 6uWb2Kqova43fqDiJ2MVj9Chw+M/Lm1r2hTWGB6KmhN9JgRnf817QWWtIuh0/VEMlq
	 +O4xTxeJDugSw46UEwtdmrPdAGII9yuub6sGt6+rrspIIqIkIXZS+zcqoPU63g1BIg
	 K6bKhfvN4Ujuc8fGNoTpbLgmRrHSFrT/MDvj8ZGvODJwcvkT/GGGHZAdweUj+TXV5j
	 YvMM1ZveMv+pQ==
Date: Wed, 22 May 2024 12:59:46 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-man@vger.kernel.org, x86@kernel.org, bpf@vger.kernel.org, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, "Borislav Petkov (AMD)" <bp@alien8.de>, 
	Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>, 
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, Deepak Gupta <debug@rivosinc.com>
Subject: Re: [PATCHv6 9/9] man2: Add uretprobe syscall page
Message-ID: <vqw4ibum2hfnxjkfp7io5ugmwaeok4tynchi3utmzp6xnsmjig@fbjxwmm6u6v3>
References: <20240521104825.1060966-1-jolsa@kernel.org>
 <20240521104825.1060966-10-jolsa@kernel.org>
 <j6qxudmvwccpqnle4evabxbswdygmx35bgqwhemuzsjs5iuydv@fk2iumwucifx>
 <ZkyKKwfhNZxrGWsa@krava>
 <Zk0C_vm3T2L79-_W@krava>
 <o5pkz3eenii6p6sm7dl2fsgy4fqqaq2qbn2rbxddhkvaarvwgm@dkjjknb44qp2>
 <Zk2k0ttdR7abKSuv@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="q46npir5oijusqfi"
Content-Disposition: inline
In-Reply-To: <Zk2k0ttdR7abKSuv@krava>


--q46npir5oijusqfi
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-man@vger.kernel.org, x86@kernel.org, bpf@vger.kernel.org, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, "Borislav Petkov (AMD)" <bp@alien8.de>, 
	Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>, 
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, Deepak Gupta <debug@rivosinc.com>
Subject: Re: [PATCHv6 9/9] man2: Add uretprobe syscall page
References: <20240521104825.1060966-1-jolsa@kernel.org>
 <20240521104825.1060966-10-jolsa@kernel.org>
 <j6qxudmvwccpqnle4evabxbswdygmx35bgqwhemuzsjs5iuydv@fk2iumwucifx>
 <ZkyKKwfhNZxrGWsa@krava>
 <Zk0C_vm3T2L79-_W@krava>
 <o5pkz3eenii6p6sm7dl2fsgy4fqqaq2qbn2rbxddhkvaarvwgm@dkjjknb44qp2>
 <Zk2k0ttdR7abKSuv@krava>
MIME-Version: 1.0
In-Reply-To: <Zk2k0ttdR7abKSuv@krava>

Hi Jirka,

On Wed, May 22, 2024 at 09:54:58AM GMT, Jiri Olsa wrote:
> ok, thanks
>=20
> jirka
>=20
>=20
> ---
> diff --git a/man/man2/uretprobe.2 b/man/man2/uretprobe.2
> new file mode 100644
> index 000000000000..5b5f340b59b6
> --- /dev/null
> +++ b/man/man2/uretprobe.2
> @@ -0,0 +1,56 @@
> +.\" Copyright (C) 2024, Jiri Olsa <jolsa@kernel.org>
> +.\"
> +.\" SPDX-License-Identifier: Linux-man-pages-copyleft
> +.\"
> +.TH uretprobe 2 (date) "Linux man-pages (unreleased)"
> +.SH NAME
> +uretprobe \- execute pending return uprobes
> +.SH SYNOPSIS
> +.nf
> +.B int uretprobe(void)
> +.fi
> +.SH DESCRIPTION
> +The
> +.BR uretprobe ()
> +system call is an alternative to breakpoint instructions for triggering =
return
> +uprobe consumers.
> +.P
> +Calls to
> +.BR uretprobe ()
> +system call are only made from the user-space trampoline provided by the=
 kernel.
> +Calls from any other place result in a
> +.BR SIGILL .
> +.SH RETURN VALUE
> +The
> +.BR uretprobe ()
> +system call return value is architecture-specific.
> +.SH ERRORS
> +.TP
> +.B SIGILL
> +The
> +.BR uretprobe ()
> +system call was called by user.

Maybe 'a user-space program'?
Anyway, LGTM.  Thanks!

	Reviewed-by: Alejandro Colomar <alx@kernel.org>

Have a lovely day!
Alex

> +.SH VERSIONS
> +Details of the
> +.BR uretprobe ()
> +system call behavior vary across systems.
> +.SH STANDARDS
> +None.
> +.SH HISTORY
> +TBD
> +.SH NOTES
> +The
> +.BR uretprobe ()
> +system call was initially introduced for the x86_64 architecture
> +where it was shown to be faster than breakpoint traps.
> +It might be extended to other architectures.
> +.P
> +The
> +.BR uretprobe ()
> +system call exists only to allow the invocation of return uprobe consume=
rs.
> +It should
> +.B never
> +be called directly.
> +Details of the arguments (if any) passed to
> +.BR uretprobe ()
> +and the return value are architecture-specific.

--=20
<https://www.alejandro-colomar.es/>

--q46npir5oijusqfi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmZN0BwACgkQnowa+77/
2zK38w/9FtV+ULMKrpnQryO/Z1ZIRX+42KpBbiPHaiHHSyuos+4ywVOTOXGd26C2
a/u972Scjw0DfwezA/t7sRKALOzBHD2L2+Y3U6HfD9AlEWQ2PY8AfcMB260c46jf
opjOZRsBLQMtcJY6RBzXNH7eiACs5XO+IpD7BCj8EJ+HbLD53Ogk722A6C4kcD8o
N4id9bgR9Z4RG28TFkP+rsq+LmQqTrWDkdHzC6cd+CLnu4wb7wszCiuTubRzBfsw
Mm85aU3fCl9BKaKJCblneLhB4/FU1VkDIFscx//fT8VIEUKPh3Pepv0HFVyHrpFP
8hsUo/DyhJyfWllz0ubmmf9VODKoMHtVYP4HGl/JVPYGdhHc+YCjUsV/IaIUnElC
XOpCQHsN6GDYboebdCb+QhiD0CsVlhiTzAz1jbeJA/eY76sW4z44I5PQAouICbI5
G8W4xjDa2SVqJVlzGmfdnfOote6pzyvep++igKI06UYPT8LJ2pRDRQZ1/DFLQWc5
tnwu3XlQCRG7lSMKi9qPI7AEOvmnxilnYPhVXrvnjjYMwHVs36n8efsBB16K62hv
nDjVWWoV6FxDdQjsYI9kSfB4zTrERIQzP0H64xqr4f6pgtZVnmkNPU+c84QMhv6E
UWiI7K5BeWmloEQ8uuyqW4RLwCWF3891HxXTH6baw3WdpFYsdpU=
=uEkW
-----END PGP SIGNATURE-----

--q46npir5oijusqfi--

