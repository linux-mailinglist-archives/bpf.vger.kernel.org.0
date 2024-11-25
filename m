Return-Path: <bpf+bounces-45561-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEC79D7A5C
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 04:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BBCCB217AF
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 03:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E67E39FD9;
	Mon, 25 Nov 2024 03:30:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5B32CA9;
	Mon, 25 Nov 2024 03:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732505451; cv=none; b=FXOmvl7YgNdENxz3YUC6hUIOcumiLHeDKJ4CqtEUMtGPC28b+NayN25UsU1o2+ppyuDJAy9Eq2Wkl141BUZNt9iwzQ/vj7WkwWo8rEW2Yv1kymM/gqAt07JfGqR7+ff2/HMhPUj3C+i4Gh+W4T/VzJlMafdTKE6Boys6IhaCvRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732505451; c=relaxed/simple;
	bh=yh9xxPO7u3XiOMx960+hEjEKDNvbp11Xdp0TxwKxFb0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gaPDF06+otAdtCpM+gDqf3bB23PADhVtkc9+dKZI43vUbGYwZbjxo3TQYQ8D9vB2MJsSQLTxE+ncAs/PtqD+1jQqGCoIGx3KFtjQrG+9MsFLOi/eBfQ5Or44ssdhHDbN0mW7VtaydmCA/lGjPJ+8glefQYc+DpIIe/k859Guog0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F322C4CECC;
	Mon, 25 Nov 2024 03:30:47 +0000 (UTC)
Date: Sun, 24 Nov 2024 22:30:45 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ruan Bonan
 <bonan.ruan@u.nus.edu>, "mingo@redhat.com" <mingo@redhat.com>,
 "will@kernel.org" <will@kernel.org>, "longman@redhat.com"
 <longman@redhat.com>, "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kpsingh@kernel.org" <kpsingh@kernel.org>, "mattbobrowski@google.com"
 <mattbobrowski@google.com>, "ast@kernel.org" <ast@kernel.org>,
 "daniel@iogearbox.net" <daniel@iogearbox.net>, "andrii@kernel.org"
 <andrii@kernel.org>, "martin.lau@linux.dev" <martin.lau@linux.dev>,
 "eddyz87@gmail.com" <eddyz87@gmail.com>, "song@kernel.org"
 <song@kernel.org>, "yonghong.song@linux.dev" <yonghong.song@linux.dev>,
 "john.fastabend@gmail.com" <john.fastabend@gmail.com>, "sdf@fomichev.me"
 <sdf@fomichev.me>, "haoluo@google.com" <haoluo@google.com>,
 "jolsa@kernel.org" <jolsa@kernel.org>, "mhiramat@kernel.org"
 <mhiramat@kernel.org>, "mathieu.desnoyers@efficios.com"
 <mathieu.desnoyers@efficios.com>, "bpf@vger.kernel.org"
 <bpf@vger.kernel.org>, "linux-trace-kernel@vger.kernel.org"
 <linux-trace-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, Fu Yeqi <e1374359@u.nus.edu>
Subject: Re: [BUG] possible deadlock in __schedule (with reproducer
 available)
Message-ID: <20241124223045.4e47e8b7@rorschach.local.home>
In-Reply-To: <CAADnVQLBhV_sSuH+BKu66ZsxTcsvw7RSLnjRGLwQX3TFSjs-Gg@mail.gmail.com>
References: <24481522-69BF-4CE7-A05D-1E7398400D80@u.nus.edu>
	<20241123202744.GB20633@noisy.programming.kicks-ass.net>
	<20241123180000.5e219f2e@gandalf.local.home>
	<CAADnVQLBhV_sSuH+BKu66ZsxTcsvw7RSLnjRGLwQX3TFSjs-Gg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 24 Nov 2024 18:02:35 -0800
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> > > -EWONTFIX. Don't do stupid.  
> >
> > Ack. BPF should not be causing deadlocks by doing code called from
> > tracepoints.  
> 
> I sense so much BPF love here that it diminishes the ability to read
> stack traces :)

You know I love BPF ;-)  I do recommend it when I feel it's the right
tool for the job.

> Above is one of many printk related splats that syzbot keeps finding.
> This is not a new issue and it has nothing to do with bpf.

I had to fight printk related spats too. But when that happens, its not
considered a bug to the code that is being attached to. Note, my
response is more about the subject title, which sounds like it's
blaming the schedule code. Which is not the issue.

> 
> > Tracepoints have a special context similar to NMIs. If you add
> > a hook into an NMI handler that causes a deadlock, it's a bug in the hook,
> > not the NMI code. If you add code that causes a deadlock when attaching to a
> > tracepoint, it's a bug in the hook, not the tracepoint.  
> 
> trace events call strncpy_from_user_nofault() just as well.
> kernel/trace/trace_events_filter.c:830

Well, in some cases you could do that from NMI as well. The point is,
tracepoints are a different context, and things need to be careful when
using it. If any deadlock occurs by attaching to a tracepoint (and this
isn't just BPF, I have code too that needs to be very careful about
this as well), then the bug is with the attached callback.

I agree with Peter. This isn't his problem. Hence my Ack.

-- Steve

