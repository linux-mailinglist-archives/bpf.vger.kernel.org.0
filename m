Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD4E64A664
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 19:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbiLLSAB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Dec 2022 13:00:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiLLSAA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 13:00:00 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B467117F;
        Mon, 12 Dec 2022 09:59:59 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id 17so5430187pll.0;
        Mon, 12 Dec 2022 09:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=24rOvFknhlRu6gQO8oxJrJr21V/VC9EdwDQ4AnkVwBM=;
        b=pkS/8Bu0i9UuotMZgHuyLeKd8Th87c3Mw9wDu4iL8isyPURINKMymGy/YH85mfizKg
         RXxWpQ2TszOjM+cnzzrVF65mNs60DxOGjbWknSLcD4p9bINYfK9CKHqBd+ZyYXN5nG53
         PzSk7NCHvgwtlxM62KpZR+b63LP3Ntxm6UykA+p1E3slWkm7VkzfWvrWlikx+ItL/BTw
         JTUTEaEPgittaoh9CpeHmU/OAlGv9+6GgZzA0ytyp3KubuONTQmLP8LqnmU7IOqgfktq
         l7Tz5FM01LpIc0R+cwcv97Qc0lLq5tMxmh9ebRBPZQccGzZrD/2j60D0cLCW+gwzrDpX
         YgIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=24rOvFknhlRu6gQO8oxJrJr21V/VC9EdwDQ4AnkVwBM=;
        b=RpE4RpcN9A75kDaPP3d5FtbgX3PxWI04BYVTvee5sy/agnWjO2ew/QOEc0yvopztoB
         Q+1LBblobSNlKsz337riqauw1ZPZEZ/ttUemSvZqPdwvmkmmEA8TU07GthSW5kwXufuI
         MKyTpI2zFO+FfgyN5W1BXhNmty0a4qxfq/Pu7wVz6BbYzskl7BLX9jd0gvYMoj1Xr1N9
         IYfdcFnVYfVSVr5EcMB6PwHiZJwUk4BPkvUKZA2Qgdly6VR5ltqnpidGHPFoZ4e5JGGr
         m9F2tHAgwshIWRePm4zw6GA/p3sAbbhs7OUEl2iPDymJUukVV5KaNYkWYO9w82zIwW8v
         nbAw==
X-Gm-Message-State: ANoB5pnfiUn8MiikMpaqeCay0p9mOqYrHWKACNIpKOT2cLeHROEr9Tvq
        mRiiJNCNOQ1wsHgCWvk5XQw=
X-Google-Smtp-Source: AA0mqf46c2PPn8MT3BCKXZKlchoYDM9q5e/HzNPpBH9stvA4CNitWVCNYG0Y4gXm/GyQbsLKz4jxWA==
X-Received: by 2002:a17:902:bc83:b0:185:441e:2240 with SMTP id bb3-20020a170902bc8300b00185441e2240mr16169984plb.59.1670867998874;
        Mon, 12 Dec 2022 09:59:58 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:9159])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902e9c600b0018725c2fc46sm6640646plk.303.2022.12.12.09.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 09:59:58 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 12 Dec 2022 07:59:56 -1000
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
Subject: Re: [PATCH 06/31] sched: Add sched_class->switching_to() and expose
 check_class_changing/changed()
Message-ID: <Y5dsHKJlVmTfedFb@slm.duckdns.org>
References: <20221130082313.3241517-1-tj@kernel.org>
 <20221130082313.3241517-7-tj@kernel.org>
 <Y5cQXTDhfvk2LIWU@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5cQXTDhfvk2LIWU@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 12, 2022 at 12:28:29PM +0100, Peter Zijlstra wrote:
> On Tue, Nov 29, 2022 at 10:22:48PM -1000, Tejun Heo wrote:
> > When a task switches to a new sched_class, the prev and new classes are
> > notified through ->switched_from() and ->switched_to(), respectively, after
> > the switching is done. However, a new sched_class needs to prepare the task
> > state before it is enqueued on the new class for the first time.
> 
> How and why isn't sched_fork() sufficient?

sched_ext has callbacks which allow the BPF scheduler to keep track of
relevant task states (like priority and cpumask). Those callbacks aren't
called while a task isn't on sched_ext. When a task comes back to SCX, we
wanna tell the BPF scheduler the up-to-date state before the task gets
enqueued, so the need for a hook which is called before the switching is
committed.

Thanks.

-- 
tejun
