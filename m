Return-Path: <bpf+bounces-62562-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C05AFBD7C
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 23:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 582643B4EE2
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 21:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176DC2874E0;
	Mon,  7 Jul 2025 21:28:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C4A194C96;
	Mon,  7 Jul 2025 21:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751923737; cv=none; b=Us5BZYsOdYvZc7zeLyI3Sgk75h0SVH0oQEqju0nAti6uEe0ziIPbt6425DPLoTht2uHudNda+G9G+MV5EsKd58A9LrUOBGC503cf7mZA0dP2ppepMJlfU65dejTOS2LxuCMjQzLRYpGeawytlk5sdpUNJOLc6zc8XhUioUPZgNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751923737; c=relaxed/simple;
	bh=YY91jF2kIXgCSrAhHbLH3CIxeqcI9tB+rbtCD3eLjz8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uhl+OM39rY2JAJ0lZsFEt9DdKLjhQ3kRzK2ZlBOT+rtCyTz7+u8klpJNABgHssgpn8nNu/FUBm5hoBvoFtDF/XRayGQPnmGj04EjKT9ubPOmAIh8oi1uSiOuDv5sq8RHqLlh6xRdLjLDBBNYtQMHPUi5reg40yMyn2teAOFMh9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id F40E81603A7;
	Mon,  7 Jul 2025 21:28:52 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id 5720820010;
	Mon,  7 Jul 2025 21:28:48 +0000 (UTC)
Date: Mon, 7 Jul 2025 17:28:47 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jens Remus <jremus@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa
 <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat
 <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, Beau
 Belgrave <beaub@linux.microsoft.com>, Andrew Morton
 <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Florian Weimer
 <fweimer@redhat.com>
Subject: Re: [PATCH v12 02/14] unwind_user: Add frame pointer support
Message-ID: <20250707172847.75bb6190@batman.local.home>
In-Reply-To: <d4fb9d4c-13d6-41fc-8c17-dee6cc0a77eb@linux.ibm.com>
References: <20250701005321.942306427@goodmis.org>
	<20250701005450.888492528@goodmis.org>
	<CAHk-=wiWOYB4c3E-Cc=D89j0txbN4AGqm0j1dojqHq3uzJ+LqQ@mail.gmail.com>
	<20250630225603.72c84e67@gandalf.local.home>
	<a6a460e6-8cff-4353-a9e1-2e071d28e993@linux.ibm.com>
	<20250702195058.7ebb026d@gandalf.local.home>
	<d4fb9d4c-13d6-41fc-8c17-dee6cc0a77eb@linux.ibm.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: sakoqdihpa7b49ngohg5pdhgdcunrjrp
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 5720820010
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/BaoY0sYmWm4CGwHUM7pkPRsQVgrbcglY=
X-HE-Tag: 1751923728-40853
X-HE-Meta: U2FsdGVkX1+6lJPe/TyS0k8S8ysy1ySKSNO9cRN3ne/FLvKPmvmCe27F5fMYniDvvpVXbr41FBJPafYCZE1OtkCsUj1yHGIYqt2qulZs3RvBIBvSdnzusIRCf+fVRGBrnF5aDcZOOtGnwmMWU9XRwqnTffdJlKUd3X8381wPe4w3tLXOBh/0MrE5jyD+ScRk3BATac6GBy6y+N2ji46T4GFzIaKEjvnXqSFF+nxJZRmoKzDLPMVHEljGMXEe0CF/oRbzDxEJhgOklsI5D1lr8RYTl/PzYUw7lDKgzDIHhErDTKB2iRvywJ4iK7bV/SBCMb4vXawyZrfIjc3xVSLV8g2bKR9YGs9iW/fkQwi13BKVfLHqM0Vdqg==

On Thu, 3 Jul 2025 18:21:10 +0200
Jens Remus <jremus@linux.ibm.com> wrote:

> >> 	/* stack going in wrong direction? */
> >> 	if (sp <= state->sp - topmost)
> >> 		goto done;  
> > 
> > How do you calculate "topmost" then?
> > 
> > Is it another field you add to "state"?  
> 
> Correct.  It is a boolean set to true in unwind_user_start() and set to
> false in unwind_user_next() when updating the state.

So it's subtracting 1 or zero? So that the topmost can be equal. Well,
that would need a bit of commenting.

> 
> I assume most architectures need above change, as their SP at function
> entry should be equal to the SP at call site (unlike x86-64 due to CALL).
> 
> s390 also needs this information to allow restoring of FP/RA saved in
> other registers (instead of on the stack) only for the topmost frame.
> For any other frame arbitrary register contents would not be available,
> as user unwind only unwinds SP, FP, and RA.
> 
> I would post my s390 sframe support patches as RFC once you have
> provided a merged sframe branch as discussed in:
> https://lore.kernel.org/all/20250702124737.565934b5@batman.local.home/

I did have a merge branch on my repo. But I was hoping to see your code
so that I can add this to this patch before having to post again. But
now I'm posting without this change, as I don't want to screw it up. I
think I know what it it looks like, but it would be better to see what
you did to make sure what I envision is correct.

Oh well. I'll post v13 without it.

-- Steve

