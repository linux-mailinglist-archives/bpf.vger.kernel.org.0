Return-Path: <bpf+bounces-31842-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF78903F25
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 16:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 703F3B20D2B
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 14:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3295611C83;
	Tue, 11 Jun 2024 14:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DFGRzkqm"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07B5BE78;
	Tue, 11 Jun 2024 14:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718117372; cv=none; b=Yqk8MGbXD9UCSAx6rwULnvueU85/Tx5x0ejF0pTMfjuHrV23ZNPnzyY1C+dWa/icuON3nhfKUIiAwChdeVGRaRPJoia6qyHgzsyxSCLtFgcV3t7HVFDaPWhS8lGpj+RQ7Xp5o2RuJ7/1TtXef/gHB2QFebQJfiFaJEISXb5oeyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718117372; c=relaxed/simple;
	bh=xwBAa2VXwEQOXEY8u+5JBoVtxZwKr+T3QtnGwL+h+AU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CrBBs7FWkhxkwudL6cf6Rh2OqlZ44AQsLbnC/c8lNSVzQ582YjxaODRxYzlLEH0V4vnUSYHQqDh874PdicB6gllT2xvawyewkCMf0nGk96MJ9iN2ucmQhxRLRa+Dvpd0o3MftsXSIi9s2wiFAbs24Khn+fOXlnpxbEdwA4WSBIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DFGRzkqm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17867C2BD10;
	Tue, 11 Jun 2024 14:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718117371;
	bh=xwBAa2VXwEQOXEY8u+5JBoVtxZwKr+T3QtnGwL+h+AU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DFGRzkqmztG0H2AiISvbcJQh6xrrRJHuqxwoX2KkOURYtsVffkD1DiJB4rXLVfW/h
	 8NfRu+R79JVl3NbsbBnBYp1O0sC/SJN4+/mEdVd/eetccWSgpfIGMP1vgSNvQgL+oB
	 KgicsQFGgF+ckdGzruza9GinMatzf0WI8oKzXt24ky1w7cB01bK1sr1Ja0nxJ1c7V1
	 8vpBdxqeR4qrRXBEnwSVSn6wheeQncZepQh3b9A5rxqma1xVP/BVfoxCV7KjF4tGEK
	 FQ/cV4QS9HbSueYXjWkuEjqGR2cL11caV2d0lL120Eq64ShPLJIc93Oj9geZ+KK3Tw
	 3/PzAypWbs+7A==
Date: Tue, 11 Jun 2024 16:49:24 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Oleg Nesterov <oleg@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-man@vger.kernel.org, x86@kernel.org, bpf@vger.kernel.org, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, "Borislav Petkov (AMD)" <bp@alien8.de>, 
	Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>, 
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, Deepak Gupta <debug@rivosinc.com>
Subject: Re: [PATCHv8 9/9] man2: Add uretprobe syscall page
Message-ID: <3pc746tolavkbac4n62ku5h4qqkbcinvttvcnkib6nxvzzfzym@k6vozf6totdw>
References: <20240611112158.40795-1-jolsa@kernel.org>
 <20240611112158.40795-10-jolsa@kernel.org>
 <20240611233022.82e8abfa2ff0e43fd36798b2@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="i3ezgrvadl2gf5uu"
Content-Disposition: inline
In-Reply-To: <20240611233022.82e8abfa2ff0e43fd36798b2@kernel.org>


--i3ezgrvadl2gf5uu
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Oleg Nesterov <oleg@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-man@vger.kernel.org, x86@kernel.org, bpf@vger.kernel.org, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, "Borislav Petkov (AMD)" <bp@alien8.de>, 
	Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>, 
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, Deepak Gupta <debug@rivosinc.com>
Subject: Re: [PATCHv8 9/9] man2: Add uretprobe syscall page
References: <20240611112158.40795-1-jolsa@kernel.org>
 <20240611112158.40795-10-jolsa@kernel.org>
 <20240611233022.82e8abfa2ff0e43fd36798b2@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240611233022.82e8abfa2ff0e43fd36798b2@kernel.org>

Hi,

On Tue, Jun 11, 2024 at 11:30:22PM GMT, Masami Hiramatsu wrote:
> On Tue, 11 Jun 2024 13:21:58 +0200
> Jiri Olsa <jolsa@kernel.org> wrote:
>=20
> > Adding man page for new uretprobe syscall.
> >=20
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > Reviewed-by: Alejandro Colomar <alx@kernel.org>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
>=20
> This looks good to me.
>=20
> Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>=20
> And this needs to be picked by linux-man@ project.

Yup; please ping me when the rest is merged and I should pick it.

Have a lovely day!
Alex

>=20
> Thank you,
>=20
> > ---
> >  man/man2/uretprobe.2 | 56 ++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 56 insertions(+)
> >  create mode 100644 man/man2/uretprobe.2
> >=20
> > diff --git a/man/man2/uretprobe.2 b/man/man2/uretprobe.2
> > new file mode 100644
> > index 000000000000..cf1c2b0d852e
> > --- /dev/null
> > +++ b/man/man2/uretprobe.2
> > @@ -0,0 +1,56 @@
> > +.\" Copyright (C) 2024, Jiri Olsa <jolsa@kernel.org>
> > +.\"
> > +.\" SPDX-License-Identifier: Linux-man-pages-copyleft
> > +.\"
> > +.TH uretprobe 2 (date) "Linux man-pages (unreleased)"
> > +.SH NAME
> > +uretprobe \- execute pending return uprobes
> > +.SH SYNOPSIS
> > +.nf
> > +.B int uretprobe(void)
> > +.fi
> > +.SH DESCRIPTION
> > +The
> > +.BR uretprobe ()
> > +system call is an alternative to breakpoint instructions for triggerin=
g return
> > +uprobe consumers.
> > +.P
> > +Calls to
> > +.BR uretprobe ()
> > +system call are only made from the user-space trampoline provided by t=
he kernel.
> > +Calls from any other place result in a
> > +.BR SIGILL .
> > +.SH RETURN VALUE
> > +The
> > +.BR uretprobe ()
> > +system call return value is architecture-specific.
> > +.SH ERRORS
> > +.TP
> > +.B SIGILL
> > +The
> > +.BR uretprobe ()
> > +system call was called by a user-space program.
> > +.SH VERSIONS
> > +Details of the
> > +.BR uretprobe ()
> > +system call behavior vary across systems.
> > +.SH STANDARDS
> > +None.
> > +.SH HISTORY
> > +TBD
> > +.SH NOTES
> > +The
> > +.BR uretprobe ()
> > +system call was initially introduced for the x86_64 architecture
> > +where it was shown to be faster than breakpoint traps.
> > +It might be extended to other architectures.
> > +.P
> > +The
> > +.BR uretprobe ()
> > +system call exists only to allow the invocation of return uprobe consu=
mers.
> > +It should
> > +.B never
> > +be called directly.
> > +Details of the arguments (if any) passed to
> > +.BR uretprobe ()
> > +and the return value are architecture-specific.
> > --=20
> > 2.45.1
> >=20
>=20
>=20
> --=20
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
>=20

--=20
<https://www.alejandro-colomar.es/>

--i3ezgrvadl2gf5uu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmZoY/QACgkQnowa+77/
2zLi7g//SygtYxPIO3XxNGK1HqDeKlxAnMa0ale5cq5pCaUK+fKLca3uvGAbFpyZ
AJw9rCYsTl9DWWgFsHB4uundIDHkhdTtEo+elGsCM46f+3eAryF2M33s1/siVgJC
4DiwJvUZh+fpbF3SEM+0CcnbH2mVYl6AruPneTzCiCdPS25smnemcab2CNpnn5S1
U602hzBJvuxLidyxpSFA6tJVO5a0JSK3JnLCdM3V0qA+PSQHkzY/dZqtAFqR/UT3
iso3ObtxUJTdpenG5SjACL3T5jgo5OSVIbref8R7Vs7CWvcKrXVGYKIWOVkowwS+
+78TM5MCCAuIGHQ6CRa78SbxZgoe3GFiAHae2UANQX72YJ7taruL+RwBiTm73khg
ZB65vafxpZx4D5dwK9y18+y8nietf2Wgtnm/MUzJsLXiS7tTmrSJedgaOuZABsm3
VqPPsF2xKLk7Oc/NKFnjqKd6WnZk+t7lEFfQ5WaQ+v8wHoiFNp86i6GDNlsVejM7
HEPQEr5/h2Tl562TsiJmBqryspA0BveMgqIuXQjwmF+6dog0Kxvq9hmaafeqdsH6
/vrRRZQyWetqDYrs1fJZ/Nzc5DLpMQmjm/YcFDWDh/q6CM/c7/ib1HRhXJEpTobP
1/cexQ5DJJFzg+CdVjpX/Q+Ys0RwqHSETm/RG44i3ZIH7NWgwLQ=
=uPz5
-----END PGP SIGNATURE-----

--i3ezgrvadl2gf5uu--

