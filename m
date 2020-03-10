Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A098917F163
	for <lists+bpf@lfdr.de>; Tue, 10 Mar 2020 09:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgCJIDK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Mar 2020 04:03:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:32796 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbgCJIDK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Mar 2020 04:03:10 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jBZqq-0008RV-Ab; Tue, 10 Mar 2020 09:02:56 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 93AD4104084; Tue, 10 Mar 2020 09:02:55 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        paulmck <paulmck@kernel.org>,
        "Joel Fernandes\, Google" <joel@joelfernandes.org>,
        Frederic Weisbecker <frederic@kernel.org>, bpf@vger.kernel.org
Subject: Re: Instrumentation and RCU
In-Reply-To: <20200310014043.4dbagqbr2wsbuarm@ast-mbp>
References: <87mu8p797b.fsf@nanos.tec.linutronix.de> <1403546357.21810.1583779060302.JavaMail.zimbra@efficios.com> <20200310014043.4dbagqbr2wsbuarm@ast-mbp>
Date:   Tue, 10 Mar 2020 09:02:55 +0100
Message-ID: <87v9nc63io.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
> In general I'm sceptical that .text annotations will work. Let's say all of
> idle is a red zone. But a ton of normal functions are called when idle. So
> objtool will go and mark them as red zone too.

No. If you carefully read what I proposed its:

noinst foo()
{
        protected_work();
        
        instr_begin();

        invoke_otherstuff();

        instr_end();

        moar_protected_work();

}

objtool will not mark anything. It will check that invocations out of
the protected section are marked as safe, i.e. inside a
instr_begin/end() pair.

So if you fail to mark protected_work() as noinstr then it will
complain. If you forget to put instr_begin/end() around the safe area it
will complain about invoke_otherstuff().

So it's a very targeted approach. objtool is there to verify that it's
consistent nothing else.

> This way large percent of the
> kernel will be off limits for tracers. Which is imo not a good trade off. I
> think addressing 1 and 2 with explicit notrace/nokprobe annotations will cover
> all practical cases where people can shot themselves in a foot with a
> tracer.

That's simply wishful thinking. The discussions in the last weeks have
clearly demonstrated that this is not the case. People were truly
convinced that e.g. probing rcu_idle_exit() is safe, but it was
not. Read the thread how long this went on.

> I realize that there will be forever whack-a-mole game and these
> annotations will never reach 100%. I think it's a fine trade
> off. Security is never 100% either.  Tracing is never going to be 100%
> safe too.

I disagree. Whack a mole games are horrible and have a guaranteed
high failure rate. Otherwise we would not discuss this at all.

And no, it's not a fine trade off.

If we can have technical means to prevent the wreckage, then not using
them for handwaving reasons is just violating the only sane engineering
principle:

        Correctness first

I spent the last 20 years mopping up the violations of this principle.

We have to stop the "features first, performance first" and "good
enough" mentality if we want to master the ever increasing complexity of
hardware and software in the long run.

From my experience of cleaning up stuff, I can tell you, that
correctness first neither hurts performance nor does it prevent
features, except those which are wrong to begin with.

As quite some people do not care about or even willfully ignore
"correctness first", we have to force them to adhere by technical means,
which spares us to mop up the mess they'd create otherwise.

And even for those who deeply care tooling support is a great help to
prevent the accidental slip up. I wish I could have spared chasing call
chains manually and then figure out two days later that I missed
something.

Thanks,

        tglx


