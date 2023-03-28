Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5096CC1D9
	for <lists+bpf@lfdr.de>; Tue, 28 Mar 2023 16:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233100AbjC1OPm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Mar 2023 10:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233143AbjC1OPa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Mar 2023 10:15:30 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BAC8CA26
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 07:15:26 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id q30-20020a631f5e000000b0050760997f4dso3288287pgm.6
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 07:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680012925;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qjzC1AXnpW8l0xPrPEZPgxXh3c0otg2X0grqn38oTAU=;
        b=Z21Fhu3pxXs+t1qejKjoB06mqPadXXUaJj6uhGgpRk+3gLqlDes+wtSSSWE2knRI8/
         qiF1U6JTQdX1HxRtou/7QeC7ME871T4I2lhXvmsiB9LqWDQkJ4A+0KJwwrxD+tJ4Zz1U
         eS8+YEXBsJWpRHPbqfmOGMvVMX3kHO1M02ByL8p7FWqBJtGrwNge2GxAveCUIe2ZNQ6v
         dvl7/FGZwG59zro3vm/oD7ttk1pXq3InfcSBeQsKHb9wmWZOyOVM20v0sF2M0rosq1uZ
         BvtS7Z8Fw8zE99KoUjs5+fCH5VuwRsaKfmGjaYi/I6cgKnvsxM9ic7CzcXo5qhkkLbxE
         V9bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680012925;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qjzC1AXnpW8l0xPrPEZPgxXh3c0otg2X0grqn38oTAU=;
        b=wrpkwQUldRGe+6748RZWJH1SOw4eQCHAIiH4WLAnz57n9ReIhu7T8XhIPNSl3ROjlZ
         bQM+hR/eZhFB5LWPRnPSEiHq8gaEDmFiDKcDndF59U4p8O7sgPxnsAnE9Jll8jtCp45i
         Bfh0a4gqR1FwiSVp3P1RAbAnR+8TD7gjfHfbhO7ywmXWmO3hUtsL76N5G4TAN/2+fTDC
         iFuL4nMLsJDhu0+3vA2+Op/WK2fbbGRLTvfAkvCO5PnvPXlOJ99T6q9rAknvMlpD53xH
         Acq/AH2eW14s1vhFPdS3m8QAzKXvV3H8k8V+e4MThI3iA5oJbjdXwhV0bGp8eT/SqT1h
         dADw==
X-Gm-Message-State: AAQBX9eUUnvjoSWHgIkKx6uzvfqkGz6J2arYsXEHq5wYDq1oqXXAc4w6
        f0oOZOVm4DXAySrmVgmgtiwQkQir+11sjw==
X-Google-Smtp-Source: AKy350YS7K4/XlK9G5uXTQxuk1NaV9HRM+JxBayP8kn09bcoJ8C7tEj08nHpJbsB9L4uvhkNT4kYeDqSgTfetg==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a63:5a43:0:b0:50a:c176:385b with SMTP id
 k3-20020a635a43000000b0050ac176385bmr4084662pgm.0.1680012925672; Tue, 28 Mar
 2023 07:15:25 -0700 (PDT)
Date:   Tue, 28 Mar 2023 14:15:23 +0000
In-Reply-To: <20230328061638.203420-6-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230328061638.203420-1-yosryahmed@google.com> <20230328061638.203420-6-yosryahmed@google.com>
Message-ID: <20230328141523.txyhl7wt7wtvssea@google.com>
Subject: Re: [PATCH v1 5/9] memcg: replace stats_flush_lock with an atomic
From:   Shakeel Butt <shakeelb@google.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michal =?utf-8?Q?Koutn=C3=BD?=" <mkoutny@suse.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 28, 2023 at 06:16:34AM +0000, Yosry Ahmed wrote:
[...]
> @@ -585,8 +585,8 @@ mem_cgroup_largest_soft_limit_node(struct mem_cgroup_tree_per_node *mctz)
>   */
>  static void flush_memcg_stats_dwork(struct work_struct *w);
>  static DECLARE_DEFERRABLE_WORK(stats_flush_dwork, flush_memcg_stats_dwork);
> -static DEFINE_SPINLOCK(stats_flush_lock);
>  static DEFINE_PER_CPU(unsigned int, stats_updates);
> +static atomic_t stats_flush_ongoing = ATOMIC_INIT(0);
>  static atomic_t stats_flush_threshold = ATOMIC_INIT(0);
>  static u64 flush_next_time;
>  
> @@ -636,15 +636,18 @@ static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
>  
>  static void __mem_cgroup_flush_stats(void)
>  {
> -	unsigned long flag;
> -
> -	if (!spin_trylock_irqsave(&stats_flush_lock, flag))
> +	/*
> +	 * We always flush the entire tree, so concurrent flushers can just
> +	 * skip. This avoids a thundering herd problem on the rstat global lock
> +	 * from memcg flushers (e.g. reclaim, refault, etc).
> +	 */
> +	if (atomic_xchg(&stats_flush_ongoing, 1))

Have you profiled this? I wonder if we should replace the above with
	
	if (atomic_read(&stats_flush_ongoing) || atomic_xchg(&stats_flush_ongoing, 1))

to not always dirty the cacheline. This would not be an issue if there
is no cacheline sharing but I suspect percpu stats_updates is sharing
the cacheline with it and may cause false sharing with the parallel stat
updaters (updaters only need to read the base percpu pointer).

Other than that the patch looks good.
