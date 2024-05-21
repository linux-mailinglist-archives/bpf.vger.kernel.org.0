Return-Path: <bpf+bounces-30111-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B183A8CAD6D
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 13:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A275B22B87
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 11:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D04757FC;
	Tue, 21 May 2024 11:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZRhqxz+l"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DF56CDA9;
	Tue, 21 May 2024 11:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716291393; cv=none; b=jq6dfWqRZaCm+lmAo7u57D+nDS3Gox6y2EQvTmeWcScrr1FcNaiBx7ySFVAk1YMx/vKETBBw+BG3yoy/6dDT8Vj/1+wkteXZUpWU9IcniCrDPK9/BkNFvOIeMngNpul3TFAM2kC+T+6XwajvTioH7l+pBy55M68upIOtiqIwRgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716291393; c=relaxed/simple;
	bh=XEPKXW7Vgf5WzTvEfGTZ49CgvombIwhtV4ZTh33ljRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g4yIzXU3HoZ5Fgr10DLNFDtQk07JaxQHPwXDfnwBbjRaPPwtEmDUqXPfEZEA59Ca482d0rk3KtHf4oMnIRaB6nJXoGqcQtQNHWs/OnCzclK7jgYeW4ukbFQmZphZ+weY8D/K5VE9YsklAzfKCMxCqBTPiM8GfIRUq7mutJsiIqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZRhqxz+l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F2A0C2BD11;
	Tue, 21 May 2024 11:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716291392;
	bh=XEPKXW7Vgf5WzTvEfGTZ49CgvombIwhtV4ZTh33ljRs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZRhqxz+lpAUotP/bMOLsaC6UdZN3w0VobwkxqHtDDiwiI97eGBLzf0rLGXQwvT06J
	 ZPOJCUUjW2elog1mc0BbpjCP5OZ/Q3C1XnoQMYiGQ9BIidsNX++xy2y8tQCRTKq1Rw
	 Zxta5pZUPA0qolzvTjZujbmmQoO/Gs6FcXmoYhF0BcfYTMfhMZtzJUUkWU5leFDcLh
	 qaPqCpggB2CbjH+6qKCNqPE3i/4Vv/de4eibPX257I2DSJmkUfb6oUISZW1CaZN6/5
	 o6gvLYTmdqv6/JTXn2O6l11XWvvlnDumgX3w4Qvf1II4un8GqA8i2Mv0T/so/zSuTE
	 aBuI//N15ulEg==
Date: Tue, 21 May 2024 13:36:25 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
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
Message-ID: <j6qxudmvwccpqnle4evabxbswdygmx35bgqwhemuzsjs5iuydv@fk2iumwucifx>
References: <20240521104825.1060966-1-jolsa@kernel.org>
 <20240521104825.1060966-10-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sord6gh2s3weogw7"
Content-Disposition: inline
In-Reply-To: <20240521104825.1060966-10-jolsa@kernel.org>


--sord6gh2s3weogw7
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
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
MIME-Version: 1.0
In-Reply-To: <20240521104825.1060966-10-jolsa@kernel.org>

Hi Jiri,

On Tue, May 21, 2024 at 12:48:25PM GMT, Jiri Olsa wrote:
> Adding man page for new uretprobe syscall.
>=20
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  man2/uretprobe.2 | 50 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 man2/uretprobe.2
>=20
> diff --git a/man2/uretprobe.2 b/man2/uretprobe.2
> new file mode 100644
> index 000000000000..690fe3b1a44f
> --- /dev/null
> +++ b/man2/uretprobe.2
> @@ -0,0 +1,50 @@
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

What header file provides this system call?

> +.SH DESCRIPTION
> +The
> +.BR uretprobe ()
> +syscall is an alternative to breakpoint instructions for
> +triggering return uprobe consumers.
> +.P
> +Calls to
> +.BR uretprobe ()
> +suscall are only made from the user-space trampoline provided by the ker=
nel.

s/suscall/system call/

> +Calls from any other place result in a
> +.BR SIGILL .

Maybe add an ERRORS section?

> +

We don't use blank lines; it causes a groff(1) warning, and other
problems.  Instead, use '.P'.

> +.SH RETURN VALUE
> +The
> +.BR uretprobe ()
> +syscall return value is architecture-specific.
> +

=2EP

> +.SH VERSIONS
> +This syscall is not specified in POSIX,

Redundant with "STANDARDS: None.".

> +and details of its behavior vary across systems.

Keep this.

> +.SH STANDARDS
> +None.
> +.SH HISTORY
> +TBD
> +.SH NOTES
> +The
> +.BR uretprobe ()
> +syscall was initially introduced for the x86_64 architecture where it wa=
s shown
> +to be faster than breakpoint traps. It might be extended to other archit=
ectures.

Please use semantic newlines.

$ MANWIDTH=3D72 man man-pages | sed -n '/Use semantic newlines/,/^$/p'
   Use semantic newlines
     In the source of a manual page, new sentences should be started on
     new lines, long sentences should be split  into  lines  at  clause
     breaks  (commas,  semicolons, colons, and so on), and long clauses
     should be split at phrase boundaries.  This convention,  sometimes
     known as "semantic newlines", makes it easier to see the effect of
     patches, which often operate at the level of individual sentences,
     clauses, or phrases.

> +.P
> +The
> +.BR uretprobe ()
> +syscall exists only to allow the invocation of return uprobe consumers.

s/syscall/system call/

> +It should
> +.B never
> +be called directly.
> +Details of the arguments (if any) passed to
> +.BR uretprobe ()
> +and the return value are architecture-specific.
> --=20
> 2.44.0

Have a lovely day!
Alex

--=20
<https://www.alejandro-colomar.es/>

--sord6gh2s3weogw7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmZMhzkACgkQnowa+77/
2zLxzw/+Nr7TcDedetItg4H5lLs1D0c6PkeDczXCv/HgvC3U929LIyVMR3YxbcRY
DZEvb2xL2lZuP5tBisHE+uA4f9mnPztAv6siRWgf3BhpBokLZ06TIek17DHo2kwL
ZL7a1xdI6XxduGBQv3U348TLH7y6ya3KXlAlt3tYaLh2vbmcsyo5WFUZNqfGDO4R
k05CXBvDmG5aotK5h/KWZSdvYn5auZh7le7Rg2qW1yP6hkK7eDz4Sx7bP0+IVIy7
lJVOMj0MhuVr8ZyX/CtP9cQBJWUw/9ZVByudEF8SFvkJTgBBK7oxypTGcN1I47Yd
JKQIMH64nKxvrP6k1Ba3PMwmrEDGdZnS1OB9X8rEdjoHYhOqcQszSo1tM3cyQqzA
5v8LHWZ1tr+AxMUw0igiK0TCAeqZYS2c0sKRavzEx2nZ/BCOGDwMBSQ1Ax4vjiWl
/J6H74GM+gz1oRGMwVpAAFHXDQjCarblNEpNSYah+jd83f2TtmkF84unPRAnNDbp
Pe/z3k1mC5veFjCvKFF13SbhS/vm59wSsxi61Kz0rVAsgZSNdk2q+VJIaablNv8w
M7fa44YS37NQ29zhZRmKtTHGXOAuMyKYx+3ZdPUh+bvH6Ovip677+OUkDD8BwY9t
2dU6YQNKk+I3dmmIgnCkfUb+cOrOMTAkRA1Tl6zIR1nDGiJa5Bk=
=SNMs
-----END PGP SIGNATURE-----

--sord6gh2s3weogw7--

