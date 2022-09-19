Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C27FD5BCF2D
	for <lists+bpf@lfdr.de>; Mon, 19 Sep 2022 16:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbiISOjN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Sep 2022 10:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiISOjL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Sep 2022 10:39:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985BA2D1D9;
        Mon, 19 Sep 2022 07:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YjclUMktNx88A5Ga2p1PmOfLVjv8YGj91znNKqBCP+E=; b=G7lVOz/mIap1ssllZ8n+ISK8rk
        8n80KY1FsEieWlq/84fHEK1/1T7cel3/JjAJZRyoWkJMMI1b1DBWlEQAuWtIQ9KHpJWcgyaK0rALw
        VqJWxpVeSXuuS+TwAEldjl2HFe6TT98FhhXPwbUxTo/7+LUTxaAHXj/tf92DTtV0fSlopt4tsja0O
        h8At168E9JoSjWikFLYiBAqvxhQjy5Pdz0ZzY33DYkP102+afhnDF5haSUapgGYVFN4rlhD5mbSzy
        3esophHivZdt/4Bhcr3izF+dFKnAd515JNsSw85x8qn8MbtbjmHugHDDMuhkjf1k5/sMZ6a2MQbhi
        9zmEVW3A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oaHvN-004mJj-9C; Mon, 19 Sep 2022 14:39:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5C8F23001F3;
        Mon, 19 Sep 2022 16:39:02 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 173372BAC7767; Mon, 19 Sep 2022 16:39:02 +0200 (CEST)
Date:   Mon, 19 Sep 2022 16:39:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Li Zhong <floridsleeves@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, namhyung@kernel.org, jolsa@kernel.org,
        alexander.shishkin@linux.intel.com, mark.rutland@arm.com,
        acme@kernel.org, mingo@redhat.com
Subject: Re: [PATCH v1] kernel/events/core: check return value of
 task_function_call()
Message-ID: <Yyh/BmvAHNMlENFw@hirez.programming.kicks-ass.net>
References: <20220917014746.3828349-1-floridsleeves@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220917014746.3828349-1-floridsleeves@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 16, 2022 at 06:47:46PM -0700, Li Zhong wrote:
> Check the return value of task_function_call(), which could be error
> code when the execution fails.

How is terminating the cgroup task iteration a useful thing? Also coding
style fail for not adding { }

> Signed-off-by: Li Zhong <floridsleeves@gmail.com>
> ---
>  kernel/events/core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 2621fd24ad26..ac0cf611b12a 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -13520,7 +13520,8 @@ static void perf_cgroup_attach(struct cgroup_taskset *tset)
>  	struct cgroup_subsys_state *css;
>  
>  	cgroup_taskset_for_each(task, css, tset)
> -		task_function_call(task, __perf_cgroup_move, task);
> +		if (!task_function_call(task, __perf_cgroup_move, task))
> +			return;
>  }
>  
>  struct cgroup_subsys perf_event_cgrp_subsys = {
> -- 
> 2.25.1
> 
