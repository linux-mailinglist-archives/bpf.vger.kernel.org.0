Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1016F0026
	for <lists+bpf@lfdr.de>; Thu, 27 Apr 2023 06:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241612AbjD0EYH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 00:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjD0EYG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 00:24:06 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE3530D5;
        Wed, 26 Apr 2023 21:24:05 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-24782fdb652so5750054a91.3;
        Wed, 26 Apr 2023 21:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682569445; x=1685161445;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AAfXpVN1vvP0JAaL+YVD/WgEKMkC9tN4ILEhT+qlC2E=;
        b=bLfuKLbCIy1GiU7g9d5C2TrnyzH8qda1SrI5/EhP6zFc5U85TA3N0A3ES+IClG7W+3
         GfwnvluqutyO3McnrWNnWiUtA2XlDGPHUbUGP3WgKeoMA/CLhd3GyXKqR6Lv9UydBTiz
         Eccn5+kETzzKjIWHyzBnrh1GhZu86W/duxwQo001FTRozFwyeZvoBSi39iPVWgr+NHBv
         1nSzT1Ll8Qz9Czf73u0WdsNG1n3Y8ADI/qxMLwA8vb08h93n1MUl6RBDJTo2VAvTPPkm
         XPKRWODT8YaooAa8p62yztwTYgjNrYZebRj1hLi3C3V83mrrJ7SFOR6YiKZedgFPLYGd
         KhOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682569445; x=1685161445;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AAfXpVN1vvP0JAaL+YVD/WgEKMkC9tN4ILEhT+qlC2E=;
        b=T1xwaL+Wn/Pr8rFVy3l1vh5+u12kfEES1yzI54Ukrne95hWfZYSVvo/fFZIf6uUCyw
         2ZfA62YmNBJskdgMlA8s3/WuJzUOCq3FtxNJ0Bi1gG9cyEuGPh+k2/BE8/jQNzAiHpBt
         Zk90fC8fF+dagxQ6imthL93tmdjXbAV7ZEeQGfjEEwQmS45joyAUe8kZ/cBaG6pOnHEB
         nl8R2k30kLe3rJUZfQbrtLYnyfH5jTIE5gmbjtybFFomZkEjrO5HMDt5kMl/tSP6gTdM
         0IVnR1SmdvK6ZdBck+mm9pI5gUORUGRuJelmkyyrPGy9Ot3T1sxYdMAJlXtG6Zk5d5IC
         iE8A==
X-Gm-Message-State: AC+VfDzRuG2FxHqFpPnF0t59Dfb3VSkPH9El2lLsQ79eCU+Z1mGButvH
        /bTgQDDMovlVGwbi2hU7LtU=
X-Google-Smtp-Source: ACHHUZ4W8MAh0Z9vzHG0EmiM2FREKJ87X1fwXUDjLkCzMSKviLhJ1qQhXVniHfgZJFriO+6m5CdnDg==
X-Received: by 2002:a17:90a:bb0f:b0:249:842d:312f with SMTP id u15-20020a17090abb0f00b00249842d312fmr622099pjr.4.1682569444885;
        Wed, 26 Apr 2023 21:24:04 -0700 (PDT)
Received: from dhcp-172-26-102-232.dhcp.thefacebook.com ([2620:10d:c090:400::5:3ca5])
        by smtp.gmail.com with ESMTPSA id np9-20020a17090b4c4900b002367325203fsm12262311pjb.50.2023.04.26.21.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 21:24:04 -0700 (PDT)
Date:   Wed, 26 Apr 2023 21:24:01 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        houtao1@huawei.com
Subject: Re: [RFC bpf-next v2 4/4] bpf: Introduce BPF_MA_REUSE_AFTER_RCU_GP
Message-ID: <20230427042401.iavewtqx2x3yjepq@dhcp-172-26-102-232.dhcp.thefacebook.com>
References: <20230408141846.1878768-1-houtao@huaweicloud.com>
 <20230408141846.1878768-5-houtao@huaweicloud.com>
 <20230422031213.ubhzng67qf7axt7x@dhcp-172-26-102-232.dhcp.thefacebook.com>
 <d8608bed-57de-ae92-f8c2-45df998123e5@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8608bed-57de-ae92-f8c2-45df998123e5@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Apr 23, 2023 at 03:41:05PM +0800, Hou Tao wrote:
> >>
> >> (3) reuse-after-rcu-gp bpf memory allocator
> > that's the one you're implementing below, right?
> Right.
> >
> >> | name                | loop (k/s) | average memory (MiB) | peak memory (MiB) |
> >> | --                  | --         | --                   | --                |
> >> | no_op               | 1276       | 0.96                 | 1.00              |
> >> | overwrite           | 15.66      | 25.00                | 33.07             |
> >> | batch_add_batch_del | 10.32      | 18.84                | 22.64             |
> >> | add_del_on_diff_cpu | 13.00      | 550.50               | 748.74            |
> >>
> >> (4) free-after-rcu-gp bpf memory allocator (free directly through call_rcu)
> > What do you mean? htab uses bpf_ma, but does call_rcu before doing bpf_mem_free ?
> No, there is no call_rcu() before bpf_mem_free(). bpf_mem_free() in
> free-after-rcu-gp flavor will do call_rcu() in batch to free these elements back
> to slab subsystem directly. The elements in this flavor of bpf_ma is not safe
> for access from sleepable program except bpf_rcu_read_{lock,unlock}() are used.
> 
> But I think using call_rcu() to call bpf_mem_free() is good candidate for
> comparison and I saw bpf_cpumask does that, so I modify bpf hash table to do the
> similar thing and paste the benchmark result. As we can seen from the result,
> the memory usage for such flavor is much bigger than reuse-after-rcu-gp and
> free-after-rcu-gp:

I don't follow what exactly you're doing and what you're measuring.
Please provide patches for both reuse-after-rcu-gp and free-after-rcu-gp to
have meaningful conversation.
Rigth now we're stuck at what bench tool is actually measuring.

> >> +		if (try_queue_work && !work_pending(&c->reuse_work)) {
> >> +			/* Use reuse_cb_in_progress to indicate there is
> >> +			 * inflight reuse kworker or reuse RCU callback.
> >> +			 */
> >> +			atomic_inc(&c->reuse_cb_in_progress);
> >> +			/* Already queued */
> >> +			if (!queue_work(bpf_ma_wq, &c->reuse_work))
> > how many kthreads are spawned by wq in the peak?
> I think it depends on the number of bpf_ma. Because bpf_ma_wq is per-CPU
> workqueue, so for each bpf_ma, there is at most one worker for each CPU. And now
> the limit for the number of active workers on each CPU is 256, but it is
> customizable through alloc_workqueue() API.

Which means that on 8 cpu system there will be 8 * 256 kthreads ?
That's a lot. Please provide num_of_all_threads before/after/at_peak during bench.

Pls trim your replies. Mailers like mutt have a hard time navigating.
