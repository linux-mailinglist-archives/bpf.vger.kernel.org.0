Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036216497EB
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 03:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbiLLCTD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 11 Dec 2022 21:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbiLLCRM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 11 Dec 2022 21:17:12 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8874E028;
        Sun, 11 Dec 2022 18:16:01 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d15so993973pls.6;
        Sun, 11 Dec 2022 18:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jAKAUWj36dYtyzUMLUez/vupRra0SMgKco51r7USvlA=;
        b=f3CotKsR5Vj3EPyn6fNaI9SpNCkkIxLE07NV2LJ9S7h1zVc8z4QlcYy7BIH1bpKESp
         yU7tZQTel+aQ4jx1zznjt7OdVSC6/76hXuwwUA+wswJO21uLP9vZ7KtYOpbCqoV8Uhi7
         f6P5r21KVTJZ/PuZP+OkXW+jv23xV3zhAtIGdo35gCi2naqRez8Fj/SfB9J+iKCgns5W
         IwTcf+vswVrMtyTpVgsCdSOOc5nLsvsMeIafoaXcd7/s2gDc9pZSDIHwPaPaMToYD3kb
         jOc03lRnZMIIOfRJjt0M88ZrUAwUdJsOlPXe246WbwPJHYoSR2bk5rsKYcc9FXdXE96O
         51yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jAKAUWj36dYtyzUMLUez/vupRra0SMgKco51r7USvlA=;
        b=I/5Tq7JAdomyW8/2N7GH4U1hcBlm2PeojxpUjHhO/aife6/nV5lAJNrMjOqTyj7ngJ
         I8R7sz0wNSx5x4zkWZj89eOxeLRAdyZiEASdQ3bCrU3+iebJsLL94A0tec8X8fq8fKZR
         U7iWHgMjiEogne+hO/c/0euHeWOhN5TPoaRMJwFW+92zEr8hMp5IfXklvimzWMMmOVOp
         3nUC69T+DR4I4N/xHXudYMhV6l24N2HjiiSaheSHbtSp5AQnPtbfw11QyeTY9FcRq7kJ
         btjwXw9EDUG1o7j+h31vbt+ZtinjkcXVud73AoMkq6fEbM+aHHObbKrSVMnMpylSBrze
         AdvA==
X-Gm-Message-State: ANoB5plARGH8/4PhJPZdKSC5+SKdek4Il942UyXVBLwzd1UvqOLtE2Ur
        X+I8e8WDZpghRjfVLBECxTQ=
X-Google-Smtp-Source: AA0mqf5KlA/xmF39o6XENkP+o5OqLxh1LQX3i6P5gCXdJzJmHGorMYNDvNVlTUjOvIy4T0SOuwGZ0w==
X-Received: by 2002:a17:90a:e409:b0:219:1a4e:349d with SMTP id hv9-20020a17090ae40900b002191a4e349dmr16368256pjb.44.1670811361024;
        Sun, 11 Dec 2022 18:16:01 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:53a9])
        by smtp.gmail.com with ESMTPSA id pl6-20020a17090b268600b00213c7cf21c0sm4266238pjb.5.2022.12.11.18.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Dec 2022 18:16:00 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Sun, 11 Dec 2022 16:15:59 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     torvalds@linux-foundation.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        joshdon@google.com, brho@google.com, pjt@google.com,
        derkling@google.com, haoluo@google.com, dvernet@meta.com,
        dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@meta.com
Subject: Re: [PATCH 14/31] sched_ext: Implement BPF extensible scheduler class
Message-ID: <Y5aO3y23uoQFCazr@slm.duckdns.org>
References: <20221130082313.3241517-1-tj@kernel.org>
 <20221130082313.3241517-15-tj@kernel.org>
 <alpine.DEB.2.22.394.2212112331150.29296@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2212112331150.29296@hadrien>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello, Julia.

On Sun, Dec 11, 2022 at 11:33:50PM +0100, Julia Lawall wrote:
> > diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> > new file mode 100644
> > index 000000000000..f42464d66de4
> > --- /dev/null
> > +++ b/kernel/sched/ext.c
> > @@ -0,0 +1,2780 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (c) 2022 Meta Platforms, Inc. and affiliates.
> > + * Copyright (c) 2022 Tejun Heo <tj@kernel.org>
> > + * Copyright (c) 2022 David Vernet <dvernet@meta.com>
> > + */
> > +#define SCX_OP_IDX(op)		(offsetof(struct sched_ext_ops, op) / sizeof(void (*)(void)))
> > +
> > +enum scx_internal_consts {
> > +	SCX_NR_ONLINE_OPS	 = SCX_OP_IDX(init),
> > +	SCX_DSP_DFL_MAX_BATCH	 = 32,
> 
> This definition of SCX_DSP_DFL_MAX_BATCH makes the dispatch queue have size
> 32.  The example central policy thus aborts if more than 32 tasks are woken
> up at once.

Yeah, scx_exampl_central needs to either set ops.dispatch_max_batch higher
according to number of CPUs or flush and exit the loop and retry when
scx_bpf_dispatch_nr_slots() reaches zero. Will update.

Thanks.

-- 
tejun
