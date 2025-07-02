Return-Path: <bpf+bounces-62183-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1436AF625C
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 21:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D49747B3137
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 19:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D0422257E;
	Wed,  2 Jul 2025 19:05:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A171CFBC;
	Wed,  2 Jul 2025 19:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751483151; cv=none; b=urSwMPQ+cxzBvwN+QdfVzF/ZANaHkgrf50oEWuwUYcYr/MToGZreajPSb35igcItikYBfMNWjjSF/YN91KYcODvzaKBh4EWsBr/KbmihkXJbzQE93atRulWRrayArQIFRB1QMPZGGqPD4V/79jYU5i4NvWeL4gH6BYWdGVIKIO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751483151; c=relaxed/simple;
	bh=c8ok4QMFo7+HEcYyTCRfFIXnQO9UbXOGRRngVgllYuc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sQhvWI/Q6BnsslbeRwP2N/5czmxbPSO04MTIXzsEXS/Mahi7SqnSLPSe+lt03H2VsrguPjIJ1ZIhqYYabeHo3JCHfsnql/n/eMquo4HTGNDpJ6cBBvsK2INlHoRH6WZSwh0YzrdsXp6xoJ19hnZ+RQHkjQBWRJ1T82ABickrK+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 219231A03FE;
	Wed,  2 Jul 2025 19:05:41 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id 657376000F;
	Wed,  2 Jul 2025 19:05:36 +0000 (UTC)
Date: Wed, 2 Jul 2025 15:05:35 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra
 <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa
 <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat
 <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, Beau
 Belgrave <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
 Florian Weimer <fweimer@redhat.com>
Subject: Re: [PATCH v12 06/14] unwind_user/deferred: Add deferred unwinding
 interface
Message-ID: <20250702150535.7d2596df@batman.local.home>
In-Reply-To: <482f6b76-6086-47da-a3cf-d57106bdcb39@efficios.com>
References: <20250701005321.942306427@goodmis.org>
	<20250701005451.571473750@goodmis.org>
	<20250702163609.GR1613200@noisy.programming.kicks-ass.net>
	<20250702124216.4668826a@batman.local.home>
	<CAHk-=wiXjrvif6ZdunRV3OT0YTrY=5Oiw1xU_F1L93iGLGUdhQ@mail.gmail.com>
	<20250702132605.6c79c1ec@batman.local.home>
	<20250702134850.254cec76@batman.local.home>
	<CAHk-=wiU6aox6-QqrUY1AaBq87EsFuFa6q2w40PJkhKMEX213w@mail.gmail.com>
	<482f6b76-6086-47da-a3cf-d57106bdcb39@efficios.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 5mpzyodm5431gmmcpfg86rfgqxrczaqw
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 657376000F
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/+DRI7nGHYvaDXc4bHmI+irhRtiHvIlS0=
X-HE-Tag: 1751483136-110189
X-HE-Meta: U2FsdGVkX18P5Kt6XSMAA0+QuG1ZCGAPnK0nT8CEIBBYVyBEw3fBTeemYEUDHYv2lwZ7I20iXQFQAJsuVVtfAaawqiuJVNsNQGQdvzLeRplwZSn7w01TIv7E6m7rgKrvbVAMpUnYbaIrhXlDLDnmCqXvVB3cGpRgcDLCcWEbFr07cm6G8yikh2hvfY4dLpqx2OIbTmCLkdHeO3o4RUq5ZOjAl/ZA8/1zXvU7pC8fXvVtkufYw7dz1IKIm1QXfGWleOsu7wyqLkdUZBoU0Kztbg0H9oE/7RncmXWkYLIw5tsBvs4myZR3D3TO8pikjPOIL+EpdnhGwFrQfNbjyoPvAkOjb+uUTwQcDxiRWJvPzuHtdNnyzdhqauxqW2pyeSPz

On Wed, 2 Jul 2025 14:47:10 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
> AFAIR, one of the goals here is to save the cookie into the trace
> to allow trace post-processing to link the event triggering the
> unwinding with the deferred unwinding data.
> 
> In order to make the trace analysis results reliable, we'd like
> to avoid the following causes of uncertainty, which would
> mistakenly cause the post-processing analysis to associate
> a stack trace with the wrong event:
> 
> - Thread ID re-use (exit + clone/fork),
> - Thread migration,
> - Events discarded (e.g. buffer full) causing missing
>    thread lifetime events or missing unwind-related events.
> 
> Unless I'm missing something, the per-thread counter would have
> issues with thread ID re-use during the trace lifetime.

But you are missing one more thing that the trace can use, and that's
the time sequence. As soon as the same thread has a new id you can
assume all the older user space traces are not applicable for any new
events for that thread, or any other thread with the same thread ID.

Thus the only issue that can truly be a problem is if you have missed
events where thread id wraps around. I guess that could be possible if
a long running task finally exits and it's thread id is reused
immediately. Is that a common occurrence?

-- Steve.


