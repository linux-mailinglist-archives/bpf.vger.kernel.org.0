Return-Path: <bpf+bounces-61392-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92EE1AE6C8A
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 18:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6597E5A6ADF
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 16:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A7F2E54B6;
	Tue, 24 Jun 2025 16:37:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE7F2E2F19;
	Tue, 24 Jun 2025 16:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750783032; cv=none; b=lc7TpG9UDCpjXoDtFSh3DzCUJJ2YZaORuYYilge+7YnokCBvQ6EYwLOtywDixxXlJjPPNCMitpfZnAFfOafC2ctP0GcVMnpkatzHCvZccqBQfcNXsh1GBDZOIo96zwoFEvyT0MfU55+FQzG1tIBbHqr0FJLD3LWi5C1qaaXQDm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750783032; c=relaxed/simple;
	bh=hdP9mpYsK2Q3RY9hTt8+NjB0LOi9gUf391YKK7ZgnTs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MAcZ0vjX4xNyTYguT3yRgc4aS259itih6J9G68jwkHZXCuPBIPIe4ja8wyvPaQt+U72y6MnXhJHhSwxugJoMu5AVTi/7UjQorY+lBgnQsq9Jh5BTj2HGe5PkQVljC2DaLoDPnWXKpw0urH3nhmSs/+V41RqSFFYX6EYcGzLPZok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 4A3C55D0C6;
	Tue, 24 Jun 2025 16:36:59 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id A42996000E;
	Tue, 24 Jun 2025 16:36:53 +0000 (UTC)
Date: Tue, 24 Jun 2025 12:36:50 -0400
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
Subject: Re: [PATCH v10 08/14] unwind deferred: Use bitmask to determine
 which callbacks to call
Message-ID: <20250624123650.45eaef1a@batman.local.home>
In-Reply-To: <20250624150021.GX1613200@noisy.programming.kicks-ass.net>
References: <20250611005421.144238328@goodmis.org>
	<20250611010429.105907436@goodmis.org>
	<20250620081542.GK1613200@noisy.programming.kicks-ass.net>
	<20250624105538.6336a717@batman.local.home>
	<20250624150021.GX1613200@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A42996000E
X-Stat-Signature: b9n45wf7go7awot9scyeebizdcbc8p3w
X-Rspamd-Server: rspamout03
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/K1WJLrL429FH033FoToSviP7JS8Y5N5Y=
X-HE-Tag: 1750783013-434321
X-HE-Meta: U2FsdGVkX1/eGpnAFrsr5SJ+kTGyCoPgr4tj81pJfwf7jhNVf4oCC0Zt+mIisg5o8bjvCOdV/7bRJwgtfk9wSABDd2z29J0QLFOr8hxmopE7XfUcvLAjPF3ahGK8KJuWFNTPTVEU7AqckqOfvwAVwDk4GfFswRSaCliZ1+0lQGJKrKvw5NgtKPsl0kACRM8OYRTdHIDzNbiuHnpjlLf7MkN/Ib3tL/lgixK3b1vMwUdLnTYXzUmd4oWHuvRSGSPGhkdgLSPmD74n28aZ+mLQ8fo8k3iIyqCddiemdv+/ytxEeuKQFHOIRNKGx/T0BqTiblOmsIxbpN2XPY+XAQQuStEtEou+l1RlyTlnYgbn86Azr8SOZdWn3jLD+qDC10Fd

On Tue, 24 Jun 2025 17:00:21 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, Jun 24, 2025 at 10:55:38AM -0400, Steven Rostedt wrote:
> 
> > > Which is somewhat inconsistent;
> > > 
> > >   __clear_bit()/__set_bit()  
> > 
> > Hmm, are the above non-atomic?  
> 
> Yes, ctags or any other code browser of you choice should get you to
> their definition, which has a comment explaining the non-atomicy of
> them.

Bah, I did do a TAGS function (emacs) to find them, but totally missed
the comment above. I just saw the macro magic of them, but totally
missed the comment above them saying:

/*
 * The following macros are non-atomic versions of their non-underscored
 * counterparts.
 */

 :-p

-- Steve

