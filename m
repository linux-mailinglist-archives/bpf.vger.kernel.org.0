Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E30E064A85B
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 21:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233399AbiLLUEB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Dec 2022 15:04:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233389AbiLLUEA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 15:04:00 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BFD1788A;
        Mon, 12 Dec 2022 12:03:59 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id 21so688651pfw.4;
        Mon, 12 Dec 2022 12:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QxiD9QOWm22ozh4cTtuGcvlN+TVb9Fc8vBBhLu2C8CM=;
        b=aCUTOAHu/xmm8z9cyKediliIPVmUzLeCJEMjJhv7iONzRgrgWaQAYxmDwiwP6GwFvd
         hEPkAFqbmYYHm3abENgM/UlBrKOcKBzwbn+gTg56JPRj6c3YRupUDWaWst5YQWkV+USa
         fV3CBrAevzb7fval2VL4gt2C2jaPTDRQoQRuf99HDLl7o2rYmUC+YZ8n+QcuRcztxxpD
         DAwoqrviplWG8HzDSTSHfI/lzThCaaC2P9EFGGU1xLYVAcnqzI/SsyekwSk/RXz0v6QU
         j19Zu6Y701NNU+R26N4SGJIRDFpOw5TuT/uR806juxtNkywIVt+7ZbV1+Y8S0zdsChbJ
         /DMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QxiD9QOWm22ozh4cTtuGcvlN+TVb9Fc8vBBhLu2C8CM=;
        b=h0LQF7nJSsYhQ4tl192qXGIlZ5zyRcbHWW5XNnpRTQCP/5cX3XySdqmuMAU2kTLdLs
         BXqbx3aVJZ7loZ+kIVXCLv0YOicxGTuVo+kAWUN0kZTrgxOHhRS7Z5H7NxVS680dRjD2
         uQLhnPGLjXK1m5nbspJy5dCEOfge1qWBRDgNyUKzc++vieaKG5EP4hu/JY4lSNnoozGs
         rhhNLIwncl51TeRg+O1mlXo9q94HyxRZRVzQXLLgbozKcaazMogB353Bk7vo2Ar5pbKc
         IMCBh/vt43U3SSXCwQjEtJKCdGDz30VB+ZafFVjf6kszFM8pdeoTfT/c6d4XATga3atq
         sf1w==
X-Gm-Message-State: ANoB5pkTe1AIEZX/T93d6jl2ghZgHpaDHGZHODDng8XfLPkJQBEvxQUh
        gkG2peFQ9epYG0uY0CwAGEM=
X-Google-Smtp-Source: AA0mqf41NVpaFY3aBkPGYrmRoRRgSVyDmbszFNRlsOkFgmmqfsO8Uema71lbsjpkFRMwn1M7y7Z+Gg==
X-Received: by 2002:a05:6a00:1f0f:b0:56c:881d:b128 with SMTP id be15-20020a056a001f0f00b0056c881db128mr15894319pfb.22.1670875438318;
        Mon, 12 Dec 2022 12:03:58 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id a15-20020aa795af000000b00576670cc170sm6347939pfk.93.2022.12.12.12.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 12:03:57 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 12 Dec 2022 10:03:56 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <Y5eJLAO09yd7j1xF@slm.duckdns.org>
References: <20221130082313.3241517-1-tj@kernel.org>
 <20221130082313.3241517-15-tj@kernel.org>
 <Y5cfD137arVsOdj7@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5cfD137arVsOdj7@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

On Mon, Dec 12, 2022 at 01:31:11PM +0100, Peter Zijlstra wrote:
> On Tue, Nov 29, 2022 at 10:22:56PM -1000, Tejun Heo wrote:
> > @@ -11242,3 +11268,38 @@ void call_trace_sched_update_nr_running(struct rq *rq, int count)
> >  {
> >          trace_sched_update_nr_running_tp(rq, count);
> >  }
> > +
> > +#ifdef CONFIG_SCHED_CLASS_EXT
> > +void sched_deq_and_put_task(struct task_struct *p, int queue_flags,
> > +			    struct sched_enq_and_set_ctx *ctx)
> > +{
> > +	struct rq *rq = task_rq(p);
> > +
> > +	lockdep_assert_rq_held(rq);
> > +
> > +	*ctx = (struct sched_enq_and_set_ctx){
> > +		.p = p,
> > +		.queue_flags = queue_flags | DEQUEUE_NOCLOCK,
> > +		.queued = task_on_rq_queued(p),
> > +		.running = task_current(rq, p),
> > +	};
> > +
> > +	update_rq_clock(rq);
> > +	if (ctx->queued)
> > +		dequeue_task(rq, p, queue_flags);
> > +	if (ctx->running)
> > +		put_prev_task(rq, p);
> > +}
> > +
> > +void sched_enq_and_set_task(struct sched_enq_and_set_ctx *ctx)
> > +{
> > +	struct rq *rq = task_rq(ctx->p);
> > +
> > +	lockdep_assert_rq_held(rq);
> > +
> > +	if (ctx->queued)
> > +		enqueue_task(rq, ctx->p, ctx->queue_flags);
> > +	if (ctx->running)
> > +		set_next_task(rq, ctx->p);
> > +}
> > +#endif	/* CONFIG_SCHED_CLASS_EXT */
> 
> So no. Like the whole __setscheduler_prio() thing, this doesn't make
> sense outside of the core code, policy/class code should never need to
> do this.

Continuing from the __setscheduler_prio() discussion, the need arises from
the fact that whether a task is on SCX or CFS changes depending on whether
the BPF scheduler is loaded or not - e.g. when the BPF scheduler gets
disabled, all tasks that were on it need to be moved back into CFS. There
are different ways to implement this but it needs to be solved somehow.

> Also: https://lkml.kernel.org/r/20220330162228.GH14330@worktop.programming.kicks-ass.net

Yeah, it'd be nice to encapsulate this sequence. The FOR_CHANGE_GUARD naming
throws me off a bit tho as it's not really a loop. Wouldn't it be better to
call it CHANGE_GUARD_BLOCK or sth?

Thanks.

-- 
tejun
