Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B8C5BF8A7
	for <lists+bpf@lfdr.de>; Wed, 21 Sep 2022 10:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbiIUIKO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Sep 2022 04:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbiIUIKN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Sep 2022 04:10:13 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB8D5A3E0;
        Wed, 21 Sep 2022 01:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=myAgx7o2VpwH7wgyiVn6SVJH48L3A2jtjDJPqzDduIo=; b=ZhN2CSbEv3TDZywjH9v0Tom8Mt
        1fVSlBY6XYC0DJh8N9POo1Tx6BszTsbns5k3bvqVU9nj3p3ZxcmUbQxzRdWt+t2M/MBNbedZ3foHN
        j8ABBziJvFA/wG1as8ZiMXtspAMLfxf8pvuUJvuC3ZLXtDMsMiaMjcZK7T5yg1mxvtodcjGZxrzyq
        1mGdgMObKhl+YMrSr/h7pEFfu3bwQeyM8a0gcTWRJ6G123oQKkUotwxzCHpa1SpstmpuTM/gDoYnP
        LSiPY8yfXn+bodZPVgZw4BdYhDDAf2vP6d5RRphCsimj3pYjcjqLn6GhS4RNRkHqDskmFZnNpOV4i
        jqgZFaxA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oaunx-00EYo0-7C; Wed, 21 Sep 2022 08:10:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9CC683001F3;
        Wed, 21 Sep 2022 10:10:00 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 535882019EC98; Wed, 21 Sep 2022 10:10:00 +0200 (CEST)
Date:   Wed, 21 Sep 2022 10:10:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Li Zhong <floridsleeves@gmail.com>,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
        namhyung@kernel.org, jolsa@kernel.org,
        alexander.shishkin@linux.intel.com, mark.rutland@arm.com,
        acme@kernel.org, mingo@redhat.com
Subject: Re: [PATCH v2] kernel/events/core: check return value of
 task_function_call()
Message-ID: <YyrG2JL/hW5m7gSl@hirez.programming.kicks-ass.net>
References: <20220919191611.1589661-1-floridsleeves@gmail.com>
 <YyrBYE4iMvei/nNC@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyrBYE4iMvei/nNC@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 21, 2022 at 09:46:40AM +0200, Ingo Molnar wrote:
> 
> * Li Zhong <floridsleeves@gmail.com> wrote:
> 
> > From: lily <floridsleeves@gmail.com>
> > 
> > Check the return value of task_function_call(), which could be error
> > code when the execution fails. We log this on info level.
> > 
> > Signed-off-by: Li Zhong <floridsleeves@gmail.com>
> > ---
> >  kernel/events/core.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index 2621fd24ad26..3848631b009c 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -13520,7 +13520,10 @@ static void perf_cgroup_attach(struct cgroup_taskset *tset)
> >  	struct cgroup_subsys_state *css;
> >  
> >  	cgroup_taskset_for_each(task, css, tset)
> > -		task_function_call(task, __perf_cgroup_move, task);
> > +		if (!task_function_call(task, __perf_cgroup_move, task)) {
> > +			printk(KERN_INFO "perf: this process isn't running!\n");
> > +			continue;
> 
> If this is a 'should never happen' condition, then this should really be 
> WARN_ON_ONCE().
> 
> (If it can happen, then polluting the syslog is wrong.)

It can happen and is just fine. If this task_function_call() fails, it
means the context switch that made it fail ensured the new values have
been picked up.
