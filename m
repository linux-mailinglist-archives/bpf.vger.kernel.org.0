Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32CFE1C8475
	for <lists+bpf@lfdr.de>; Thu,  7 May 2020 10:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgEGIOt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 May 2020 04:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725857AbgEGIOs (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 7 May 2020 04:14:48 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A59C061A41
        for <bpf@vger.kernel.org>; Thu,  7 May 2020 01:14:48 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id o134so6049705yba.18
        for <bpf@vger.kernel.org>; Thu, 07 May 2020 01:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=jJ+0WVT0o7QnePYWoDu2DLbS3PF1WBgkVDF9XXQH2a0=;
        b=ivglXwvDfB4/pd8fDyiSer//832TB2EZ2jFXvGPGLpLtmfFxysFjth6U6ltV45e+nh
         7cTyxgyoN8J/Vr8cBP0YOGwzl/YjLBCwWYRxSG6UP6VveKOyIvjOXDHYw0jL89LVAoA5
         0b4nLuEjj8WZXKHMuua05G+Qf04QbzB5HgbeAgqN1gA2nRLqzTU8HLqEtYpXKHSscRS7
         TUC/edfu14DK8bZ1RqEcE3pQmG+QxeueS7pi1KAQLqNIe4MmLwBfjQ3ViQdwoC7andKg
         Z9UZjTS//VfS7phn1QXJyIPu2JCmIxtmyvkFhp6kH/v4Q1kXkm/FdmGy5r6cEXDwRvSc
         jzHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=jJ+0WVT0o7QnePYWoDu2DLbS3PF1WBgkVDF9XXQH2a0=;
        b=BYlYkRH7YSM0b3zQRj7rFKxqDIpUgbLHjm/nong3whOd0s1N5dh7RtVA8IAjRjoYjf
         mVxb0lWufLVThcXew//Z3Dz9qe6tFgSfPuam+BTXztNoBTjl6wtPbKooNwO63oVwCuZg
         0sxqRIx75qH339dDnMOsJoFQ4NVPijs2aQR6rFwbbZhTDQ9TkcM3Bg1WrzoqCbQC+Wur
         dOYmQ2zC5NeiNQIUhv1DWiyez9sxkWf6RsuunbDh6WaTUruCQhf0xuFazK4waceunOwu
         Ce1Y9TVx2olWN8ZJjYqf6oNv59U0nu/jJBKolkpkfvF98TZWwasTO97C8GYKRHqqirln
         fnog==
X-Gm-Message-State: AGi0PuY1lMLEigxC9Si8rxiTEOLkg0Tlx8tCeMMuwLaR9ph/lyrAi77p
        cO/sdRX7yFsmNjC4NCeoaFKtvsgZZ3TH
X-Google-Smtp-Source: APiQypL12F/G/IG1P0vRR+5Jg8zc4/oiuJDwhAuqK50oi9mZH3/+YXbOSRjblC5OcgxtqRVov4Hi57WfIeic
X-Received: by 2002:a25:c246:: with SMTP id s67mr19644886ybf.317.1588839287376;
 Thu, 07 May 2020 01:14:47 -0700 (PDT)
Date:   Thu,  7 May 2020 01:14:29 -0700
Message-Id: <20200507081436.49071-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [RFC PATCH 0/7] Share events between metrics
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Kim Phillips <kim.phillips@amd.com>,
        linux-kernel@vger.kernel.org
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Metric groups contain metrics. Metrics create groups of events to
ideally be scheduled together. Often metrics refer to the same events,
for example, a cache hit and cache miss rate. Using separate event
groups means these metrics are multiplexed at different times and the
counts don't sum to 100%. More multiplexing also decreases the
accuracy of the measurement.

This change orders metrics from groups or the command line, so that
the ones with the most events are set up first. Later metrics see if
groups already provide their events, and reuse them if
possible. Unnecessary events and groups are eliminated.

RFC because:
 - without this change events within a metric may get scheduled
   together, after they may appear as part of a larger group and be
   multiplexed at different times, lowering accuracy - however, less
   multiplexing may compensate for this.
 - libbpf's hashmap is used, however, libbpf is an optional
   requirement for building perf.
 - other things I'm not thinking of.

Thanks!

Ian Rogers (7):
  perf expr: migrate expr ids table to libbpf's hashmap
  perf metricgroup: change evlist_used to a bitmap
  perf metricgroup: free metric_events on error
  perf metricgroup: always place duration_time last
  perf metricgroup: delay events string creation
  perf metricgroup: order event groups by size
  perf metricgroup: remove duped metric group events

 tools/perf/tests/expr.c       |  32 ++---
 tools/perf/tests/pmu-events.c |  22 ++--
 tools/perf/util/expr.c        | 125 ++++++++++--------
 tools/perf/util/expr.h        |  22 ++--
 tools/perf/util/expr.y        |  22 +---
 tools/perf/util/metricgroup.c | 242 +++++++++++++++++++++-------------
 tools/perf/util/stat-shadow.c |  46 ++++---
 7 files changed, 280 insertions(+), 231 deletions(-)

-- 
2.26.2.526.g744177e7f7-goog

