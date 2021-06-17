Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17A8D3ABBF7
	for <lists+bpf@lfdr.de>; Thu, 17 Jun 2021 20:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbhFQSoh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Jun 2021 14:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbhFQSoh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Jun 2021 14:44:37 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7653CC061760
        for <bpf@vger.kernel.org>; Thu, 17 Jun 2021 11:42:29 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id g4-20020ac80ac40000b029024ead0ebb62so31572qti.13
        for <bpf@vger.kernel.org>; Thu, 17 Jun 2021 11:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ZlXcWG52LpPBNrp8iFYVpN63n0II1sNMyDIazVtXK6g=;
        b=WqCCDit+fwpG7RHerB83fx97SNuOWrBI92BhNuoDyIQiJqzVSqTV3pt0kQ07mP3Rwz
         NtGndorgHcF1qcgrnbzf/QK1bKl9karIOVU/Zpy1FCTNSiBk6gbbCdkmzGi07JpQVMHO
         xR0Lwf6XbXHCWulBVj1WCmH05CoTvHL8gNdpBya6SByiF6jAr4Omvo/G5rYeUBENj7Pz
         ifageJWCezrnSGf1aQbUhaIiWhfJRkqG74iYxj5RMBTzgg0oAMkONhYU1ZrK+7XMUokT
         91x2i3fCwAnPnu7rHCH8ypV3QPfvtOfntuzcsFg83jcg5PgGPocbCq1XakU6Tm6tUskA
         eszw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ZlXcWG52LpPBNrp8iFYVpN63n0II1sNMyDIazVtXK6g=;
        b=ipnJgv0+9Nxr1kFxSizyWO0TcUlS5oMGy2ruRSW7MaMFPVmQpj3oFVJmlY89OFOB6c
         sbChWro/mrmskQqxJThtc53zH7eg3MzgbHTt/swwIR+DmV0ZVZXe0afDAxbb50fevW2J
         yEvzeMrAB0AygaAoEpIO9Tln9b+698GYNezAXokgY/NFJR21n4tU7f5lCm4LDa9A4fbp
         V3KGnCt83GU1BBUZh8jnqWAk/LcXSqtktozydXelZZYNMHLpZPPP0AXmUkt8NHuN/orY
         QFs8/DjqKRYy5RQgiGFsIwmrUR0aTfANi2GYX/62Za76oq6WTmNfh2kz6UdwwLC41cR8
         MNCg==
X-Gm-Message-State: AOAM530Pe0a1qtKfJ/etUx0epGF+pgBlb7PJjQfJIhg4X5MmibQSjdAF
        NknqMi8u/jGQ1hnnxRZ0ur4WCZsbPdGw
X-Google-Smtp-Source: ABdhPJwew74OmEVaWxaFf7DCKZvVPSy8SzWjiBZiMsqU3WWiBEam74KB2f3Je5RJeGnqbDXadOITpsveRIHJ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:ef90:beff:e92f:7ce0])
 (user=irogers job=sendgmr) by 2002:a25:ca45:: with SMTP id
 a66mr7969252ybg.10.1623955348375; Thu, 17 Jun 2021 11:42:28 -0700 (PDT)
Date:   Thu, 17 Jun 2021 11:42:13 -0700
Message-Id: <20210617184216.2075588-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: [PATCH 1/4] perf test: Fix non-bash issue with stat bpf counters
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

$(( .. )) is a bash feature but the test's interpreter is !/bin/sh,
switch the code to use expr.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat_bpf_counters.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/stat_bpf_counters.sh b/tools/perf/tests/shell/stat_bpf_counters.sh
index 22eb31e48ca7..2f9948b3d943 100755
--- a/tools/perf/tests/shell/stat_bpf_counters.sh
+++ b/tools/perf/tests/shell/stat_bpf_counters.sh
@@ -11,9 +11,9 @@ compare_number()
        second_num=$2
 
        # upper bound is first_num * 110%
-       upper=$(( $first_num + $first_num / 10 ))
+       upper=$(expr $first_num + $first_num / 10 )
        # lower bound is first_num * 90%
-       lower=$(( $first_num - $first_num / 10 ))
+       lower=$(expr $first_num - $first_num / 10 )
 
        if [ $second_num -gt $upper ] || [ $second_num -lt $lower ]; then
                echo "The difference between $first_num and $second_num are greater than 10%."
-- 
2.32.0.288.g62a8d224e6-goog

