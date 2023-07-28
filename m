Return-Path: <bpf+bounces-6112-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F61766094
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 02:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1009282541
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 00:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3CD580C;
	Fri, 28 Jul 2023 00:12:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E83515A5
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 00:12:56 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF4FBF
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 17:12:54 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-c64ef5bde93so1464576276.0
        for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 17:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690503173; x=1691107973;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Pjo35PlF/wWvhS1Cmx8bdMFmFen6pv+m7YZnMKsM5hM=;
        b=Kxi7gcEHRIDlZ8Dkc2GhTzNZ20lYfZCvlq+ldSJviigTVdp0JZgOz5hqDz2Aa+rfvi
         ALuAGwd59azVJCigV88ctSOJRFGTPP4BBeZmqsXtVJHiu8EPgdhC+vGXNffNbbA7hgqk
         ch9Vw/sRFCzPTn5XUWe6FfCeQ5btSOpQNPO+NUm5v+uKBT5PVH+SPSlp1/7oen9+0w2w
         k3RM8rts+l34AAbcdCkYj/0SI/q7OatEGzGM/HC+I4fcH9sd9tJNIiSqVDD7ku8+8viG
         bkmvcEUxK/AocjL1j0qx0gGXFo9PmD6uL+XwQYpa4obRkNKAZhZPCKBbc0//y5EraIMJ
         ZKyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690503173; x=1691107973;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pjo35PlF/wWvhS1Cmx8bdMFmFen6pv+m7YZnMKsM5hM=;
        b=ZpKAPq0KtVCrFyBvKT5dl/KYfe74lJbJFOCQd4iZ4ZCwkpjAXjcNPpjpEqV6Fhhx2D
         r/N+zPH4xHjIOlTCYlA17kX4aAxOFfBIW9yIOgpOa4E11yrpdiU+LWwCFp5gLbUsuCD0
         KDzdRrWKJJvD/i2WmfsRBU7EKz+Zu2cpgQvywSlVLVT1AKTgU0lpdmEBG/9ReRFH34y5
         6FeXr0Q1jrY97F1zj2HFzsHS6ItSAhBKNezUL0Clk8TVvXdC5N0zynVak83zlviY0UyH
         9HqGi9QTA7iNRwBb89lfN/q5qdWfk0Xm6IaPkD7ujXVgvgYlhZrrcshnQSXtftKyUALG
         D8Hw==
X-Gm-Message-State: ABy/qLYcj2EFaD1cQ9J8akXvB3GizjDCW7Coa7m6Xy/sjSSkKxV62X5j
	BMsIY2fBMLllT/kndSoWy+zCeEJ8QaBU
X-Google-Smtp-Source: APBJJlF8HwXtj+YshMZZDcCVKC35WCn7D5t/5BkZSF40yl9o6ZL5PKImCZTzA7ciNPRV+LorQdyG8DubR6So
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:3d03:ff18:af30:2dad])
 (user=irogers job=sendgmr) by 2002:a25:37d8:0:b0:c64:2bcd:a451 with SMTP id
 e207-20020a2537d8000000b00c642bcda451mr973yba.7.1690503173648; Thu, 27 Jul
 2023 17:12:53 -0700 (PDT)
Date: Thu, 27 Jul 2023 17:12:09 -0700
Message-Id: <20230728001212.457900-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Subject: [PATCH v1 0/3] Remove BPF arrays from perf event parsing
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Rob Herring <robh@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Wang Nan <wangnan0@huawei.com>, Wang ShaoBo <bobo.shaobowang@huawei.com>, 
	YueHaibing <yuehaibing@huawei.com>, He Kuang <hekuang@huawei.com>
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Event parsing was recently refactored:
https://lore.kernel.org/all/20230502223851.2234828-1-irogers@google.com/

During these changes I wanted to get coverage of all parts of the
parse-events.y and found that I couldn't test the array code.

The first patch fixes a BPF testing issue.
The 2nd and 3rd patch remove the BPF array event parsing code so that
it isn't adding complexity to event parsing.

Ian Rogers (3):
  perf parse-event: Avoid BPF test segv
  perf tools: Revert enable indices setting syntax for BPF map
  perf parse-events: Remove array remnants

 tools/perf/util/bpf-loader.c   | 101 ---------------------------
 tools/perf/util/parse-events.c |  18 +----
 tools/perf/util/parse-events.h |  10 ---
 tools/perf/util/parse-events.l |  11 ---
 tools/perf/util/parse-events.y | 122 ---------------------------------
 5 files changed, 2 insertions(+), 260 deletions(-)

-- 
2.41.0.487.g6d72f3e995-goog


