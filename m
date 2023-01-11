Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B0D666261
	for <lists+bpf@lfdr.de>; Wed, 11 Jan 2023 18:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbjAKR7k (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Jan 2023 12:59:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233899AbjAKR70 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Jan 2023 12:59:26 -0500
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFCE014D24;
        Wed, 11 Jan 2023 09:59:25 -0800 (PST)
Received: by mail-il1-f175.google.com with SMTP id m15so8273221ilq.2;
        Wed, 11 Jan 2023 09:59:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ns9qgbZZDM0cRBwnUDXXAKWNmRdk/HbHXOFx6BEC0M8=;
        b=Udznus0+05ocgOYtYseFqL9ktwoX/2rg99XjOTQaoOGTjZmysKvcmMKzXZUdZJISyn
         99tIfixYBPPz+kdqrtLmRu6YhzB6Bd9iGnVpP6R4VYJmDEH8zcVOL5N1AdICnit+uPPf
         sdKt/ddMJjWZDIqoESH6CUzdTLy3cAtEBNEPYutia2CqPbhZwvtUCfTvEoZEU/6fmj8X
         fFo/luqxcLBo4371dzPr96GmomU4jex9FnmphrCI5rm4kDcaxfWH0mFt3H226maOwQJZ
         DhwHrWn64TfEgMOCYdZjzjq0jjNsGFRlhvQ+JzRI6XwJCijlroBXxiCB5e3lny+XmCL9
         1FZg==
X-Gm-Message-State: AFqh2kpbAaz8xLITCHpCQz3AfCZNuYqW5a14YMFgSckNzYIvXldYevPx
        EhEiG1R26eYggLOtnMlHGMyypZeta2K87XLlpI9JOkNi
X-Google-Smtp-Source: AMrXdXsJddMuCsiA9+eT+WzET0US5MtSPeMTawi/c0UjcJjVM6BAW+IiF0eo8+IsDS+OsnmlEKuBVMk0B2U01lSDFJQ=
X-Received: by 2002:a05:6e02:f10:b0:30d:e353:8613 with SMTP id
 x16-20020a056e020f1000b0030de3538613mr106170ilj.250.1673459965081; Wed, 11
 Jan 2023 09:59:25 -0800 (PST)
MIME-Version: 1.0
References: <20221229204101.1099430-1-namhyung@kernel.org> <20221229204101.1099430-2-namhyung@kernel.org>
 <Y7wFJ+NF0NwnmzLa@hirez.programming.kicks-ass.net> <Y7x3RUd67smv3EFQ@google.com>
 <CAM9d7ciVZCHk0YqpobfR+t0FPN_-tpnLgNbN981=EygkM_riDg@mail.gmail.com>
 <Y76xng1U6UYpIGaW@hirez.programming.kicks-ass.net> <Y77nswJ7gMWekXTt@hirez.programming.kicks-ass.net>
In-Reply-To: <Y77nswJ7gMWekXTt@hirez.programming.kicks-ass.net>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 11 Jan 2023 09:59:13 -0800
Message-ID: <CAM9d7cjARKJ7Xj93k00KccJ+UQtytZn-g8nbWpz9nfT9s2nkhQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] perf/core: Set data->sample_flags in perf_prepare_sample()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 11, 2023 at 8:45 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Jan 11, 2023 at 01:54:54PM +0100, Peter Zijlstra wrote:
> > On Tue, Jan 10, 2023 at 12:06:00PM -0800, Namhyung Kim wrote:
> >
> > > Another example, but in this case it's real, is ADDR.  We cannot update
> > > the data->addr just because filtered_sample_type has PHYS_ADDR or
> > > DATA_PAGE_SIZE as it'd lose the original value.
> >
> > Hmm, how about something like so?
> >
> > /*
> >  * if (flags & s) flags |= d; // without branches
> >  */
> > static __always_inline unsigned long
> > __cond_set(unsigned long flags, unsigned long s, unsigned long d)
> > {
> >       return flags | (d * !!(flags & s));
> > }
> >
> > Then:
> >
> >       fst = sample_type;
> >       fst = __cond_set(fst, PERF_SAMPLE_CODE_PAGE_SIZE, PERF_SAMPLE_IP);
> >       fst = __cond_set(fst, PERF_SAMPLE_DATA_PAGE_SIZE |
> >                             PERF_SAMPLE_PHYS_ADDR,      PERF_SAMPLE_ADDR);
> >       fst = __cond_set(fst, PERF_SAMPLE_STACK_USER,     PERF_SAMPLE_REGS_USER);
> >       fst &= ~data->sample_flags;
> >
>
> Hmm, I think it's better to write this like:
>
> static __always_inline unsigned long
> __cond_set(unsigned long flags, unsigned long s, unsigned long d)
> {
>         return d * !!(flags & s);
> }
>
>         fst = sample_type;
>         fst |= __cond_set(sample_type, PERF_SAMPLE_CODE_PAGE_SIZE, PERF_SAMPLE_IP);
>         fst |= __cond_set(sample_type, PERF_SAMPLE_DATA_PAGE_SIZE |
>                                        PERF_SAMPLE_PHYS_ADDR,      PERF_SAMPLE_ADDR);
>         fst |= __cond_set(sample_type, PERF_SAMPLE_STACK_USER,     PERF_SAMPLE_REGS_USER);
>         fst &= ~data->sample_flags;
>
> Which should be identical but has less data dependencies and thus gives
> an OoO CPU more leaway to paralleize things.

Looks good.  Let me try this.

Thanks,
Namhyung
