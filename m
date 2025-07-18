Return-Path: <bpf+bounces-63696-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CD0B09AA4
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 06:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 724715A661E
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 04:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3EB31DDC37;
	Fri, 18 Jul 2025 04:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HKFQpGAc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256903214;
	Fri, 18 Jul 2025 04:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752814305; cv=none; b=o0Un4+TiBniJDMd2yIFbY5EOYuIRg8LL2Uqib2oTAYD8PndYz7K6Z5WHj4LxEaZPux5Oh0W+az5Isj4WemZ1hUBD3wjv9jELPJMHWj0FY9IENGEgoZvEheGwXEZAWfK+qPBOQ8dGPmJxpUtfhwJH1qlLsjywyFawE5A7ugqRO/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752814305; c=relaxed/simple;
	bh=HzK0xvM6DowzYgIdQvDNnKh63eFvBeTTOCJbu1mZRyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jMf+dFk/iwUFsN8ZcxcY8XDWuLJscRUPzYnnb3dikzmkIj3nJ1h1Rpyq29ddhkWNlDbPw6ML5+NAdYSiSSd2+tFbg5mViQgm9inMGOqyS0MhR6pBM70vBtrgKCZLLvcpN2ci+czeeeAh4Rpd5BP/AQWCbp+SIT0UJhOEepLXL9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HKFQpGAc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D56C1C4CEED;
	Fri, 18 Jul 2025 04:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752814304;
	bh=HzK0xvM6DowzYgIdQvDNnKh63eFvBeTTOCJbu1mZRyg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HKFQpGAcoCEeDdk4QOOZD/4JH85eXeVL+A8QXVeSgOYpf/LwAE8U26QELjU+op4vQ
	 7loYEvUctgYToiud6wyu1rBi5wm3Y9MD4Q4MqjMGFYcvU6OL+rhxNtcG4Nh1ay7W3C
	 MW/P8fGPvcBoA6mXF65Q+LqeelDojJ5MzTykpp9RZiyTZ1XeMZY2cK4Qmheuwh236u
	 XVM29c1/uUHyrBm6+g35ytiIF2E6z/Y4awvvxreqitNN8atcB0zMNxNcTIcM95nzmx
	 ZMmVHxsA3a8khz+Bg2OL3eJXp25FGUU630w/+3P9Ndvzlu5ASuPmqm+Vuat8mY/30M
	 223SY5hMfEIeg==
Date: Thu, 17 Jul 2025 21:51:42 -0700
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
Message-ID: <ryuuuud2oistduo4exftjydws4bevd3ucsisuf4c7polup4bdv@6alhwwx4yyag>
References: <20250710163522.3195293-1-jremus@linux.ibm.com>
 <20250710163522.3195293-9-jremus@linux.ibm.com>
 <oasyyga72yuiad7y2nzh7wcd7t7wmxnsbo2kuvsn5xsnuypewd@ukxxgdjbvegz>
 <6285a2b1-eb9b-4315-b960-cfaa99513ac1@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6285a2b1-eb9b-4315-b960-cfaa99513ac1@linux.ibm.com>

On Thu, Jul 17, 2025 at 01:28:25PM +0200, Jens Remus wrote:
> >>  	}
> >>  
> >>  	/* Get the Frame Pointer (FP) */
> >> -	if (frame->fp_off && unwind_get_user_long(fp, cfa + frame->fp_off, state))
> >> +	switch (frame->fp.loc) {
> >> +	case UNWIND_USER_LOC_NONE:
> >> +		break;
> > 
> > The UNWIND_USER_LOC_NONE behavior is different here compared to above.
> 
> See my comments below.
> 
> > Do we also need UNWIND_USER_LOC_PT_REGS?
> 
> Sorry, I cannot follow.  Do you suggest to rename UNWIND_USER_LOC_REG to
> UNWIND_USER_LOC_PT_REGS?

I think I completely misunderstood the meaning of UNWIND_USER_LOC_NONE.
Never mind :-)

> >> +	case UNWIND_USER_LOC_STACK:
> >> +		if (!frame->fp.frame_off)
> >> +			goto done;
> >> +		if (unwind_get_user_long(fp, cfa + frame->fp.frame_off, state))
> >> +			goto done;
> >> +		break;
> >> +	case UNWIND_USER_LOC_REG:
> >> +		if (!IS_ENABLED(CONFIG_HAVE_UNWIND_USER_LOC_REG) || !topmost)
> >> +			goto done;
> > 
> > The topmost checking is *really* getting cumbersome, I do hope we can
> > get rid of that.
> 
> Restoring from arbitrary registers is only valid in the topmost frame,
> as their values (i.e. task_pt_regs(current)) are only available there.
> For other frames only SP, FP, and RA register values are available.
> 
> I think this test makes sense.  Is this test really that expensive?

ra_off=0 (UNWIND_USER_LOC_NONE) on a !topmost frame should never happen
unless the sframe entry is bad.  But 0 is *far* from the only potential
bad RA offset value.  In the absolute worst case of a 4 byte offset,
there are 4+ billion other possible bad values that can still go
undetected.

So I question the usefulness of those !topmost tests.  And they do add
complexity to the code.

-- 
Josh

