Return-Path: <bpf+bounces-61751-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE55AEB965
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 16:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E01691C45E2C
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 14:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11105176242;
	Fri, 27 Jun 2025 14:00:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A0B2F1FF0;
	Fri, 27 Jun 2025 14:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751032855; cv=none; b=orHUbUXPI3/2fM4xer9iolOaK10iyUy7OJ6nSTF5me9RkjBFD+TdLNfogLxWDm8MI6uKNg2WyLASDxyD+kETaL0V9rmbjZSXWsMCSW0zVHjQC5k/HCi8YB91JUZPTB1Nh+3esa1syOr3MwekB5P8sbycqzqDoWvbQBAGkJuvisI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751032855; c=relaxed/simple;
	bh=Y0zjR+0lq6F1z+5zhA934yp+N1Q5XifqEik1+HZfEtM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rg8YSBtHR/bxmOq7aHjapAZ0729Mx7LRWw4uA7vbR2iH9iadc6HpaWzWcLAttUYL6/nuBw4gPQufd90TwSpteuST4iiYOQzPaUAW5VbUr6UAI+udjBzjbLqkRcKaJ1SAMMk9uUfjtPH7go8edi/ntXuT/4AQeZVPhJIF6qRDUoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 93FB01D06DE;
	Fri, 27 Jun 2025 14:00:49 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id 57C1A19;
	Fri, 27 Jun 2025 14:00:45 +0000 (UTC)
Date: Fri, 27 Jun 2025 10:01:13 -0400
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
Message-ID: <20250627100113.7f9ee77b@gandalf.local.home>
In-Reply-To: <20250626081220.71ac3ab6@gandalf.local.home>
References: <20250625225600.555017347@goodmis.org>
	<20250625225717.187191105@goodmis.org>
	<aF0FwYq1ECJV5Fdi@gmail.com>
	<20250626081220.71ac3ab6@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: hdt6wmr7gywmeefrxeczah87ep1ye9om
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 57C1A19
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19E746lenE+7SEV7ki2qR+MVKChNG+Z7fk=
X-HE-Tag: 1751032845-404136
X-HE-Meta: U2FsdGVkX1/P1YN2KwnQ0FhggpRH6yYU7kVuhVuoheh6IxatY7b07M7xU7cbGn1nBrAWOzahfJC8XSffe/AZawD//UHhhWMagG7OgkM2943jJk2ReX5jjoXhjR+fnJoZhziO6b+gWWNt+Qry0I6ikgX78Vd5rP2vq98dfI4oGLQWMkUKj2kh8NRdqhau8lYidMInfptkL+ssZpCtnNZXJWDfXrbraknillJFqRkiKHXdsHYe9xvKiS65KMpo6V33NxQkDivwbGq2cCSJUhF8+9xWOv/j8bKv8i/Veq59a28Ybgy75X+i4DB0TXpv/vkcvU/d5z7zSqHvyB6xNE9poU91DcHeBbF5nBvvKh3k4ZBDQ5tiWAKzWKE7XjFYTB3F

On Thu, 26 Jun 2025 08:12:20 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> 
> 
> >   
> > > +/*
> > > + * If an architecture needs to initialize the state for a specific
> > > + * reason, for example, it may need to do something different
> > > + * in compat mode, it can define arch_unwind_user_init to a
> > > + * function that will perform this initialization.    
> > 
> > Please use 'func()' when referring to functions in comments.  
> 
> You mean to use "arch_unwind_user_init()"?
> 
> >   
> > > +/*
> > > + * If an architecture requires some more updates to the state between
> > > + * stack frames, it can define arch_unwind_user_next to a function
> > > + * that will update the state between reading stack frames during
> > > + * the user space stack walk.    
> > 
> > Ditto.  
> 
> And this to have arch_unwind_user_next()?

I went to go update these than realized that the are not functions. As the
comment says, "it can define arch_unwind_user_next", that means it has to be:

  #define arch_unwind_user_next arch_unwind_user_next

That's not a function. It's just setting a macro named arch_unwind_user_next to
be arch_unwind_user_next. I think adding "()" to the end of that will be
confusing. I could update it to say:

  ... it can define a macro named arch_unwind_user_next with the name of the
  function that will update ...

Would that work?

I may even change the x86 code to be:

#define arch_unwind_user_next x86_unwind_user_next

As the function name doesn't have to be the same as the macro.

-- Steve

