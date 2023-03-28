Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6566CC9A0
	for <lists+bpf@lfdr.de>; Tue, 28 Mar 2023 19:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjC1RtI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Mar 2023 13:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbjC1RtH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Mar 2023 13:49:07 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B99CE07C
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 10:49:05 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id eg48so52909710edb.13
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 10:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112; t=1680025744;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AqbE7OnUHsZ2+LRH4fu/PmF89EsJRI5zjHe+XmQVCDs=;
        b=AcESMi6Tg2n/wTojpHFGYu2mc0254BMahR7WXFU2zVr1NcQ+s53BTljFpeIkztOPZD
         0aHsoJ3G5s4OycOCAjAOMGekHiqgs0q7mySZxqSKuAcwdT7mTALbB9ifAfB9AIpBTQxZ
         77SxzXW8rSToW0hJofZQ49zOI3KVuRDag5eKqxw/f9AQ2AyaATGPm/ubHWEm4d3LnrDu
         fmDW6ShKYODDJ9EAe7FHBCkCMZ6PLv4Mtdar6MuRkkvF2TJWSME4HUKVL3vitSqOkEGg
         Xi9dKsgKvexVMivDuoNUUzIf/XqWuhItchnt1+Aw4oTYjjFOsgTI7bUhs1PnVw6AykQW
         emjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680025744;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AqbE7OnUHsZ2+LRH4fu/PmF89EsJRI5zjHe+XmQVCDs=;
        b=2XK23gxrbEHNz9x2e2lJSJzIDmJwM1dVLRV6B7kgJBBlq89Ehqp20c3IQDZ1KubEWQ
         3XiZpwbCrZKz57+p5qgbWV+rLoGjak5XPtcLkC+XXV6WEa2lvn5jSbGXY179+T2fFsbx
         NknwVyRzTbqfcYPvkQTreSM+3mwvvdyF53RCVtVfU4BDiMZT7EgAm3iXFcnjEdUmLvSd
         qtrNGgzJKI8YVVzdsXiSCHxUZBpXXRadww9e7sebvn2z6T1Hlv25JxAgktgUY653vcXN
         V6VWj1ERu1A/auLi8XvH4o0OYxP5KJ6ZjqosuGByBHWe8q5GbDfrB6QBOHJh9mNlu2AR
         YfHQ==
X-Gm-Message-State: AAQBX9fb3JxkyyLEkyJBficYgeM1Lsx83mnjrFgLnMLT5bNziyqDLa17
        W0SnkQJXw/IgovlrZl+3zNyY9Q==
X-Google-Smtp-Source: AKy350bAUU2oFiMTm5phz6lxAVuPkhaTa/v8Z1SDfrPzx5L1ctMYrdc6nb8Raqgi36OVzrqh8Pkl1A==
X-Received: by 2002:a17:907:76f8:b0:939:c395:1b3 with SMTP id kg24-20020a17090776f800b00939c39501b3mr17143261ejc.31.1680025744032;
        Tue, 28 Mar 2023 10:49:04 -0700 (PDT)
Received: from localhost ([2a02:8070:6387:ab20:5139:4abd:1194:8f0e])
        by smtp.gmail.com with ESMTPSA id zc14-20020a170906988e00b00927f6c799e6sm15588135ejb.132.2023.03.28.10.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 10:49:03 -0700 (PDT)
Date:   Tue, 28 Mar 2023 13:49:02 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH v1 4/9] cgroup: rstat: add WARN_ON_ONCE() if flushing
 outside task context
Message-ID: <ZCMojk50vjiK6mBe@cmpxchg.org>
References: <20230328061638.203420-1-yosryahmed@google.com>
 <20230328061638.203420-5-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328061638.203420-5-yosryahmed@google.com>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 28, 2023 at 06:16:33AM +0000, Yosry Ahmed wrote:
> rstat flushing is too expensive to perform in irq context.
> The previous patch removed the only context that may invoke an rstat
> flush from irq context, add a WARN_ON_ONCE() to detect future
> violations, or those that we are not aware of.
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> ---
>  kernel/cgroup/rstat.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
> index d3252b0416b6..c2571939139f 100644
> --- a/kernel/cgroup/rstat.c
> +++ b/kernel/cgroup/rstat.c
> @@ -176,6 +176,8 @@ static void cgroup_rstat_flush_locked(struct cgroup *cgrp, bool may_sleep)
>  {
>  	int cpu;
>  
> +	/* rstat flushing is too expensive for irq context */
> +	WARN_ON_ONCE(!in_task());
>  	lockdep_assert_held(&cgroup_rstat_lock);

This seems a bit arbitrary. Why is an irq caller forbidden, but an
irq-disabled, non-preemptible section caller is allowed? The latency
impact on the system would be the same, right?
