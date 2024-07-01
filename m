Return-Path: <bpf+bounces-33472-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2781791DAC0
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 10:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3CD628648A
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 08:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44AE984A28;
	Mon,  1 Jul 2024 08:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ayeZXJn/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65116839FE;
	Mon,  1 Jul 2024 08:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719824243; cv=none; b=KhyvMa5xORg2ScF7Qy1pgiIqqReDuWAdFOukbjjyoqlSGi3whG1W6te0t5zLQV2LMa08uWtIWcwJwAY68PHsoj4lKAabLgpiON/XlNtZX7b2X5YClM942KOquaSlRfvBLI21yH3TDTz1YP7DH3GGmpLtC2Jol4W1hSnoxyhrVjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719824243; c=relaxed/simple;
	bh=x9qyqzYLzzPN6prYn4VihZJVecigNgYi6pofpHOU8fk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=TC8Debu07wt/Eg2nfpg4Bkwh4ISuy+aQtcWZsNtf41y77zGyBp9qjx6z8EY2O7rSgpTCQzsF1JZGwwWMTBw77FJF/gYSmZsmAXaxMgNLX+DiTqj+JTFOuhmiNAJcazKq7iauTFTDgOt48iv3yDHnEV22t6ANxcsDiGjp4glC3XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ayeZXJn/; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2c7bf925764so1980747a91.0;
        Mon, 01 Jul 2024 01:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719824242; x=1720429042; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s3EvXgsoc3O6to34ZUw4BNKot/Hf+C3K+5hMVbVjdas=;
        b=ayeZXJn/otxyB2xO9AUifBbHzkzPgUKNq8GHXhS33+lw2oZRXAI3DIzEHzTc21BbVY
         Z+BH7X5MCqBCeQ5ugXF8dw1Zjp8J1J838CL0k2Gu+b1OGHzZD2GExgh318aN4fq5qG2T
         6l1ZHvU0BrXcYUq49XHZ0Iuo5jTqE66jWcqdYphkkvfJ7jrVXz9OST01eku8IQqEghch
         Qlx9HeElBfSo96v3j92ErbtD2+sNL9b1MEvZh6ZBCqT0ah0R8BJhHmKAgu1+jVNvWE+c
         9tPpBg63kirPgc1uoUmZkIu4E4EMTa7DtEty1Cy/TALma0o4RYfd5Xho16gcI/RfWmjJ
         jWlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719824242; x=1720429042;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s3EvXgsoc3O6to34ZUw4BNKot/Hf+C3K+5hMVbVjdas=;
        b=nObmSeuLY76sXmyyYbk/XRGTV6WtuSPUdl9ehDsBh0pzQxz4FuRVWk+roGM9KD2v/T
         /I4FWUflY/Vcc7krriwUmTSSMxgp7svSMT/eZnoa0njiZs4bghACsJKsIb5O2hSmcJlR
         NZqhn09jHuw2uRh4+pdlEnyTuWNwq+YDM8m4BCUndoJGIwA/kNxrc1V+8fxHptAoRTwZ
         +CiB6z5XXr/wAWyOaZ/buSvjNwxGHg7htEwwmji8NWaLXpmdYdVOnZbJ0iwBxDJLfgeA
         lMTy6mT7nunDNKWepSOQRsd5qtpSyjc/ccN4UeUHSvjbGjWuMwcEzTeRyBvtvIUPT7Lz
         G+gA==
X-Forwarded-Encrypted: i=1; AJvYcCU/v5W+nGiljXKrk/Sxg5s4KcGylwimVU3y757aRyDze8lGq22nBcVoBbcbtFjyV8ZwoP18XeKzNraEULI/ohk4Djo3bY5TaItx1J1rEbKgOr3oUoFGLukLP4Exf3D84h+Io0ElkqzG
X-Gm-Message-State: AOJu0YwJTx4eGLwmSIK5ZItoL9LYsas+8gseMOK+bIVuWDNy7wVAJYIF
	Jut3w5+cLb5GdfO9tDFQ9gmjAzDyE7e/lD/AeS26xWuTyf4X8EMs
X-Google-Smtp-Source: AGHT+IEDvSU0oo0hBRimVQFNxsC3NUrVirQPsrFJamW6UMpKXqrPbz0/TBmfJjHNrLF1XSL0utuzIw==
X-Received: by 2002:a17:90a:5145:b0:2c8:660d:cc2 with SMTP id 98e67ed59e1d1-2c93d6f286cmr3927079a91.4.1719824241618;
        Mon, 01 Jul 2024 01:57:21 -0700 (PDT)
Received: from localhost (118-211-5-80.tpgi.com.au. [118.211.5.80])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91d3b9f2csm6205352a91.35.2024.07.01.01.57.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 01:57:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 01 Jul 2024 18:57:12 +1000
Message-Id: <D2E2T58ECN7G.1CFVM4AI1ZESG@gmail.com>
Cc: "Michael Ellerman" <mpe@ellerman.id.au>, "Steven Rostedt"
 <rostedt@goodmis.org>, "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Christophe Leroy" <christophe.leroy@csgroup.eu>, "Masahiro Yamada"
 <masahiroy@kernel.org>, "Mark Rutland" <mark.rutland@arm.com>, "Alexei
 Starovoitov" <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "John Fastabend" <john.fastabend@gmail.com>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Song Liu" <song@kernel.org>, "Jiri Olsa"
 <jolsa@kernel.org>
Subject: Re: [RFC PATCH v3 02/11] powerpc/ftrace: Unify 32-bit and 64-bit
 ftrace entry code
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Naveen N Rao" <naveen@kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-trace-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <cover.1718908016.git.naveen@kernel.org>
 <f2d5d66d47b28474b6224613787757fed3e92d3d.1718908016.git.naveen@kernel.org>
In-Reply-To: <f2d5d66d47b28474b6224613787757fed3e92d3d.1718908016.git.naveen@kernel.org>

On Fri Jun 21, 2024 at 4:54 AM AEST, Naveen N Rao wrote:
> On 32-bit powerpc, gcc generates a three instruction sequence for
> function profiling:
> 	mflr	r0
> 	stw	r0, 4(r1)
> 	bl	_mcount
>
> On kernel boot, the call to _mcount() is nop-ed out, to be patched back
> in when ftrace is actually enabled. The 'stw' instruction therefore is
> not necessary unless ftrace is enabled. Nop it out during ftrace init.
>
> When ftrace is enabled, we want the 'stw' so that stack unwinding works
> properly. Perform the same within the ftrace handler, similar to 64-bit
> powerpc.
>
> For 64-bit powerpc, early versions of gcc used to emit a three
> instruction sequence for function profiling (with -mprofile-kernel) with
> a 'std' instruction to mimic the 'stw' above. Address that scenario also
> by nop-ing out the 'std' instruction during ftrace init.

Cool! Could 32-bit use the 2-insn sequence as well if it had
-mprofile-kernel, out of curiosity?

>
> Signed-off-by: Naveen N Rao <naveen@kernel.org>
> ---
>  arch/powerpc/kernel/trace/ftrace.c       | 6 ++++--
>  arch/powerpc/kernel/trace/ftrace_entry.S | 4 ++--
>  2 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/arch/powerpc/kernel/trace/ftrace.c b/arch/powerpc/kernel/tra=
ce/ftrace.c
> index d8d6b4fd9a14..463bd7531dc8 100644
> --- a/arch/powerpc/kernel/trace/ftrace.c
> +++ b/arch/powerpc/kernel/trace/ftrace.c
> @@ -241,13 +241,15 @@ int ftrace_init_nop(struct module *mod, struct dyn_=
ftrace *rec)
>  		/* Expected sequence: 'mflr r0', 'stw r0,4(r1)', 'bl _mcount' */
>  		ret =3D ftrace_validate_inst(ip - 8, ppc_inst(PPC_RAW_MFLR(_R0)));
>  		if (!ret)
> -			ret =3D ftrace_validate_inst(ip - 4, ppc_inst(PPC_RAW_STW(_R0, _R1, 4=
)));
> +			ret =3D ftrace_modify_code(ip - 4, ppc_inst(PPC_RAW_STW(_R0, _R1, 4))=
,
> +						 ppc_inst(PPC_RAW_NOP()));
>  	} else if (IS_ENABLED(CONFIG_MPROFILE_KERNEL)) {
>  		/* Expected sequence: 'mflr r0', ['std r0,16(r1)'], 'bl _mcount' */
>  		ret =3D ftrace_read_inst(ip - 4, &old);
>  		if (!ret && !ppc_inst_equal(old, ppc_inst(PPC_RAW_MFLR(_R0)))) {
>  			ret =3D ftrace_validate_inst(ip - 8, ppc_inst(PPC_RAW_MFLR(_R0)));
> -			ret |=3D ftrace_validate_inst(ip - 4, ppc_inst(PPC_RAW_STD(_R0, _R1, =
16)));
> +			ret |=3D ftrace_modify_code(ip - 4, ppc_inst(PPC_RAW_STD(_R0, _R1, 16=
)),
> +						  ppc_inst(PPC_RAW_NOP()));

So this is the old style path... Should you check the mflr validate
result first? Also do you know what GCC version, roughly? Maybe we
could have a comment here and eventually deprecate it.

You could split this change into its own patch.

>  		}
>  	} else {
>  		return -EINVAL;
> diff --git a/arch/powerpc/kernel/trace/ftrace_entry.S b/arch/powerpc/kern=
el/trace/ftrace_entry.S
> index 76dbe9fd2c0f..244a1c7bb1e8 100644
> --- a/arch/powerpc/kernel/trace/ftrace_entry.S
> +++ b/arch/powerpc/kernel/trace/ftrace_entry.S
> @@ -33,6 +33,8 @@
>   * and then arrange for the ftrace function to be called.
>   */
>  .macro	ftrace_regs_entry allregs
> +	/* Save the original return address in A's stack frame */
> +	PPC_STL		r0, LRSAVE(r1)
>  	/* Create a minimal stack frame for representing B */
>  	PPC_STLU	r1, -STACK_FRAME_MIN_SIZE(r1)
> =20
> @@ -44,8 +46,6 @@
>  	SAVE_GPRS(3, 10, r1)
> =20
>  #ifdef CONFIG_PPC64
> -	/* Save the original return address in A's stack frame */
> -	std	r0, LRSAVE+SWITCH_FRAME_SIZE+STACK_FRAME_MIN_SIZE(r1)
>  	/* Ok to continue? */
>  	lbz	r3, PACA_FTRACE_ENABLED(r13)
>  	cmpdi	r3, 0

That seems right to me.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

