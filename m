Return-Path: <bpf+bounces-28444-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFA68B9BC7
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 15:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65B60283E03
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 13:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C2F13C66F;
	Thu,  2 May 2024 13:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRcwr4M1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD097441E;
	Thu,  2 May 2024 13:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714657420; cv=none; b=F2Jwh7xuFHgHlQujvmkmdcrUTgAQA5xHCZ3BV7beDvCXLeCPCrukpjbNDlFb2hEKHO/CsKiPY7RvF8Tk41+rokR1jgjw51AroBF2IA9qsPlVPIx+50Ahl9OTyR20ywzFkyEZXqjQzb+5LakT/KDi2gNeL8Y9nfHbzKR/jW6qfyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714657420; c=relaxed/simple;
	bh=HtGp1xU+30x0HMmW9Qu2geRr7bEsMJ+1LRzEdacgOZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KsjajTHohT57T7ByD2B/b+cg/pZ7xTmKiSRSXxAyFBcvwE8bZUbFg4SnHFnbuc0Iunw0YnbgowZizc3TOoIJV59U/iIPuBDnilo3lEAjA9UOtlNESn5JFCqTpKQpK902NV3jaAwSl8x4i/ddPP1kFh1WKjMX8g5aSAk5gQb+vXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QRcwr4M1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CD6CC113CC;
	Thu,  2 May 2024 13:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714657420;
	bh=HtGp1xU+30x0HMmW9Qu2geRr7bEsMJ+1LRzEdacgOZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QRcwr4M1hCYR/BY50XFObmHG8s43BYAUBcoEseJHA3vgZxK8Nff7R0AXErOKGxKRe
	 tOsO6qL/BVFSeeWah0nHQke056L2xlMlQVLnEjMmK83xVdwqJ77ltNLJmKQcQJHVVr
	 z1Fs2FhkoIj6uexh1YJoyxq7tZDgWQ/EUm7KbytdqhN9wdvvSZ6nlN2kGIdIUmuClc
	 dWZRlHcxfLpDtVkyJ1tEqMGi/2aMY1dj39ZcNT2QYTvcdWWrS64zm3pela9U0GJIsp
	 X6HKBOGe+5A96ULnlboZRRCBLiIYifxPXJYDIb2x4I9rcyLOB3qAhcC8oavkDW7q7J
	 4qbUIiE1DcgiQ==
Date: Thu, 2 May 2024 15:43:27 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
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
Message-ID: <ZjOYf_g2qRrhDoQD@debian>
References: <20240502122313.1579719-1-jolsa@kernel.org>
 <20240502122313.1579719-8-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KBL3g/TAaXMZ7pyE"
Content-Disposition: inline
In-Reply-To: <20240502122313.1579719-8-jolsa@kernel.org>


--KBL3g/TAaXMZ7pyE
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Thu, 2 May 2024 15:43:27 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
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

On Thu, May 02, 2024 at 02:23:13PM +0200, Jiri Olsa wrote:
> Adding man page for new uretprobe syscall.
>=20
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  man2/uretprobe.2 | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 man2/uretprobe.2
>=20
> diff --git a/man2/uretprobe.2 b/man2/uretprobe.2
> new file mode 100644
> index 000000000000..08fe6a670430
> --- /dev/null
> +++ b/man2/uretprobe.2
> @@ -0,0 +1,45 @@
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
> +Kernel is using
> +.BR uretprobe()
> +syscall to trigger uprobe return probe consumers instead of using
> +standard breakpoint instruction.
> +

Please use .P instead of a blank.  See man-pages(7):

   Formatting conventions (general)
     Paragraphs should be separated by suitable markers (usually either
     .P or .IP).  Do not separate paragraphs using blank lines, as this
     results in poor rendering in some output formats  (such  as  Post=E2=
=80=90
     Script and PDF).

> +The uretprobe syscall is not supposed to be called directly by user, it'=
s allowed

s/by user/by the user/

> +to be invoked only through user space trampoline provided by kernel.

s/user space/user-space/

Missing a few 'the' too, here and in the rest of the page.

> +When called from outside of this trampoline, the calling process will re=
ceive
> +.BR SIGILL .
> +
> +.SH RETURN VALUE
> +.BR uretprobe()

You're missing a space here:

=2EBR uretprobe ()

> +return value is specific for given architecture.
> +
> +.SH VERSIONS
> +This syscall is not specified in POSIX,
> +and details of its behavior vary across systems.
> +.SH STANDARDS
> +None.

You could add a HISTORY section.

Have a lovely day!
Alex

> +.SH NOTES
> +.BR uretprobe()
> +syscall is initially introduced on x86-64 architecture, because doing sy=
scall
> +is faster than doing breakpoint trap on it. It might be extended to other
> +architectures.
> +
> +.BR uretprobe()
> +syscall exists only to allow the invocation of return uprobe consumers.
> +It should
> +.B never
> +be called directly.
> +Details of the arguments (if any) passed to
> +.BR uretprobe ()
> +and the return value are specific for given architecture.
> --=20
> 2.44.0
>=20
>=20

--=20
<https://www.alejandro-colomar.es/>
A client is hiring kernel driver, mm, and/or crypto developers;
contact me if interested.

--KBL3g/TAaXMZ7pyE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmYzmH8ACgkQnowa+77/
2zImYBAAlwYZZzeDBdbX0PzV0n1M313n43ulhVURXdHBIIN6w+rRyt/SCAFYRGq7
8qXhG38H0HX/vN/8pRUQ0r31xT7vlAYXllo9NKM/OOeiYdw48hOYWQuHNDqFAihd
o3trVoKeLHc47boWpIUljBWjchbT89ik2bp/WwGLFvZJFFjy8CmWEhQqIpMDRnP4
nfdTbhGb2GJLXy5FC7MO+oRn9uyOUEO+NTngNVduRpsWMYCZFEIKUdcMHJdFIROt
mPB2s455mopPg7paOSiGZpxSIln9gKUUzzlbznh5Q9K0MOIAwdW6MMAo6tEcBwtw
6mU67Q3plUykc3t43EpuDrlfKo3APtKIzSw5npSNOJ2p+XVqyB6rNGRPchB1yRNC
Wyk5j/ZqEidg1inH2+sw/vyRakophCPJZTL8N4BUqaiJkmTgS2YixQNieuzFP0gy
YHu9XCI/uu/tVJVCCSFT+PA/84WFr3uysyoGJKEtKAycBHLMdGFzU6xIj5I7PTwn
vkTPj8p5sJ1kK2lPhLdRs2ofwPfOI0ZI7P8DjLu7vKiHslF/CilPu7HfdQ/1T+/w
Z0MNCA2xPCClNJvIQGHF7ope0rhIGXHlHpFHaYa6nw+gCoJyStqR65zxvaptH0xK
UKDxMqU0hh5i9kjTrSlm9vgzpRklyKYlh2D1YUugCvP+OoOk1t8=
=gVaX
-----END PGP SIGNATURE-----

--KBL3g/TAaXMZ7pyE--

