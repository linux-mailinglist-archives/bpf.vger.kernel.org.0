Return-Path: <bpf+bounces-60952-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C0AADF0C8
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 17:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDEF14A0215
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 15:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F32E2EE987;
	Wed, 18 Jun 2025 15:10:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66AC16A95B;
	Wed, 18 Jun 2025 15:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750259448; cv=none; b=Q47wBYd8I+aAb8pufS5O1Oj+pbf3wa/gK7S2ue5HiwP10/oiCuQG5pxHXFJX5qDUEJoWj+nx+FgX23RTQ9Dtc58BM0gEyyxoQsxS/aqfvu8L9a9+/ok3rqwTItVBeaZdSQ1HBHjzj2aXXKCho3UxFXzS9WSUuYWmzkSK9LxqeT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750259448; c=relaxed/simple;
	bh=7celbNZK7cUowrtpbJpvgT/P4/mtH33mLD4DahcanO0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hlPznCfvQk1Jp2yWiPY7h56dTLTcCe+GbnNpa6Wx5TPG7/zhwLR1HBwG2HJ9Ib4wN9G/FqvB8O+IKDHOaB3q9zkSgJBYWrOtyVI1jWNLn/aJKqeU2el/ocaE4AYUZPgFXAC4bLE0A0CkpOJuBs8tbZMDzamjW6jH0Y8GehXWQ1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 640E31CD07A;
	Wed, 18 Jun 2025 15:10:42 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id 823AE20019;
	Wed, 18 Jun 2025 15:10:38 +0000 (UTC)
Date: Wed, 18 Jun 2025 11:10:46 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, Indu
 Bhagat <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, Beau
 Belgrave <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton
 <akpm@linux-foundation.org>
Subject: Re: [PATCH v10 03/14] unwind_user: Add compat mode frame pointer
 support
Message-ID: <20250618111046.793870b8@gandalf.local.home>
In-Reply-To: <20250618134641.GJ1613376@noisy.programming.kicks-ass.net>
References: <20250611005421.144238328@goodmis.org>
	<20250611010428.261095906@goodmis.org>
	<20250618134641.GJ1613376@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 823AE20019
X-Stat-Signature: 4dy7nzocsgk4ijxsa3itupmpfbp6ogep
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18qKTDnFjwgUe2QGMU6ftBeeSp0rG0uMe4=
X-HE-Tag: 1750259438-195004
X-HE-Meta: U2FsdGVkX18lMjb0gzHottcD+djXgm1V24zuIEaRz5H6kvhaYJpN5MnMA6PJDkC6o3d+5DKlf6puSBleP2YAsi2jHw4XzvzshrLt0mYR9R3n2YEhdgCTT7Pau02nG+TTjaZUenMtTUb9BKvDbajnAzwv4ZozWSJ1br5o+JRtU58jP9kx8u0uovm/J2+IERHAz5DsrOIZT/zBRGpiRKAFLmSHOR0os4/UO3MralzMnI8VeoHBA+8OxKxtIdjWDpeEfjJxsJWBQXJY9uCcs6XVUxQslCPlDqQJA6jkp/wBA2jzAXlRYO2bZ57e00XYCJ7mYlXFHHq7w4gLWaCMz7dhnSFgQIuDYwhfMUvUJQl+rl2UcqoRKWogbkuZ3rmH9DQW

On Wed, 18 Jun 2025 15:46:41 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, Jun 10, 2025 at 08:54:24PM -0400, Steven Rostedt wrote:
> > diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
> > index 4fc550356b33..29e1f497a26e 100644
> > --- a/kernel/unwind/user.c
> > +++ b/kernel/unwind/user.c
> > @@ -12,12 +12,32 @@ static struct unwind_user_frame fp_frame = {
> >  	ARCH_INIT_USER_FP_FRAME
> >  };
> >  
> > +static struct unwind_user_frame compat_fp_frame = {
> > +	ARCH_INIT_USER_COMPAT_FP_FRAME
> > +};
> > +
> >  static inline bool fp_state(struct unwind_user_state *state)
> >  {
> >  	return IS_ENABLED(CONFIG_HAVE_UNWIND_USER_FP) &&
> >  	       state->type == UNWIND_USER_TYPE_FP;
> >  }
> >  
> > +static inline bool compat_state(struct unwind_user_state *state)  
> 
> Consistency would mandate this thing be called: compat_fp_state().

Sure. Will update it.

> 
> > +{
> > +	return IS_ENABLED(CONFIG_HAVE_UNWIND_USER_COMPAT_FP) &&
> > +	       state->type == UNWIND_USER_TYPE_COMPAT_FP;
> > +}
> > +
> > +#define UNWIND_GET_USER_LONG(to, from, state)				\  
> 
> Do we have to shout this?

Don't we usually shout macros?

-- Steve

> 
> > +({									\
> > +	int __ret;							\
> > +	if (compat_state(state))					\
> > +		__ret = get_user(to, (u32 __user *)(from));		\
> > +	else								\
> > +		__ret = get_user(to, (unsigned long __user *)(from));	\
> > +	__ret;								\
> > +})
> > +
> >  int unwind_user_next(struct unwind_user_state *state)
> >  {
> >  	struct unwind_user_frame *frame;  


