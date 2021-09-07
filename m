Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A13D402FE5
	for <lists+bpf@lfdr.de>; Tue,  7 Sep 2021 22:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235991AbhIGUv0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Sep 2021 16:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbhIGUv0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Sep 2021 16:51:26 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D0CC061575;
        Tue,  7 Sep 2021 13:50:19 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id z18so1094664ybg.8;
        Tue, 07 Sep 2021 13:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c67uG96v7m5oK6v4jgMgyYQ8vaVF+ha9XkRfekq/788=;
        b=pMAobo9YyVRUKw/e0lSeOrV7MzoP1qHoxGq8kRvC9THZX5iSxB3qteUbxw0PjY7KW+
         laobPerUdQAc0Yl3Du7F9AggiSAbM9c0JmZmQ1xewS1u4dTZsWeQ/79dLQ7oHxufFCFI
         /J1ItRGJnN5/XY9zEhttI6t+nPQCILUYm5JzQVCHebKPRgZSVl95KfKJK6vxR2zAIC9B
         61YK2JMJpDrH5/G05Xyps4NnRbfG9RRS3LZaCrABOQhNYtPXNOa9UYg6ucFiKcr5I1/q
         pIeKOVklz3UTov7xILClILhf37fsJiz4a5g6vgiiy5iNy/2RYDQEVyEYhjUlT/2yb5yW
         xgkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c67uG96v7m5oK6v4jgMgyYQ8vaVF+ha9XkRfekq/788=;
        b=XxiRnMWQdUcFDZENBjjgkxOFFjJtnC3Y56Yo124ZDR3bKmuY1i+IFHsgz8IvkbiEVg
         HQmKXAHIxy9sjJyrtc+WWpQcEeoax+PKwU/dqU83KHquNYlNoo4npV+IKaxLiOCsHfYR
         dPXdrykhVfcMQtwoMSKPnSw93n01laAsdTpR7YVHzY+3Z79e2VfcsFRqmcLJZO6wynSF
         dF7gCfI19bJw7PQZg5NmOI4menuv1pbfi0SuX68z333Y87F9B9vpTnnBWkNl3q9oDn0M
         e9/7CICNqtH4Y4lcOJSGyP0o3GOAaG/KxdibKHNFQoiZQ5nyFlxeru4mYbsbMpIJiUFm
         aWWQ==
X-Gm-Message-State: AOAM5312MOlUWUefriUWvPEzov+P2nwma9d+SgF0A6K439QLy69Yu22h
        YGRfN4i2FGMOveyDMCpBd63kLkBkDKdXkNTuJsU=
X-Google-Smtp-Source: ABdhPJybg9oFilkeCBAgj727ohS1ttz6miPunDJMsWJhvp+uTbm1kaEwtFDY7Y2R8WzmRLxFk6D27omAtLDUAAz051c=
X-Received: by 2002:a25:65c4:: with SMTP id z187mr423211ybb.113.1631047818433;
 Tue, 07 Sep 2021 13:50:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210902165706.2812867-1-songliubraving@fb.com>
 <20210902165706.2812867-2-songliubraving@fb.com> <YTHWoCcSgvfx24/N@hirez.programming.kicks-ass.net>
 <D501C4AD-3778-431B-A710-3399BFE6EE56@fb.com> <B3CCDCB4-1D06-4331-A3C7-B1D413A4ABA5@fb.com>
In-Reply-To: <B3CCDCB4-1D06-4331-A3C7-B1D413A4ABA5@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 7 Sep 2021 13:50:07 -0700
Message-ID: <CAEf4Bzacgy=u+aTmTGbWo6UhHUWk6uA-zsKdsNCk5g6oPNycog@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 1/3] perf: enable branch record for software events
To:     Song Liu <songliubraving@fb.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, bpf <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "acme@kernel.org" <acme@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "kjain@linux.ibm.com" <kjain@linux.ibm.com>,
        Kernel Team <Kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 7, 2021 at 12:02 PM Song Liu <songliubraving@fb.com> wrote:
>
>
>
> > On Sep 3, 2021, at 9:50 AM, Song Liu <songliubraving@fb.com> wrote:
> >
> >
> >
> >> On Sep 3, 2021, at 1:02 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> >>
> >> On Thu, Sep 02, 2021 at 09:57:04AM -0700, Song Liu wrote:
> >>> +static int
> >>> +intel_pmu_snapshot_branch_stack(struct perf_branch_entry *entries, unsigned int cnt)
> >>> +{
> >>> +   struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> >>> +
> >>> +   intel_pmu_disable_all();
> >>> +   intel_pmu_lbr_read();
> >>> +   cnt = min_t(unsigned int, cnt, x86_pmu.lbr_nr);
> >>> +
> >>> +   memcpy(entries, cpuc->lbr_entries, sizeof(struct perf_branch_entry) * cnt);
> >>> +   intel_pmu_enable_all(0);
> >>> +   return cnt;
> >>> +}
> >>
> >> Would something like the below help get rid of that memcpy() ?
> >>
> >> (compile tested only)
> >
> > We can get rid of the memcpy. But we will need an extra "size" or "num_entries"
> > parameter for intel_pmu_lbr_read. I can add this change in the next version.
> >
>
> This is trickier than I thought. As current lbr_read() function works with
> perf_branch_stack, while the BPF helper side uses array of perf_branch_entry.
> And the array is passed into the helper by the BPF program. Therefore, to
> really get rid of the memcpy, we need to refactor the lbr driver code more.
> How about we keep the memcpy for now, and add the optimization later (if we
> think it is necessary)?
>

Sounds good to me!

> Thanks,
> Song
>
