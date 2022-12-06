Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 567A6644E1E
	for <lists+bpf@lfdr.de>; Tue,  6 Dec 2022 22:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbiLFVmc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 16:42:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiLFVmb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 16:42:31 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6333E48761;
        Tue,  6 Dec 2022 13:42:30 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id w23so15223774ply.12;
        Tue, 06 Dec 2022 13:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CjJnMDyt/NNp+Ep12ubSTLl5hV1ShtEgJ1DJNEKSYuI=;
        b=RMNnhQfUcUNpgEo82iPLWj7vrC0aDD0MjKOfj9jlvUlGQUaaOAZ6xXcyJ3Kv50bFJm
         YSknEoJh7BNPJ5ti/NGZDQa+2HqwE1QPw68hCMaIIL2WG37/mDgj+Ezv9vBnjyob4HhX
         t/5xVnoYmlAMNGc6qXAyBQZA8hCpxrBGhIaYxjWpj2IGRpPsNNq/7/wV+ymZQEQgQ7LS
         sRGc6CLzPTK9rK+8hsicPVolWrpUdQnA07lDdS9B9Kr7aH/rLloZf4SM2cCPO1E46tq/
         /bKzbLmd+Hwy6qbohxBIbvzbAQEEhaUcQkQMxwDcwUh14SNwjLQFJQ0s/JutIi2SCff8
         u2Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CjJnMDyt/NNp+Ep12ubSTLl5hV1ShtEgJ1DJNEKSYuI=;
        b=iwYvLvRIkWAandsGExtaN2mTUKsOwjgiX/hQtyE4Q5v1/F44QlQZ1csNLGhq5T2hK6
         vtc1dIQlqFpdV2/wNeUwSrIZXH4ZSQYDc5faXENr31IDcuZzvaGsy/ppsv+XsxxqtSg7
         rApxrMQ5oAGDJtFkFOnivUuVuiZmidwOiUAR98nDH2Vh6mqOiyoMirti7YSk4tzWF7GL
         iAbpaEHJuz+YWbEgOed+ghohwmmGYcFSChYTnLL1shNC5tpLKvyXwEwqy0QAen3JCYe4
         zDCNo8R3m+I3CbJHncy7JXOdeaAUrhYbjDUhqvmOz0WD0tx+LhN674SAeFQkhPuqEQgt
         8p7g==
X-Gm-Message-State: ANoB5pngv8sC257au8CLSECL4kvsKQIR0gd3M6r3J+sfQEzWBWM2qG2U
        7QUAF2HSQ5uD1AXc5avDIA8=
X-Google-Smtp-Source: AA0mqf6YblcoDIEHEcWbGxV56wWXrOBhqjA+DBm4Qygg6pgXR/A8xoeDoVq2ot7AE0t3YnGAePbxag==
X-Received: by 2002:a17:90b:35cb:b0:213:22d:b2e2 with SMTP id nb11-20020a17090b35cb00b00213022db2e2mr40628251pjb.148.1670362949601;
        Tue, 06 Dec 2022 13:42:29 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:841a])
        by smtp.gmail.com with ESMTPSA id s24-20020a17090ad49800b00210125b789dsm11272853pju.54.2022.12.06.13.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 13:42:29 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 6 Dec 2022 11:42:27 -1000
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
Message-ID: <Y4+3Q2FnG1bsGH55@slm.duckdns.org>
References: <20221130082313.3241517-1-tj@kernel.org>
 <20221130082313.3241517-15-tj@kernel.org>
 <8d146099-a12a-c5a1-4829-dec95497fdca@google.com>
 <Y4o9gV2v8eyI1arK@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4o9gV2v8eyI1arK@slm.duckdns.org>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello, Barret.

On Fri, Dec 02, 2022 at 08:01:37AM -1000, Tejun Heo wrote:
> > you still end up grabbing both locks, but just not at the same time.
> 
> Yeah, this probably would look better than the current double lock dancing,
> especially in the finish_dispatch() path.
>
> > plus, task_rq_lock() takes the guesswork out of whether you're getting p's
> > rq lock or not.  it looks like you're using the holding_cpu to handle the
> > race where p moves cpus after you read task_rq(p) but before you lock that
> > task_rq.  maybe you can drop the whole concept of the holding_cpu?
> 
> ->holding_cpu is there to basically detect intervening dequeues, so if we
> lock them out with TASK_ON_RQ_MIGRATING, we might be able to drop it. I need
> to look into it more tho. Things get pretty subtle around there, so I could
> easily be missing something. I'll try this and let you know how it goes.

I tried both and I'm pretty ambivalent. The problem is that the
finish_dispatch() path can't use TASK_ON_RQ_MIGRATING the way the consume
path does because the dispatch path isn't starting with the task locked. The
only claim it has to the task is through p->scx.ops_state.

It can be argued that getting rid of double locking is still nice but given
that holding_cpu is needed anyway and can play the same role, I'm not sure
how attractive it is. I suppose we can go either way.

Thanks.

-- 
tejun
