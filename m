Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDE8764B3B0
	for <lists+bpf@lfdr.de>; Tue, 13 Dec 2022 12:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235227AbiLMLDF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Dec 2022 06:03:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235247AbiLMLC6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Dec 2022 06:02:58 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6986F11C05;
        Tue, 13 Dec 2022 03:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nVeAC07Szykku1yuUAuCP4jwMN/7vl8k2vkxnnVo4AE=; b=cO7zzKzKp/ruXYRkCGrznk3k0W
        syUETTAVyHKjkjP6YDdnFHd3fjUitq3WJKJ8qexU31R/9fYJH/Dj5hJ+2R8k848C/ySdz00LjL4Hc
        tpWgUM50ycNpRpGDfSd0k4jZ7ixH0cTw6Q4KLejPAGrqdmbHlwsdGUxidmWtQKP9aMKBmJggBAPSq
        FoGvFodLZYvWXy5oyH8xvheK10ru0AXZJqCTfOdzhqz40T/WYM3OCGOXroxJpiRpCbHfcWe2jllhY
        ymAAyfKC+ttQ18MtXl65Qj/46AHjiuYDhisgCCziQrJ4vTuuefnAD2jpWmr/4KBfl29jp+3d4AFU5
        +H4iadFw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p5337-00A3T8-0D; Tue, 13 Dec 2022 11:02:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id ED0CF30036B;
        Tue, 13 Dec 2022 11:55:10 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AED67201FEA66; Tue, 13 Dec 2022 11:55:10 +0100 (CET)
Date:   Tue, 13 Dec 2022 11:55:10 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     torvalds@linux-foundation.org, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@kernel.org, joshdon@google.com, brho@google.com,
        pjt@google.com, derkling@google.com, haoluo@google.com,
        dvernet@meta.com, dschatzberg@meta.com, dskarlat@cs.cmu.edu,
        riel@surriel.com, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 14/31] sched_ext: Implement BPF extensible scheduler class
Message-ID: <Y5haDh3sYUFcXkBx@hirez.programming.kicks-ass.net>
References: <20221130082313.3241517-1-tj@kernel.org>
 <20221130082313.3241517-15-tj@kernel.org>
 <Y5ckYyz14bxCvv40@hirez.programming.kicks-ass.net>
 <Y5eeGMpr/SuyGBQO@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5eeGMpr/SuyGBQO@slm.duckdns.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 12, 2022 at 11:33:12AM -1000, Tejun Heo wrote:

> > But this.. afaict that means that:
> > 
> >  - the whole EXT thing is incompatible with SCHED_CORE
> 
> Can you expand on why this would be? I didn't test against SCHED_CORE, so am
> sure things might be broken but can't think of a reason why it'd be
> fundamentally incompatible.

For starters, SCHED_CORE doesn't use __pick_next_task() (much). But I
think you're going to have more trouble with prio_less() (which is the
3rd implementation of the scheduling function :/)

> >  - the whole EXT thing can be trivially starved by the presence of a
> >    single CFS/BATCH/IDLE task.
> 
> It's a simliar situation w/ RT vs. CFS, which is resolved via RT having
> starvation avoidance.

That is a horrible situation as is, FIFO/RR are very crap scheduling
policies for a number of reasons but we're stuck with them due to
history and POSIX :-(, that is not something you should justify anything
with.

In fact, it should be an example of what to avoid.

Specifically, FIFO/RR fail at the fundamentals of OS
abstractions -- they provide neither resource distribution nor
isolation.

> Here, the way it's handled is a bit different, SCX has
> a watchdog mechanism implemented in "[PATCH 18/31] sched_ext: Implement
> runnable task stall watchdog", so if SCX tasks hang for whatever reason
> including being starved by CFS, it will get aborted and all tasks will be
> handed back to CFS. IOW, it's treated like any other BPF scheduler errors
> that can lead to stalls and recovered the same way.

That all sounds quite terrible.. :/

When the scheduler isn't available it should be an error to switch a
task to the policy, when there are tasks in the policy, it must not go
away.

The policy itself should never cause policy changes.


