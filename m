Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35EAA696C54
	for <lists+bpf@lfdr.de>; Tue, 14 Feb 2023 19:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjBNSGw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Feb 2023 13:06:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjBNSGv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Feb 2023 13:06:51 -0500
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8803D40E2;
        Tue, 14 Feb 2023 10:06:48 -0800 (PST)
Received: by mail-vk1-f182.google.com with SMTP id bs10so8396562vkb.3;
        Tue, 14 Feb 2023 10:06:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KrQm1/EFavHyFPihiEA+04y1YzVp/FTphoUcyDODtiU=;
        b=1eUHz/xRl+jwcqfb9Kc+JFJCTUeSLpZMGMH2tU04axq3YtKDBfxuVMnvc0iWSHmzZV
         jdiJwTMLFxfvgdO3EEV6bNHyh/g1bGyySAaYtluhhTczW/2AoENPX5LZM+D1TXNlEBG2
         H4hfU5BUmfalrY0hu0E7mIYDNPNq2imdXj/35+yaHbPqFk76DRO3DWBbQ+osCIcUAzNZ
         zLik78pj2yhUl8SLuFJOcpCVvH7sjTo/1tqBcayzCK3LtIE5PMKHXYt30Ptf+VKRht/U
         xs14rjkA5++IYsjPZpSnDt0HnpsC4pzb3Tpc30yqc7TIr95Yfuup82sOTdPSBd06fI+c
         qkjA==
X-Gm-Message-State: AO0yUKXLURTRLnOoq9OxXUeLrgGks3DzQTxFWOn6Sn7gZtNVmUWoE0lu
        nOmQUHQ5EpKfQ1oyg8Fb2UTBgEKD1yYH8UiA9sc=
X-Google-Smtp-Source: AK7set9DyOIWzAEHf2w4JiY6NohRsF9v8/HH3brHwyUo6IdtREUtQdjy8HQC/QZMvWHphz7qN7f7ZBMN33o/dyqbH1I=
X-Received: by 2002:a1f:a258:0:b0:401:b89:5375 with SMTP id
 l85-20020a1fa258000000b004010b895375mr526413vke.22.1676398007610; Tue, 14 Feb
 2023 10:06:47 -0800 (PST)
MIME-Version: 1.0
References: <20230214050452.26390-1-namhyung@kernel.org> <20230214050452.26390-5-namhyung@kernel.org>
 <CAP-5=fWV+VCheBocBpXg-jRHr+vkNnKWbH4Rjma9imQRJpis+w@mail.gmail.com>
In-Reply-To: <CAP-5=fWV+VCheBocBpXg-jRHr+vkNnKWbH4Rjma9imQRJpis+w@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 14 Feb 2023 10:06:36 -0800
Message-ID: <CAM9d7ch9pLB7ZvNjisASruLqaQTw_DdZDjJQFSir7zntQHNnhw@mail.gmail.com>
Subject: Re: [PATCH 4/7] perf record: Record dropped sample count
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Song Liu <song@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        James Clark <james.clark@arm.com>, Hao Luo <haoluo@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 14, 2023 at 8:41 AM Ian Rogers <irogers@google.com> wrote:
>
> On Mon, Feb 13, 2023 at 9:05 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > When it uses bpf filters, event might drop some samples.  It'd be nice
> > if it can report how many samples it lost.  As LOST_SAMPLES event can
> > carry the similar information, let's use it for bpf filters.
> >
> > To indicate it's from BPF filters, add a new misc flag for that and
> > do not display cpu load warnings.
>
> Can you potentially have lost samples from being too slow to drain the
> ring buffer and dropped samples because of BPF? Is it possible to
> distinguish lost and dropped with this approach?

Yeah, the former is exactly what LOST_SAMPLES event gives you.
It should come from the kernel while BPF filters keep a separate
counter for dropped samples and inject LOST_SAMPLES events
with the new misc flag.  So we can differentiate them using the misc
flag and that's how I suppress the warning for BPF dropped ones.

Thanks,
Namhyung
