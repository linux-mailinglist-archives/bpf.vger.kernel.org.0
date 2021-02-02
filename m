Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8F2130CD9E
	for <lists+bpf@lfdr.de>; Tue,  2 Feb 2021 22:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbhBBVF5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Feb 2021 16:05:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:46306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231902AbhBBVF4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Feb 2021 16:05:56 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C024164F3F;
        Tue,  2 Feb 2021 21:05:14 +0000 (UTC)
Date:   Tue, 2 Feb 2021 16:05:13 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nikolay Borisov <nborisov@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: kprobes broken since 0d00449c7a28 ("x86: Replace ist_enter()
 with nmi_enter()")
Message-ID: <20210202160513.38ada3a7@gandalf.local.home>
In-Reply-To: <YBmaStZn9XEU0QE+@hirez.programming.kicks-ass.net>
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
        <YBmaStZn9XEU0QE+@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 2 Feb 2021 19:30:34 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> That does mean that kprobes are then fundamentally running from
> in_nmi(), which is what started all this.

I just thought about the fact that tracing records the context of the
function it is called in. If you set "in_nmi()" for all ftrace handlers,
then all functions will look like they are in an NMI context during tracing.

That is, the preempt count is checked to fill in the flags in the ring
buffer that denotes what context the event (in this case the function) was
called in.

-- Steve
