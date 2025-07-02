Return-Path: <bpf+bounces-62187-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33BD0AF62B9
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 21:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F5711BC48F7
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 19:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639972E49AF;
	Wed,  2 Jul 2025 19:36:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578C22F5097;
	Wed,  2 Jul 2025 19:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751484972; cv=none; b=SwogLVwyn6lmrgrw2XcUtSvzy6cbAvUtT3RzY+GDSnn/9scbkoK5jbhtE8aZtFzK0x0+mhiXl/fNYk5vquSuR5AgqIeDxHMEWw+SRKKUqTcrK6IIA6K/aLKIwu6iBY0PjFJriJ9fyhQQmkU7CUzTu2f4GjiCNhOxOyrl/UkSr7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751484972; c=relaxed/simple;
	bh=T7eFpeJ2hPR3UieIGjn0Xi34fdNGDcf9vVngY9MWc/g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ct8N97/Yxs8gy68lf3DIu1uhL1BB+2z/etLHAYX/n0eNhszYR7YTNbxsAkmuEIcgi5RdA83iHj3XcOErXmKSOOqj/EfPVnR/PfFbNHIQofGOKApAMPUJx5P4r1qYYuJUciA7qv0nmakpi6/K+q0rEZob2AbhVtgm1EyjNCqhCVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 9A8C71A0405;
	Wed,  2 Jul 2025 19:36:06 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id EA2A22000D;
	Wed,  2 Jul 2025 19:36:01 +0000 (UTC)
Date: Wed, 2 Jul 2025 15:36:00 -0400
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
Message-ID: <20250702153600.28dcf1e3@batman.local.home>
In-Reply-To: <20250702152111.1bec7214@batman.local.home>
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
	<20250702152111.1bec7214@batman.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: ydritzqo8d775n1uedxjm31s6uohtkmt
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: EA2A22000D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/lmDX9LuBokFVyEfJ3dwSWT/90/X0+QkM=
X-HE-Tag: 1751484961-985359
X-HE-Meta: U2FsdGVkX1++zpvjHyplHVBAcd6gg7t+pjp4SmB3sVgdaPV1zXwqTc3a89XcWRg6LZXw7U7aOCGk1Qqt8gZQ2HThc2fTjOE0E9hh4sAB7kGCMuzJ43ktcOaZJh5N46G+CxQ/T9NQIuvsDHGUF7gRJR8YS4eUNOiJZI3pDgYbg36rJpvbwjt0lVUP4Nx/E7EaV91nPG+iaiysEoHFPJ0sd5mskxZTIqzXJmHbnIHaPoEu8dmRmIl7FTjIBeM+g8ZFGoQNljUMEcqF9XZhFJo2qr9pVwNL87GN+Ek/7M2xN6pmDM7Gy0+dDESSarEjgBo6K6RupsifotbGdSEZTU2TfUrwk9Wflh+XT+k2vNfgIdhDcsJzVwccMAGB3rqb9a+R

On Wed, 2 Jul 2025 15:21:11 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> The only case is if you see a deferred request with id 1 for task 8888,
> then you start dropping all events and that task 8888 exits and a new
> one appears with task id 8888 where it too has a deferred request with
> id 1 then you start picking up events again and see a deferred stack
> trace for the new task 8888 where it's id is 1, you lose.

And if we want to fix that, we could make the cookie 64 bit again, and
set the timestamp on the first time it is used for the trace.

union unwind_task_id {
	struct {
		u32		task_id;
		u32		cnt;
	}
	u64 id;
};

static u64 get_cookie(struct unwind_task_info *info)
{
	u32 cnt = READ_ONCE(info->id.cnt);
	u32 new_cnt;

	if (cnt & 1)
		return info->id;

	if (unlikely(!info->id.task_id)) {
		u32 task_id = local_clock();

		cnt = 0;
		if (try_cmpxchg(&info->id.task_id, &cnt, task_id))
			task_id = cnt;
	}

	new_cnt = cnt + 3;
	if (try_cmpxchg(&info->id, &cnt, new_cnt))
		new_cnt = cnt; // try_cmpxchg() expects something

	return info->id;
}


So now each task will have its own id and even if we have a task wrap
around, the cookie will never be the same, as fork sets the info->id to
zero.

Yes, the local_clock() can wrap around, but now making all those the
same to cause an issue is extremely unlikely, and still, if it happens,
the worse thing that it causes is that the user space stack trace will
be associated to the wrong events.

-- Steve

