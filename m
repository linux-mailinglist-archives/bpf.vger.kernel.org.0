Return-Path: <bpf+bounces-62151-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E986AF5EEA
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 18:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C0034A47B0
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 16:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F096B2F50AA;
	Wed,  2 Jul 2025 16:42:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178572F5082;
	Wed,  2 Jul 2025 16:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751474547; cv=none; b=KAmXNK8bjBv+6cyqYi9A0jsD4RylYmlJKHJcJ2q5KT+ISSuPFkLxS49tY0kg/Bp/mpy+8zUpCR4YNRy3UDd1B93h1J746+Wuu3vq3uphhWJoPxSSPN/9ndc5VvzXm+wprswhV7tR5dWMQOHpSJFVWdyqbEywsA4iyLGVohwpLkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751474547; c=relaxed/simple;
	bh=U8aPLyto8xSPmI62s9flWlkDCRFEVUR3nhkdg5FeI8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N8JR4EwpSehd2CVQalO8wQNlpH6t2dgekKjfaMY1UlQEc95VAjVq6aQ30coT6n1fNT94PPXgajGNXcdbDimdvYF6LFcm5uBsfi+9TZueE6a75dlY2XF+PD0AGYajoBRw2soVXcaehWHjYXR5DmpM13NZU8QK62SfdRPz1lpulJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 0D0571A0318;
	Wed,  2 Jul 2025 16:42:22 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id C7FB920026;
	Wed,  2 Jul 2025 16:42:17 +0000 (UTC)
Date: Wed, 2 Jul 2025 12:42:16 -0400
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
 <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Florian Weimer
 <fweimer@redhat.com>
Subject: Re: [PATCH v12 06/14] unwind_user/deferred: Add deferred unwinding
 interface
Message-ID: <20250702124216.4668826a@batman.local.home>
In-Reply-To: <20250702163609.GR1613200@noisy.programming.kicks-ass.net>
References: <20250701005321.942306427@goodmis.org>
	<20250701005451.571473750@goodmis.org>
	<20250702163609.GR1613200@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: netenn7xkwzyb68prgsnpoueqzis7abs
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: C7FB920026
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+dRp69bIojykbTPxqDmsm3YNIBsrva6g4=
X-HE-Tag: 1751474537-827306
X-HE-Meta: U2FsdGVkX1/9l6Hc4CnX+5NXEHskW+UT46irJWG5vv08Df97E/drCeCunumjuC0YYsED3AKXgM+w2wf/RA3px3yhczxzFFuX+aNEJMKutkSDh7raaBMGAeczkysbB/Qhdo4btImdnZV+WrQ/kv73w6kAZJuDA4ZaT3CGaYb5ryLOEKD0iHFh83qlJ4Or97fN+kwAVLjn6C2hcw3t+diqjiPYjLGjbcee37aqj02vdQ6IP0u4LnchumWU4W0JLolUF2HTyFo+QHh9WbQuWIgrhs5nZR5U7DrSQqa8MWdsjyLcjGENFUUwKRYusAsvQeSBmhnx3KCiwmeDeREF2/DZQuzwQ4+ifAXK4uJGp3+5m9tCxuB3wDoo3mDa62HsCkoF

On Wed, 2 Jul 2025 18:36:09 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> > +static u64 get_timestamp(struct unwind_task_info *info)
> > +{
> > +	lockdep_assert_irqs_disabled();
> > +
> > +	if (!info->timestamp)
> > +		info->timestamp = local_clock();
> > +
> > +	return info->timestamp;
> > +}  
> 
> I'm very hesitant about this. Modern hardware can do this, but older
> hardware (think Intel Core and AMD Bulldozer etc hardware) might
> struggle with this. They don't have stable TSC and as such will use
> the magic in kernel/sched/clock.c; which can get stuck on a window
> edge for a little bit and re-use timestamps.

Well, the idea of using timestamps came from Microsoft as that's what
they do for a similar feature. It just seemed like an easier approach.
But I could definitely go back to the "cookie" idea that is just a per
cpu counter (with the CPU number as part of the cookie).

As the timestamp is likely not going to be as useful as it is with
Microsoft as there's no guarantee that the timestamp counter used is
the same as the timestamp used by the tracer asking for this, the cookie
approach may indeed be better.

-- Steve

