Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 635F764C066
	for <lists+bpf@lfdr.de>; Wed, 14 Dec 2022 00:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236985AbiLMXVM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Dec 2022 18:21:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236039AbiLMXVK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Dec 2022 18:21:10 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DD4AE5A
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 15:21:09 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id q17-20020a17090aa01100b002194cba32e9so5273743pjp.1
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 15:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K2MRfppyK0Vjy0SQr+LLnmvXYBM84uS+b5lx4JIkd8g=;
        b=bw8bgkvy4Ahs4b1YsvA9xPAebM3f20MVqewjGj0vJiUAwFVHxXTRbQGHfsSxZh7nKz
         bVXIKp5zcK1wTpLXKQQnsL0c+WKKDKFY6ndP21nV8EbtIOc/dydfbKN90sNezFI3qrAi
         zWBqtXduRXOYlG0bhovZoDNWuUNfEPSTXbvknEWegRAkySZDexuChNlrh+oAv0n6RJ7z
         rR66ALBLzbMIjWYmA8r5YH1Pi2blyqBe3oOD1Hs05pjG33KNDITO2V6nwlzhT9sHMseF
         EooMnVP0xTsr93zsQNd8okxf/8EDhxD1gaBHG+lOXYe+Xs2ssSUiiYJvFAOYw6L5dXYN
         EbjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K2MRfppyK0Vjy0SQr+LLnmvXYBM84uS+b5lx4JIkd8g=;
        b=u8RR7aNb7yOexw4vyag5IjZqM3qSH8x/41Q39BPJbJmf9q905RazatgiuWsKc6256z
         av1hpK4tBs4DdcEKRAY48elRBNvcbQ0A6QbbXo6qbKICFlnJB6g0kGNx/MdR/JpZqssC
         784EddKCf4l5IfNXyxXW+kJINiDUuOC2/9KLjfemKPa8amMqHjHoyTOJpFHCHjQdyUDd
         DI2WJILnl+MTk7Zb9FpJu0OQjdG7aaZvV8yYWLq/cnjSf6tHDKx/HLthgAPPcb/pFTaG
         TH77kYer+GmbIS3nyPTZ+TS6Osf6vHG+0q5PJwJtB7vKmjKhXraA6K5Rbb/qkWBIGOCG
         ay8w==
X-Gm-Message-State: ANoB5pljFG2u8+/KOWrOSREwYb9SempIB2si7O/z6UrgidFpaLKdwCyk
        EdWcS5R5RTmY9+UPWssOKfkPU+t0YAiDnYVPhLCwWg==
X-Google-Smtp-Source: AMrXdXt41EFmrI7Nfo9QvtuNC+CqQZCCdPo+VfWS8FAWz+3wppOM/qMwogyFaUdvE7M/P4veLMOoFd+E4xt7eaNgTP0=
X-Received: by 2002:a17:90a:1b86:b0:219:e176:7079 with SMTP id
 w6-20020a17090a1b8600b00219e1767079mr46073pjc.196.1670973669128; Tue, 13 Dec
 2022 15:21:09 -0800 (PST)
MIME-Version: 1.0
References: <20221130082313.3241517-1-tj@kernel.org> <20221130082313.3241517-15-tj@kernel.org>
 <Y5ckYyz14bxCvv40@hirez.programming.kicks-ass.net> <Y5eeGMpr/SuyGBQO@slm.duckdns.org>
 <Y5haDh3sYUFcXkBx@hirez.programming.kicks-ass.net> <Y5jAc/Gs4gVRzkDe@slm.duckdns.org>
 <52c9d084d9852cc7c769dbb76f03a13df014c37f.camel@surriel.com>
In-Reply-To: <52c9d084d9852cc7c769dbb76f03a13df014c37f.camel@surriel.com>
From:   Josh Don <joshdon@google.com>
Date:   Tue, 13 Dec 2022 15:20:57 -0800
Message-ID: <CABk29Nuyz4oT_pE9tFh8+q+ygPhnYBH3MMx7xgYOUcFUQ0qk3w@mail.gmail.com>
Subject: Re: [PATCH 14/31] sched_ext: Implement BPF extensible scheduler class
To:     Rik van Riel <riel@surriel.com>
Cc:     Tejun Heo <tj@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        torvalds@linux-foundation.org, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@kernel.org, brho@google.com, pjt@google.com,
        derkling@google.com, haoluo@google.com, dvernet@meta.com,
        dschatzberg@meta.com, dskarlat@cs.cmu.edu,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 13, 2022 at 10:40 AM Rik van Riel <riel@surriel.com> wrote:
>
> On Tue, 2022-12-13 at 08:12 -1000, Tejun Heo wrote:
> > Hello,
> >
> > On Tue, Dec 13, 2022 at 11:55:10AM +0100, Peter Zijlstra wrote:
> > > On Mon, Dec 12, 2022 at 11:33:12AM -1000, Tejun Heo wrote:
> > >
> > > > Here, the way it's handled is a bit different, SCX has
> > > > a watchdog mechanism implemented in "[PATCH 18/31] sched_ext:
> > > > Implement
> > > > runnable task stall watchdog", so if SCX tasks hang for whatever
> > > > reason
> > > > including being starved by CFS, it will get aborted and all tasks
> > > > will be
> > > > handed back to CFS. IOW, it's treated like any other BPF
> > > > scheduler errors
> > > > that can lead to stalls and recovered the same way.
> > >
> > > That all sounds quite terrible.. :/
> >
> > The main source of difference is that we can't implicitly trust the
> > BPF
> > scheduler and if it malfunctions or on user request, the system
> > should
> > always be recoverable, so there are some extra things which are
> > inherently
> > necessary to support that.
> >
> That makes me wonder whether loading an SCX policy
> should just have that policy take over all of the
> SCHED_OTHER tasks by default, and have a failure of
> the policy just return those tasks to CFS?
>
> Having the two be operative at the same time seems
> to be a cause of hard to resolve issues, while simply
> running all non-RT tasks under the loadable policy
> could simplify both internal kernel interfaces, as
> well as externally visible effects?

There are reasons to want to still have CFS available even when SCX is
loaded. For example, on a partitioned shared tenant machine, moving
one application to an SCX policy without needing to move everyone. Or,
wanting to avoid scheduling things like kthreads under an SCX policy,
since for example that makes an SCX policy writer need not only
consider the needs of application threads, but also those of kernel
threads.
