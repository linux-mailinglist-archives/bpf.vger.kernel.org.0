Return-Path: <bpf+bounces-72658-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07ED5C177AC
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 01:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA32F1C80071
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 00:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2312B1DEFE0;
	Wed, 29 Oct 2025 00:09:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733C11D6187;
	Wed, 29 Oct 2025 00:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761696566; cv=none; b=SennGiQ9oA3+GgOQsGpzMLcbDgl5HV8yfpmtWjY094asq4JP4z3YWLE+Vb+++RSlbqhtvaJvMbfEDJ2utUkNJNbJGeCcHIEaStILYMJasyBERHQHU7zqg+tQxxTBHy/+mJSq45gdo4RIktm7BblmKnfQ0xc2bFYQS/TZg1SKKEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761696566; c=relaxed/simple;
	bh=zn7/Mgfu6z/4MIpO86n81HjFLAX8EANlwORyqEV34j0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rrCdw/nKb43aEQtuP6GUzn4lWI8W33KS8igHFD4EYG0Ag0jv0D6hK/fgTV22Ir3mEcHKeyUYtNBXBA3laHcbRcFZePxhaY+levmnb+Ph5Pkwj9yUoDBwcomrW0kFslPNg4hx7WqjIlq1sZ8yx79W+9bjqLQQFU50rEEmRnmb9Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 8101449945;
	Wed, 29 Oct 2025 00:09:21 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id 867FE20024;
	Wed, 29 Oct 2025 00:09:16 +0000 (UTC)
Date: Tue, 28 Oct 2025 20:09:55 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Arnaldo
 Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>,
 Indu Bhagat <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>,
 Beau Belgrave <beaub@linux.microsoft.com>, Jens Remus
 <jremus@linux.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, Florian Weimer
 <fweimer@redhat.com>, Sam James <sam@gentoo.org>, Kees Cook
 <kees@kernel.org>, Carlos O'Donell <codonell@redhat.com>
Subject: Re: [PATCH v16 4/4] perf tools: Merge deferred user callchains
Message-ID: <20251028200955.0340ae1c@gandalf.local.home>
In-Reply-To: <20251024130203.GC3245006@noisy.programming.kicks-ass.net>
References: <20250908175319.841517121@kernel.org>
	<20250908175430.639412649@kernel.org>
	<20251002134938.756db4ef@gandalf.local.home>
	<20251024130203.GC3245006@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: s83ogzogzibnpwpdr7u1e4k6r9bahc13
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 867FE20024
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19rKG5R5mSBL4RI6DA9hDmkitecXs2Ve6E=
X-HE-Tag: 1761696556-616127
X-HE-Meta: U2FsdGVkX186yRanWr15TKP/V7dgTJ5pJjNT8Qf8W1MTctYl1Wud062AX/34wZL7UA3kO+CIHwvKBGtEm+Fe5ZR8+ENT9XdsvdRwqAtQ/XNx26Km/RI3T8zO1A0YrtnEU/6E6u49zw2MSnQvM+9bFjLjmnzjMlGu00fZONCaCkrhThdHIpCLQLdKYRXGK7+2PIq9vzDT/Zdbb+u6FlQ9R+zGdzue2aMEUAbAuL+QUNGEaFKfgHn5dmyssE3Im47Qkb/tuVx3MGnM56pYldJCzI7S87uA9i77m/fTSW5PE8yTYzuq9DQwNDTseCyrWOZubu9I+jL0jkWBzOBLeEvxJfG7RWB62xXf7tMfZJngxeeDJ8R5NXyrJMim4DFXBQDu

On Fri, 24 Oct 2025 15:02:03 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> > The sample__merge_deferred_callchain() initializes both
> > orig_sample.deferred_callchain and the callchain. But now that it's not
> > being called, it can cause the below free to happen with junk as the
> > callchain. This needs:
> > 
> > 		else
> > 			orig_sample.deferred_callchain = false;  
> 
> Ah, so I saw crashes from here and just deleted both free()s and got on
> with things ;-)

I just downloaded your tree again and it doesn't look like it was updated.

Just didn't want you to forget about this ;)

-- Steve

