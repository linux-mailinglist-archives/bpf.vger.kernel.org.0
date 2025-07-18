Return-Path: <bpf+bounces-63697-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B57B09AA6
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 06:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBEDDA41F1D
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 04:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8711C1DE2C9;
	Fri, 18 Jul 2025 04:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qg0cyTZl"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4E63214;
	Fri, 18 Jul 2025 04:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752814349; cv=none; b=EO/+sFqDRHGEL1OUq1JFgE8w1Z3vbV+ZQ9YFmSgaakoCF5EAFLN6INOZEJdCF6O2gFfsPoFo71FEAjh5SgPtDNp2WZ0CdgyanKTyz8y6EHnEn592ZxgqYwzEl/A4avZHHO00WvfEG2u7DDwF5LDUL2nLFm9ZGYtlsASqxhn5Ri4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752814349; c=relaxed/simple;
	bh=FupbUBUrdSZ0TJ2N1xUV1dTQyd9vwDIJ79ctuHulAH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tR8jqUkP9kZ5dYNM+h41U9/LmS2uCZTQhxHF9TKvSUsWfGGDGs+Pwi7yFEF1TZiPc0unu4dO1x//9zs667guQyqmbL55UwTw4Rt0IdBaZ/oXUpLM0rqTyTlGPqryv4zY6SM1c9AaymTkxg/D/8JPZDC2V3+xen+6j0OXnLULhB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qg0cyTZl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84F31C4CEED;
	Fri, 18 Jul 2025 04:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752814348;
	bh=FupbUBUrdSZ0TJ2N1xUV1dTQyd9vwDIJ79ctuHulAH4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qg0cyTZlPRjcy0iFtxA4C3BYIKBabl3begko7SxYdeaeCyNLvqEafsFTzgJSvzrNi
	 vm6+FE6DQuOqgxl7h5F2sPWaqrgFbmFHq/9IFeacmlqHLnM6zDYIkDO2KELBrgebxX
	 S/wWnoeqAJpljWEAKKYJIPKRg0NgUzxwRurLmWOwbxhqOV6udPA4QQR7/6siR9lxXO
	 YRY0nNxIVU7pYfzQLw0zPrq26iPyZqYGYpbZ2Pdsu9weNN9A1xGuaGFT3ZMlTTwWhS
	 hYBe4FYfOCroKp/Rl36vzcEXlZ4VBBf+zDVrbIlKd+ciYkGJnynpd8EoERlPN/GBh0
	 xCKEbZ6BMYPHA==
Date: Thu, 17 Jul 2025 21:52:24 -0700
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
Message-ID: <qk5sfunxgef6qtnfqorszybubhai7kqg5h473dx5wcmvlphq5a@om7pohqhho6a>
References: <20250710163522.3195293-1-jremus@linux.ibm.com>
 <20250710163522.3195293-9-jremus@linux.ibm.com>
 <oasyyga72yuiad7y2nzh7wcd7t7wmxnsbo2kuvsn5xsnuypewd@ukxxgdjbvegz>
 <3he7rlcdchkwjtpbdt5khqflg4dipuvkneydhju2jjgs2ujqoh@2rpb6dutdogx>
 <94e27f70-58f6-431d-9623-9c349a5977ff@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <94e27f70-58f6-431d-9623-9c349a5977ff@linux.ibm.com>

On Thu, Jul 17, 2025 at 02:07:05PM +0200, Jens Remus wrote:
> On 17.07.2025 04:50, Josh Poimboeuf wrote:
> > So the following is wrong:
> > 
> > 	case UNWIND_USER_LOC_STACK:
> > 		if (!frame->fp.frame_off)
> > 			goto done;
> > 		if (unwind_get_user_long(fp, cfa + frame->fp.frame_off, state))
> > 			goto done;
> > 		break;
> > 
> > Instead of having !fp.frame_off stopping the unwind, it should just
> > break out of the switch statement and keep going.
> 
> If frame->fp.loc is UNWIND_USER_LOC_STACK then frame->fp.frame_off must
> have a value != 0.  At least if we keep the original semantic.
> 
> We can omit this check, if we assume all producers of frame behave
> correctly.  For instance user unwind sframe would not produce that
> (see below).  Could it somehow be made a debug-config-only check?

Ah... the !frame->fp.frame_off check for the UNWIND_USER_LOC_STACK case
completely threw me for a loop.  I was confusing that with
UNWIND_USER_LOC_NONE.  So never mind.

And yes, I think that check has no use and can be removed.

-- 
Josh

