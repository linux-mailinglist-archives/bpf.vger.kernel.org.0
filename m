Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1935D539CDC
	for <lists+bpf@lfdr.de>; Wed,  1 Jun 2022 08:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349649AbiFAGB2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Jun 2022 02:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243355AbiFAGB1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Jun 2022 02:01:27 -0400
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3F32FFF1;
        Tue, 31 May 2022 23:01:26 -0700 (PDT)
Received: by mail-oi1-f177.google.com with SMTP id s188so1374649oie.4;
        Tue, 31 May 2022 23:01:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3gQ5prNQvxNU5BCy8dGPEskxDYGkNMOicAPNaI2Vitw=;
        b=I4MMCzJdhF/gPZ5ZBd3iS7EDKHDy3QSSkFjFc/fgwtrdAlWJJRxUj4XVtMc+fBY9Kq
         zWf3MUsbI5oIJtuEs0A1mJgGJxt8ke0dyl6Aa1I0RqK78S4BCgUdCsUB+zOjjrQ3MBKz
         wqf3kxyR+7MwK/YPEYWSuT5ASemOwsVdEhVTZ++VO7AkL91eArerrK94fbLYlR1g6Kgk
         PJqaLceS/PrN9tDHFxN5gbc3m+kOlx9VkNY4XufZt2tcWqWrMz5IC2FZEimL+2lOjiow
         SvbUcbisQA1EUYZoZjl7o/zRsbLB2fIzKyFjNcry7fJwdjE+iYyR8GOKj110NxclwfDx
         OkFg==
X-Gm-Message-State: AOAM532vnY/wIkTJbG88MDypDrWXxz9MHFe5HiniFhSAAwAvxpy+a+oZ
        CNS7qqtazsnstHIK752wckPQP/j8myD5mVVrF9s=
X-Google-Smtp-Source: ABdhPJwYo/SJBcdj28bukzhXOluCYEl/I07PSoNeX5qSgooxA7bKozLBhQW8UO8GP/5L7Y2QfNd3LlCmIV/uJe0vDMY=
X-Received: by 2002:a05:6808:16ac:b0:2f9:52e5:da90 with SMTP id
 bb44-20020a05680816ac00b002f952e5da90mr14509606oib.5.1654063285559; Tue, 31
 May 2022 23:01:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220518224725.742882-1-namhyung@kernel.org> <20220518224725.742882-3-namhyung@kernel.org>
 <CAP-5=fX=fiuZ31O2XTSsAwyGD=c5uf9P_BzX9L1QG-q8cUvQYQ@mail.gmail.com>
In-Reply-To: <CAP-5=fX=fiuZ31O2XTSsAwyGD=c5uf9P_BzX9L1QG-q8cUvQYQ@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 31 May 2022 23:01:14 -0700
Message-ID: <CAM9d7cjT2o3xVUQf402shzirD4K2XoyomN+AL_R2WENKg6pwoQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] perf record: Enable off-cpu analysis with BPF
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Hao Luo <haoluo@google.com>, bpf <bpf@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Milian Wolff <milian.wolff@kdab.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Blake Jones <blakejones@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, May 31, 2022 at 5:00 PM Ian Rogers <irogers@google.com> wrote:
>
> On Wed, May 18, 2022 at 3:47 PM Namhyung Kim <namhyung@kernel.org> wrote:
[SNIP]
> > +
> > +/*
> > + * Old kernel used to call it task_struct->state and now it's '__state'.
> > + * Use BPF CO-RE "ignored suffix rule" to deal with it like below:
> > + *
> > + * https://nakryiko.com/posts/bpf-core-reference-guide/#handling-incompatible-field-and-type-changes
> > + */
> > +static inline int get_task_state(struct task_struct *t)
> > +{
> > +       if (bpf_core_field_exists(t->__state))
> > +               return BPF_CORE_READ(t, __state);
> > +
>
> When building against a pre-5.14 kernel I'm running into a build issue here:
>
> tools/perf/util/bpf_skel/off_cpu.bpf.c:96:31: error: no member named '__
> state' in 'struct task_struct'; did you mean 'state'?
>        if (bpf_core_field_exists(t->__state))
>                                     ^~~~~~~
>                                     state
>
> This isn't covered by Andrii's BPF CO-RE reference guide. I have an
> #iffy workaround below,but this will be brittle if the 5.14+ kernel
> code is backported. Suggestions welcomed :-)

Thanks for the fix.  I think we should not guess the field name
in the current task struct and check both versions separately.
I'm afraid the version check won't work with some backported
kernels.  But do we care?

Thanks,
Namhyung
