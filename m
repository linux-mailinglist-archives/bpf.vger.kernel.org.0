Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD28564C22A
	for <lists+bpf@lfdr.de>; Wed, 14 Dec 2022 03:12:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237065AbiLNCLz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Dec 2022 21:11:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237055AbiLNCLx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Dec 2022 21:11:53 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37080220FE
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 18:11:53 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id 124so3536718pfy.0
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 18:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WTwRd3Vfb9mMXt87QjpBobPhpTfI8kJpvB+zz9Ggrdc=;
        b=COu9NWhJ67WsyFRU2hjs5TqHYciSwbilz5g7t1Z+ZLdU2tlsLG8/wjdXSjlL+xh4fL
         TMm52Td++Ur6X1U2aN7usUppUTFmj3gzAQIpRFzSLODmnigY1ZPgzor5QmG5FrWUfI54
         F3DAd5oL4fsfSNODiB25I3LjQg/mw2oEPzUhCAfAozrLNRmQafMQhx385Oay4gv0pf4B
         Gr1g3okj9Y/xtJVmjj8iRQbdOSolvN5H+gTJnSNZdK5+NKV1TEY2WtkmB1rt0dUdiK2b
         4BwHfVRf2ndDKZkJYOuKeh6AcvgF0PRADrcIpTuCbpwSeyYvi8eLB0JcP8Y+ZCG2Vw63
         28Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WTwRd3Vfb9mMXt87QjpBobPhpTfI8kJpvB+zz9Ggrdc=;
        b=BxAivjYKYztOZIhluJxCtOvZR+Wg93uxZ2STWmc9okIdXcQzc7Qy2ajhzi1gVyOqsp
         WOA9lWwb5aGOXk5PjzFwuuaGcDHWm3AuAjObS4/QrYdL3ggyKDanLM3fgRMzxFDUawZ9
         NC6Ksjm+TZVPm6eDUer1InbsOjw8nWO2UlqQ/c1tWMn1sOxQ7MRiBrL2rMwUb6QBrgR0
         Icpl/fVvGvwPbGl1D96fJbIcGR96vjQh9dqdaYqCq6ywyzbRihGR7pJqVSJZ4DuhwzAq
         4PAaA0Kp20EiEvqpYCZX483Hw8AU2szXUrJmGNl48JL6+MExTVZfIoUcqHxYOh+nrPhk
         2ULw==
X-Gm-Message-State: ANoB5pkwFpcp3GH8Fx6spNcjWRxums5O3Ph8dF68QtuEAnoIEyY5hEg8
        pHYoccgtl9pLm2hp3Nz6LNcnd5dVAb0sjSNKaLbRrA==
X-Google-Smtp-Source: AA0mqf5/xweGeEjmBl4DOm2Y/blYrG1UU2cHlX0uIDmT/udC/44xAdbkJ28KzqoV1xcoXbVUpAT8ISGiwe7fi55T27g=
X-Received: by 2002:a63:1247:0:b0:476:ed2a:6216 with SMTP id
 7-20020a631247000000b00476ed2a6216mr77729739pgs.556.1670983911856; Tue, 13
 Dec 2022 18:11:51 -0800 (PST)
MIME-Version: 1.0
References: <20221130082313.3241517-1-tj@kernel.org> <Y5b++AttvjzyTTJV@hirez.programming.kicks-ass.net>
In-Reply-To: <Y5b++AttvjzyTTJV@hirez.programming.kicks-ass.net>
From:   Josh Don <joshdon@google.com>
Date:   Tue, 13 Dec 2022 18:11:38 -0800
Message-ID: <CABk29Ntf1ZMAmvkVTzj6=HjanHgn6Qu3-J8gHHyMM30yiHM3_w@mail.gmail.com>
Subject: Re: [PATCHSET RFC] sched: Implement BPF extensible scheduler class
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Tejun Heo <tj@kernel.org>, torvalds@linux-foundation.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        brho@google.com, pjt@google.com, derkling@google.com,
        haoluo@google.com, dvernet@meta.com, dschatzberg@meta.com,
        dskarlat@cs.cmu.edu, riel@surriel.com,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 12, 2022 at 2:14 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Nov 29, 2022 at 10:22:42PM -1000, Tejun Heo wrote:
>
> > Rolling out kernel upgrades is a slow and iterative process. At a large scale
> > it can take months to roll a new kernel out to a fleet of servers. While this
> > latency is expected and inevitable for normal kernel upgrades, it can become
> > highly problematic when kernel changes are required to fix bugs. Livepatch [9]
> > is available to quickly roll out critical security fixes to large fleets, but
> > the scope of changes that can be applied with livepatching is fairly limited,
> > and would likely not be usable for patching scheduling policies. With
> > sched_ext, new scheduling policies can be rapidly rolled out to production
> > environments.
>
> I don't think we can or should use this argument to push BPF into ever
> more places.

Improving scheduling performance requires rapid iteration to explore
new policies and tune parameters, especially as hardware becomes more
heterogeneous, and applications become more complex. Waiting months
between evaluating scheduler policy changes is simply not scalable,
but this is the reality with large fleets that require time for
testing, qualification, and progressive rollout. The security angle
should be clear from how involved it was to integrate core scheduling,
for example.
