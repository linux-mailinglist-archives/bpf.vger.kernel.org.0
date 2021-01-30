Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB3AB30918D
	for <lists+bpf@lfdr.de>; Sat, 30 Jan 2021 03:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbhA3CsI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Jan 2021 21:48:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:58498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233135AbhA3COp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Jan 2021 21:14:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BCF7064E02;
        Sat, 30 Jan 2021 02:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611972174;
        bh=lbJlMuUVFRumkCODX2oNdPrWomOmGRFVYk+u+Pk4cAk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZGY3sYfFNa8fp2aAB7QLpHVEhVZfaU9pRHb/XZXWcaPO81ej2FYIvulA9wfawyD3N
         qtYRYJf+IncguHjJ0fRU20bfEjPhsdYcj5nNmKQAqwtRTYRg8J1Qp2EU0pX7oz6Nqi
         PUMmDr+AvXUvhJWKCpiRpjI09v1HXI/hR22+7BUHxUvD4nOJBEa33MQr4GavsSms65
         myoccoR/EgHkx4Htx+6rqwBz4b8vl5LmMqqmGb3qQMDMXcj/Wb20q/KrGLswHuK11f
         jkzrBJutMwuQckXyhXsqR/6pRfaE2WX9dr+0gtDA/NAe0rnK4++6EQM79SBeOmk28K
         +OEGQIn2h6Zmw==
Date:   Sat, 30 Jan 2021 11:02:49 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nikolay Borisov <nborisov@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: kprobes broken since 0d00449c7a28
 ("x86: Replace ist_enter() with nmi_enter()")
Message-Id: <20210130110249.61fdad8f0cfe51a121c72302@kernel.org>
In-Reply-To: <20210129175943.GH8912@worktop.programming.kicks-ass.net>
References: <20210128123842.c9e33949e62f504b84bfadf5@gmail.com>
        <e8bae974-190b-f247-0d89-6cea4fd4cc39@suse.com>
        <eb1ec6a3-9e11-c769-84a4-228f23dc5e23@suse.com>
        <YBMBTsY1uuQb9wCP@hirez.programming.kicks-ass.net>
        <20210129013452.njuh3fomws62m4rc@ast-mbp.dhcp.thefacebook.com>
        <YBPNyRyrkzw2echi@hirez.programming.kicks-ass.net>
        <20210129224011.81bcdb3eba1227c414e69e1f@kernel.org>
        <20210129105952.74dc8464@gandalf.local.home>
        <20210129162438.GC8912@worktop.programming.kicks-ass.net>
        <CAADnVQLMqHpSsZ1OdZRFmKqNWKiRq3dxRxw+y=kvMdmkN7htUw@mail.gmail.com>
        <20210129175943.GH8912@worktop.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 29 Jan 2021 18:59:43 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, Jan 29, 2021 at 09:45:48AM -0800, Alexei Starovoitov wrote:
> > Same things apply to bpf side. We can statically prove safety for
> > ftrace and kprobe attaching whereas to deal with NMI situation we
> > have to use run-time checks for recursion prevention, etc.
> 
> I have no idea what you're saying. You can attach to functions that are
> called with random locks held, you can create kprobes in some very
> sensitive places.
> 
> What can you staticlly prove about that?

For the bpf and the kprobe tracer, if a probe hits in the NMI context,
it can call the handler with another handler processing events.

kprobes is carefully avoiding the deadlock by checking recursion
with per-cpu variable. But if the handler is shared with the other events
like tracepoints, it needs to its own recursion cheker too.

So, Alexei, maybe you need something like this instead of in_nmi() check.

DEFINE_PER_CPU(bool, under_running_bpf);

common_handler()
{
	if (__this_cpu_read(under_running_bpf))
		return;
	__this_cpu_write(under_running_bpf, true);
	/* execute bpf prog */
	__this_cpu_write(under_running_bpf, false);	
}

Does this work for you?

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
