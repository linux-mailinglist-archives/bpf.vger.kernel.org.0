Return-Path: <bpf+bounces-69019-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 514A8B8BA28
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 01:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 133BA178681
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 23:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C03262FDD;
	Fri, 19 Sep 2025 23:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A01+nJEj"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B60523A;
	Fri, 19 Sep 2025 23:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758324846; cv=none; b=ieKD+OBjBWN1wR31NoRWPzecWdjhY06yWDb9yauMMizcOvMJLPMJWE1U5lmOPrfcjJ+LNdUokrfEoXq7R6wlS42d6KnSCd6aUgkO30FErroKKczYjfpPM4m0Y484pyWlbBrmlVdmcMOo1lb+mS9eBw+Wdy1FQsOxbHSpeQInEOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758324846; c=relaxed/simple;
	bh=Kot04m3JebeuguS1IxyvQpD3d0BuR5ZYLFS9ssS3oQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lsSKFxoMfcbPb6YvPQAeIu3U7wTtSd8yf08ok70TX0NMZHtFtsH8copZawYW0oOLqP6CD0iKAvD5A3csGiyERqwd3yH7H21abtx4tHAZdZHETMK0x3FU0h7FhtvhXfztagzoPr7Czo1UjvD2zFo2TqIQ8Ug0MI71mNu2vKBl3d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A01+nJEj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35F8BC4CEF0;
	Fri, 19 Sep 2025 23:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758324845;
	bh=Kot04m3JebeuguS1IxyvQpD3d0BuR5ZYLFS9ssS3oQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A01+nJEj6CRn7EQvzk6UHgBogoIdLUpBHREyHJZ/KzSIZy1k9D50tGm1OvjIhl5eD
	 XBFDaWov4sydmsL2+x7xLx49d8qfyJ1YAf58inJcHUEUDbEO8Lt7dIbqFcaNBweEyp
	 qyGyLp/8Ga3MjDehRlC6fXgCIjPV7ub2T6FWQULh7xgnQndbrhbwdbfafA0E/n829O
	 ZjymGRxjFo1qkuvoqB2Umm75flLR2ZETV3zqET56Ks6dv520rGTnYYk691B75PCHV1
	 /fYDjPahjdLZfhw9CmuFY+CiDKrI7gN7jDvNKG6WQtEH9YPzID0zEFAFErFvvspWAD
	 reuTa7VtP/0xg==
Date: Fri, 19 Sep 2025 16:34:02 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, 
	Indu Bhagat <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, 
	Beau Belgrave <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Florian Weimer <fweimer@redhat.com>, Sam James <sam@gentoo.org>, Kees Cook <kees@kernel.org>, 
	Carlos O'Donell <codonell@redhat.com>
Subject: Re: [RESEND][PATCH v15 0/4] perf: Support the deferred unwinding
 infrastructure
Message-ID: <pde32olzdlqvbom5bya5exndcrfgsw7lmffy6uav5yoplonzj3@ddb2b5sihlpx>
References: <20250908171412.268168931@kernel.org>
 <20250918114610.GZ3419281@noisy.programming.kicks-ass.net>
 <20250918111853.5dc424df@gandalf.local.home>
 <20250918172414.GC3409427@noisy.programming.kicks-ass.net>
 <20250918173220.GA3475922@noisy.programming.kicks-ass.net>
 <20250918151018.7281647b@batman.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250918151018.7281647b@batman.local.home>

On Thu, Sep 18, 2025 at 03:10:18PM -0400, Steven Rostedt wrote:
> On Thu, 18 Sep 2025 19:32:20 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > > Now, task_work_run() is in the exit_to_user_mode_loop() which is notably
> > > *before* exit_to_user_mode() which does the unwind_reset_info().
> > > 
> > > What happens if we get an NMI requesting an unwind after
> > > unwind_reset_info() while still very much being in the kernel on the way
> > > out?  
> > 
> > AFAICT it will try and do a task_work_add(TWA_RESUME) from NMI context,
> > and this will fail horribly.
> > 
> > If you do something like:
> > 
> > 	twa_mode = in_nmi() ? TWA_NMI_CURRENT : TWA_RESUME;
> > 	task_work_add(foo, twa_mode);
> > 
> > it might actually work.
> 
> Ah, the comment for TWA_RESUME didn't express this restriction.
> 
> That does look like that would work as the way I expected task_work to
> handle this case.

BTW, I remember Peter had a fix for TWA_NMI_CURRENT, I guess it got lost
in the shuffle or did something else happen in the meantime?

  https://lore.kernel.org/20250122124228.GO7145@noisy.programming.kicks-ass.net

-- 
Josh

