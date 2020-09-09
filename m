Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 942962636D2
	for <lists+bpf@lfdr.de>; Wed,  9 Sep 2020 21:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbgIITsv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Sep 2020 15:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728936AbgIITsf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Sep 2020 15:48:35 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2FDC061786
        for <bpf@vger.kernel.org>; Wed,  9 Sep 2020 12:48:32 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 67so2812975pgd.12
        for <bpf@vger.kernel.org>; Wed, 09 Sep 2020 12:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PT0Nb+iqbTo2AJ5qPAcEhHWXVUm3Uisd5urv5Ntxdn4=;
        b=Bb0UTuT1arDv7oBHdxGVadh3RYgB5tGeoX3gPrGeMThwtbuitlTGSTw13XyeJy87fV
         /vwhrO52wYSCQMNhqPVR3obVnrgPIBr6P37S51S4QFv2OwePy9JPEBJh6gEB4GkZxVhL
         mDs87gHJh+TWtxgN15f88Xs4Ug2Mr1m3s5rE9btScWb2nWFcj+EGe/9MtfblEGZpb4nT
         GNP2ulsp5knWbXsHCZbL9QUvV9ZE2ia+ZJ1ijbmXv+JvKp4gnxra84Eh9Oq/5C2nLU0m
         eWLZF0jyLQd1TJA8gckgkx915HfLVZvnbRIKOdqKBxUMiviajQWPFCkukedZhLAThiX3
         03BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PT0Nb+iqbTo2AJ5qPAcEhHWXVUm3Uisd5urv5Ntxdn4=;
        b=ExYUTm4quUIlPFpTjDYFltjRiQIxiU7lcVIhIe4dhbkJzr/6/6qEIynQpYDSpYdqJB
         wKxjx/gStdK8SGPg1IGTtFbeHO5JRVBnQhvhRN7pHUk1xmZSqsIe7BTmLiOgDHkYdWmd
         Gw6Flcult+7NEixNQGLkvH3VhbYFOzNXZpO02RfKQTpPsiZu2D8uW92Q8aW3wWm2d7OB
         WVPQAfAyiyNX9CFhOTZ+ghAzeydtR8QjEumT3EXh2TF/fyBYvvhQ/rW8QwwBTqf/B2iI
         O5h9+A/fWLbb8tiBrWVs8R3K7wCDCweo87i1xL1iFrCSwOpC3kRwTck9QTYboDijVXO2
         6AFw==
X-Gm-Message-State: AOAM5301LXH4Cfe29HY915szLFxtWXHZfpF1ruBmnKZP9VFby0TptK8S
        U57rBldI4Amm0xXVDWcNtvw=
X-Google-Smtp-Source: ABdhPJw0TDcW+lbSCGJlZfdBsfUeERhZBFgfRcY0YsxLbVGVRmhpSTxjr9sJkIexeyt+WdVgTHatpQ==
X-Received: by 2002:a17:902:b40d:: with SMTP id x13mr2285589plr.116.1599680912397;
        Wed, 09 Sep 2020 12:48:32 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:8178])
        by smtp.gmail.com with ESMTPSA id i17sm3530088pfa.29.2020.09.09.12.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 12:48:31 -0700 (PDT)
Date:   Wed, 9 Sep 2020 12:48:28 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: slow sync rcu_tasks_trace
Message-ID: <20200909194828.urz6islrqajifukj@ast-mbp.dhcp.thefacebook.com>
References: <CAADnVQK_AiX+S_L_A4CQWT11XyveppBbQSQgH_qWGyzu_E8Yeg@mail.gmail.com>
 <20200909113858.GF29330@paulmck-ThinkPad-P72>
 <20200909171228.dw7ra5mkmvqrvptp@ast-mbp.dhcp.thefacebook.com>
 <20200909173512.GI29330@paulmck-ThinkPad-P72>
 <20200909180418.hlivoaekhkchlidw@ast-mbp.dhcp.thefacebook.com>
 <20200909193900.GK29330@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909193900.GK29330@paulmck-ThinkPad-P72>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 09, 2020 at 12:39:00PM -0700, Paul E. McKenney wrote:
> > > 
> > > When do you need this by?
> > > 
> > > Left to myself, I will aim for the merge window after the upcoming one,
> > > and then backport to the prior -stable versions having RCU tasks trace.
> > 
> > That would be too late.
> > We would have to disable sleepable bpf progs or convert them to srcu.
> > bcc/bpftrace have a limit of 1000 probes for regexes to make sure
> > these tools don't add too many kprobes to the kernel at once.
> > Right now fentry/fexit/freplace are using trampoline which does
> > synchronize_rcu_tasks(). My measurements show that it's roughly
> > equal to synchronize_rcu() on idle box and perfectly capable to
> > be a replacement for kprobe based attaching.
> > It's not uncommon to attach a hundred kprobes or fentry probes at
> > a start time. So bpf trampoline has to be able to do 1000 in a second.
> > And it was the case before sleepable got added to the trampoline.
> > Now it's doing:
> > synchronize_rcu_mult(call_rcu_tasks, call_rcu_tasks_trace);
> > and it's causing this massive slowdown which makes bpf trampoline
> > pretty much unusable and everything that builds on top suffers.
> > I can add a counter of sleepable progs to trampoline and do
> > either sync rcu_tasks or sync_mult(tasks, tasks_trace),
> > but we've discussed exactly that idea few months back and concluded that
> > rcu_tasks is likely to be heavier than rcu_tasks_trace, so I didn't
> > bother with the counter. I can still add it, but slow rcu_tasks_trace
> > means that sleepable progs are not usable due to slow startup time,
> > so have to do something with sleepable anyway.
> > So "when do you need this by?" the answer is asap.
> > I'm considering such changes to be a bugfix, not a feture.
> 
> Got it.
> 
> With the patch below, I am able to reproduce this issue, as expected.

I think your tests is more stressful than mine.
test_progs -t trampoline_count
doesn't run the sleepable progs. So there is no lock/unlock_trace at all.
It's updating trampoline and doing sync_mult() that's all.

> My plan is to try the following:
> 
> 1.	Parameterize the backoff sequence so that RCU Tasks Trace
> 	uses faster rechecking than does RCU Tasks.  Experiment as
> 	needed to arrive at a good backoff value.
> 
> 2.	If the tasks-list scan turns out to be a tighter bottleneck 
> 	than the backoff waits, look into parallelizing this scan.
> 	(This seems unlikely, but the fact remains that RCU Tasks
> 	Trace must do a bit more work per task than RCU Tasks.)
> 
> 3.	If these two approaches, still don't get the update-side
> 	latency where it needs to be, improvise.
> 
> The exact path into mainline will of course depend on how far down this
> list I must go, but first to get a solution.

I think there is a case of 4. Nothing is inside rcu_trace critical section.
I would expect single ipi would confirm that.
