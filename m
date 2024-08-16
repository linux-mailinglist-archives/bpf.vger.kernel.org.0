Return-Path: <bpf+bounces-37362-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B1195482F
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 13:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12F701C22BD1
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 11:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC231AE050;
	Fri, 16 Aug 2024 11:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZKfX+cDL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E822954BD4;
	Fri, 16 Aug 2024 11:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723808553; cv=none; b=pUqfLrmuS3UPGdMbFP6v3BIDAz6yFdJFP0gQhrLnXP3I+2KduoZgO4Vg8Upm51V47P8+BI0gpVdn1XzKQdqsRsbsV72O/IxeBIE3ZgfrvcqnLJ8tuEwTaCN3sYCZqn/NMD0ktlj8RI5c7HckBD55r1cF+SzERQZS6lcli+rPIzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723808553; c=relaxed/simple;
	bh=J+GSTdLpJEZfAk/f/yXm2p8gFmA0yCS+q76KUgXiJdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZfR+WWv6y0ZTJIlm/Td1zD/Wo+WR9vfTg72sRpzqC2C3lqeeyfV/vUacQZFqZaOI4ZH0Ll9uSTU+FScgpU4APIBfxNnQQbYYOLXOAFcxmCTQh+jjU5p+KHyP1o4UPLD8JU+R0siptEQ1wL4+oqdsZIwzMrFPaatF4ZZJdCv9Kko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZKfX+cDL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42484C4AF0D;
	Fri, 16 Aug 2024 11:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723808552;
	bh=J+GSTdLpJEZfAk/f/yXm2p8gFmA0yCS+q76KUgXiJdQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZKfX+cDLe9cWJg0Jsc/3IFVH4xssQrIdWDyXAdVBkooWS2TBxzTytsXYgh+KarcPq
	 SOdGJvmrOoHFMr1br8qx8sAr7lIAl8AMBgau8VodV9yQXD98IDOzQaEOMEEQwOXTFi
	 BVGM6D+6SEc3sh/DaeqzG5IOCMeUfE8n+fn3velhWq2ju0ry0LjdIUkyMnwz8mmI1M
	 SO8/UYZ7360FyeDOgQk65crCXPbEVqp+59srpUbtAW+vsLBetnOdpDXoLV1KIde5pp
	 7Kkq4r+M8kdWWjbQ+cGA2oqDi19LN14UpktOzg+AbJ8cZwkymF2msZHXuXAZ6HHYH+
	 IWFG7sEs1rG+w==
Date: Fri, 16 Aug 2024 13:42:26 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
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
Message-ID: <ygpwfyjvhuctug2bsibvc7exbirahojuivglcfjusw4rrqeqhc@44h23muvk3xb>
References: <20240611112158.40795-1-jolsa@kernel.org>
 <20240611112158.40795-10-jolsa@kernel.org>
 <20240611233022.82e8abfa2ff0e43fd36798b2@kernel.org>
 <3pc746tolavkbac4n62ku5h4qqkbcinvttvcnkib6nxvzzfzym@k6vozf6totdw>
 <20240807162734.100d3b55@gandalf.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o547xbwl3zxtiyuh"
Content-Disposition: inline
In-Reply-To: <20240807162734.100d3b55@gandalf.local.home>


--o547xbwl3zxtiyuh
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
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
 <3pc746tolavkbac4n62ku5h4qqkbcinvttvcnkib6nxvzzfzym@k6vozf6totdw>
 <20240807162734.100d3b55@gandalf.local.home>
MIME-Version: 1.0
In-Reply-To: <20240807162734.100d3b55@gandalf.local.home>

Hi Steven, Jiri,

On Wed, Aug 07, 2024 at 04:27:34PM GMT, Steven Rostedt wrote:
> Just in case nobody pinged you, the rest of the series is now in Linus's
> tree.

Thanks for the ping!

I have prepared some tweaks to the patch (see below).
Also, I have some doubts.  The prototype shows that it has no arguments
(void), but the text said that arguments, if any, are arch-specific.
Does any arch have arguments?  Should we use a variadic prototype (...)?

Please add the changes proposed below to your patch, tweak anything if
you consider it appropriate) and send it as v10.

Have a lovely day!
Alex


diff --git i/man/man2/uretprobe.2 w/man/man2/uretprobe.2
index cf1c2b0d8..51b566998 100644
--- i/man/man2/uretprobe.2
+++ w/man/man2/uretprobe.2
@@ -7,50 +7,43 @@ .SH NAME
 uretprobe \- execute pending return uprobes
 .SH SYNOPSIS
 .nf
-.B int uretprobe(void)
+.B int uretprobe(void);
 .fi
 .SH DESCRIPTION
-The
 .BR uretprobe ()
-system call is an alternative to breakpoint instructions for triggering re=
turn
-uprobe consumers.
+is an alternative to breakpoint instructions
+for triggering return uprobe consumers.
 .P
 Calls to
 .BR uretprobe ()
-system call are only made from the user-space trampoline provided by the k=
ernel.
+are only made from the user-space trampoline provided by the kernel.
 Calls from any other place result in a
 .BR SIGILL .
-.SH RETURN VALUE
-The
+.P
+Details of the arguments (if any) passed to
 .BR uretprobe ()
-system call return value is architecture-specific.
+are architecture-specific.
+.SH RETURN VALUE
+The return value is architecture-specific.
 .SH ERRORS
 .TP
 .B SIGILL
-The
 .BR uretprobe ()
-system call was called by a user-space program.
+was called by a user-space program.
 .SH VERSIONS
-Details of the
-.BR uretprobe ()
-system call behavior vary across systems.
+The behavior varies across systems.
 .SH STANDARDS
 None.
 .SH HISTORY
-TBD
-.SH NOTES
-The
+Linux 6.11.
+.P
 .BR uretprobe ()
-system call was initially introduced for the x86_64 architecture
+was initially introduced for the x86_64 architecture
 where it was shown to be faster than breakpoint traps.
 It might be extended to other architectures.
-.P
-The
+.SH CAVEATS
 .BR uretprobe ()
-system call exists only to allow the invocation of return uprobe consumers.
+exists only to allow the invocation of return uprobe consumers.
 It should
 .B never
 be called directly.
-Details of the arguments (if any) passed to
-.BR uretprobe ()
-and the return value are architecture-specific.

--=20
<https://www.alejandro-colomar.es/>

--o547xbwl3zxtiyuh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAma/OyEACgkQnowa+77/
2zJDCxAAhQ1Ra2KloypCCqkmA4dXbkaqQJyIuJ1Nmls+E5zYqiF2zKYI6OZ9njtq
Ev/Fx+c59cm2r0DQtu04LfbzrymBLncErRofjceDWAU7Z28hYtFtVEs+Rx4Mdrxu
5LwnSiLgTv0rwjj3rz91liRasAxBRmDBx/llAHrwO3fYQk2Zp2Y0UrT3GT02moSG
f/LXSx/DihVQzoZJPvDC0hy+sYix6Lkr/hZRdlBSclfQJJsm1xv79N0qG6lKCgP9
Au4DW4Pvjfw1xeYtfHAHLvw2cyvHUcHvLyH2uvX5F+33kk1hLGf81DjraL3wFsyj
z0uDA/TkNHrLiMu8fxNnG6CBxasaZYk8U7EsUFqtC3gVMleDZFxLzuSrRI4xprBe
rxJ/SxkVl0pLOGMMlj+Q3yjilgPQqBklZK1fOwqdNQ7fWAKR2K7vRXj+fRb84Xck
O3LJg02hlH8Oquh3QmlGFl9QaMZn8FHV16Rpk4Vl3q+Y3I48rg8n+bhT7vuhOK+H
4G5yEMLB5BfmQ5DSDlpSmN7jQlK9NVoPgk9yV09LkBtlW29pDvJXaTth9H0Is3ci
DxTJySu/USezOarYS/AUjbTGJT943EtGj5KMHwcixS6ub+CsufI6CAnyXkfJMvzt
CdseNjZW7MfslXPlP3fpVehUSUXSA36CDIH754UV4xZLoxrOHs0=
=J420
-----END PGP SIGNATURE-----

--o547xbwl3zxtiyuh--

