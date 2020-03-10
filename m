Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5AD817EE10
	for <lists+bpf@lfdr.de>; Tue, 10 Mar 2020 02:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbgCJBku (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Mar 2020 21:40:50 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:35661 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbgCJBku (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Mar 2020 21:40:50 -0400
Received: by mail-pj1-f67.google.com with SMTP id mq3so728505pjb.0;
        Mon, 09 Mar 2020 18:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hHh+yzxvosI5eVAcwu2vKCdjCy40ip824d0OTCKUabk=;
        b=MatZ5SAkWOiAs/dJH7GvgGm6RyOsu3/1oNHEFsfDf2hS5MjCwrbn7vz4CFMndrIyCU
         +CLQu6aAdkk2kEVuStjFZ/nasHieWtFeleJJch8W8DV4eV7RaoBrs3Az2MfA4Yu8GNL+
         xM8icwFyC4b16lIlOCVDH+WIrw7rAJRfjJ/CRkayuGXUUOPnFvyXdYvzOhWZCAmEC5u0
         nhDgXC2I2ZRBNmCa/IfW4pu25s4wAMMree2E3PaEffjdQpk5LNvUvCiqgrp+ZpJqRyD8
         ajHIKz2lTo7Q1ggErwMRFzYZzad5nbbzgtih1cnF4EJdKjWpn3W3Ry0lN3GvRbEImVrp
         UMvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hHh+yzxvosI5eVAcwu2vKCdjCy40ip824d0OTCKUabk=;
        b=p2nOILFbcNg06zxU8uzRnL2RZpyUGKsDQWdQ1U5TvkSSm+FtxPO4RDXXab/BAVKC0s
         oI2532zYu5rfDkYOsO6yzr0AeiDTw/lz3uha85xh+7cMownRuqz1M6PRkpEH2bP80I/7
         Q2lkcEnIEHyH4hDNRehQgzmi+MfrFeug1xwPINGK+MBM7PLnNNzjzssBDm2CDkh43ihh
         8k8ZTQp+nbm+Ro7yUGE+GgXhiDgN+/IEiiCW2mcdP1ptKwueJLmM9gEP1sW+aRTkPyDM
         pgy3KJi5CRRUwg7Lm4OeR9nJjEcH+3ANCB2vysvjewe1SZqzyYDf92OxXZHZZMd+Q1Jm
         21Xw==
X-Gm-Message-State: ANhLgQ3k1Xr6pipel81jtWHeJ0YfFXlnmUEFUoD17ptn68a8g2smkf2E
        86SyG5Lafm2jSxmV4MXYOJjLCJev
X-Google-Smtp-Source: ADFU+vv+OusmieCScSdXl4bt3fcTWukFx+IJQbyUgexq0Dwozi6BAxD04lzw71j7/8vbIBqzMBFTcw==
X-Received: by 2002:a17:902:7585:: with SMTP id j5mr18715878pll.254.1583804448250;
        Mon, 09 Mar 2020 18:40:48 -0700 (PDT)
Received: from ast-mbp ([2620:10d:c090:500::7:4bc0])
        by smtp.gmail.com with ESMTPSA id y7sm5690438pfq.159.2020.03.09.18.40.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Mar 2020 18:40:47 -0700 (PDT)
Date:   Mon, 9 Mar 2020 18:40:45 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        paulmck <paulmck@kernel.org>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Frederic Weisbecker <frederic@kernel.org>, bpf@vger.kernel.org
Subject: Re: Instrumentation and RCU
Message-ID: <20200310014043.4dbagqbr2wsbuarm@ast-mbp>
References: <87mu8p797b.fsf@nanos.tec.linutronix.de>
 <1403546357.21810.1583779060302.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1403546357.21810.1583779060302.JavaMail.zimbra@efficios.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 09, 2020 at 02:37:40PM -0400, Mathieu Desnoyers wrote:
> > 
> >    But what's relevant is the tracer overhead which is e.g. inflicted
> >    with todays trace_hardirqs_off/on() implementation because that
> >    unconditionally uses the rcuidle variant with the scru/rcu_irq dance
> >    around every tracepoint.
> 
> I think one of the big issues here is that most of the uses of
> trace_hardirqs_off() are from sites which already have RCU watching,
> so we are doing heavy-weight operations for nothing.

I think kernel/trace/trace_preemptirq.c created too many problems for the
kernel without providing tangible benefits. My understanding no one is using it
in production. It's a tool to understand how kernel works. And such debugging
tool can and should be removed.

One of Thomas's patches mentioned that bpf can be invoked from hardirq and
preempt tracers. This connection doesn't exist in a direct way, but
theoretically it's possible. There is no practical use though and I would be
happy to blacklist such bpf usage at a minimum.

> We could use the approach proposed by Peterz's and Steven's patches to basically
> do a lightweight "is_rcu_watching()" check for rcuidle tracepoint, and only enable
> RCU for those cases. We could then simply go back on using regular RCU like so:
> 
> #define __DO_TRACE(tp, proto, args, cond, rcuidle)                      \
>         do {                                                            \
>                 struct tracepoint_func *it_func_ptr;                    \
>                 void *it_func;                                          \
>                 void *__data;                                           \
>                 bool exit_rcu = false;                                  \
>                                                                         \
>                 if (!(cond))                                            \
>                         return;                                         \
>                                                                         \
>                 if (rcuidle && !rcu_is_watching()) {                    \
>                         rcu_irq_enter_irqson();                         \
>                         exit_rcu = true;                                \
>                 }                                                       \
>                 preempt_disable_notrace();                              \
>                 it_func_ptr = rcu_dereference_raw((tp)->funcs);         \
>                 if (it_func_ptr) {                                      \
>                         do {                                            \
>                                 it_func = (it_func_ptr)->func;          \
>                                 __data = (it_func_ptr)->data;           \
>                                 ((void(*)(proto))(it_func))(args);      \
>                         } while ((++it_func_ptr)->func);                \
>                 }                                                       \
>                 preempt_enable_notrace();                               \
>                 if (exit_rcu)                                           \
>                         rcu_irq_exit_irqson();                          \
>         } while (0)

I think it's a fine approach interim.

Long term sounds like Paul is going to provide sleepable and low overhead
rcu_read_lock_for_tracers() that will include bpf.
My understanding that this new rcu flavor won't have "idle" issues,
so rcu_is_watching() checks will not be necessary.
And if we remove trace_preemptirq.c the only thing left will be Thomas's points
1 (low level entry) and 2 (breakpoints) that can be addressed without
creating fancy .text annotations and teach objtool about it.

In the mean time I've benchmarked srcu for sleepable bpf and it's quite heavy.
srcu_read_lock+unlock roughly adds 10x execution cost to trivial bpf prog.
I'm proceeding with it anyway, but really hoping that
rcu_read_lock_for_tracers() will materialize soon.

In general I'm sceptical that .text annotations will work. Let's say all of
idle is a red zone. But a ton of normal functions are called when idle. So
objtool will go and mark them as red zone too. This way large percent of the
kernel will be off limits for tracers. Which is imo not a good trade off. I
think addressing 1 and 2 with explicit notrace/nokprobe annotations will cover
all practical cases where people can shot themselves in a foot with a tracer. I
realize that there will be forever whack-a-mole game and these annotations will
never reach 100%. I think it's a fine trade off. Security is never 100% either.
Tracing is never going to be 100% safe too.
