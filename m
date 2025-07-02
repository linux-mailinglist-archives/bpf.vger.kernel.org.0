Return-Path: <bpf+bounces-62186-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E017AF6287
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 21:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D17713A467E
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 19:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA062BE650;
	Wed,  2 Jul 2025 19:21:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC042F7CF5;
	Wed,  2 Jul 2025 19:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751484082; cv=none; b=DDMDTYKDC6miaFo4xHv8NxfJ+Pjz+MYO/JKC+u3Bd8DlM0OCS0Xe0n4h4/yUrWxWg8CdV6Hvtq3NX7Z7n32d4xtSdYp4OyJ/I0p1WTybWH7glQ9DT2rH413ZYqGnN9aPnXsvTghe8zN2gc0D9HBa1wFqKvztXQyaf741+2M+s74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751484082; c=relaxed/simple;
	bh=dueNBlsJVSAVJ2AlhlfnyDbPope+jpVaZnfUAMmtjv4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mIVBLnKCSyLyroT1ND3xqwXiT2yRcsSdwbcjReTBOsGxMFSVLNMMAFuTT19bVWkn8gZ6sdBKatN8vk9nSszQbA4aCfsH6eeFCk9c0UAa6FWbDYHDsvkvP9uQUgGIBCXh4e3HuJ/JdNODpAoIMqRy4uFjXxmmpBYc8z5xQcfRbtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 130A51D5FB3;
	Wed,  2 Jul 2025 19:21:17 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id AD6D06000F;
	Wed,  2 Jul 2025 19:21:12 +0000 (UTC)
Date: Wed, 2 Jul 2025 15:21:11 -0400
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
Message-ID: <20250702152111.1bec7214@batman.local.home>
In-Reply-To: <47a43d27-7eac-4f88-a783-afdd3a97bb11@efficios.com>
References: <20250701005321.942306427@goodmis.org>
	<20250701005451.571473750@goodmis.org>
	<20250702163609.GR1613200@noisy.programming.kicks-ass.net>
	<20250702124216.4668826a@batman.local.home>
	<CAHk-=wiXjrvif6ZdunRV3OT0YTrY=5Oiw1xU_F1L93iGLGUdhQ@mail.gmail.com>
	<20250702132605.6c79c1ec@batman.local.home>
	<20250702134850.254cec76@batman.local.home>
	<CAHk-=wiU6aox6-QqrUY1AaBq87EsFuFa6q2w40PJkhKMEX213w@mail.gmail.com>
	<482f6b76-6086-47da-a3cf-d57106bdcb39@efficios.com>
	<20250702150535.7d2596df@batman.local.home>
	<47a43d27-7eac-4f88-a783-afdd3a97bb11@efficios.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: ymt99nrw7w58osra5c1t68kcgjbx66gf
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: AD6D06000F
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+MPIlH+ZKwpz+NY4Y3E+2OcjN0mP5AlDI=
X-HE-Tag: 1751484072-743416
X-HE-Meta: U2FsdGVkX18C67Kx2uvUWXB1myunFSzqcXROa4Mz0sEEwtEUaH9GNNx/hF/sHro7iEOVSD7UV6dcPgmIJr2a66ei1TTkEldQiU5A+QZRZ0f85zfqac+USamVcYteesVH+K8xbPvMOmc0oXj1k2FdoKpW/0K2+Kleq4aRitZ9SJ1LMwCsN0qj8jeVzshPiI1H4huV5kSegQyVJKio34fE44Fk9Zl0eOOi5V6EH0O6LxyYA2w1DsKxlobc1F/QKF/w7MG3xUQuWarOeFulgNfIkz+9VmKdMyWKl/Dak4VN9SGoSk9cddRqrthXEZWp1YfXKyyGVuoj4VSrtZVHFwKqGgPwHAFwfaL+Xh8F3V1xNmZSKZGdbPkOgbh2OiZSXBof

On Wed, 2 Jul 2025 15:12:45 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> > But you are missing one more thing that the trace can use, and that's
> > the time sequence. As soon as the same thread has a new id you can
> > assume all the older user space traces are not applicable for any new
> > events for that thread, or any other thread with the same thread ID.  
> 
> In order for the scheme you describe to work, you need:
> 
> - instrumentation of task lifetime (exit/fork+clone),
> - be sure that the events related to that instrumentation were not
>    dropped.
> 
> I'm not sure about ftrace, but in LTTng enabling instrumentation of
> task lifetime is entirely up to the user.

Has nothing to do with task lifetime. If you see a deferred request
with id of 1 from task 8888, and then later you see either a deferred
request or a stack trace with an id other than 1 for task 8888, you can
then say all events before now are no longer eligible for new deferred
stack traces.

> 
> And even if it's enabled, events can be discarded (e.g. buffer full).

The only case is if you see a deferred request with id 1 for task 8888,
then you start dropping all events and that task 8888 exits and a new
one appears with task id 8888 where it too has a deferred request with
id 1 then you start picking up events again and see a deferred stack
trace for the new task 8888 where it's id is 1, you lose.

But other than that exact scenario, it should not get confused.

> 
> > 
> > Thus the only issue that can truly be a problem is if you have missed
> > events where thread id wraps around. I guess that could be possible if
> > a long running task finally exits and it's thread id is reused
> > immediately. Is that a common occurrence?  
> 
> You just need a combination of thread ID re-use and either no
> instrumentation of task lifetime or events discarded to trigger this.

Again, it's seeing a new request with another id for the same task, you
don't need to worry about it. You don't even need to look at fork and
exit events.

> Even if it's not so frequent, at large scale and in production, I
> suspect that this will happen quite often.

Really? As I explained above?

-- Steve

