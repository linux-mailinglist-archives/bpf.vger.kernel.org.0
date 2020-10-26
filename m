Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A78AA298F43
	for <lists+bpf@lfdr.de>; Mon, 26 Oct 2020 15:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1781433AbgJZO2J (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Oct 2020 10:28:09 -0400
Received: from mail.efficios.com ([167.114.26.124]:52272 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1781431AbgJZO2J (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Oct 2020 10:28:09 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 333A8241008;
        Mon, 26 Oct 2020 10:28:08 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Xg14e8EdwAjX; Mon, 26 Oct 2020 10:28:07 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id B696B240EA5;
        Mon, 26 Oct 2020 10:28:07 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com B696B240EA5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1603722487;
        bh=b+GvRyxbmnlNapP2hfxVxVrD6YKJjDQAOCHDyfDeiQM=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=vGsTu2H3JKJdzT8unx9/Fv4fVOf456LViyeWlMNx7UwqsFUquU4lfXmFtACDtQ3/J
         miTb+yJ6YY7x+zlBpZoV/j7xlWrE5y83SKAX3WHCTgObaYMc1CjIYCVWxA3Lf7d10T
         l5e7NMPDBzTixdEHrITvBwUCRsqhKW2Db77Ms0LtgJNNg8sO/b9LSaniK8b17Wg7ko
         eJs7BnJB9GcHiiF/2aHoC9mTmbdJKiHdlK/ndo9hHq6MjaLdtJMhGF8FjzBnmfpFCM
         5c761C+1Fx2AncVEVef3SDuGUd4AB/xxprSfe3vLnp/V1CYTCffLMleWUyzQNgty0Q
         0T3g4sF2sROuw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id tcJv_BKkx5ct; Mon, 26 Oct 2020 10:28:07 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id A226A240D1F;
        Mon, 26 Oct 2020 10:28:07 -0400 (EDT)
Date:   Mon, 26 Oct 2020 10:28:07 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>
Cc:     Michael Jeanson <mjeanson@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        rostedt <rostedt@goodmis.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>, paulmck <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, acme <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, bpf <bpf@vger.kernel.org>
Message-ID: <73192641.37901.1603722487627.JavaMail.zimbra@efficios.com>
In-Reply-To: <20201026082010.GC2628@hirez.programming.kicks-ass.net>
References: <20201023195352.26269-1-mjeanson@efficios.com> <20201023195352.26269-7-mjeanson@efficios.com> <20201023211359.GC3563800@google.com> <20201026082010.GC2628@hirez.programming.kicks-ass.net>
Subject: Re: [RFC PATCH 6/6] tracing: use sched-RCU instead of SRCU for
 rcuidle tracepoints
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3968 (ZimbraWebClient - FF81 (Linux)/8.8.15_GA_3968)
Thread-Topic: tracing: use sched-RCU instead of SRCU for rcuidle tracepoints
Thread-Index: He6ZVtkzgwO4+WmVRRp7McQ4EPG+Cw==
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

----- On Oct 26, 2020, at 4:20 AM, Peter Zijlstra peterz@infradead.org wrote:

> On Fri, Oct 23, 2020 at 05:13:59PM -0400, Joel Fernandes wrote:
>> On Fri, Oct 23, 2020 at 03:53:52PM -0400, Michael Jeanson wrote:
>> > From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> > 
>> > Considering that tracer callbacks expect RCU to be watching (for
>> > instance, perf uses rcu_read_lock), we need rcuidle tracepoints to issue
>> > rcu_irq_{enter,exit}_irqson around calls to the callbacks. So there is
>> > no point in using SRCU anymore given that rcuidle tracepoints need to
>> > ensure RCU is watching. Therefore, simply use sched-RCU like normal
>> > tracepoints for rcuidle tracepoints.
>> 
>> High level question:
>> 
>> IIRC, doing this increases overhead for general tracing that does not use
>> perf, for 'rcuidle' tracepoints such as the preempt/irq enable/disable
>> tracepoints. I remember adding SRCU because of this reason.
>> 
>> Can the 'rcuidle' information not be pushed down further, such that perf does
>> it because it requires RCU to be watching, so that it does not effect, say,
>> trace events?
> 
> There's very few trace_.*_rcuidle() users left. We should eradicate them
> and remove the option. It's bugs to begin with.

I agree with Peter. Removing the trace_.*_rcuidle weirdness from the tracepoint
API and fixing all callers to ensure they trace from a context where RCU is
watching would simplify instrumentation of the Linux kernel, thus making it harder
for subtle bugs to hide and be unearthed only when tracing is enabled. This is
AFAIU the general approach Thomas Gleixner has been aiming for recently, and I
think it is a good thing.

So if we consider this our target, and that the current state of things is that
we need to have RCU watching around callback invocation, then removing the
dependency on SRCU seems like an overall simplification which does not regress
feature-wise nor speed-wise compared with what we have upstream today. The next
steps would then be to audit all rcuidle tracepoints and make sure the context
where they are placed has RCU watching already, so we can remove the tracepoint
rcuidle API. That would effectively remove the calls to rcu_irq_{enter,exit}_irqson
from the tracepoint code.

This is however beyond the scope of the proposed patch set.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
