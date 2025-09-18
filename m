Return-Path: <bpf+bounces-68852-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D623B869FC
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 21:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED7681C87164
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 19:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D822D063C;
	Thu, 18 Sep 2025 19:10:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479671B424F;
	Thu, 18 Sep 2025 19:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758222636; cv=none; b=RvaGYxd8kw1/DglhuMiOJensFjQSqc2rUp+BUK/tIQpCikzL097ll2G6VXZcJ6+go3M3blRz/cgNKH6EoZ0FAo0AbjKv8oM8iL1lBcFb9NCokvzAalX+YRz00nhVJpL1YjHe35fYvSE+m8Sl52uNH4qjHLwQlSti30k9knL8Uo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758222636; c=relaxed/simple;
	bh=9SZR+SuTYIC8MLH7n/Yq2yFZOALoWMg54qW6QG2HcGI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R7sTvp6F3TEtb3b475ZYc5H2qcf+J7nHcv0/plm/6jCOfT9urCUUlFfo7tKyt4tDT8QrI2dAJuMJ7o7Ab+tObIHrH9Iyb8PCRKMxMi8fDaG7Mav5OEI/YA4KHphfLp/mNbS/ed+zgFJAI73FDRiUljwDPHQ62ae4cA3EXvMlNr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 411791DE95D;
	Thu, 18 Sep 2025 19:10:25 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id D67712000E;
	Thu, 18 Sep 2025 19:10:19 +0000 (UTC)
Date: Thu, 18 Sep 2025 15:10:18 -0400
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
Subject: Re: [RESEND][PATCH v15 0/4] perf: Support the deferred unwinding
 infrastructure
Message-ID: <20250918151018.7281647b@batman.local.home>
In-Reply-To: <20250918173220.GA3475922@noisy.programming.kicks-ass.net>
References: <20250908171412.268168931@kernel.org>
	<20250918114610.GZ3419281@noisy.programming.kicks-ass.net>
	<20250918111853.5dc424df@gandalf.local.home>
	<20250918172414.GC3409427@noisy.programming.kicks-ass.net>
	<20250918173220.GA3475922@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D67712000E
X-Stat-Signature: h1hgkh88tuibdg3mt1ehcpsxxxdt3gir
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/zbrh9fWamytU6OGKlVUT/UuZ68vGirDg=
X-HE-Tag: 1758222619-146320
X-HE-Meta: U2FsdGVkX19b91weo4g1HI+eRc29F0KZYjyDDZ5n7luQgDFeo3pumYSHPARppijOoR7nLeGpkqbqOqSBVUgcD0uyw4ARnoZ8OkS2tP91QTa+5ShhqVanQXvkdQNz+1PaygLEQZ0Zyd6x0XkEkGFcKjjmLFA4PWrf3JHwYDKLSOg5pEzSGxl6ZPZ4TLHbMJYju8VwewgBwdUVZYOARYRhCt3+eHcdMQF+XfotU7PHOYTcSBu/EF7V7gi7Gbym8yvW7oNPzntLcHrSOO+C/RP4YpEaPW6c5E59tQQcRVNIMg1nU4qtl/i/db66SYD3jtYt7CBF6iq8RRMNVMnvEcG2iZkG6BS5eRo4vBLvv6itELqD2840DkVgXddlcGp6urGc

On Thu, 18 Sep 2025 19:32:20 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> > Now, task_work_run() is in the exit_to_user_mode_loop() which is notably
> > *before* exit_to_user_mode() which does the unwind_reset_info().
> > 
> > What happens if we get an NMI requesting an unwind after
> > unwind_reset_info() while still very much being in the kernel on the way
> > out?  
> 
> AFAICT it will try and do a task_work_add(TWA_RESUME) from NMI context,
> and this will fail horribly.
> 
> If you do something like:
> 
> 	twa_mode = in_nmi() ? TWA_NMI_CURRENT : TWA_RESUME;
> 	task_work_add(foo, twa_mode);
> 
> it might actually work.

Ah, the comment for TWA_RESUME didn't express this restriction.

That does look like that would work as the way I expected task_work to
handle this case.

-- Steve

