Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A119C64AA1B
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 23:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233032AbiLLWTa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Dec 2022 17:19:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbiLLWTO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 17:19:14 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2014DED2
        for <bpf@vger.kernel.org>; Mon, 12 Dec 2022 14:19:12 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id o1-20020a17090a678100b00219cf69e5f0so1459253pjj.2
        for <bpf@vger.kernel.org>; Mon, 12 Dec 2022 14:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zisc8FQAJzDFm4trJFIzgD9QQfRGpDr3HkVwJ+oTsJM=;
        b=j6fkBaTj8AwshXaywWh1a9KWsPOjHp8CRFCVBQ6q3Zz32esLihQfmQhrCt2cTWA43y
         teSFLYYg644Fq35Bjb8RgBsV8SXZOx81jacbSLLbmoJVYcXx5SL974sk/HmkhaYnPGXQ
         fG5Qm5yLPWwjqj3QWYg59p5uuDeubfTeBwvALcy2i1l2Ba9Gr0zgtDH3T7UksXDTZ6ds
         8VS25Kgcnn4KU0Ztb3ck/srxcTPvK6/oHYTPk4LaG7yGvkxOgzMhrlmAoMJ/vQ0KnYwR
         BmTzs1zoHJMh7bAl+ji7JxV/VHTH2CkADFdUxr725pXZQcZMrETt9IFJdMixp8829TWf
         1NXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zisc8FQAJzDFm4trJFIzgD9QQfRGpDr3HkVwJ+oTsJM=;
        b=FPl5tfL7lR79qOuq8ouQIzTQkqMz+6N5tyGfstDkLEonxYFppaHWZsx3Dv166dMnTh
         4y6WLDwFgb3CEyjEUOMajKvPn4wESs4rL4oc+u35vTvUJCQM9IK+uK09qcBy6sn6nf2a
         oXznia0RI4UdR0SAERHcX/gyrfplUiq9bmEbAyI8xIhLycHICcIdA7XWPCv6DJ+ZJ+jO
         N9op4qX8MkSCL3+zZ8hHHC4sA+TilBouRLqA7WqU1IJdxhlpWmlo9OzaPmPfRdOalKmQ
         6P5UgcrhietB/jLO9zpryj4rWHSomUHyO6I9aahz0D8WyPz0sy7eqVGbVKDfpgD/ydhD
         2Twg==
X-Gm-Message-State: ANoB5pmm2YINkpDBnx4puYutkPBlxwrlOdclQwppmsk8zRHbNQeBW/aD
        41/ELWrxq8vvcO5v5FXz65iQMjgRK8AgMsN9Z5cAfg==
X-Google-Smtp-Source: AA0mqf7xU30UgM7K9HH3CgKT5DUoABhrQKkZDM5aW633/AexSv9WURbogF6S7bzIJAeyMsFUa8dQayscJW9nPAPGJzQ=
X-Received: by 2002:a17:90a:4ecf:b0:219:c638:b718 with SMTP id
 v15-20020a17090a4ecf00b00219c638b718mr51539pjl.143.1670883551932; Mon, 12 Dec
 2022 14:19:11 -0800 (PST)
MIME-Version: 1.0
References: <20221130082313.3241517-1-tj@kernel.org> <20221130082313.3241517-32-tj@kernel.org>
 <Y5c0qEuyn8cAvLGQ@hirez.programming.kicks-ass.net>
In-Reply-To: <Y5c0qEuyn8cAvLGQ@hirez.programming.kicks-ass.net>
From:   Josh Don <joshdon@google.com>
Date:   Mon, 12 Dec 2022 14:18:59 -0800
Message-ID: <CABk29Nu5WiCmhNN2jZrTShELbCDOYUziUeW5xojkwB83R+VzEQ@mail.gmail.com>
Subject: Re: [PATCH 31/31] sched_ext: Add a rust userspace hybrid example scheduler
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
        kernel-team@meta.com, Peter Oskolkov <posk@google.com>
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

Hey Peter,

On Mon, Dec 12, 2022 at 6:03 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Nov 29, 2022 at 10:23:13PM -1000, Tejun Heo wrote:
> > From: Dan Schatzberg <dschatzberg@meta.com>
> >
> > Atropos is a multi-domain BPF / userspace hybrid scheduler where the BPF
> > part does simple round robin in each domain and the userspace part
> > calculates the load factor of each domain and tells the BPF part how to load
> > balance the domains.
> >
> > This scheduler demonstrates dividing scheduling logic between BPF and
> > userspace and using rust to build the userspace part.
>
> And here I am, speaking neither Rust nor BPF.
>
> But really, having seen some of this I long for the UMCG patches -- that
> at least was somewhat sane and trivially composes, unlike all this
> madness.

I wasn't sure if you were focusing specifically on how the BPF portion
is implemented, or on UMCG vs sched_ext. For the latter, and ignoring
the specifics of this example, the UMCG and sched_ext work are
complementary, but not mutually exclusive. UMCG is about driving
cooperative scheduling within a particular application. UMCG does not
have control over or react to external preemption, nor does it make
thread placement decisions. sched_ext is considering things more at
the system level: arbitrating fairness and preemption between
processes, deciding when and where threads run, etc., and also being
able to take application-specific hints if desired.
