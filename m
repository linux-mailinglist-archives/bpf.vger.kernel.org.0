Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44585188CA5
	for <lists+bpf@lfdr.de>; Tue, 17 Mar 2020 18:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgCQR4Q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Mar 2020 13:56:16 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43802 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgCQR4Q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Mar 2020 13:56:16 -0400
Received: by mail-qk1-f196.google.com with SMTP id x18so13915144qki.10
        for <bpf@vger.kernel.org>; Tue, 17 Mar 2020 10:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7RNpd6M/2oQakPhwyqPFEbJMn7TU7SvV4L7GUJPMayA=;
        b=nnS+OKk02P7VrQnABseQC4bOefYsCTSgtCEVhn7bBP0xNNyU4h6TGDww0Ia+ZGRgPH
         boa465SNvwmiQ5FN+Psrnr4sEkhPXcOfxBj7YAnaN7K5ZwrPFG96jeRtcZHMVEaVdH1j
         CsBmOnW92RJkeEnjXzblhSds9to/fnaLkmdgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7RNpd6M/2oQakPhwyqPFEbJMn7TU7SvV4L7GUJPMayA=;
        b=RdN1WUwRTKeESt6m02Xk156UzI8Z6PRWtqcuvjpbUmMrmPxq6zgWxR4fM3kEXFfj0B
         5779Cbh666FiET3hYhAoh0dfR72TYdsNo1lfoOc3k9Cp7Jl7P3mL1How0s+Hzq94RW4Q
         npGck8mnummiffHysN0y1rJP5sXBKgbT8UyO9Igi4GehGu+3SLMEDLMQHqBLRllFktz7
         li8UDMtaHKq+tKqS+k/uAJgWYAlqp3I+Jl8V7zhIpWPTniQLg/+fFH1GXDGJi1cckLua
         WnYuBlORHRK6tJtsnxxltLIU7aOjaHGBjV23brEcrCyMRa2xLFAw2kd+EvZo+kEkTvA1
         QaaA==
X-Gm-Message-State: ANhLgQ0QzgElHJm0JAUHEQK6bNnvwgywOMaD6gDeQ7vYJ2NoACO7N41K
        kUBjEQScnJGPTRjUejOlsRK+VA==
X-Google-Smtp-Source: ADFU+vtD4t5gVr9EMvYH+WW9ETFmrA1c0LKslzF/783C+M/FpQwopvv+KORN6IKdnpsIUS7F3AYXRA==
X-Received: by 2002:a37:648:: with SMTP id 69mr13718qkg.353.1584467775182;
        Tue, 17 Mar 2020 10:56:15 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id t55sm2754304qte.24.2020.03.17.10.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 10:56:14 -0700 (PDT)
Date:   Tue, 17 Mar 2020 13:56:14 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        paulmck <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>, bpf@vger.kernel.org
Subject: Re: Instrumentation and RCU
Message-ID: <20200317175614.GA13090@google.com>
References: <87mu8p797b.fsf@nanos.tec.linutronix.de>
 <1403546357.21810.1583779060302.JavaMail.zimbra@efficios.com>
 <20200310014043.4dbagqbr2wsbuarm@ast-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310014043.4dbagqbr2wsbuarm@ast-mbp>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 09, 2020 at 06:40:45PM -0700, Alexei Starovoitov wrote:
> On Mon, Mar 09, 2020 at 02:37:40PM -0400, Mathieu Desnoyers wrote:
> > > 
> > >    But what's relevant is the tracer overhead which is e.g. inflicted
> > >    with todays trace_hardirqs_off/on() implementation because that
> > >    unconditionally uses the rcuidle variant with the scru/rcu_irq dance
> > >    around every tracepoint.
> > 
> > I think one of the big issues here is that most of the uses of
> > trace_hardirqs_off() are from sites which already have RCU watching,
> > so we are doing heavy-weight operations for nothing.
> 
> I think kernel/trace/trace_preemptirq.c created too many problems for the
> kernel without providing tangible benefits. My understanding no one is using it
> in production.

Hi Alexei,
There are various people use the preempt/irq disable tracepoints for last 2
years at Google and ARM. There's also a BPF tool (in BCC) that uses those for
tracing critical sections. Also Daniel Bristot's entire Preempt-IRQ formal
verification stuff depends on it.

> It's a tool to understand how kernel works. And such debugging
> tool can and should be removed.

If we go by that line of reasoning, then function tracing also should be
removed from the kernel.

I am glad Thomas and Peter are working on it and looking forward to seeing
the patches,

thanks,

 - Joel


> One of Thomas's patches mentioned that bpf can be invoked from hardirq and
> preempt tracers. This connection doesn't exist in a direct way, but
> theoretically it's possible. There is no practical use though and I would be
> happy to blacklist such bpf usage at a minimum.
> 
> > We could use the approach proposed by Peterz's and Steven's patches to basically
> > do a lightweight "is_rcu_watching()" check for rcuidle tracepoint, and only enable
> > RCU for those cases. We could then simply go back on using regular RCU like so:
> > 
> > #define __DO_TRACE(tp, proto, args, cond, rcuidle)                      \
> >         do {                                                            \
> >                 struct tracepoint_func *it_func_ptr;                    \
> >                 void *it_func;                                          \
> >                 void *__data;                                           \
> >                 bool exit_rcu = false;                                  \
> >                                                                         \
> >                 if (!(cond))                                            \
> >                         return;                                         \
> >                                                                         \
> >                 if (rcuidle && !rcu_is_watching()) {                    \
> >                         rcu_irq_enter_irqson();                         \
> >                         exit_rcu = true;                                \
> >                 }                                                       \
> >                 preempt_disable_notrace();                              \
> >                 it_func_ptr = rcu_dereference_raw((tp)->funcs);         \
> >                 if (it_func_ptr) {                                      \
> >                         do {                                            \
> >                                 it_func = (it_func_ptr)->func;          \
> >                                 __data = (it_func_ptr)->data;           \
> >                                 ((void(*)(proto))(it_func))(args);      \
> >                         } while ((++it_func_ptr)->func);                \
> >                 }                                                       \
> >                 preempt_enable_notrace();                               \
> >                 if (exit_rcu)                                           \
> >                         rcu_irq_exit_irqson();                          \
> >         } while (0)
> 
> I think it's a fine approach interim.
> 
> Long term sounds like Paul is going to provide sleepable and low overhead
> rcu_read_lock_for_tracers() that will include bpf.
> My understanding that this new rcu flavor won't have "idle" issues,
> so rcu_is_watching() checks will not be necessary.
> And if we remove trace_preemptirq.c the only thing left will be Thomas's points
> 1 (low level entry) and 2 (breakpoints) that can be addressed without
> creating fancy .text annotations and teach objtool about it.
> 
> In the mean time I've benchmarked srcu for sleepable bpf and it's quite heavy.
> srcu_read_lock+unlock roughly adds 10x execution cost to trivial bpf prog.
> I'm proceeding with it anyway, but really hoping that
> rcu_read_lock_for_tracers() will materialize soon.
> 
> In general I'm sceptical that .text annotations will work. Let's say all of
> idle is a red zone. But a ton of normal functions are called when idle. So
> objtool will go and mark them as red zone too. This way large percent of the
> kernel will be off limits for tracers. Which is imo not a good trade off. I
> think addressing 1 and 2 with explicit notrace/nokprobe annotations will cover
> all practical cases where people can shot themselves in a foot with a tracer. I
> realize that there will be forever whack-a-mole game and these annotations will
> never reach 100%. I think it's a fine trade off. Security is never 100% either.
> Tracing is never going to be 100% safe too.
