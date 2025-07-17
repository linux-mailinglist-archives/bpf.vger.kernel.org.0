Return-Path: <bpf+bounces-63547-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDAEB08323
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 04:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23E1D7A7962
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 02:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F031E0083;
	Thu, 17 Jul 2025 02:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gt/XfUAL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A461C5D72;
	Thu, 17 Jul 2025 02:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752720652; cv=none; b=qpGImts2mO4jRU15DZ9tdk9q+wKQxB96AtrtaGO1unhykIOLunQz0LkNvtZcm8XfrcQ5vSKy7fatiJE9ffFV7GuFoiiAZyR+P7SMJg+ac8drTqWqknlKwojb1/u4hZpDlY8pEGMXV4NrtjTO/I6Nd2mVBSWWyx+wucwFQp0swKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752720652; c=relaxed/simple;
	bh=rVW7x1cWdtS/+/SD3/qe8rX3MeF4ZR7nrYkxM81heB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D/i3kVijrFOWg30UwbfW1cMiCVkgci3pnQox8EDVQVUJLk7DAqHaSFYW7aMumbV7O9o6yCdnXc2ogzn/407nwqR1OfBLfUHGBzp9RTB9gJD6nO6cWq1I+JbUHKcJwqrCXO+BjsGC+qTYJLtA67Z3Zh9buUFmCOZyDlhYPleIzDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gt/XfUAL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BB7EC4CEE7;
	Thu, 17 Jul 2025 02:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752720652;
	bh=rVW7x1cWdtS/+/SD3/qe8rX3MeF4ZR7nrYkxM81heB8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gt/XfUALD6phvu3PhD4sn3bhFzRUDMN41ZizMV1/fxQYrgO9wDV2v4QbhN5V9QEvm
	 Vhc+k+oGh4hFmz1mUKhqIBCTOi0ZWb6YzrTXGWyM9UgVm9zAkYIzVuvk3x3ZZiOtGN
	 7+0FKJ+5HK/weLKGAsLuRB0MSEJZ3U5QSge2Qfq2KCuJQge5+ZSgKZgJD9m5OIPVd2
	 aeMygstZ/rE/0famjY3rrz6zo3Mn3nZW45FLXVN0O7Tt2LwnGcVgRUM1ahDSjduKZP
	 FnpiA0vN5ZchF2xhc2sarOQierrru+TGxft98hnrjjYngCRoXCUoAfdYIMnxGCsVoj
	 +rhVql9u3xnFg==
Date: Wed, 16 Jul 2025 19:50:48 -0700
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
Message-ID: <3he7rlcdchkwjtpbdt5khqflg4dipuvkneydhju2jjgs2ujqoh@2rpb6dutdogx>
References: <20250710163522.3195293-1-jremus@linux.ibm.com>
 <20250710163522.3195293-9-jremus@linux.ibm.com>
 <oasyyga72yuiad7y2nzh7wcd7t7wmxnsbo2kuvsn5xsnuypewd@ukxxgdjbvegz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <oasyyga72yuiad7y2nzh7wcd7t7wmxnsbo2kuvsn5xsnuypewd@ukxxgdjbvegz>

On Wed, Jul 16, 2025 at 07:01:09PM -0700, Josh Poimboeuf wrote:
> >  	state->ip = ra;
> >  	state->sp = sp;
> > -	if (frame->fp_off)
> > +	if (frame->fp.loc != UNWIND_USER_LOC_NONE)
> >  		state->fp = fp;
> 
> Instead of the extra conditional here, can fp be initialized to zero?
> Either at the top of the function or in the RA switch statement?

So it's been a while since I looked at the original code, but I actually
think there's a bug here.

There's a subtlety in the original code:

	if (frame->fp_off && unwind_get_user_long(fp, cfa + frame->fp_off, state))
		goto done;

	state->ip = ra;
	state->sp = cfa;
	if (frame->fp_off)
		state->fp = fp;

	arch_unwind_user_next(state);

Note that unlike !frame->ra_off, !frame->fp_off does NOT end the unwind.
That only means the FP offset is unknown for the current frame.  Which
is a perfectly valid condition, e.g. if the function doesn't have frame
pointers or if it's before the prologue.

In that case, the unwind should continue, and state->fp's existing value
should be preserved, as it might already have a valid value from a
previous frame.

So the following is wrong:

	case UNWIND_USER_LOC_STACK:
		if (!frame->fp.frame_off)
			goto done;
		if (unwind_get_user_long(fp, cfa + frame->fp.frame_off, state))
			goto done;
		break;

Instead of having !fp.frame_off stopping the unwind, it should just
break out of the switch statement and keep going.

And that means the following is also wrong:

	state->ip = ra;
	state->sp = sp;
	if (frame->fp.loc != UNWIND_USER_LOC_NONE)
		state->fp = fp;

because state->fp needs to preserved for the STACK+!fp.frame_off case.

So, something like this?

	bool preserve_fp = false;
	...

	/* Get the Frame Pointer (FP) */
	switch (frame->fp.loc) {
	case UNWIND_USER_LOC_NONE:
		preserve_fp = true;
		break;
	case UNWIND_USER_LOC_STACK:
		if (!frame->fp.frame_off) {
			preserve_fp = true;
			break;
		}
	...

	state->ip = ra;
	state->sp = sp;
	if (!preserve_fp)
		state->fp = fp;

BTW, I would suggest renaming "frame_off" to "offset",
"frame->fp.offset" reads better and is more compact.

-- 
Josh

