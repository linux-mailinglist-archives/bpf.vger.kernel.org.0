Return-Path: <bpf+bounces-37401-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A9E9552CB
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 23:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B07D21F22ACD
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 21:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45851C689B;
	Fri, 16 Aug 2024 21:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sM2HJ8Gf"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293EB1C57B4;
	Fri, 16 Aug 2024 21:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723845406; cv=none; b=BhVuyn+WpG3hh8K/iMI3FB355tEcJXnmNzU3juap8DeyPCoj6N8v4WPpgqqzudiibgqitJSMFvXxlUrXrfLoZNPG/8joQwpqdcKUAJkMfWlOK3VPFQY1je2RUk3np8RMTcu5pN/UHLZ8TwZ/KwrdGUZxionn7rHZAuoRcDGweZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723845406; c=relaxed/simple;
	bh=iDFw77pu0YUWQ2wI2VHQzi76pQTpMJz3zqKX0bgLUgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n0L6QmA2djdJPoiZZ1qW41aysotQ+Rxl0weMVLGng/45UUqjFNpjlGfkyyZCi6Thi0CjWdN2sHK0mmFz3iRU6N3C83h9tEKOgupYHVXXQ6JuF8AY7YttcrtFdcCSBbqrKHryNg5YqPLxcCScqK0xUKQbhhGW5oNN1miJsRU/jOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sM2HJ8Gf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95121C32782;
	Fri, 16 Aug 2024 21:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723845405;
	bh=iDFw77pu0YUWQ2wI2VHQzi76pQTpMJz3zqKX0bgLUgA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sM2HJ8GfFXS0+FJtifnI0dbBBuJKDmYfeZLUV9JjkRaqV0T8oJaPfpyT696ASzWYU
	 yh+/eqSivlRIAUlBDCWvajswyJHITfN7X3P3sdK59YfU9ZVd/GItyGpI3NnixbATJ8
	 zYSewzkJqq8giure+UCdOdh9Lh/hiy2p3ApKLnmij9D2fux3jz8K87L2GHdhVxB2U4
	 DA60itAY11CNxjfO4t+1MwlG6szzcfU/nlaugb3AT9MALQMP4MQoWhC4OCVWZMbzR2
	 vxpPX9SjMz5gmbH1Tmf4n38fb/uNrJDt7cN6cZ3Svwsv48T7g1BvHBde04nO+zGoeQ
	 F41brTy75WumQ==
Date: Fri, 16 Aug 2024 23:56:39 +0200
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
Message-ID: <ht6hc5dbvgx3ny22pvhiazs7vxjhiockr6glpho5bpp6hrwn4f@oew3iu7a62j2>
References: <20240611112158.40795-1-jolsa@kernel.org>
 <20240611112158.40795-10-jolsa@kernel.org>
 <20240611233022.82e8abfa2ff0e43fd36798b2@kernel.org>
 <3pc746tolavkbac4n62ku5h4qqkbcinvttvcnkib6nxvzzfzym@k6vozf6totdw>
 <20240807162734.100d3b55@gandalf.local.home>
 <ygpwfyjvhuctug2bsibvc7exbirahojuivglcfjusw4rrqeqhc@44h23muvk3xb>
 <Zr-Gf3EEganRSzGM@krava>
 <c7v4einpsvpswvj3rqn5esap2e5lpeiwacylqlzwdcp7slsgvg@jfmchkiqru4u>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="plljbzi2pasmdt6h"
Content-Disposition: inline
In-Reply-To: <c7v4einpsvpswvj3rqn5esap2e5lpeiwacylqlzwdcp7slsgvg@jfmchkiqru4u>


--plljbzi2pasmdt6h
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
 <c7v4einpsvpswvj3rqn5esap2e5lpeiwacylqlzwdcp7slsgvg@jfmchkiqru4u>
MIME-Version: 1.0
In-Reply-To: <c7v4einpsvpswvj3rqn5esap2e5lpeiwacylqlzwdcp7slsgvg@jfmchkiqru4u>

Hi Jiri, Steven,

On Fri, Aug 16, 2024 at 08:55:47PM GMT, Alejandro Colomar wrote:
> > hi,
> > there are no args for x86.. it's there just to note that it might
> > be different on other archs, so not sure what man page should say
> > in such case.. keeping (void) is fine with me
>=20
> Hmmm, then I'll remove that paragraph.  If that function is implemented
> in another arch and the args are different, we can change the manual
> page then.
>=20
> >=20
> > >=20
> > > Please add the changes proposed below to your patch, tweak anything if
> > > you consider it appropriate) and send it as v10.
> >=20
> > it looks good to me, thanks a lot
> >=20
> > Acked-by: From: Jiri Olsa <jolsa@kernel.org>

I have applied your patch with the tweaks I mentioned, and added several
tags to the commit message.

It's currently here:
<https://www.alejandro-colomar.es/src/alx/linux/man-pages/man-pages.git/com=
mit/?h=3Dcontrib&id=3D977e3eecbb81b7398defc4e4f41810ca31d63c1b>

and will $soon be pushed to master.

Have a lovely night!
Alex


--=20
<https://www.alejandro-colomar.es/>

--plljbzi2pasmdt6h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAma/yxcACgkQnowa+77/
2zK97A//WrXlVppm6sreVtUPEfxfYfGTPE4VAT4lYZRcQ2HboHlCPNMLRXu9kv0G
wDgwW3P5KiI5XqGtB/oVo9osSWqt2yAQg5JHe2iUAnBjWpN4oDnpMgqFAw00j6J4
WqV6rsmm81NPfXi3G2ReSBarakNscIRk+IGrF3wso9zu3yLfVUrus80aATLD18vA
cnEXaJCKrk/gi4S4zeF/YDZsd6CTx6HYpYR4kI8Cgdu5Qhsj1cEN4SOzuRPg1wYB
tLQ9CWKnpJPOvt0x//7Iwj1dHwSEt69sRUmFs/Gwnapj+lRcRmc2Li3N3xn9oJCq
RUM0c4i9GAESo5UL6Mps96QZa9MRIHUHQDE7LTSz9Qm66vZt7GyOtHm28xgfrzGZ
syFEcocjr7viVkf8mCg3wX9o3KGkev+e7r8qQglBlIcn7ycSGnu5qq+qxKiFkbGp
leB1BXF0uTr6OHrOC2DKC2GcwdpkQjHxwNoOxyFSaDFb+5AWZLwu3JbmcqkGP6TX
0Xt+pEGTKLEDwV+IMa8v69L8DOM4Mf97SFvmbQjPbzm+0x0ZigzNnxpq7HeYdcV7
/x0FIG69F7zlEQUoTF8HMfl8fI9YBOdQ2cNzLIcpRdrtvt7Ap6GGKoKfNFMSr+4t
Rf8AS/JcqJqexPlBbSIuCBOW8P+4BnxCVI/mlmF3vu5SkZv+p8U=
=bM7I
-----END PGP SIGNATURE-----

--plljbzi2pasmdt6h--

