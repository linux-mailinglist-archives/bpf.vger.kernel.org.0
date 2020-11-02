Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8A772A333C
	for <lists+bpf@lfdr.de>; Mon,  2 Nov 2020 19:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgKBSny (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 2 Nov 2020 13:43:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbgKBSnx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 2 Nov 2020 13:43:53 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958F7C0617A6
        for <bpf@vger.kernel.org>; Mon,  2 Nov 2020 10:43:53 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id o205so5606233qke.10
        for <bpf@vger.kernel.org>; Mon, 02 Nov 2020 10:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qiHZ1hrsvinTv/K83q0Rhp/LFKZP3RXggPFNrMPda6o=;
        b=mlUxWUYczJS33fR/iEwt/7WalH3MyWBBWGTZPF3zH1DpEprnioF1fYaxu2gUKfLdKw
         1WMZTm5lKn3mAjOa41gApSWGp+MEayPPgZTLRwmfUBDhuWArFWjsSASOHXFb+IfhiElE
         SmHeEPC+CaEHSaIUeDgtVjphVl0ukNHXln5sE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qiHZ1hrsvinTv/K83q0Rhp/LFKZP3RXggPFNrMPda6o=;
        b=OR2eIJAXrY6Qbb5HlxgKAATRpT+SMJ2wf7z6M8Ne7eZDDlPrTtcZaFaEun0zTYuBRs
         8GknxHkoVNkRj8GZt6G2h/GfxARVlSqm7mZXsyyy4AhfRpdvrrSl2fMF9vTJUEFKkvHx
         GvLzMrc8wnXNVEkjfQk5UZUHpsr2CHIyENgz//bxdt28SPboIRAg6ORMfm6PnfgKTcFo
         vhznwl+tIJtQnOwB6B5Th2K9P9EXQlGEH0DhyW/jFgNXlG/FxHlhNYGu4I9cxZaiHZDH
         sKd4t82/uZCLo1d98VK6GQXHX/D4zP+ymNKfBhR6PUMPVI8R/4MB9EBnWdFDoqMn5HHK
         P+Tw==
X-Gm-Message-State: AOAM530E508IgmZIZ5ZkQqeT2Dsax6PVBCmhZRKBq9kaGZgVdz1YNCWu
        wb9a3GT4UYk1g9LKvN9KItKTOw==
X-Google-Smtp-Source: ABdhPJxhYLiuNq2MONOb69Pm6DrknVY7dG6jwS8GHGFR1nX80wOdGTryPPiTHxLvnkYi9O5IVdbUng==
X-Received: by 2002:a05:620a:2144:: with SMTP id m4mr16144470qkm.269.1604342632790;
        Mon, 02 Nov 2020 10:43:52 -0800 (PST)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id 71sm8719856qko.55.2020.11.02.10.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 10:43:52 -0800 (PST)
Date:   Mon, 2 Nov 2020 13:43:51 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Jeanson <mjeanson@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        rostedt <rostedt@goodmis.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>, paulmck <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, acme <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [RFC PATCH 6/6] tracing: use sched-RCU instead of SRCU for
 rcuidle tracepoints
Message-ID: <20201102184351.GA595952@google.com>
References: <20201023195352.26269-1-mjeanson@efficios.com>
 <20201023195352.26269-7-mjeanson@efficios.com>
 <20201023211359.GC3563800@google.com>
 <20201026082010.GC2628@hirez.programming.kicks-ass.net>
 <73192641.37901.1603722487627.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73192641.37901.1603722487627.JavaMail.zimbra@efficios.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 26, 2020 at 10:28:07AM -0400, Mathieu Desnoyers wrote:
> ----- On Oct 26, 2020, at 4:20 AM, Peter Zijlstra peterz@infradead.org wrote:
> 
> > On Fri, Oct 23, 2020 at 05:13:59PM -0400, Joel Fernandes wrote:
> >> On Fri, Oct 23, 2020 at 03:53:52PM -0400, Michael Jeanson wrote:
> >> > From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> >> > 
> >> > Considering that tracer callbacks expect RCU to be watching (for
> >> > instance, perf uses rcu_read_lock), we need rcuidle tracepoints to issue
> >> > rcu_irq_{enter,exit}_irqson around calls to the callbacks. So there is
> >> > no point in using SRCU anymore given that rcuidle tracepoints need to
> >> > ensure RCU is watching. Therefore, simply use sched-RCU like normal
> >> > tracepoints for rcuidle tracepoints.
> >> 
> >> High level question:
> >> 
> >> IIRC, doing this increases overhead for general tracing that does not use
> >> perf, for 'rcuidle' tracepoints such as the preempt/irq enable/disable
> >> tracepoints. I remember adding SRCU because of this reason.
> >> 
> >> Can the 'rcuidle' information not be pushed down further, such that perf does
> >> it because it requires RCU to be watching, so that it does not effect, say,
> >> trace events?
> > 
> > There's very few trace_.*_rcuidle() users left. We should eradicate them
> > and remove the option. It's bugs to begin with.
> 
> I agree with Peter. Removing the trace_.*_rcuidle weirdness from the tracepoint
> API and fixing all callers to ensure they trace from a context where RCU is
> watching would simplify instrumentation of the Linux kernel, thus making it harder
> for subtle bugs to hide and be unearthed only when tracing is enabled. This is
> AFAIU the general approach Thomas Gleixner has been aiming for recently, and I
> think it is a good thing.
> 
> So if we consider this our target, and that the current state of things is that
> we need to have RCU watching around callback invocation, then removing the
> dependency on SRCU seems like an overall simplification which does not regress
> feature-wise nor speed-wise compared with what we have upstream today. The next
> steps would then be to audit all rcuidle tracepoints and make sure the context
> where they are placed has RCU watching already, so we can remove the tracepoint
> rcuidle API. That would effectively remove the calls to rcu_irq_{enter,exit}_irqson
> from the tracepoint code.
> 
> This is however beyond the scope of the proposed patch set.

You are right, it doesn't regress speedwise - I got confused since the code
was modified to call rcu_enter_irqson() even for the rcuidle case (which I
had avoided when I added SRCU). So in current code, SRCU is kind of
pointless. I think keep the patch in the series.

thanks,

 - Joel

