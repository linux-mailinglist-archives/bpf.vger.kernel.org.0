Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 962CF3243A2
	for <lists+bpf@lfdr.de>; Wed, 24 Feb 2021 19:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234392AbhBXSOw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Feb 2021 13:14:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:57860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234451AbhBXSOt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Feb 2021 13:14:49 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CC8164EDD;
        Wed, 24 Feb 2021 18:14:07 +0000 (UTC)
Date:   Wed, 24 Feb 2021 13:14:05 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Michael Jeanson <mjeanson@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>, paulmck <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, acme <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        bpf <bpf@vger.kernel.org>
Subject: Re: [RFC PATCH 0/6] [RFC] Faultable tracepoints (v2)
Message-ID: <20210224131405.20d64b49@gandalf.local.home>
In-Reply-To: <915297635.2997.1614185975415.JavaMail.zimbra@efficios.com>
References: <20210218222125.46565-1-mjeanson@efficios.com>
        <20210223211639.670db85c@gandalf.local.home>
        <083bce0f-bd66-ab83-1211-be9838499b45@efficios.com>
        <915297635.2997.1614185975415.JavaMail.zimbra@efficios.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 24 Feb 2021 11:59:35 -0500 (EST)
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
> As a prototype solution, what I've done currently is to copy the user-space
> data into a kmalloc'd buffer in a preparation step before disabling preemption
> and copying data over into the per-cpu buffers. It works, but I think we should
> be able to do it without the needless copy.
> 
> What I have in mind as an efficient solution (not implemented yet) for the LTTng
> kernel tracer goes as follows:
> 
> #define COMMIT_LOCAL 0
> #define COMMIT_REMOTE 1
> 
> - faultable probe is called from system call tracepoint [ preemption/blocking/migration is allowed ]
>   - probe code calculate the length which needs to be reserved to store the event
>     (e.g. user strlen),
> 
>   - preempt disable -> [ preemption/blocking/migration is not allowed from here ]
>     - reserve_cpu = smp_processor_id()
>     - reserve space in the ring buffer for reserve_cpu
>       [ from that point on, we have _exclusive_ access to write into the ring buffer "slot"
>         from any cpu until we commit. ]
>   - preempt enable -> [ preemption/blocking/migration is allowed from here ]
> 

So basically the commit position here doesn't move until this task is
scheduled back in and the commit (remote or local) is updated.

To put it in terms of the ftrace ring buffer, where we have both a commit
page and a commit index, and it only gets moved by the first one to start a
commit stack (that is, interrupts that interrupted a write will not
increment the commit).

Now, I'm not sure how LTTng does it, but I could see issues for ftrace to
try to move the commit pointer (the pointer to the new commit page), as the
design is currently dependent on the fact that it can't happen while
commits are taken place.

Are the pages of the LTTng indexed by an array of pages?

-- Steve
