Return-Path: <bpf+bounces-37387-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B39195511F
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 20:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F9AE1C228A6
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 18:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4031E1C3F23;
	Fri, 16 Aug 2024 18:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Niewnao7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3791BE861;
	Fri, 16 Aug 2024 18:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723834547; cv=none; b=Y1HOc95hXNJqGPQn4KcbvdmRs9eOW3dURLGp+CDDZ9v4pZMPAqJJ6fuCzbYceDw3S0AYe2exsl1AFvsMKwvIT9hM1EfplLsfMasvDiyfdULcP4fD0pZaUm2Sb7k56uhSsrkBhqFsvH1EVmLnU1nis083KsgBbM5OEZnQlTzL3V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723834547; c=relaxed/simple;
	bh=n8tFPheGQ/ucQVspJWimdx1mXcYOAojOe0mrEjVgMJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RerKYkKqni/U8fl+R88boXv1Mh8YP63V8WIAji0P/rlWQJUCgLv21njRjX4E7JQHtnXZgWdxaO41ex6YzEJHNZubtl4zq3Gsmx/uWesR0jI2rx4FxwbvVblLv89gGj/CjEDZdyp0GPm8RyRDhoTiAM1DGcujo+yGmi5jP912154=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Niewnao7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27E29C32782;
	Fri, 16 Aug 2024 18:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723834547;
	bh=n8tFPheGQ/ucQVspJWimdx1mXcYOAojOe0mrEjVgMJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Niewnao7moKKMCxKTARNHowGGFokUNSyZIXh+8fgWw3eAB0PzC1IlVLI+xH1yxz/n
	 1nI9PAbGxJfqBvZ6wdXibbsyWos74WCYyugNCgnZAps6jbso7TLVr75bCZmPmEgp/+
	 UAQoBAwb+BZgmvws4CZwxd42SWu2KtLfFKbQOdqasZV5YFBvq/9J8xm6OrqSY5kYGA
	 FN3m94xf8T0ICqG99sDdT8aEMhwvcsJX1sYPaTZUdx2Qis/5TDaZVNRLLOqjrI8ACq
	 a9WmUouSi1oVLbEgzi04V5+cco5P/CiYTGin2rSKBBl8k4BilHk7qFx8u4gRFJ0dHl
	 Tlo3ffxJDO+gg==
Date: Fri, 16 Aug 2024 20:55:41 +0200
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
Subject: Re: [PATCHv8 9/9] man2: Add uretprobe syscall page
Message-ID: <c7v4einpsvpswvj3rqn5esap2e5lpeiwacylqlzwdcp7slsgvg@jfmchkiqru4u>
References: <20240611112158.40795-1-jolsa@kernel.org>
 <20240611112158.40795-10-jolsa@kernel.org>
 <20240611233022.82e8abfa2ff0e43fd36798b2@kernel.org>
 <3pc746tolavkbac4n62ku5h4qqkbcinvttvcnkib6nxvzzfzym@k6vozf6totdw>
 <20240807162734.100d3b55@gandalf.local.home>
 <ygpwfyjvhuctug2bsibvc7exbirahojuivglcfjusw4rrqeqhc@44h23muvk3xb>
 <Zr-Gf3EEganRSzGM@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ppzmph6bpxetz6l5"
Content-Disposition: inline
In-Reply-To: <Zr-Gf3EEganRSzGM@krava>


--ppzmph6bpxetz6l5
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
Subject: Re: [PATCHv8 9/9] man2: Add uretprobe syscall page
References: <20240611112158.40795-1-jolsa@kernel.org>
 <20240611112158.40795-10-jolsa@kernel.org>
 <20240611233022.82e8abfa2ff0e43fd36798b2@kernel.org>
 <3pc746tolavkbac4n62ku5h4qqkbcinvttvcnkib6nxvzzfzym@k6vozf6totdw>
 <20240807162734.100d3b55@gandalf.local.home>
 <ygpwfyjvhuctug2bsibvc7exbirahojuivglcfjusw4rrqeqhc@44h23muvk3xb>
 <Zr-Gf3EEganRSzGM@krava>
MIME-Version: 1.0
In-Reply-To: <Zr-Gf3EEganRSzGM@krava>

On Fri, Aug 16, 2024 at 07:03:59PM GMT, Jiri Olsa wrote:
> On Fri, Aug 16, 2024 at 01:42:26PM +0200, Alejandro Colomar wrote:
> > Hi Steven, Jiri,
> >=20
> > On Wed, Aug 07, 2024 at 04:27:34PM GMT, Steven Rostedt wrote:
> > > Just in case nobody pinged you, the rest of the series is now in Linu=
s's
> > > tree.
> >=20
> > Thanks for the ping!
> >=20
> > I have prepared some tweaks to the patch (see below).
> > Also, I have some doubts.  The prototype shows that it has no arguments
> > (void), but the text said that arguments, if any, are arch-specific.
> > Does any arch have arguments?  Should we use a variadic prototype (...)?
>=20
> hi,
> there are no args for x86.. it's there just to note that it might
> be different on other archs, so not sure what man page should say
> in such case.. keeping (void) is fine with me

Hmmm, then I'll remove that paragraph.  If that function is implemented
in another arch and the args are different, we can change the manual
page then.

>=20
> >=20
> > Please add the changes proposed below to your patch, tweak anything if
> > you consider it appropriate) and send it as v10.
>=20
> it looks good to me, thanks a lot
>=20
> Acked-by: From: Jiri Olsa <jolsa@kernel.org>

Thanks!

Have a lovely day!
Alex

>=20
> jirka
>=20
> >=20
> > Have a lovely day!
> > Alex
> >=20
> >=20
> > diff --git i/man/man2/uretprobe.2 w/man/man2/uretprobe.2
> > index cf1c2b0d8..51b566998 100644
> > --- i/man/man2/uretprobe.2
> > +++ w/man/man2/uretprobe.2
> > @@ -7,50 +7,43 @@ .SH NAME
> >  uretprobe \- execute pending return uprobes
> >  .SH SYNOPSIS
> >  .nf
> > -.B int uretprobe(void)
> > +.B int uretprobe(void);
> >  .fi
> >  .SH DESCRIPTION
> > -The
> >  .BR uretprobe ()
> > -system call is an alternative to breakpoint instructions for triggerin=
g return
> > -uprobe consumers.
> > +is an alternative to breakpoint instructions
> > +for triggering return uprobe consumers.
> >  .P
> >  Calls to
> >  .BR uretprobe ()
> > -system call are only made from the user-space trampoline provided by t=
he kernel.
> > +are only made from the user-space trampoline provided by the kernel.
> >  Calls from any other place result in a
> >  .BR SIGILL .
> > -.SH RETURN VALUE
> > -The
> > +.P
> > +Details of the arguments (if any) passed to
> >  .BR uretprobe ()
> > -system call return value is architecture-specific.
> > +are architecture-specific.
> > +.SH RETURN VALUE
> > +The return value is architecture-specific.
> >  .SH ERRORS
> >  .TP
> >  .B SIGILL
> > -The
> >  .BR uretprobe ()
> > -system call was called by a user-space program.
> > +was called by a user-space program.
> >  .SH VERSIONS
> > -Details of the
> > -.BR uretprobe ()
> > -system call behavior vary across systems.
> > +The behavior varies across systems.
> >  .SH STANDARDS
> >  None.
> >  .SH HISTORY
> > -TBD
> > -.SH NOTES
> > -The
> > +Linux 6.11.
> > +.P
> >  .BR uretprobe ()
> > -system call was initially introduced for the x86_64 architecture
> > +was initially introduced for the x86_64 architecture
> >  where it was shown to be faster than breakpoint traps.
> >  It might be extended to other architectures.
> > -.P
> > -The
> > +.SH CAVEATS
> >  .BR uretprobe ()
> > -system call exists only to allow the invocation of return uprobe consu=
mers.
> > +exists only to allow the invocation of return uprobe consumers.
> >  It should
> >  .B never
> >  be called directly.
> > -Details of the arguments (if any) passed to
> > -.BR uretprobe ()
> > -and the return value are architecture-specific.
> >=20
> > --=20
> > <https://www.alejandro-colomar.es/>
>=20

--=20
<https://www.alejandro-colomar.es/>

--ppzmph6bpxetz6l5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAma/oKwACgkQnowa+77/
2zKQ0Q/7BMLDfH0gPaxMV9IWrTc2+lclJ8zMlgxZW7+zvmjLjTwGjQ4yFBxaVyhR
ZaBnZ1i4Dw5Fwx3ZU+eSxxlpe3URC2IdgboPptXAf1B1qoUFX15qsGBbGe2yViYs
kbOEH5n2TN499IbKujOwYZFgWXtU/dSeBqiOUOQ90CqWjcg0lqlltukhMve3MOAi
DDf1e1sXDXhyJWLxxsJ3LZ53Mq3US3yOeo4VRbvHq0vQaWAcS0TjjLImaYgshzGM
31cuvioBunIjaB70hcRM8vDncUaE2b04SmPufSX5aJ3HkBVyFCoDAHZ+7wqVVuE/
HyIMV5uxxa4qkiEqH2os2/Q0zQd/9KQ4skWj/XdbN1xqWRiKDZ01am9wByIXAmMS
zjyvW5evroJ8KQheSNY0rhAJQa6jYORyjqjhP24J2W9mfsEnPvS/0Bbyj9s40aXG
z9TkrDXq3PqzNJd55Astixv211W+Te7uxDxKTEEi5BTP/sTf4M+GOAhMwEo4RY5+
/F3IQKI3g0LtEU9IeQNSgwQ1f5x3wS4fM7fBwWOnlyVOyQ2BUVAMjitHYFrJsGCD
PFR+dfUckpyjVNDuf32O00hDeNCSHwxgHz8IUdau8A38IGsX44QxrInIuliptU1t
Y6aJ/Jp64Y7AWhYDSOLZsi5aVAG5/IJEamHQqjOiBHh69c8CM/k=
=1RZB
-----END PGP SIGNATURE-----

--ppzmph6bpxetz6l5--

