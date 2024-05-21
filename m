Return-Path: <bpf+bounces-30161-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A78E28CB4F4
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 22:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D643285949
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 20:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D987149C74;
	Tue, 21 May 2024 20:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p3R4WUv+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D2C7F49F;
	Tue, 21 May 2024 20:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716324883; cv=none; b=Exc5fpEEO6ibZO9gT8yGC+HqOELd0Yh+IHRUF3lxhZwCtJlM4fWXJe2hQcUt18zWp2hE7pP81AnzGGNDv2y1tvPhSk6h+FSxvTmgnMSMHwnF9hJ15/hxfPpIPrQT6JRmZAvV81ZNIyg9p/yGU9y01zM/SPfAa3YvwndHRttVvaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716324883; c=relaxed/simple;
	bh=VTAL4Yq+4Yy+z4E1P9/Al5QouIguhAlWKRwZdyxg52M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LgoOYfwjNTV6X+e1N4uzm9lBoe62enYByhJsIvrYKZFLey/6pWkDkte8uGfMfOhkdj5KsAmYUGWOFl7tVYyJWRa7K1tYjK4OG4IJ4JbDURnTtyZ1R1cheYs/suUu4ZPjMyCheA/YKJI8Ve35CohK2sqP3n2KdWyXUQ683/28HH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p3R4WUv+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36512C2BD11;
	Tue, 21 May 2024 20:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716324882;
	bh=VTAL4Yq+4Yy+z4E1P9/Al5QouIguhAlWKRwZdyxg52M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p3R4WUv+kc/24r928j3pVsWQOsB1N0CAxB+kS0SRf4sVQt1P9rmjuVCATNP0BskN1
	 UZIVV9K7bwQUYHqrOXICo9acVb86X28vnucfNX8pN5GatbMsIk0f5sw8mE6fZMdbqG
	 Qgsx526A/UNVH23sOavMMLmrVuc868S5NZG8jZXc6/g1op8sjrp/yITmzUKqMcUMVq
	 NN5bbt5OxsyDoNO5lGYeauRkDgyHp1zkBlHteWrZqXlLzMckRJMjQZpFxLBl7kC0Yj
	 HQuBnFAv+gOK+J4pyHzNRpgzudw1kYi1YZq7PuQsRtItIM2CJm2REQVv4DlgHov6YS
	 bhwkDrRP2/m0Q==
Date: Tue, 21 May 2024 22:54:36 +0200
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
Message-ID: <o5pkz3eenii6p6sm7dl2fsgy4fqqaq2qbn2rbxddhkvaarvwgm@dkjjknb44qp2>
References: <20240521104825.1060966-1-jolsa@kernel.org>
 <20240521104825.1060966-10-jolsa@kernel.org>
 <j6qxudmvwccpqnle4evabxbswdygmx35bgqwhemuzsjs5iuydv@fk2iumwucifx>
 <ZkyKKwfhNZxrGWsa@krava>
 <Zk0C_vm3T2L79-_W@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ccdqohwx336ci7ml"
Content-Disposition: inline
In-Reply-To: <Zk0C_vm3T2L79-_W@krava>


--ccdqohwx336ci7ml
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
MIME-Version: 1.0
In-Reply-To: <Zk0C_vm3T2L79-_W@krava>

Hi Jirka,

On Tue, May 21, 2024 at 10:24:30PM GMT, Jiri Olsa wrote:
> how about the change below?

Much better.  I still have a few comments below.  :-)

>=20
> thanks,
> jirka
>=20
>=20
> ---
> diff --git a/man/man2/uretprobe.2 b/man/man2/uretprobe.2
> new file mode 100644
> index 000000000000..959b7a47102b
> --- /dev/null
> +++ b/man/man2/uretprobe.2
> @@ -0,0 +1,55 @@
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
> +.BR SIGILL

This should be a tagged paragraph, preceeded with '.TP'.  See any manual
page with an ERRORS section for an example.

Also, BR is Bold alternating with Roman, but this is just bold, so it
should use '.B'.

=2ETP
=2EB SIGILL

> +The
> +.BR uretprobe ()
> +system call was called by user.
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
> +system call was initially introduced for the x86_64 architecture where i=
t was shown

We have a strong-ish limit at column 80.  Please break after
'architecture', which is a clause boundary.

Have a lovely night!
Alex

> +to be faster than breakpoint traps.
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
>=20

--=20
<https://www.alejandro-colomar.es/>

--ccdqohwx336ci7ml
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmZNCgsACgkQnowa+77/
2zJIQQ/7BAgwH2hW3N8bbbBv85y8HA8GsAtUZDSO9flK1GsoZlmwsR8dbWJmbE1v
395U8q21JqlOEGlk98ES9n2ssEsq5dLEx1eIPlYuADlc0+PFOEJRhBnXS/td1+mM
ADJm+e9tyc8PIpuB1ysLeeRfmovWUDxEubm5q+qzJ+n1k5ZMiGmLPmDor5afLDyR
iug3Yyv4+5g+FzqE23vudpJ5pcv6eRVVbYuZ8gwIpY7hfwVvQ4MQed339XL8bZun
qa2mKy0dMME/SNc5rDKoJ4t0KvbfWGH6UKM9iXVEu8xZZuGnxyjmpwGBYNxBz4c1
UN3ep5j+ufqlTydspd2vQYZEN6cOTRONd5bC0kH0ZAFJsbIlyxX7IOBtjbbKRv59
o23M6bfUEpz7sfxdrODpP45gYV5JQTz3/GCRv8rGiDN1SlkCZl7wXK0Zigop5l+D
VxDs+E57YtcLQYU1u8qHJpMQsjzEC6uIOtI6/0FBHMeoon6JKxBZZrYZO3YfmWwd
8ZQSJctgTL//aQQRLc7a/fCuscWtWA03QWuCmFxy6020l9Hkkh43bzUyQRFRx543
WdjLslYj0AQkvOmhxp1jEXEhqDCYQBDvyqoS24gIFOAEraSIlRYJK9bcDwhRVHcz
IZKE8tzJ81Dtlkfzi2H59LciIAvVKXze40tjsHL2hWfhfgJVQgE=
=lj6M
-----END PGP SIGNATURE-----

--ccdqohwx336ci7ml--

