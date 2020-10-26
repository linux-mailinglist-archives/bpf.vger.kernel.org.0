Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91F812988B9
	for <lists+bpf@lfdr.de>; Mon, 26 Oct 2020 09:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1772048AbgJZIpv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Oct 2020 04:45:51 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46928 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1771224AbgJZIpv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Oct 2020 04:45:51 -0400
X-Greylist: delayed 1517 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Oct 2020 04:45:51 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cG+bUw0htssS2VsM1tSm5/tJVv+7Iw86NvNGo250wAA=; b=b2Jg5WMEQkbZCXLmYMhmlHHGD0
        i0wezkUlu8euA7C3i2l6BEyNR+Rvd9yXt2Gi2xU83cNxNkLuIMgdipp7/bU3SQs4dWi1jCAbIu7lM
        C/wcBsh2JqIVv2iIIFP9QTKo98vhcZnUap3lPxPWCQ0yn2XH8Bb32SuF0hMvpnWguLjEZNa/mmuze
        Fpl/ZJFgwddm2cJ6/vlI5ZnRRnIOafcwoSdE4NBPojQDX51UGO47kKX23tdMytouXJolVVCkJvq2a
        UjNGewtz2ZPHOwXqRt2sPujjEOqzwWNNlmWPo3uKGuHVFpIfOrF2/hmIg9rgGDWF0xIdUbVfXf93X
        fAR5oAWw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kWxjh-00070s-OX; Mon, 26 Oct 2020 08:20:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9853A301179;
        Mon, 26 Oct 2020 09:20:10 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5E077214ECD42; Mon, 26 Oct 2020 09:20:10 +0100 (CET)
Date:   Mon, 26 Oct 2020 09:20:10 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Michael Jeanson <mjeanson@efficios.com>,
        linux-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, bpf@vger.kernel.org
Subject: Re: [RFC PATCH 6/6] tracing: use sched-RCU instead of SRCU for
 rcuidle tracepoints
Message-ID: <20201026082010.GC2628@hirez.programming.kicks-ass.net>
References: <20201023195352.26269-1-mjeanson@efficios.com>
 <20201023195352.26269-7-mjeanson@efficios.com>
 <20201023211359.GC3563800@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201023211359.GC3563800@google.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 23, 2020 at 05:13:59PM -0400, Joel Fernandes wrote:
> On Fri, Oct 23, 2020 at 03:53:52PM -0400, Michael Jeanson wrote:
> > From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > 
> > Considering that tracer callbacks expect RCU to be watching (for
> > instance, perf uses rcu_read_lock), we need rcuidle tracepoints to issue
> > rcu_irq_{enter,exit}_irqson around calls to the callbacks. So there is
> > no point in using SRCU anymore given that rcuidle tracepoints need to
> > ensure RCU is watching. Therefore, simply use sched-RCU like normal
> > tracepoints for rcuidle tracepoints.
> 
> High level question:
> 
> IIRC, doing this increases overhead for general tracing that does not use
> perf, for 'rcuidle' tracepoints such as the preempt/irq enable/disable
> tracepoints. I remember adding SRCU because of this reason.
> 
> Can the 'rcuidle' information not be pushed down further, such that perf does
> it because it requires RCU to be watching, so that it does not effect, say,
> trace events?

There's very few trace_.*_rcuidle() users left. We should eradicate them
and remove the option. It's bugs to begin with.
