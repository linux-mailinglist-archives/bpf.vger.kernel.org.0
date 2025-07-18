Return-Path: <bpf+bounces-63755-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D827B0A8FC
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 19:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF3B856063B
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 17:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB262E7171;
	Fri, 18 Jul 2025 17:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nyjyMO/U"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB042E6D0C;
	Fri, 18 Jul 2025 17:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752858003; cv=none; b=DF3woJ6mIphPxRG1go2X7eW2X2zKlPYcUI+MyYfKLrOPtKEGydDKrtabP3/SUW1FiZOciQY7Igk1ysqf4YsqYNbeA025JxvRtgrKfMOyz206NS/V6MewpA2iXY3QvOA6/eVoCT6QIDaGxYMr2tVxDxEaCPC6kits5ykXQkwgTz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752858003; c=relaxed/simple;
	bh=W8t2koyJaLZ0JVX3vE0SM1n+BlRW5WXxbRMRDeUKeho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mnBr5giqlFNla9STzXeQ6fGrP3GRTZAf+MWIrgYtDRpDnT8NOhpNkWJqeEhL2ebnzEfe6XQDQxfKeXZ1jsJRRVMn7LMAsE+ujbHQz8QTkl9HdixBbHXU0/Zfz4bqPpATI/t7SO+BW7gGGb9TBb4t2xPoX7DbYx9q3UYAMKCLa6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nyjyMO/U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DAAEC4CEEB;
	Fri, 18 Jul 2025 17:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752858003;
	bh=W8t2koyJaLZ0JVX3vE0SM1n+BlRW5WXxbRMRDeUKeho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nyjyMO/U4AOcZ5FiPo2kAvehkOrhceb+dLNPToeAHAtFe+iWzwTApDQs+rMZYLlwt
	 YulTf7jRbvvH/SloIfDPEyzq9xidtthHrwngAZWUzKqZMut9rslgyZohR1OEfV7Ru9
	 OirTfvVGP9FY/b4iGd96Me65dtz2huk0t+3dGW09oLgZ2EyrVsV1EUh8e72AA2kOy7
	 YuerM2aadCH4ms8HYKmqWPoVLwoJXS+mtdyki/s3YRn4z1OG2W9NAtUXup6A2O5W/m
	 XEIKLoSfUPQxY18ygr3FpHdq6YtdbrJHkQFfKi10rGUtYCPGDer6rK2TxfAL84Xkdj
	 tDg6FIppgcy8g==
Date: Fri, 18 Jul 2025 09:59:59 -0700
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
Message-ID: <v6gwx63cd5divimoadofeuz2vn72uw7zrlcjacufaedeuxbvjc@qmobatrxo66u>
References: <20250710163522.3195293-1-jremus@linux.ibm.com>
 <20250710163522.3195293-8-jremus@linux.ibm.com>
 <xgbpe46th7rbpslybo5xdt57ushlgwr5xyrq4epuft5nfrqms3@izeojto3wzu4>
 <b5121d71-f916-45ea-9e6c-b74a27f90dcd@linux.ibm.com>
 <fb9ee560-d449-4d46-9fb1-19780ff28e65@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fb9ee560-d449-4d46-9fb1-19780ff28e65@linux.ibm.com>

On Fri, Jul 18, 2025 at 10:28:32AM +0200, Jens Remus wrote:
> On 17.07.2025 13:09, Jens Remus wrote:
> > On 17.07.2025 01:01, Josh Poimboeuf wrote:
> >> On Thu, Jul 10, 2025 at 06:35:13PM +0200, Jens Remus wrote:
> >>> +++ b/arch/Kconfig
> >>> @@ -450,6 +450,11 @@ config HAVE_UNWIND_USER_SFRAME
> >>>  	bool
> >>>  	select UNWIND_USER
> >>>  
> >>> +config HAVE_USER_RA_REG
> >>> +	bool
> >>> +	help
> >>> +	  The arch passes the return address (RA) in user space in a register.
> >>
> >> How about "HAVE_UNWIND_USER_RA_REG" so it matches the existing
> >> namespace?
> > 
> > Ok.  I am open to any improvements.
> 
> Thinking about this again I realized that the config option actually
> serves two purposes:
> 
> 1. Enable code (e.g. unwind user) to determine the presence of the new
>    user_return_address().  That is where I derived the name from.
> 2. Enable unwind user (sframe) to behave differently, if an architecture
>    has/uses a RA register (unlike x86, which solely uses the stack).

The sframe CONFIG_HAVE_USER_RA_REG check is redundant with the
unwind_user one, no?  I'm thinking it's better for sframe to just decode
the entry as it is, and then let unwind_user validate things.

> I think the primary notion is that an architecture has/uses a register
> for the return address and thus provides user_return_address().  What
> consumers such as unwind user do with that info is secondary.
> 
> Thoughts?

user_return_address() only has the single user, and is not all that
generically useful anyway (e.g., it warns on x86), so let's keep it
encapsulated in include/linux/unwind_user.h and give it the
"unwind_user" prefix.

Also, "RA_REG" is a bit ambiguous, it sounds almost like that other
option which spills RA to another register.  Conceptually, it's a link
register, so can we rename that to CONFIG_HAVE_UNWIND_USER_LINK_REG and
unwind_user_get_link_reg() or so?

Similarly, CONFIG_HAVE_UNWIND_USER_LOC_REG isn't that descriptive, how
about CONFIG_HAVE_UNWIND_USER_LINK_REG_SPILL?

Also we can get rid of the '#define func_name func_name' things and just
guard those functions with their corresponding CONFIG options in
inclide/linux/unwind_user.h.

Also those two functions should have similar naming and prototypes.

For example, in include/linux/unwind_user.h:

#ifndef CONFIG_HAVE_UNWIND_USER_LINK_REG
int unwind_user_get_link_reg(unsigned long *val)
{
	WARN_ON_ONCE(1);
	return -EINVAL;
}
#endif

#ifndef CONFIG_HAVE_UNWIND_USER_LINK_REG_SPILL
int unwind_user_get_reg(unsigned long *val, unsigned int regnum)
{
	WARN_ON_ONCE(1);
	return -EINVAL;
}
#endif

Then the code can be simplified (assuming no topmost checks):

	/* Get the Return Address (RA) */
	switch (frame->ra.loc) {
	case UNWIND_USER_LOC_NONE:
		if (unwind_user_get_link_reg(&ra))
			goto done;
		break;
	...
	case UNWIND_USER_LOC_REG:
		if (unwind_user_get_reg(&ra, frame->ra.regnum))
			goto done;
		break;
	...

-- 
Josh

