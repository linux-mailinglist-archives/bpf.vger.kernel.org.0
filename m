Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 393FB64A98F
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 22:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbiLLVdR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Dec 2022 16:33:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiLLVdP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 16:33:15 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C534DDC;
        Mon, 12 Dec 2022 13:33:14 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id u15-20020a17090a3fcf00b002191825cf02so1412821pjm.2;
        Mon, 12 Dec 2022 13:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DAwiiJ3gzBmaogwEMCs5wwB0PWSWlCpNEYVO2I6Gx2A=;
        b=WGRXmtvVuu6kPUpvgb4SRtKcVotSdyJUJzDOzCG42ZzUpb6qhS0dY9lSlBLeQTKu/i
         48c3/Z172q3e+bemEtGPMeA2eaPJgq6fcLQ3/r6LHGjdWUYxZhKxmTPVecDpc+WMO+Mr
         Yd2nGNvHCAe0GIMEgTJ9NiYVV0hgy5LTgYHBIcJfxmXVm1vr/u7P1RN3Md8jMbagciUL
         6NWjn5vf9ZDuMCK/vfOCoKN4+Nw8vSXvm25/LfsIbzVyzQjUt0B8adSEnbxbTAM50sw/
         E/umkAe/0Ueild7o7vIUzVVEqRm0Gsofaou7cY8doooLeNdBYX3pcAQKm6WxDj3BxcMi
         Ja4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DAwiiJ3gzBmaogwEMCs5wwB0PWSWlCpNEYVO2I6Gx2A=;
        b=qXmK2Oz677zeNPaTcytDhpae/bK7zFsMyuVOA+LtYRFB+5diz9XDhv5twh+lRl3UaT
         Uof+fFbJzLXzxRUzUw70AMdFFXt9iH1OMALB3juQcEJVwASAatGhjgONsP1/RBXigeAB
         uGC6btp16/nLpDixeZCXBpnAoQwrdHiW+8THCcd7YtV8yAo1HUkRfsaZYkpgdAdtB8ZX
         aos/sXJGFnWq92jpwyjcvfEjD6lHxVudTzIdhkmXm3Ag+HBzUhGOxXDEG/muvasyNzfw
         8H74fe0y2hhoGDDFOY5O07Y+YcynQy010YbpkMNxBAldpDrk7LciZ1mH0yikHqjcVv/F
         wPPA==
X-Gm-Message-State: ANoB5pmyIgDnHTSeyyBdpUXzrjKmE5SsPAw+8eJGREIUKO3N/y1RvFwW
        JhxzdXmYCJU6FI7dPTVuFl4=
X-Google-Smtp-Source: AA0mqf6qqt7P5sZgPWb2d/3ZdsVhc85L0yyAivW6G3O+FWF9vxSUkK+zgywGm9geQ8J+YBKza9RQvA==
X-Received: by 2002:a17:902:eb82:b0:189:da3b:17ae with SMTP id q2-20020a170902eb8200b00189da3b17aemr19154032plg.14.1670880793761;
        Mon, 12 Dec 2022 13:33:13 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id b18-20020a170903229200b00182a9c27acfsm6842253plh.227.2022.12.12.13.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 13:33:13 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 12 Dec 2022 11:33:12 -1000
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
Message-ID: <Y5eeGMpr/SuyGBQO@slm.duckdns.org>
References: <20221130082313.3241517-1-tj@kernel.org>
 <20221130082313.3241517-15-tj@kernel.org>
 <Y5ckYyz14bxCvv40@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5ckYyz14bxCvv40@hirez.programming.kicks-ass.net>
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

On Mon, Dec 12, 2022 at 01:53:55PM +0100, Peter Zijlstra wrote:
> Perhaps the saner way to write this is:
> 
> #ifdef CONFIG_SMP
> 	BUG_ON(!sched_class_above(&stop_sched_class, &dl_sched_class));
> #endif
> 	BUG_ON(!sched_class_above(&dl_sched_class, &rt_sched_class));
> 	BUG_ON(!sched_class_above(&rt_sched_class, &fair_sched_class));
> 	BUG_ON(!sched_class_above(&fair_sched_class, &idle_sched_class));
> #ifdef CONFIG_...
> 	BUG_ON(!sched_class_above(&fair_sched_class, &ext_sched_class));
> 	BUG_ON(!sched_class_above(&ext_sched_class, &idle_sched_class));
> #endif

Yeah, this looks way better. Will update.

> > +static inline const struct sched_class *next_active_class(const struct sched_class *class)
> > +{
> > +	class++;
> > +	if (!scx_enabled() && class == &ext_sched_class)
> > +		class++;
> > +	return class;
> > +}
> > +
> > +#define for_active_class_range(class, _from, _to)				\
> > +	for (class = (_from); class != (_to); class = next_active_class(class))
> > +
> > +#define for_each_active_class(class)						\
> > +	for_active_class_range(class, __sched_class_highest, __sched_class_lowest)
> > +
> > +/*
> > + * SCX requires a balance() call before every pick_next_task() call including
> > + * when waking up from idle.
> > + */
> > +#define for_balance_class_range(class, prev_class, end_class)			\
> > +	for_active_class_range(class, (prev_class) > &ext_sched_class ?		\
> > +			       &ext_sched_class : (prev_class), (end_class))
> > +
> 
> This seems quite insane; why not simply make the ext methods effective
> no-ops? Both balance and pick explicitly support that already, no?

Yeah, we can definitely do that. It's just nice to guarantee from the core
code that we aren't calling into a sched class which isn't enabled at the
moment. If you take a look at "[PATCH 20/31] sched_ext: Allow BPF schedulers
to switch all eligible tasks into sched_ext", it's used the other way around
too to elide calling into CFS when it knows that there are no tasks there.
If the core code doesn't elide the calls, we might need some gating in CFS
too.

> > @@ -5800,10 +5812,13 @@ static void put_prev_task_balance(struct rq *rq, struct task_struct *prev,
> >  	 * We can terminate the balance pass as soon as we know there is
> >  	 * a runnable task of @class priority or higher.
> >  	 */
> > -	for_class_range(class, prev->sched_class, &idle_sched_class) {
> > +	for_balance_class_range(class, prev->sched_class, &idle_sched_class) {
> >  		if (class->balance(rq, prev, rf))
> >  			break;
> >  	}
> > +#else
> > +	/* SCX needs the balance call even in UP, call it explicitly */
> 
> This, *WHY* !?!

This comes from the fact that there are no strict rq boundaries and the BPF
scheduler can share scheduling queues across any subset of CPUs however they
see fit. So, task <-> rq association is flexible until the very last moment
the task gets picked for execution. For the dispatch path to support this,
it needs to be able to migrate tasks across rq's which requires unlocking
the current rq which can only be done in ->balance(). So, sched_ext uses
->balance() to run the dispatch path and thus needs it called even on UP.

Given that UP doesn't need to transfer tasks across, it might be possible to
move the whole dispatch operation into ->pick_next_task() but the current
state would be different, so it's more complicated and will likely be more
brittle.

> > @@ -5876,7 +5894,7 @@ static inline struct task_struct *pick_task(struct rq *rq)
> >  	const struct sched_class *class;
> >  	struct task_struct *p;
> >  
> > -	for_each_class(class) {
> > +	for_each_active_class(class) {
> >  		p = class->pick_task(rq);
> >  		if (p)
> >  			return p;
> 
> 
> But this.. afaict that means that:
> 
>  - the whole EXT thing is incompatible with SCHED_CORE

Can you expand on why this would be? I didn't test against SCHED_CORE, so am
sure things might be broken but can't think of a reason why it'd be
fundamentally incompatible.

>  - the whole EXT thing can be trivially starved by the presence of a
>    single CFS/BATCH/IDLE task.

It's a simliar situation w/ RT vs. CFS, which is resolved via RT having
starvation avoidance. Here, the way it's handled is a bit different, SCX has
a watchdog mechanism implemented in "[PATCH 18/31] sched_ext: Implement
runnable task stall watchdog", so if SCX tasks hang for whatever reason
including being starved by CFS, it will get aborted and all tasks will be
handed back to CFS. IOW, it's treated like any other BPF scheduler errors
that can lead to stalls and recovered the same way.

Thanks.

-- 
tejun
