Return-Path: <bpf+bounces-61661-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3909AE9D44
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 14:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 642AE3BA6CB
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 12:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CB120FA8B;
	Thu, 26 Jun 2025 12:12:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546113C2F;
	Thu, 26 Jun 2025 12:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750939929; cv=none; b=Nbqe8R4qi4fXnUvPusDkkkmLWSZ/W/wd5z145tO0YmhtoixK1wjrhDPV5CdEYeoCz8gRlf0J1IzYqeqoXKaDndbxcVjmJ0PPAo5LDVcwjxu5pGACHRryq0Ep2LAMmNpVyboja+u3zV7OGkhLPFZHYbmKGg+dC6lJJZSmI9eP/MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750939929; c=relaxed/simple;
	bh=S0He3klNKgx264BDmuWA7zCXhYd94x/8cNR57vffdQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s4W+258R+7sNlUrwzUq/K06r5VjkL0BoYW9QGBAoL6v3nXwwR1mNGo4cWcLvZrod9zlnUvf7ZuePX9TzanAPQt223fQ5Oz6rT5ZOoh/V17xDLEbGc7/N+rTSH6Y8XM/1d9KdCJHmwM9ajLQPu29HM+DZwfUCuukSd3rjnxvHlzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 7FDF014019D;
	Thu, 26 Jun 2025 12:12:03 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id 644EA60011;
	Thu, 26 Jun 2025 12:11:59 +0000 (UTC)
Date: Thu, 26 Jun 2025 08:12:20 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim
 <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Andrii
 Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>, "Jose
 E. Marchesi" <jemarch@gnu.org>, Beau Belgrave <beaub@linux.microsoft.com>,
 Jens Remus <jremus@linux.ibm.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>,
 Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v11 14/14] unwind_user/x86: Enable compat mode frame
 pointer unwinding on x86
Message-ID: <20250626081220.71ac3ab6@gandalf.local.home>
In-Reply-To: <aF0FwYq1ECJV5Fdi@gmail.com>
References: <20250625225600.555017347@goodmis.org>
	<20250625225717.187191105@goodmis.org>
	<aF0FwYq1ECJV5Fdi@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: gikz5ymk5gtkqfsbe7umaz6ygmti5hdb
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 644EA60011
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+3QBRxWW5QKTEc4mL8hVqCKcePDm/UYrE=
X-HE-Tag: 1750939919-377805
X-HE-Meta: U2FsdGVkX193DTU0jxe+hcnGyWs5G+kMGoQ+BjeKhg3ibdZ049hEqDvRQOdn/n+fmBWDV3neU1YtovsnJY9UIDM79V7xzGvVJtumYGrQEg+adFQorFWXawPyyw3B/mNEHV3KCRcmPcY9vLYMwmCTehxc5/2TkYsltq60/bTRMNGrv4NQmlpYZ4ABC1PXa8tOK3/gnOlmIk8FrG5cTLKrHzOlDuvzEZLJGM925d+wWkY/GVGYRiB7e5o8gYHrLRm9k9f0B6jgLLCbxRjdt5wJxwielPiYeWaLP4L6E6T8yUR13Ghfk3qo9hc/zFIX8Kb2XKNcE1edOxfznjnsGrRTIfaU/9vkn29TvihmPMU5NZPexAoxv/6DKmTgkb8+fOfNp9qsaF2yTsH3g4v/xZnVjQ==

On Thu, 26 Jun 2025 10:33:05 +0200
Ingo Molnar <mingo@kernel.org> wrote:

> * Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > diff --git a/arch/x86/include/asm/unwind_user_types.h b/arch/x86/include/asm/unwind_user_types.h
> > new file mode 100644
> > index 000000000000..d7074dc5f0ce
> > --- /dev/null
> > +++ b/arch/x86/include/asm/unwind_user_types.h
> > @@ -0,0 +1,17 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _ASM_UNWIND_USER_TYPES_H
> > +#define _ASM_UNWIND_USER_TYPES_H  
> 
> This is not the standard x86 header guard pattern ...

Should it be:

#ifndef _ASM_X86_UNWIND_USER_TYPES_H

?

> 
> > +
> > +#ifdef CONFIG_IA32_EMULATION
> > +
> > +struct arch_unwind_user_state {
> > +	unsigned long ss_base;
> > +	unsigned long cs_base;
> > +};
> > +#define arch_unwind_user_state arch_unwind_user_state  
> 
> Ran out of newlines? ;-)

I believe Josh purposely kept the #define and the structure together
without a newline as one defines itself to be used in the generic code.

Do you prefer them to be separated by a newline?


> 
> > +/*
> > + * If an architecture needs to initialize the state for a specific
> > + * reason, for example, it may need to do something different
> > + * in compat mode, it can define arch_unwind_user_init to a
> > + * function that will perform this initialization.  
> 
> Please use 'func()' when referring to functions in comments.

You mean to use "arch_unwind_user_init()"?

> 
> > +/*
> > + * If an architecture requires some more updates to the state between
> > + * stack frames, it can define arch_unwind_user_next to a function
> > + * that will update the state between reading stack frames during
> > + * the user space stack walk.  
> 
> Ditto.

And this to have arch_unwind_user_next()?

I'll update.

Thanks for the review.

-- Steve

