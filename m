Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6AC1DB76B
	for <lists+bpf@lfdr.de>; Wed, 20 May 2020 16:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgETOun (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 May 2020 10:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbgETOun (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 May 2020 10:50:43 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55B1C08C5C0
        for <bpf@vger.kernel.org>; Wed, 20 May 2020 07:50:42 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id x15so1106596ybr.10
        for <bpf@vger.kernel.org>; Wed, 20 May 2020 07:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ajOsEVzBBmvLmCdJ2Fdc///Cfm2T2Xmx2TMwaA04DAo=;
        b=I8m8YrPTQXsy55nnqHyJdwIhm6QdarEOtspEoGcg9nkXM0Ew5AiYBTRIXjdtZxXD6S
         izOaYJYXE9XhaKVivA15X9QwZB3PnP3Qtl7QtzesZcYYMbCOjlRer0BjLRwvbWrr3bKz
         vk+zY7elcJGaeObSkGHGPxyQecLQW8tuncrc2tGZPsmNSar4qJEW9mJ2sKXaBeXLnFb1
         knwneHaygvC8zuiYEbffnkfuYqr7AB8BPsN2D0fzE8BkWD983alvNMTYO3pCTscKsJsU
         UoCgPcIVR5XrlFoUhmm56VsMLBd29uLTatSh8xwvQO3OY7NoruCYGaLLv2KyCDTa7hrJ
         7ZHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ajOsEVzBBmvLmCdJ2Fdc///Cfm2T2Xmx2TMwaA04DAo=;
        b=o/3P6NUrwPHwBuCy5uMWGE+udZLpB0fbRBNmfVBKExdQL9dRt5/yXwUCuVoQzN27yG
         TI0gY8gT9KgOHsn3PneybAjef4ifihYMHKUi9lQPsvEi1QMLUPrSw0xQIUg+6Bb3guLL
         C+5gM51zL2Nny3l+yPyRFubFxZi9kDMjNf4k9y9ySkJK8XufreAD6qBVFB9r/gJ3+27S
         Aszmc0MwD0AH8SAKm7tHs60fDL1YZ+SW672ecQVX0SD/qLKU5Lt/PcW4zeFvR6/nnjgb
         aI8UPBYjsGBgcfnNGmvCwBaouPuTsAPUEPtIKElREPoRjhffX6xWKmnXFTh1hNWm1Ic+
         Xenw==
X-Gm-Message-State: AOAM531RoGbkn/RtmxG+rIyhn0cwe2dgC7EQGMgLXo7tQzwNoW8WpaTI
        GmL6UMObMIE72vJXmQ7mmW1YZbYtuCGyP7kBKobh8w==
X-Google-Smtp-Source: ABdhPJwUG/n0zhdUFbriSJsXmMxGywwDOeEtiLHjve+29uytAAbLo+u0KRAoTbKvizTmfvhGt1A2X7ckmp17h3/0lU0=
X-Received: by 2002:a25:4446:: with SMTP id r67mr7502533yba.41.1589986241692;
 Wed, 20 May 2020 07:50:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200520072814.128267-1-irogers@google.com> <20200520131359.GJ157452@krava>
In-Reply-To: <20200520131359.GJ157452@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 20 May 2020 07:50:30 -0700
Message-ID: <CAP-5=fXZVmjuiGyRsjzjfsBOpN50SeA+Gi66Of_wa61j7f6X5Q@mail.gmail.com>
Subject: Re: [PATCH 0/7] Share events between metrics
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Paul Clarke <pc@us.ibm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 20, 2020 at 6:14 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Wed, May 20, 2020 at 12:28:07AM -0700, Ian Rogers wrote:
> > Metric groups contain metrics. Metrics create groups of events to
> > ideally be scheduled together. Often metrics refer to the same events,
> > for example, a cache hit and cache miss rate. Using separate event
> > groups means these metrics are multiplexed at different times and the
> > counts don't sum to 100%. More multiplexing also decreases the
> > accuracy of the measurement.
> >
> > This change orders metrics from groups or the command line, so that
> > the ones with the most events are set up first. Later metrics see if
> > groups already provide their events, and reuse them if
> > possible. Unnecessary events and groups are eliminated.
> >
> > The option --metric-no-group is added so that metrics aren't placed in
> > groups. This affects multiplexing and may increase sharing.
> >
> > The option --metric-mo-merge is added and with this option the
> > existing grouping behavior is preserved.
> >
> > Using skylakex metrics I ran the following shell code to count the
> > number of events for each metric group (this ignores metric groups
> > with a single metric, and one of the duplicated TopdownL1 and
> > TopDownL1 groups):
>
> hi,
> I'm getting parser error with:
>
> [jolsa@krava perf]$ sudo ./perf stat -M IPC,CPI -a -I 1000
> event syntax error: '..ed.thread}:W{inst_retired.any,cpu_clk_unhalted.thread}:W,{inst_retired.any,cycles}:W'
>                                   \___ parser error
>
> jirka

Ah, looks like an issue introduced by:
https://lore.kernel.org/lkml/20200520072814.128267-8-irogers@google.com/
as there is a missing comma. I'll investigate after some breakfast.

Thanks,
Ian
