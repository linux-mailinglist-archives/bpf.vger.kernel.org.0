Return-Path: <bpf+bounces-45514-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC70F9D6B74
	for <lists+bpf@lfdr.de>; Sat, 23 Nov 2024 21:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6450BB23A0A
	for <lists+bpf@lfdr.de>; Sat, 23 Nov 2024 20:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86ADA19DF66;
	Sat, 23 Nov 2024 20:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YF5uUcdX"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB5117BA6;
	Sat, 23 Nov 2024 20:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732393680; cv=none; b=QNdg1O6pKJ7jg1YFmYu7lZgV8sKHo+sLWcZfpH2wXU3G84ZuTDPCP/s3w8cJ427ADNnxH0+7nlKYH3cg6Ei9grk3oMpIbC2KCq7ERZaMUieuE4IRqEJdM2SO/5uuEB5xP/zDzoqRZSaDQzdWfh1oUMYrXXHlvo/us6mxvbtGtxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732393680; c=relaxed/simple;
	bh=SEGoX0bHr13Xtp65WJRcTpnLvGjowmoEsWzmlpyXLhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kJuhdTJvmDRjOJEZ/msAHfYZs3m/i9VNUqqO2fO01RhwfWcEPIaZ+Pni33JGRUeoPQrHwqn4bLDvF/oOW9JnH4TTt1VIhN2oIMn5clCrDrWLRsWQfq2n4vPxysxxkz2166MVQgPQil8RoSYYs2pmpeslT0PYT8QvlLY3GeC0++E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YF5uUcdX; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=257ZdKH+aJHSa1dbnLRZzHvINCigQhG1AP2blIFIDRU=; b=YF5uUcdXH9jLpzmqk7mrIr+sj4
	BGQFq7nVL90ADw+i0YnylVO4Xyslr8X1LE54duXEWUbwMWcqTRvAPMSVvVyifPAuFSSbk2syg2SLh
	IuSBqje1fLCx6zq4rXUfu6aiS75oD5KeqbNN0u0QqOIDhw3VLxIW7KTSBlrXTJ3IjISVDGER/tDsa
	cw58bW6gF7p6i4WezVv6mYQK9Xv35xl3RO34vX3Xg5niHLyAQ5xNIkSN35A8/40U/QrID5rbRtS4w
	5Gg6GsqzjJcGKrBHHepFnso0PtzIBrOu9YsNKWSb1b860OludckAAFG81ytsxAdx6xpmcdCmgA6Ca
	9cNruIZw==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tEwjH-00000009bQJ-3RPK;
	Sat, 23 Nov 2024 20:27:45 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 358FE300201; Sat, 23 Nov 2024 21:27:44 +0100 (CET)
Date: Sat, 23 Nov 2024 21:27:44 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Ruan Bonan <bonan.ruan@u.nus.edu>
Cc: "mingo@redhat.com" <mingo@redhat.com>,
	"will@kernel.org" <will@kernel.org>,
	"longman@redhat.com" <longman@redhat.com>,
	"boqun.feng@gmail.com" <boqun.feng@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kpsingh@kernel.org" <kpsingh@kernel.org>,
	"mattbobrowski@google.com" <mattbobrowski@google.com>,
	"ast@kernel.org" <ast@kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	"andrii@kernel.org" <andrii@kernel.org>,
	"martin.lau@linux.dev" <martin.lau@linux.dev>,
	"eddyz87@gmail.com" <eddyz87@gmail.com>,
	"song@kernel.org" <song@kernel.org>,
	"yonghong.song@linux.dev" <yonghong.song@linux.dev>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"sdf@fomichev.me" <sdf@fomichev.me>,
	"haoluo@google.com" <haoluo@google.com>,
	"jolsa@kernel.org" <jolsa@kernel.org>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"mhiramat@kernel.org" <mhiramat@kernel.org>,
	"mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Fu Yeqi <e1374359@u.nus.edu>
Subject: Re: [BUG] possible deadlock in __schedule (with reproducer available)
Message-ID: <20241123202744.GB20633@noisy.programming.kicks-ass.net>
References: <24481522-69BF-4CE7-A05D-1E7398400D80@u.nus.edu>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24481522-69BF-4CE7-A05D-1E7398400D80@u.nus.edu>

On Sat, Nov 23, 2024 at 03:39:45AM +0000, Ruan Bonan wrote:

>  </TASK>
> FAULT_INJECTION: forcing a failure.
> name fail_usercopy, interval 1, probability 0, space 0, times 0
> ======================================================
> WARNING: possible circular locking dependency detected
> 6.12.0-rc7-00144-g66418447d27b #8 Not tainted
> ------------------------------------------------------
> syz-executor144/330 is trying to acquire lock:
> ffffffffbcd2da38 ((console_sem).lock){....}-{2:2}, at: down_trylock+0x20/0xa0 kernel/locking/semaphore.c:139
> 
> but task is already holding lock:
> ffff888065cbd718 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested kernel/sched/core.c:598 [inline]
> ffff888065cbd718 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock kernel/sched/sched.h:1506 [inline]
> ffff888065cbd718 (&rq->__lock){-.-.}-{2:2}, at: rq_lock kernel/sched/sched.h:1805 [inline]
> ffff888065cbd718 (&rq->__lock){-.-.}-{2:2}, at: __schedule+0x140/0x1e70 kernel/sched/core.c:6592
> 
> which lock already depends on the new lock.
> 
>        _printk+0x7a/0xa0 kernel/printk/printk.c:2432
>        fail_dump lib/fault-inject.c:46 [inline]
>        should_fail_ex+0x3be/0x570 lib/fault-inject.c:154
>        strncpy_from_user+0x36/0x230 lib/strncpy_from_user.c:118
>        strncpy_from_user_nofault+0x71/0x140 mm/maccess.c:186
>        bpf_probe_read_user_str_common kernel/trace/bpf_trace.c:215 [inline]
>        ____bpf_probe_read_user_str kernel/trace/bpf_trace.c:224 [inline]
>        bpf_probe_read_user_str+0x2a/0x70 kernel/trace/bpf_trace.c:221
>        bpf_prog_bc7c5c6b9645592f+0x3e/0x40
>        bpf_dispatcher_nop_func include/linux/bpf.h:1265 [inline]
>        __bpf_prog_run include/linux/filter.h:701 [inline]
>        bpf_prog_run include/linux/filter.h:708 [inline]
>        __bpf_trace_run kernel/trace/bpf_trace.c:2316 [inline]
>        bpf_trace_run4+0x30b/0x4d0 kernel/trace/bpf_trace.c:2359
>        __bpf_trace_sched_switch+0x1c6/0x2c0 include/trace/events/sched.h:222
>        trace_sched_switch+0x12a/0x190 include/trace/events/sched.h:222

-EWONTFIX. Don't do stupid.

