Return-Path: <bpf+bounces-63542-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C725B082AB
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 04:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C90E4E66F9
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 02:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C882A15D1;
	Thu, 17 Jul 2025 02:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9R//HVr"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4288C1BC58;
	Thu, 17 Jul 2025 02:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752717670; cv=none; b=ER0f4flVldEwvbj7439Nx/fUWlebBvEL6MmAD90CPl8L8zzrRS/9ZODArEXA1RwKPy8sWobwDSaOqowRF6ZFQozzRC0g9Vc+ONrPEb/40lt/Kth1L67SlCrdNlD9NmWZilJCOoBIMlBgSvdxz0aoFJsY7wTYfw1Jxnd2bp4VdTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752717670; c=relaxed/simple;
	bh=S7Y8uiFlZlxrGHyyuEem013pBJJXIkns4WysoiiW7tw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eH+TmGDNpy+vJejhsI1UZ/fYIPsT7sAyGcpqkNdv2feOcuKwiBVn6AKSfmHpdIsVls9E79K8X50AnlcQSiORKqMb6KSCZjXxu7wbEho2WdD525yUG3GVCsgfmnyORXNAT9NnCleZNXJYPF3SDjsIoapWoge5ZB6OyOTAfQNMxik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9R//HVr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AD18C4CEE7;
	Thu, 17 Jul 2025 02:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752717669;
	bh=S7Y8uiFlZlxrGHyyuEem013pBJJXIkns4WysoiiW7tw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T9R//HVrOII6pCWTJfXfKlkYXyHyCqHFyM1TkVjra35UBaj2gpa/tTm3D52lkxau5
	 f9ejgGEmKr3xF6mLy5OKecxnjcBTS+wUbz7K9c7zT1MyPrlWyyNyfwlol1xYRXjaN8
	 5MWbGNZ1OicJT9XJf8baTIqy11+LVC1N3vu771F4t9P9PyYsBl63SzrwHHDWNDsD2Y
	 +QWFZc/jMRDrc8gWvpkOnRbzc1mPfeLiAorsKaoKJoIQjN/Q+PrvqnaOkE5wn3BAL0
	 57NLM0brSk1WbgMvPII83wP0nc4bUy8UYnG7GR+ISrSpu0lPjyrEG/1Fsj+mG9t2X4
	 aIY5SnIlX5TPQ==
Date: Wed, 16 Jul 2025 19:01:06 -0700
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
Subject: Re: [RFC PATCH v1 08/16] unwind_user: Enable archs that save RA/FP
 in other registers
Message-ID: <oasyyga72yuiad7y2nzh7wcd7t7wmxnsbo2kuvsn5xsnuypewd@ukxxgdjbvegz>
References: <20250710163522.3195293-1-jremus@linux.ibm.com>
 <20250710163522.3195293-9-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250710163522.3195293-9-jremus@linux.ibm.com>

On Thu, Jul 10, 2025 at 06:35:14PM +0200, Jens Remus wrote:
> +#ifndef unwind_user_get_reg
> +
> +/**
> + * generic_unwind_user_get_reg - Get register value.
> + * @val: Register value.
> + * @regnum: DWARF register number to obtain the value from.
> + *
> + * Returns zero if successful. Otherwise -EINVAL.
> + */
> +static inline int generic_unwind_user_get_reg(unsigned long *val, int regnum)
> +{
> +	return -EINVAL;
> +}
> +
> +#define unwind_user_get_reg generic_unwind_user_get_reg
> +
> +#endif /* !unwind_user_get_reg */

I believe the traditional way to do this is to give the function the
same name as the define:

#ifndef unwind_user_get_reg
static inline int unwind_user_get_reg(unsigned long *val, int regnum)
{
	return -EINVAL;
}
#define unwind_user_get_reg unwind_user_get_reg
#endif

> +/**
> + * generic_sframe_set_frame_reginfo - Populate info to unwind FP/RA register
> + * from SFrame offset.
> + * @reginfo: Unwind info for FP/RA register.
> + * @offset: SFrame offset value.
> + *
> + * A non-zero offset value denotes a stack offset from CFA and indicates
> + * that the register is saved on the stack. A zero offset value indicates
> + * that the register is not saved.
> + */
> +static inline void generic_sframe_set_frame_reginfo(
> +	struct unwind_user_reginfo *reginfo,
> +	s32 offset)
> +{
> +	if (offset) {
> +		reginfo->loc = UNWIND_USER_LOC_STACK;
> +		reginfo->frame_off = offset;
> +	} else {
> +		reginfo->loc = UNWIND_USER_LOC_NONE;
> +	}
> +}

This just inits the reginfo struct, can we call it sframe_init_reginfo()?

Also the function comment seems completely superfluous as the function
is completely obvious.

Also the signature should match kernel style, something like:

static inline void
sframe_init_reginfo(struct unwind_user_reginfo *reginfo, s32 offset)

> @@ -98,26 +98,57 @@ static int unwind_user_next(struct unwind_user_state *state)
>  
>  
>  	/* Get the Return Address (RA) */
> -	if (frame->ra_off) {
> +	switch (frame->ra.loc) {
> +	case UNWIND_USER_LOC_NONE:
> +		if (!IS_ENABLED(CONFIG_HAVE_USER_RA_REG) || !topmost)
> +			goto done;
> +		ra = user_return_address(task_pt_regs(current));
> +		break;
> +	case UNWIND_USER_LOC_STACK:
> +		if (!frame->ra.frame_off)
> +			goto done;
>  		/* Make sure that the address is word aligned */
>  		shift = sizeof(long) == 4 || compat_fp_state(state) ? 2 : 3;
> -		if ((cfa + frame->ra_off) & ((1 << shift) - 1))
> +		if ((cfa + frame->ra.frame_off) & ((1 << shift) - 1))
>  			goto done;
> -		if (unwind_get_user_long(ra, cfa + frame->ra_off, state))
> +		if (unwind_get_user_long(ra, cfa + frame->ra.frame_off, state))
>  			goto done;
> -	} else {
> -		if (!IS_ENABLED(CONFIG_HAVE_USER_RA_REG) || !topmost)
> +		break;
> +	case UNWIND_USER_LOC_REG:
> +		if (!IS_ENABLED(CONFIG_HAVE_UNWIND_USER_LOC_REG) || !topmost)
>  			goto done;
> -		ra = user_return_address(task_pt_regs(current));
> +		if (unwind_user_get_reg(&ra, frame->ra.regnum))
> +			goto done;
> +		break;
> +	default:
> +		WARN_ON_ONCE(1);
> +		goto done;

The default case will never happen, can we make it a BUG()?

>  	}
>  
>  	/* Get the Frame Pointer (FP) */
> -	if (frame->fp_off && unwind_get_user_long(fp, cfa + frame->fp_off, state))
> +	switch (frame->fp.loc) {
> +	case UNWIND_USER_LOC_NONE:
> +		break;

The UNWIND_USER_LOC_NONE behavior is different here compared to above.
Do we also need UNWIND_USER_LOC_PT_REGS?

> +	case UNWIND_USER_LOC_STACK:
> +		if (!frame->fp.frame_off)
> +			goto done;
> +		if (unwind_get_user_long(fp, cfa + frame->fp.frame_off, state))
> +			goto done;
> +		break;
> +	case UNWIND_USER_LOC_REG:
> +		if (!IS_ENABLED(CONFIG_HAVE_UNWIND_USER_LOC_REG) || !topmost)
> +			goto done;

The topmost checking is *really* getting cumbersome, I do hope we can
get rid of that.

> +		if (unwind_user_get_reg(&fp, frame->fp.regnum))
> +			goto done;
> +		break;
> +	default:
> +		WARN_ON_ONCE(1);
>  		goto done;
> +	}

BUG(1) here as well.

>  	state->ip = ra;
>  	state->sp = sp;
> -	if (frame->fp_off)
> +	if (frame->fp.loc != UNWIND_USER_LOC_NONE)
>  		state->fp = fp;

Instead of the extra conditional here, can fp be initialized to zero?
Either at the top of the function or in the RA switch statement?

-- 
Josh

