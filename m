Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 338AA640CC2
	for <lists+bpf@lfdr.de>; Fri,  2 Dec 2022 19:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234033AbiLBSBm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Dec 2022 13:01:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234152AbiLBSBl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Dec 2022 13:01:41 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72FCCE61CF;
        Fri,  2 Dec 2022 10:01:40 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id k2-20020a17090a4c8200b002187cce2f92so9008747pjh.2;
        Fri, 02 Dec 2022 10:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=unq15Boqc5fQcQaBlgiNBwM4n1cI6lL/XfwEmSxwwuQ=;
        b=SYBc4wuTywgBZjryabalnIcwN5pNfyFGYrJ48kdRRb82LZSmJN38+HcpMu/nuegPkB
         r3HwbRDHpCnzR+H3GPhNIcmZ51dVpodLL7adEX/SeBI9VBGLwnuyUh1ojbnJvK/OnCee
         yzPySqGihsvwMFr6W8CASyrwELoqST8mJMEjI/DhZR0zHpysh8DSM8HOArxTD/qA+2HZ
         eVZVmGkbjcGA3biw8dUUJkxLFoqCXh3RGubsx7UGAqqqAxp+oD2xewinbolh5Pogo6Sk
         wWEy1HVKvQ8F4t386WXj+C9VvG9PyHVCMGtIep9TpigTBMJCSNPE5DPjX25UKrkCG5yI
         mA0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=unq15Boqc5fQcQaBlgiNBwM4n1cI6lL/XfwEmSxwwuQ=;
        b=64/Q2DAOmIw804JwhHUHTpEFXcZf1ikFNic5vcqCF0JnIAwE9WGiWmCwo15ns+lCzQ
         8kQNwCJhEEWpbLCf7w7Y9BuA9pTmxmVZTRMCPmV9VYowR8h7iPNTN1ZUB4iZVgAfnL0R
         dIImUiTeJu+4oQgIWJV8w+ZX8twGMLXL+e03DuJ5erZzVm7gkAxdsrOkEQatZzXJpgL0
         gNF5IpXjer9Z6rgqOY96Extyn5BCSPzIc8bqVEC4or/1cJkj8j5txbOFu1KIXiQ0QYrI
         jUS76JHGeUEUbqAHy9LkbqZEgxTeeSBzeyZRf8FxdhdSM0WLhjwiU6wmW3nyv4xjghYf
         s/ig==
X-Gm-Message-State: ANoB5plbxrhFkhYFr1HWDZ+Ds1k4jIJSjG3D0qOaaPCC6weh9FuRKdHt
        ErhFkVwbNeWEHxAh2YRZnoo=
X-Google-Smtp-Source: AA0mqf6KTArSjxNx6RNy+FpOtO0BMt5uhy0fFQB1V1qK3d6ls63iE18vzLlUqkGZ0KgA5LuiVtiuUA==
X-Received: by 2002:a17:903:251:b0:189:78d9:fe3c with SMTP id j17-20020a170903025100b0018978d9fe3cmr32814026plh.101.1670004099551;
        Fri, 02 Dec 2022 10:01:39 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id k3-20020aa79723000000b0057409583c09sm5359383pfg.163.2022.12.02.10.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 10:01:39 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 2 Dec 2022 08:01:37 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Barret Rhoden <brho@google.com>
Cc:     torvalds@linux-foundation.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        joshdon@google.com, pjt@google.com, derkling@google.com,
        haoluo@google.com, dvernet@meta.com, dschatzberg@meta.com,
        dskarlat@cs.cmu.edu, riel@surriel.com,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@meta.com
Subject: Re: [PATCH 14/31] sched_ext: Implement BPF extensible scheduler class
Message-ID: <Y4o9gV2v8eyI1arK@slm.duckdns.org>
References: <20221130082313.3241517-1-tj@kernel.org>
 <20221130082313.3241517-15-tj@kernel.org>
 <8d146099-a12a-c5a1-4829-dec95497fdca@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d146099-a12a-c5a1-4829-dec95497fdca@google.com>
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

On Fri, Dec 02, 2022 at 12:08:27PM -0500, Barret Rhoden wrote:
> you might be able to avoid the double_lock_balance() by using
> move_queued_task(), which internally hands off the old rq lock and returns
> with the new rq lock.
> 
> the pattern for consume_dispatch_q() would be something like:
> 
> - kfunc from bpf, with this_rq lock held
> - notice p isn't on this_rq, goto remote_rq:
> - do sched_ext accounting, like the this_rq->dsq->nr--
> - unlock this_rq
> - p_rq = task_rq_lock(p)
> - double_check p->rq didn't change to this_rq during that unlock
> - new_rq = move_queued_task(p_rq, rf, p, new_cpu)
> - do sched_ext accounting like new_rq->dsq->nr++
> - unlock new_rq
> - relock the original this_rq
> - return to bpf
> 
> you still end up grabbing both locks, but just not at the same time.

Yeah, this probably would look better than the current double lock dancing,
especially in the finish_dispatch() path.

> plus, task_rq_lock() takes the guesswork out of whether you're getting p's
> rq lock or not.  it looks like you're using the holding_cpu to handle the
> race where p moves cpus after you read task_rq(p) but before you lock that
> task_rq.  maybe you can drop the whole concept of the holding_cpu?

->holding_cpu is there to basically detect intervening dequeues, so if we
lock them out with TASK_ON_RQ_MIGRATING, we might be able to drop it. I need
to look into it more tho. Things get pretty subtle around there, so I could
easily be missing something. I'll try this and let you know how it goes.

Thanks.

-- 
tejun
