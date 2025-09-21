Return-Path: <bpf+bounces-69165-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27459B8E983
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 01:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D565189A591
	for <lists+bpf@lfdr.de>; Sun, 21 Sep 2025 23:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B222724A06B;
	Sun, 21 Sep 2025 23:33:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C962019CC02;
	Sun, 21 Sep 2025 23:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758497637; cv=none; b=PUXP1ak4fvpN7eeH435jeK1BCbPqHiS8+zUfZP9l0JDgpVn5SqxW1K+tqmZiibgz+a4xhiSHCbj+6Z09ShfIKaeGwy+4HMC8O+mhqBn4rLUri4bC2KzdMDsxPKro3w5Fz1MftgctzBeGjJnefbteYYP5m61w+6B26T6xWEmpYgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758497637; c=relaxed/simple;
	bh=Yf3UQklLmhe1vv51Dn6kgpYDqK6rXBdXw1BYHLIUJIw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PtKbkr0UrbiM3ANO36D2eLkvR4dW5cUVa8Xv1bdcCZWjJNg61KCDmBRTUL1oFBsrjVVDWA6bybrL0T9a27zOBEQYkXXkXtDRAx0vnsjdKWhgYp7MHo4vaetOLaCM8g3O8I2w1wWMx1UDef46IhAjfmk6Vuf99L6uXE79zjygUL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 19965C0405;
	Sun, 21 Sep 2025 23:33:46 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id D2DBE20011;
	Sun, 21 Sep 2025 23:33:41 +0000 (UTC)
Date: Sun, 21 Sep 2025 19:33:40 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Steven Rostedt
 <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa
 <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung
 Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Andrii
 Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>, "Jose
 E. Marchesi" <jemarch@gnu.org>, Beau Belgrave <beaub@linux.microsoft.com>,
 Jens Remus <jremus@linux.ibm.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>,
 Florian Weimer <fweimer@redhat.com>, Sam James <sam@gentoo.org>, Kees Cook
 <kees@kernel.org>, Carlos O'Donell <codonell@redhat.com>
Subject: Re: [RESEND][PATCH v15 0/4] perf: Support the deferred unwinding
 infrastructure
Message-ID: <20250921190956.0709dfff@batman.local.home>
In-Reply-To: <pde32olzdlqvbom5bya5exndcrfgsw7lmffy6uav5yoplonzj3@ddb2b5sihlpx>
References: <20250908171412.268168931@kernel.org>
 <20250918114610.GZ3419281@noisy.programming.kicks-ass.net>
 <20250918111853.5dc424df@gandalf.local.home>
 <20250918172414.GC3409427@noisy.programming.kicks-ass.net>
 <20250918173220.GA3475922@noisy.programming.kicks-ass.net>
 <20250918151018.7281647b@batman.local.home>
 <pde32olzdlqvbom5bya5exndcrfgsw7lmffy6uav5yoplonzj3@ddb2b5sihlpx>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: mh6isozgpb7fnk9p8zx3hazq3uig46iq
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: D2DBE20011
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18+d36eC/qktbvrhxTA9YT6i/6m3FQ+OTM=
X-HE-Tag: 1758497621-436331
X-HE-Meta: U2FsdGVkX18yJnjfWuD4l8P/8kQQLBF7dpWHFBcLfLM7PszIA87E/ipUCOOv654S7jhQpIuL4mINNOnscFa2w2ZnVbx3VPvobiTSJLw0WkRpqM1YubmwCp9RflyzSlC9PkUcp7jKaNfl/Ph4qgx0JCh87EOmtwJx3ef1YfSAESQ34PIczQQDVX7m9416fLhjqn7HZ7CTO+AHkYr6DEcf8PQxK+7XhqRE2XF9Ludqww4bOjyC2n71nZT6pEhct6/6iML0im6izcWGhuNr2D5QAgLtQ8foUfzSWD//jKXgpWuucBvcWFEZvVILff/9TclOAyVkSSXvu0Np2Kk8yKMTHf7H2GVZP9mmhe/FBjmSFTQX97Q+FsvTOZe4LUc1akYMAPUOavgcuF/dnVNLLTOrWw==

On Fri, 19 Sep 2025 16:34:02 -0700
Josh Poimboeuf <jpoimboe@kernel.org> wrote:

> > That does look like that would work as the way I expected task_work to
> > handle this case.  
> 
> BTW, I remember Peter had a fix for TWA_NMI_CURRENT, I guess it got lost
> in the shuffle or did something else happen in the meantime?
> 
>   https://lore.kernel.org/20250122124228.GO7145@noisy.programming.kicks-ass.net

Yeah, it did get lost in the shuffle. I took the code from your git
tree, but missed the comments that were made to the patches you sent to
the mailing list. :-p

Thanks for pointing this out!

-- Steve

