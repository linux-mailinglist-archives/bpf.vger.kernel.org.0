Return-Path: <bpf+bounces-61937-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7A8AEECAB
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 05:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14BDA189D81E
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 03:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991691DFD8F;
	Tue,  1 Jul 2025 03:05:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F21165F16;
	Tue,  1 Jul 2025 03:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751339102; cv=none; b=Nt98wA9UJTnux1tVqsBxgR4B3RiNioddpwNJSX8TGeLFzREPXbMFjZVz7XUeAd1Q2iG3NdyD0IEFNrwpAUyfnmcZmrswzUCUMTGNEEl304SbfbvTibxItwFNjsmKwEZ9ogk2YCm3O07xMR+26TBJUdUM+J+Jk/ram8Q6VpRm62c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751339102; c=relaxed/simple;
	bh=fJMXAYXK4ApkKTRvz8fEh3fzLlpNIYItc2zGwyJEkU0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j4ypDbnRQ3goFgLZmbev7FFcErAU7Ah05SvZmqwbPiBuC9206A8t0IBeAFHO0radylUc57kj0VJlbpmb6x8wUCwrRkxsO0//hG57fs69LOu88LCaqHoZEjYG/h96ud3J0PozS7Pzwz9ePoak3fcWZRYxYWmy9NkJfO5KWThl32E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id ACC9D103D0C;
	Tue,  1 Jul 2025 03:04:56 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id 4DBFD20024;
	Tue,  1 Jul 2025 03:04:52 +0000 (UTC)
Date: Mon, 30 Jun 2025 23:05:28 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa
 <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat
 <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, Beau
 Belgrave <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
 Florian Weimer <fweimer@redhat.com>, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v12 02/14] unwind_user: Add frame pointer support
Message-ID: <20250630230528.5e368f19@gandalf.local.home>
In-Reply-To: <20250630225603.72c84e67@gandalf.local.home>
References: <20250701005321.942306427@goodmis.org>
	<20250701005450.888492528@goodmis.org>
	<CAHk-=wiWOYB4c3E-Cc=D89j0txbN4AGqm0j1dojqHq3uzJ+LqQ@mail.gmail.com>
	<20250630225603.72c84e67@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: t88mfkokopccoe3yfmjp5wgne6bccm8t
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 4DBFD20024
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+UKVbCqKQe/uukd2krREykYYrKxhbbAe4=
X-HE-Tag: 1751339092-149871
X-HE-Meta: U2FsdGVkX19J47Yys8Go8kVhJUnavGX522lH2O2zKWSbJ45DADQD39vwDt+1vXshVWgzTR6zbNJ+FyZ16VUwL1adhrm6OjgiXR3gSc39zi4wdLj7diH5xQXRU/ztDr6nmRPFROTfhk5PaH1C00MaIuszxX/D9ALovTPc8rE2yy8rqbvGBTIKWDTHYz50Z/qtN8B/yiRM0PM3P77yX8sGMbAq9tj1okt9T3QsR6RNIlcVqTCIq7lh6unmjv0O3+Im3lUGTjXl/dRVfntCoUIcNXisKsQpLBnZkwvEB8evxmCxRKbQaKGLfwGLsp6S35qUpiUXozhoVBJGLl/exg++6MNE2a7Jki289ISYEGGsLRrPH/5G5mAJV3lpjhFvAXtFZ2OT/U+aJGPWa7atjPeR9fiWBJPNiwFblXDgDqGa/CBLDvU5Y8SqExp9ch9iQ2B8

On Mon, 30 Jun 2025 22:56:03 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 30 Jun 2025 19:10:09 -0700
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> > On Mon, 30 Jun 2025 at 17:54, Steven Rostedt <rostedt@goodmis.org> wrote:  
> > >
> > > +       /* stack going in wrong direction? */
> > > +       if (cfa <= state->sp)
> > > +               goto done;    
> > 
> > I suspect this should do a lot more testing.  
> 
> Sure.

Adding Kees too.

Kees,

I'd like to get some security eyes on this code to take a look at it. As it
is making decisions on input from user space, I'd like to have more
security folks looking at this to make sure that some malicious task can't
set up its stack in such a way that it can exploit something here.

The parsing of the sframe code (latest version net yet posted) will need a
similar audit.

Thanks,

-- Steve


> 
> >   
> > > +       /* Find the Return Address (RA) */
> > > +       if (get_user(ra, (unsigned long *)(cfa + frame->ra_off)))
> > > +               goto done;
> > > +
> > > +       if (frame->fp_off && get_user(fp, (unsigned long __user *)(cfa + frame->fp_off)))
> > > +               goto done;    
> > 
> > .. and this should check the frame for validity too.  At a minimum it
> > should be properly aligned, but things like "it had better be above
> > the current frame" to avoid having some loop would seem to be a good
> > idea.  
> 
> Makes sense.
> 
> > 
> > Maybe even check that it's the same vma?  
> 
> Hmm, I call on to Jens Remus and ask if s390 can do anything whacky here?
> Where something that isn't allowed on other architectures may be allowed
> there? I know s390 has some strange type of stack usage.
> 
> -- Steve


