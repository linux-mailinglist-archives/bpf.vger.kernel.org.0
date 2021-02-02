Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25EC930C9EC
	for <lists+bpf@lfdr.de>; Tue,  2 Feb 2021 19:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234485AbhBBSc5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Feb 2021 13:32:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238694AbhBBSb1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Feb 2021 13:31:27 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD578C0613ED;
        Tue,  2 Feb 2021 10:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jFGMt/5rvZkOd4kJq4sdHZEiD2PN74Dx0ZAKwhJWvEU=; b=Z8xIBS0FsqnMJFgEQ0eLvw3f8X
        FbBGHTxQZbnZJrLRO4VjHEGfCgyvYi9mAHy4FevWoNdz7dJgitQSZCQElU764JLE/WqyQyheXR8c6
        0rwEMVSUmUkmcpsdn/mOP57DbkvC4QlSAVNcMO7R5HV+9Matczizc6cXxbC9lY8a9NwCA14YrKkh1
        dqvYW81Uliy8NnctdU9RuX1l69nlG10l3zmDHDY3hDBxr5zu8BWhhGgr9NdmYdPvtu6GUcwVY9B0s
        U6S2W6AmcrZbJKwDlbsybn82CKW5LFxegyALTemTNwKbZc0qDMcCtVfFIhdNShbjSCTVsQstRAAPC
        2LPa6Xtw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l70Rg-0005bW-3A; Tue, 02 Feb 2021 18:30:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8950D301179;
        Tue,  2 Feb 2021 19:30:34 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 73BBE203B8CC7; Tue,  2 Feb 2021 19:30:34 +0100 (CET)
Date:   Tue, 2 Feb 2021 19:30:34 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nikolay Borisov <nborisov@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: kprobes broken since 0d00449c7a28 ("x86: Replace ist_enter()
 with nmi_enter()")
Message-ID: <YBmaStZn9XEU0QE+@hirez.programming.kicks-ass.net>
References: <CAADnVQLMqHpSsZ1OdZRFmKqNWKiRq3dxRxw+y=kvMdmkN7htUw@mail.gmail.com>
 <20210129175943.GH8912@worktop.programming.kicks-ass.net>
 <20210129140103.3ce971b7@gandalf.local.home>
 <20210129162454.293523c6@gandalf.local.home>
 <YBUYsFlxjsQxuvfB@hirez.programming.kicks-ass.net>
 <20210130074410.6384c2e2@oasis.local.home>
 <YBktVT+z7sV/vEPU@hirez.programming.kicks-ass.net>
 <20210202095249.5abd6780@gandalf.local.home>
 <YBmBu0c24RjNYFet@hirez.programming.kicks-ass.net>
 <20210202115623.08e8164d@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202115623.08e8164d@gandalf.local.home>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 02, 2021 at 11:56:23AM -0500, Steven Rostedt wrote:

> NMIs are special, and they always have been. They shouldn't be doing much
> anyway. If they are, then that's a problem.

There is a fair amount of NMI level code these days, and it seems to be
ever increasing...

> My question wasn't to have them do it, I was simply asking if they do. I
> was assuming that they do not.

per nmi_enter() we do:

  __preempt_count_add(NMI_OFFSET + HARDIRQ_OFFSET);       \

> > But it doesn't help with:
> > 
> > 	spin_lock_irq(&foo); // task context
> > 	#DB
> > 	  spin_lock_irq(&foo); // interrupt context per your above
> 
> The statement above said:
> 
>  "If #DB and #BP do not change the in_interrupt() context"
> 
> Which would make the above be in the same context and the handler would
> not be called for the #DB case.

But then replace the above #DB with __fentry__ and explain how it is
fundamentally different? And consider that direct call into god knows
what code option you have. That doesn't go past any recursion checks
IIRC.

> I'm fine with #DB and #BP being a "in_nmi()", as they are probably even
> more special than NMIs.

That does mean that kprobes are then fundamentally running from
in_nmi(), which is what started all this.

Sure, the opt-probes and ftrace-probes don't actually have in_nmi() set
today (because they don't trigger an exception), but given that that is
all optional, any kprobe handler had better be in_nmi() clean.
