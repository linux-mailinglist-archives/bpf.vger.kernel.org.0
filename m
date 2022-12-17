Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C3E64FAE1
	for <lists+bpf@lfdr.de>; Sat, 17 Dec 2022 16:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbiLQPyu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 17 Dec 2022 10:54:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbiLQPy3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 17 Dec 2022 10:54:29 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624C8897EC
        for <bpf@vger.kernel.org>; Sat, 17 Dec 2022 07:38:23 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id ay14-20020a05600c1e0e00b003cf6ab34b61so6025439wmb.2
        for <bpf@vger.kernel.org>; Sat, 17 Dec 2022 07:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=26nXor7sS/ZV2W2K2M+o17GQCMcdVjM6UrUiQscmnVU=;
        b=Rs1HqHY1tQf41efAqYD4NOp0Eu41MCO45RU+KlPjqLbDXr8btwPruYkuVxWKf5Npup
         /09FOGhQaqDVGLngrIYKpClEE1//siFdnIioFIrUzbi8ObRtcJm6beqv7fiNb2mQnN2g
         SQ8cHkkF6xPqD9k+q7bka0oT9H3bmBZ07pxhLLSUqLE2tmJ3El7LodjfTGlwsS7oOMN5
         xPHJ5raNDvaM5m75g4vvsV3rWo904B5Do8GZ29QynbGtVlDrmo7HSHU71XkbzUGFd7Pj
         D4JPsFQldaKfJsbzW3OPhd4SZ5SFbdboRlxN7/j3pLgWA8QnqdcaaIh7rHq5J6liuHWN
         MYXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=26nXor7sS/ZV2W2K2M+o17GQCMcdVjM6UrUiQscmnVU=;
        b=ib0Dzle8PD/LYkh7iHNukdJ1lJLP3fw33221Tj6KXqRmBO2TXrWwaZ+nCyT/J8PwmX
         Ni0w0EW24pbMvw+67JNwlZ1SkxshqP1+5TPz8b969UfnFtojdQ1zy/FQiKy3s3XU6OjI
         tSEp+Pn9th9Hl+zygObchBczrXpEZnSc796nNkMtcJkxarFZPBj2cTpIWUPibEnG7bf5
         bV5wQ6cwlhp0xDnA0ASAr7vX5nLh8I8wLvHtTEsCZ9qaIUir/N7q593h5XkuolzVOfQ2
         srNJt2lNGnSbJyqxogn4sqbBL0iBws9A512JhRO6Z6SkbhI6AJers0HTTzdSJTrBMicM
         REyA==
X-Gm-Message-State: ANoB5pm+bpSHESdHNhHyI06lkD4hpAWyxmOFkwaACLnwhtWwjPC3yztN
        FYh25vLUbCZ4MXiUJhCWtmsZ8oXhR8WfKSsPUdY=
X-Google-Smtp-Source: AA0mqf5yZHVA+3LK55NVeD2cSZVOVr9O5iGWlYlpweUrBj+HbRiR0ym/8W2/izsKlp6at4s7Qm2+lY2hvPWIlEhGrVM=
X-Received: by 2002:a05:600c:1609:b0:3cf:9877:c7e0 with SMTP id
 m9-20020a05600c160900b003cf9877c7e0mr1069159wmn.109.1671291501843; Sat, 17
 Dec 2022 07:38:21 -0800 (PST)
MIME-Version: 1.0
References: <20221215043217.81368-1-xiangxia.m.yue@gmail.com>
 <553c4d32-aac1-f5d2-8f39-86cdca1af0d6@meta.com> <CAMDZJNW+c0JkgZ0XOtq674cjXeof+U0D54yd8JBzizuQioDt3A@mail.gmail.com>
 <425c20bd-9e7e-4fc7-9050-7d9e9bfce972@iogearbox.net>
In-Reply-To: <425c20bd-9e7e-4fc7-9050-7d9e9bfce972@iogearbox.net>
From:   Tonghao Zhang <xiangxia.m.yue@gmail.com>
Date:   Sat, 17 Dec 2022 23:37:43 +0800
Message-ID: <CAMDZJNWwiScnqhvhBqDf_neiRimLGmZw-xN0UNLJE_q01K3vkQ@mail.gmail.com>
Subject: Re: [bpf-next v2 1/2] bpf: add runtime stats, max cost
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Yonghong Song <yhs@meta.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Hou Tao <houtao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Dec 17, 2022 at 12:07 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 12/16/22 10:05 AM, Tonghao Zhang wrote:
> > On Fri, Dec 16, 2022 at 1:40 PM Yonghong Song <yhs@meta.com> wrote:
> >> On 12/14/22 8:32 PM, xiangxia.m.yue@gmail.com wrote:
> >>> From: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> >>>
> >>> Now user can enable sysctl kernel.bpf_stats_enabled to fetch
> >>> run_time_ns and run_cnt. It's easy to calculate the average value.
> >>>
> >>> In some case, the max cost for bpf prog invoked, are more useful:
> >>> is there a burst sysload or high cpu usage. This patch introduce
> >>> a update stats helper.
> >>
> >> I am not 100% sure about how this single max value will be useful
> >> in general. A particular max_run_time_ns, if much bigger than average,
> >> could be an outlier due to preemption/softirq etc.
> >> What you really need might be a trend over time of the run_time
> >> to capture the burst. You could do this by taking snapshot of
> > Hi
> > If the bpf prog is invoked frequently,  the run_time_ns/run_cnt may
> > not be increased too much while
> > there is a maxcost in bpf prog. The max cost value means there is at
> > least one high cost in bpf prog.
> > we should take care of the most cost of bpf prog. especially, much
> > more than run_time_ns/run_cnt.
>
> But then again, see Yonghong's comment with regards to outliers. I
> think what you're probably rather asking for is something like tracking
> p50/p90/p99 run_time_ns numbers over time to get a better picture. Not
> sure how single max cost would help, really..
What I am asking for is that is there a high cpu cost in bpf prog ? If
the bpf prog run frequently,
the run_time_ns/cnt is not what we want. because if we get bpf runtime
stats frequently, there will
be a high syscall cpu load. so we can't use syscall frequently. so why
I need this max cost value, as
yonghong say "if much bigger than average, could be an outlier due to
preemption/softirq etc.". It is right.
but I think there is another reason, the bpf prog may be too bad to
cause the issue or bpf prog invoke a bpf helper which
take a lot cpu. Anyway this can help us debug the bpf prog. and help
us to know what max cost the prog take. If possible
we can update the commit message and send v3.

> >> run_time_ns/run_cnt periodically and plot the trend of average
> >> run_time_ns which might correlate with other system activity.
> >> Maybe I missed some use cases for max_run_time_ns...
> >>
> >>>
> >>> $ bpftool --json --pretty p s
> >>>      ...
> >>>      "run_max_cost_ns": 313367
> >>>
> >>> Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> >>> Cc: Alexei Starovoitov <ast@kernel.org>
> >>> Cc: Daniel Borkmann <daniel@iogearbox.net>
> >>> Cc: Andrii Nakryiko <andrii@kernel.org>
> >>> Cc: Martin KaFai Lau <martin.lau@linux.dev>
> >>> Cc: Song Liu <song@kernel.org>
> >>> Cc: Yonghong Song <yhs@fb.com>
> >>> Cc: John Fastabend <john.fastabend@gmail.com>
> >>> Cc: KP Singh <kpsingh@kernel.org>
> >>> Cc: Stanislav Fomichev <sdf@google.com>
> >>> Cc: Hao Luo <haoluo@google.com>
> >>> Cc: Jiri Olsa <jolsa@kernel.org>
> >>> Cc: Hou Tao <houtao1@huawei.com>
> >>> ---
> >>> v2: fix build warning
> >>> ---
> >>>    include/linux/filter.h   | 29 ++++++++++++++++++++++-------
> >>>    include/uapi/linux/bpf.h |  1 +
> >>>    kernel/bpf/syscall.c     | 10 +++++++++-
> >>>    kernel/bpf/trampoline.c  | 10 +---------
> >>>    4 files changed, 33 insertions(+), 17 deletions(-)
> >>>
> >> [...]
> >
> >
> >
>


-- 
Best regards, Tonghao
