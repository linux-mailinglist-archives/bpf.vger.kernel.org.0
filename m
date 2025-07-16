Return-Path: <bpf+bounces-63498-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1793DB080CC
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 01:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AF083B07D6
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 23:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078492EF28F;
	Wed, 16 Jul 2025 23:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qR6dHzFj"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE6A3FE7;
	Wed, 16 Jul 2025 23:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752706912; cv=none; b=MZ/06XSUBv/J7HMWx6xQsoeeCFNIKRwVMV3xxm2f54PdTjPH+k4+OERJad7KJaIjJVaIYTpk2Ri9tUCIsQGebhF9Vj34+Wha9Ifjs2et7p5Ir0vpTfoZ8mfQtcNc7Rjff3ZtzXD8uN7EqCpYMcgyniRy+9kDRkbY5/QEGlrJSQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752706912; c=relaxed/simple;
	bh=eTSM2gEEJQ5T9pQPDPvIpmLJmmh1g3S1O9etB6ZruuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d7Z/8yQOH+2jmtVQTY/JWkKQr2MVPEYKwUxuwvGWSmR2iWia8p5m1fFqGESU0PR1g/KIBlaz3w99BSM0NdotFzIXyx9gR+XkKGj0K7NjhELkKLYQC/CMOlEM8yVw/J2CUEt/AB+iRnwP61lBBH59GVlY1jetAnh62WjdVJjqMgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qR6dHzFj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61178C4CEE7;
	Wed, 16 Jul 2025 23:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752706912;
	bh=eTSM2gEEJQ5T9pQPDPvIpmLJmmh1g3S1O9etB6ZruuI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qR6dHzFj+fN4ONLZqFvs7Gy7vsE2TI+UNv6Chfj0G+PSeRF/6Dd8l3wcredHKjb8A
	 OU9pUhBZQUtK3f0nTQf5gowTU0I/xtZQAOoVQ6Rl7AYfB3S46L+SvOzd50Wr3iMqZS
	 tlqwNCBatSdIJ8osvA88MUFcqZ813n/yzpUwa+xECkQ3yV1y4V8hPAesTPQR5BwOdD
	 4FtH/FnlAokS/zLeE210c0yIgXKTGVPgLGUF7e2rhCG3Hp76nLayFfOjlT5VIJz22y
	 1O1sTaZHeyU7/SWFb4/Xaes32s3h7Qop4Y8HY598qlwgl02RfKvFLXDqZ7ye7mPJWf
	 EIJ/6ANnmkt1Q==
Date: Wed, 16 Jul 2025 16:01:48 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Jens Remus <jremus@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, x86@kernel.org, Steven Rostedt <rostedt@kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, 
	Indu Bhagat <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, 
	Beau Belgrave <beaub@linux.microsoft.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, 
	Florian Weimer <fweimer@redhat.com>, Sam James <sam@gentoo.org>
Subject: Re: [RFC PATCH v1 07/16] unwind_user: Enable archs that do not
 necessarily save RA
Message-ID: <xgbpe46th7rbpslybo5xdt57ushlgwr5xyrq4epuft5nfrqms3@izeojto3wzu4>
References: <20250710163522.3195293-1-jremus@linux.ibm.com>
 <20250710163522.3195293-8-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250710163522.3195293-8-jremus@linux.ibm.com>

On Thu, Jul 10, 2025 at 06:35:13PM +0200, Jens Remus wrote:
> +++ b/arch/Kconfig
> @@ -450,6 +450,11 @@ config HAVE_UNWIND_USER_SFRAME
>  	bool
>  	select UNWIND_USER
>  
> +config HAVE_USER_RA_REG
> +	bool
> +	help
> +	  The arch passes the return address (RA) in user space in a register.

How about "HAVE_UNWIND_USER_RA_REG" so it matches the existing
namespace?

> @@ -310,6 +307,12 @@ static __always_inline int __find_fre(struct sframe_section *sec,
>  		return -EINVAL;
>  	fre = prev_fre;
>  
> +	if ((!IS_ENABLED(CONFIG_HAVE_USER_RA_REG) || !topmost) && !fre->ra_off) {
> +		dbg_sec_uaccess("fde addr 0x%x: zero ra_off\n",
> +				fde->start_addr);
> +		return -EINVAL;
> +	}

The topmost frame doesn't necessarily (or even likely) come from before
the prologue, or from a leaf function, so this check would miss the case
where a non-leaf function wrongly has !ra_off after its prologue.

Which in reality is probably fine, as there are other guardrails in
place to catch such bad sframe data.

But then do we think the !ra_off check is still worth the effort?  It
would be simpler to just always assume !ra_off is valid for the
CONFIG_HAVE_USER_RA_REG case.

I think I prefer the simplicity of removing the check, as the error
would be rare, and corrupt sframe would be caught in other ways.

> @@ -86,18 +88,28 @@ static int unwind_user_next(struct unwind_user_state *state)
>  
>  	/* Get the Stack Pointer (SP) */
>  	sp = cfa + frame->sp_val_off;
> -	/* Make sure that stack is not going in wrong direction */
> -	if (sp <= state->sp)
> +	/*
> +	 * Make sure that stack is not going in wrong direction.  Allow SP
> +	 * to be unchanged for the topmost frame, by subtracting topmost,
> +	 * which is either 0 or 1.
> +	 */
> +	if (sp <= state->sp - topmost)
>  		goto done;
>  
> -	/* Make sure that the address is word aligned */
> -	shift = sizeof(long) == 4 || compat_fp_state(state) ? 2 : 3;
> -	if ((cfa + frame->ra_off) & ((1 << shift) - 1))
> -		goto done;
>  
>  	/* Get the Return Address (RA) */
> -	if (unwind_get_user_long(ra, cfa + frame->ra_off, state))
> -		goto done;
> +	if (frame->ra_off) {
> +		/* Make sure that the address is word aligned */
> +		shift = sizeof(long) == 4 || compat_fp_state(state) ? 2 : 3;
> +		if ((cfa + frame->ra_off) & ((1 << shift) - 1))
> +			goto done;
> +		if (unwind_get_user_long(ra, cfa + frame->ra_off, state))
> +			goto done;
> +	} else {
> +		if (!IS_ENABLED(CONFIG_HAVE_USER_RA_REG) || !topmost)
> +			goto done;

I think this check is redundant with the one in __find_fre()?

-- 
Josh

