Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28318299053
	for <lists+bpf@lfdr.de>; Mon, 26 Oct 2020 15:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1782861AbgJZO7o (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Oct 2020 10:59:44 -0400
Received: from mail.efficios.com ([167.114.26.124]:33752 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1782779AbgJZO7l (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Oct 2020 10:59:41 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 21C44241037;
        Mon, 26 Oct 2020 10:59:40 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id G7pQKe8Qcx9t; Mon, 26 Oct 2020 10:59:39 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id BD460241036;
        Mon, 26 Oct 2020 10:59:39 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com BD460241036
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1603724379;
        bh=wEIBiJ3QMm3QOpyR3tdXCbxMtI6b1O3DxiirHqrjjIQ=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=ByniI8Jv/3HwcAT9v0h+YhV9JP3s1GryDNFTPFR5oxR1k0l0os5Zu0tlONv3Tv4Oa
         HVZL5lFQQZlV5F3AR4glOtR5JiSvJVTNhVvtfoVmRmcHnYB5uROcL7ezH5Babn4tYY
         cn2oNzkCugReRSKwLNpT5nKz5r7L1EaB/yj+nb/zl0ksV6w4g36O460ztaBs/V3saF
         bgGcDA2hI8sRtMc8loTc8a67VIfEydxuyEDqSjWmjCV5o33GhAECQV3Xuxn8aUMA0M
         0gJbllaspwSnjntYRPwcd3Hil45Mev4s42xM4yxZWcj/JFpfenncBbEAH5LKiunFJ0
         ZkEt3c/yDryXg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Cai7GuYWN-nm; Mon, 26 Oct 2020 10:59:39 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id A52A32411A1;
        Mon, 26 Oct 2020 10:59:39 -0400 (EDT)
Date:   Mon, 26 Oct 2020 10:59:39 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     peter enderborg <peter.enderborg@sony.com>
Cc:     Michael Jeanson <mjeanson@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        rostedt <rostedt@goodmis.org>,
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
Message-ID: <1771115581.37989.1603724379532.JavaMail.zimbra@efficios.com>
In-Reply-To: <083f3ffa-3395-d66b-bb8b-d6a3fd7f6177@sony.com>
References: <20201023195352.26269-1-mjeanson@efficios.com> <083f3ffa-3395-d66b-bb8b-d6a3fd7f6177@sony.com>
Subject: Re: [RFC PATCH 0/6] Sleepable tracepoints
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3968 (ZimbraWebClient - FF81 (Linux)/8.8.15_GA_3968)
Thread-Topic: Sleepable tracepoints
Thread-Index: AMUC8e/DFHMGexX5Gfm6w6o6aqmr8g==
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

----- On Oct 26, 2020, at 8:05 AM, peter enderborg peter.enderborg@sony.com wrote:

> On 10/23/20 9:53 PM, Michael Jeanson wrote:
>> When invoked from system call enter/exit instrumentation, accessing
>> user-space data is a common use-case for tracers. However, tracepoints
>> currently disable preemption around iteration on the registered
>> tracepoint probes and invocation of the probe callbacks, which prevents
>> tracers from handling page faults.
>>
>> Extend the tracepoint and trace event APIs to allow specific tracer
>> probes to take page faults. Adapt ftrace, perf, and ebpf to allow being
>> called from sleepable context, and convert the system call enter/exit
>> instrumentation to sleepable tracepoints.
> 
> Will this not be a problem for analyse of the trace? It get two
> relevant times, one it when it is called and one when it returns.

It will depend on what the tracer chooses to do. If we call the side-effect
of what is being traced a "transaction" (e.g. actually opening a file
descriptor and adding it to a process'file descriptor table as the result
of an open(2) system call), we have to consider that already today the
timestamp which we get is either slightly before or after the actual
side-effect of the transaction in the kernel. That is true even without
being preemptable.

Sometimes it's not relevant to have a tracepoint before and after the
transaction, e.g. when all we care about is to know that the transaction
has successfully happened or not.

In the case of system calls, we have sys_enter and sys_exit to mark the
beginning and end of the "transaction". Whatever side-effects are done by
the system call happens in between.

I think the question here is whether it is relevant to know whether page
faults triggered by accessing system call input parameters need to
happen after we trace a "system call entry" event. If the tracers care,
then it would be up to them to first trace that "system call entry" event,
and have a separate event for the argument payload. But there are other
ways to identify whether page faults happen within the system call or
from user-space, for instance by using the instruction pointer associated
with the page fault. So when observing page faults happening before sys
enter, but associated with a kernel instruction pointer, a trace analysis
tool could theoretically figure out who is to blame for that page fault,
*if* it cares.

> 
> It makes things harder to correlate in what order things happen.

The alternative is to have partial payloads like LTTng does today for
system call arguments. If reading a string from userspace (e.g. open(2)
file name) requires to take a page fault, LTTng truncates the string. This
is pretty bad for automated analysis as well.

> 
> And handling of tracing of contexts that already are not preamptable?

The sleepable tracepoints are only meant to be used in contexts which can sleep.
For tracepoints placed in non-preemptible contexts, those should never take
a page fault to begin with.

> 
> Eg the same tracepoint are used in different places and contexts.

As far as considering that a given tracepoint "name" could be registered to
by both a sleepable and non-sleepable tracer probes, I would like to see an
actual use-case for this. I don't have any.

I can envision that some tracer code will want to be allowed to work in
both sleepable and non-sleepable context, e.g. take page faults in
sleepable context (and called from a sleepable tracepoint), but have a
truncation behavior when called from non-sleepable context. This can actually
be done by looking at the new "TRACEPOINT_MAYSLEEP" tp flag. Passing that
tp_flags to code shared between sleepable and non-sleepable probes would allow
the callee to know whether it can take a page fault or not.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
