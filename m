Return-Path: <bpf+bounces-62188-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9514AF62CC
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 21:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1794E1C44F48
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 19:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE36B2F5327;
	Wed,  2 Jul 2025 19:40:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715BF2E49B6;
	Wed,  2 Jul 2025 19:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751485258; cv=none; b=PEfm4+o1eWBWcWefgC1GsJCoG8C7QeszCHHRV1U2ELu/kYlMOFTbli+1x6v0pxFZITatfzFEx3ieEdOIkK8DqQMWGjt/T52AeLOepl1PcPO6XC6zsWqDagLBB10lyBfIjv2QFna4cwmh6uUbQwkXMarSMqWbfGkI+NaXl1qt2Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751485258; c=relaxed/simple;
	bh=bfbeJ1ZIKCy40rKkbDEbq4uSiGrhzMAtzssHyRFA6gs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=duEVVIl57ckpMi/de/V1Iazbzg9JHblfXiDch1b6SYkFHmMblrg1gbwb0fpiyzZ672UkWGlQNcKR1zGg9jCm3Fv6Ma6F/NKxnTvHaEEaM4fgM30q2+qDMRS7pDU560s1gMU/0JPeXFM71sIQLbthykq6vmg4LLN2DfuVoteX4Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id D0F291A040C;
	Wed,  2 Jul 2025 19:40:53 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id 8462B6000F;
	Wed,  2 Jul 2025 19:40:49 +0000 (UTC)
Date: Wed, 2 Jul 2025 15:40:48 -0400
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
Message-ID: <20250702154048.71c5a63d@batman.local.home>
In-Reply-To: <20250702153600.28dcf1e3@batman.local.home>
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
	<20250702153600.28dcf1e3@batman.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 35ma67p6fbj1jjshpxt47oqxgzs3jyd7
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 8462B6000F
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18phC46JlPG/lKCcrynhyw3nm8a5WQ6vPI=
X-HE-Tag: 1751485249-607143
X-HE-Meta: U2FsdGVkX18pCKSv8Or9Fr0wWN+mCrW/Ckyll/SWVmKjNsCEzN4WY3H+vUgu5jgSygneemTARZCAGgOQY8MOIuoL/K8DXyO7+93MHlHYFuzumSwWvzTm4HOAzrVZuS8/NnMyzrbKi+q2zlbFpEiFeehQCZ+nvzMg1QnUKJGbRCSi1Da4oJCo2aHfXOM6J/rX0V4fhHKauvu3EZYjBzkpH1QvwXqzbUMpPZxLFCrlL4QUC3aj4Aa9OCggS3+kTVVtKZZqvAF5Keqiq8ectlEONR8/QLxgEu5SPifvuUYb6u1+82tZ4Zvykgv404qftukqiLhm9oyEPaCy3F4Mzqp6L36mVs7Q2YBLZ5Ap+xo8+p9HJVaspC9ZyLuXQ4StlRr3

On Wed, 2 Jul 2025 15:36:00 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> union unwind_task_id {
> 	struct {
> 		u32		task_id;
> 		u32		cnt;
> 	}
> 	u64 id;
> };
> 
> static u64 get_cookie(struct unwind_task_info *info)
> {
> 	u32 cnt = READ_ONCE(info->id.cnt);
> 	u32 new_cnt;
> 
> 	if (cnt & 1)
> 		return info->id;
> 
> 	if (unlikely(!info->id.task_id)) {
> 		u32 task_id = local_clock();
> 
> 		cnt = 0;
> 		if (try_cmpxchg(&info->id.task_id, &cnt, task_id))
> 			task_id = cnt;
> 	}
> 
> 	new_cnt = cnt + 3;
> 	if (try_cmpxchg(&info->id, &cnt, new_cnt))
> 		new_cnt = cnt; // try_cmpxchg() expects something
> 
> 	return info->id;
> }

Honestly I think this is way overkill. What I would do, is to have the
cookie saved in the event be 64 bit, but we can start with the
simple 32 bit solution keeping the top 32 bits zeros. If this does
indeed become an issue in the future, we could fix it with a 64 bit
number. By making sure all the exposed "cookies" are 64 bit, it should
not break anything. The cookie is just supposed to be a random unique
number that associates a request with its deferred user space stack
trace.

With any exposed cookies to user space being 64 bits, this should not
be an issue to address in the future.

-- Steve

