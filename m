Return-Path: <bpf+bounces-67740-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF14B496DA
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 19:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B9833B4482
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 17:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964B03128A7;
	Mon,  8 Sep 2025 17:20:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1E6215F4A;
	Mon,  8 Sep 2025 17:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757352038; cv=none; b=ipJ1Fw/khAXR5f6mGsMjFfxSrFUQEU/bmgL2e8TK2pbAvvr383UadV6+7dDfWm8oN3pkajTaapLbd3SHV5AhjsDn5RLeiUtdUWJpe0h8OblI1X+Gc5J+V56d+mFLOUMA+i7DgbUbvoTEtxTeu5pAdLbFnlRXlEF7PWAZa6p0eMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757352038; c=relaxed/simple;
	bh=CS/zVkAdwqJuw1dmgpUdwoAji4piFHhOZapySBMokZM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VfD4o7Lzc57bTZsyRK1xjAc258hPWikOeF5i8fUqpwGJ4seH8yCb/wVK9ur6UjPa8cW1ZaQPpF9gwIgonEWxhyGtkeR/3b3KMcfg4Pjpw0vCv++2hkRQDOcfQuF0ZnAQBLF3ctvQMAbFi/YFTOxzl2dSjkYisiN+aLTQM2MZQxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id BB2CFC01FE;
	Mon,  8 Sep 2025 17:20:25 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id 96AC820016;
	Mon,  8 Sep 2025 17:20:20 +0000 (UTC)
Date: Mon, 8 Sep 2025 13:21:06 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>,
 "Jose E. Marchesi" <jemarch@gnu.org>, Beau Belgrave
 <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>, Linus
 Torvalds <torvalds@linux-foundation.org>, Andrew Morton
 <akpm@linux-foundation.org>, Florian Weimer <fweimer@redhat.com>, Sam James
 <sam@gentoo.org>, Kees Cook <kees@kernel.org>, "Carlos O'Donell"
 <codonell@redhat.com>
Subject: Re: [RESEND][PATCH v15 0/4] perf: Support the deferred unwinding
 infrastructure
Message-ID: <20250908132106.435b0e6f@gandalf.local.home>
In-Reply-To: <20250908171412.268168931@kernel.org>
References: <20250908171412.268168931@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 4kt1e6fk88dmkbfxpwi3d8tn3ndriaq3
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 96AC820016
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+2yHLmgm+7ni2h79Iu8dQa9mquDqjI9Es=
X-HE-Tag: 1757352020-988652
X-HE-Meta: U2FsdGVkX1/JNFh5XfDKE39cK5sgjeJ4mGcnRUWIEUmw/WScinmxEFigJZmIr2drxN/LC4Ar5tCW9rO01AbV6eaV7hrxSCtQ1Cuw20eJfnoWF6bmHbKNlJzD29YjJLRhHPCQCVLZCkI2iJUH7gNdU9NmgjpUfAooy5KXNsBvxbddEkW8im2UG2P+MQuyNFCsc1w4SEADQjUVWUREbdUazNXCLHtrP8vbDYztQWcpnwgT+JcfCSxBVLwU9wOaWWUGYeqDzQAeKMlUllG/+X9zzz4ZopQ/wUip/auivXVlgeDB7s9M+UEqEsxV0VMU3lARBiKOsGeom9ovqtttcWXan21JJijMw/9E


Peter, can you take a look at these patches please. I believe you're the
only one that really maintains this code today.

-- Steve


On Mon, 08 Sep 2025 13:14:12 -0400
Steven Rostedt <rostedt@kernel.org> wrote:

> [
>   This is simply a resend of version 15 of this patch series
>   but with only the kernel changes. I'm separating out the user space
>   changes to their own series.
>   The original v15 is here:
>     https://lore.kernel.org/linux-trace-kernel/20250825180638.877627656@kernel.org/
> ]
> 
> This patch set is based off of perf/core of the tip tree:
>   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
> 
> To run this series, you can checkout this repo that has this series as well as the above:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git  unwind/perf-test
> 
> This series implements the perf interface to use deferred user space stack
> tracing.
> 
> Patch 1 adds a new API interface to the user unwinder logic to allow perf to
> get the current context cookie for it's task event tracing. Perf's task event
> tracing maps a single task per perf event buffer and it follows the task
> around, so it only needs to implement its own task_work to do the deferred
> stack trace. Because it can still suffer not knowing which user stack trace
> belongs to which kernel stack due to dropped events, having the cookie to
> create a unique identifier for each user space stack trace to know which
> kernel stack to append it to is useful.
> 
> Patch 2 adds the per task deferred stack traces to perf. It adds a new event
> type called PERF_RECORD_CALLCHAIN_DEFERRED that is recorded when a task is
> about to go back to user space and happens in a location that pages may be
> faulted in. It also adds a new callchain context called PERF_CONTEXT_USER_DEFERRED
> that is used as a place holder in a kernel callchain to append the deferred
> user space stack trace to.
> 
> Patch 3 adds the user stack trace context cookie in the kernel callchain right
> after the PERF_CONTEXT_USER_DEFERRED context so that the user space side can
> map the request to the deferred user space stack trace.
> 
> Patch 4 adds support for the per CPU perf events that will allow the kernel to
> associate each of the per CPU perf event buffers to a single application. This
> is needed so that when a request for a deferred stack trace happens on a task
> that then migrates to another CPU, it will know which CPU buffer to use to
> record the stack trace on. It is possible to have more than one perf user tool
> running and a request made by one perf tool should have the deferred trace go
> to the same perf tool's perf CPU event buffer. A global list of all the
> descriptors representing each perf tool that is using deferred stack tracing
> is created to manage this.
> 
> 
> Josh Poimboeuf (1):
>       perf: Support deferred user callchains
> 
> Steven Rostedt (3):
>       unwind deferred: Add unwind_user_get_cookie() API
>       perf: Have the deferred request record the user context cookie
>       perf: Support deferred user callchains for per CPU events
> 
> ----
>  include/linux/perf_event.h            |  11 +-
>  include/linux/unwind_deferred.h       |   5 +
>  include/uapi/linux/perf_event.h       |  25 +-
>  kernel/bpf/stackmap.c                 |   4 +-
>  kernel/events/callchain.c             |  14 +-
>  kernel/events/core.c                  | 421 +++++++++++++++++++++++++++++++++-
>  kernel/unwind/deferred.c              |  21 ++
>  tools/include/uapi/linux/perf_event.h |  25 +-
>  8 files changed, 518 insertions(+), 8 deletions(-)


