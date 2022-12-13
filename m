Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B02464B44D
	for <lists+bpf@lfdr.de>; Tue, 13 Dec 2022 12:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235199AbiLMLhn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Dec 2022 06:37:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235065AbiLMLhl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Dec 2022 06:37:41 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75101135;
        Tue, 13 Dec 2022 03:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TZWCZhOPRggWJARUco+Kzrwbj8L0A4oI8MvhoWMET90=; b=SK6h5CICbVr9EW2PC1uEKKIoky
        an1u6J0/ZLagxihUuzVbz03d55Pm0Zwo66XXKmCzyJLBImSXcNdj7IiVMeysqaQUzRzWdcmO8Isen
        NsxB+DCmN0HCuqh1xQNefxpTzyM1CfUTCpTMsdubU6/7epy6l1H4pVhyeffVyTDdXycn2mr0tYDNe
        li+57M4iiHzi+KXmgm3Qf8gd8EP35l2/DI/SpaH77xnkiXJdxAUYNwFKAKdyT2Jl9ojFa1olo3Kgf
        BOTiSBJGlRCj53pb5ggTYbsb08QgE3cMhvHBHpkSk4AJ88pWQ0xsNwlXlFEDcn7nW/Nc6Mr4oKDpr
        XfLFNCyg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p53aw-00A4F5-Ib; Tue, 13 Dec 2022 11:37:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B643F30036B;
        Tue, 13 Dec 2022 12:30:06 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 939C82074BBB5; Tue, 13 Dec 2022 12:30:06 +0100 (CET)
Date:   Tue, 13 Dec 2022 12:30:06 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Don <joshdon@google.com>
Cc:     Tejun Heo <tj@kernel.org>, torvalds@linux-foundation.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        brho@google.com, pjt@google.com, derkling@google.com,
        haoluo@google.com, dvernet@meta.com, dschatzberg@meta.com,
        dskarlat@cs.cmu.edu, riel@surriel.com,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@meta.com, Peter Oskolkov <posk@google.com>
Subject: Re: [PATCH 31/31] sched_ext: Add a rust userspace hybrid example
 scheduler
Message-ID: <Y5hiPqaT6UqaUcGK@hirez.programming.kicks-ass.net>
References: <20221130082313.3241517-1-tj@kernel.org>
 <20221130082313.3241517-32-tj@kernel.org>
 <Y5c0qEuyn8cAvLGQ@hirez.programming.kicks-ass.net>
 <CABk29Nu5WiCmhNN2jZrTShELbCDOYUziUeW5xojkwB83R+VzEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABk29Nu5WiCmhNN2jZrTShELbCDOYUziUeW5xojkwB83R+VzEQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 12, 2022 at 02:18:59PM -0800, Josh Don wrote:

> > But really, having seen some of this I long for the UMCG patches -- that
> > at least was somewhat sane and trivially composes, unlike all this
> > madness.
> 
> I wasn't sure if you were focusing specifically on how the BPF portion
> is implemented, or on UMCG vs sched_ext. For the latter, 

The latter, from where I'm sitting UMCG looks a *TON* saner than this
BPF scheduler proposal. In fact, I'm >< close to just saying NAK to the
whole thing and ignoring it henceforth, there's too many problems with
the whole approach.

( Many were already noted by Linus when he NAK'ed loadable schedulers
  previously. )

> and ignoring
> the specifics of this example, the UMCG and sched_ext work are
> complementary, but not mutually exclusive. UMCG is about driving
> cooperative scheduling within a particular application. UMCG does not
> have control over or react to external preemption, 

It can control preemption inside the process, and if you have the degree
of control you need to make the whole BPF thing work, you also have the
degree of control to ensure you only run the one server task on a CPU
and all that no longer matters because there's only the process and you
control preemption inside that.

> nor does it make thread placement decisions. 

It can do that just fine -- inside the process. UMCG has full control
over which server task a worker task is associated with, then run a
single server task per CPU and have them pinned and you get full
placement control.

> sched_ext is considering things more at
> the system level: arbitrating fairness and preemption between
> processes, deciding when and where threads run, etc., and also being
> able to take application-specific hints if desired.

sched_ext does fundamentally not compose, you cannot run two different
schedulers for two different application stacks that happen to co-reside
on the same machine.

While with UMCG that comes naturally.

sched_ext also sits at the very bottom of the class stack (it more or
less has to) the result is that in order to use it at all, you have to
have control over all runnable tasks in the system (a stray CFS task
would interfere quite disastrously) but that is exactly the same
constraint you need to make UMCG work.

Conversely, it is very hard to use the BPF thing to do what UMCG can do.
Using UMCG I can have a SCHED_DEADLINE server implement a task based
pipeline schedule (something that's fairly common and really hard to
pull off with just SCHED_DEADLINE itself).

Additionally, UMCG naturally works with things like Proxy Execution,
seeing how the server task *is* a proxy for the current active worker
task.
