Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 083303ABBFC
	for <lists+bpf@lfdr.de>; Thu, 17 Jun 2021 20:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233284AbhFQSot (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Jun 2021 14:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233286AbhFQSop (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Jun 2021 14:44:45 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A324C061768
        for <bpf@vger.kernel.org>; Thu, 17 Jun 2021 11:42:36 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id z5-20020ac86c450000b029024e9a87714dso4689011qtu.2
        for <bpf@vger.kernel.org>; Thu, 17 Jun 2021 11:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5DjNG/5LrW+h84YK4KYw+ImmLTxQ10GkkIqN1ecfe50=;
        b=U67lanHkkfa0ltY86P0m9Lk89MeEmTbJ+2mZ9Wqd1wYOQ5MgP7PXnYgh0iY/U8haW5
         DQaO04AZkL/bvpONjjQxefNZN6I2pDT6LJ+nm4fSNjlvGETIdULShNNbcyjmu0hmVNW4
         cihAn6VL4SPwgfX3jvOHDr2hJ17hbhADYfnf0x4B7NstfALSrmPgPwo93ItstMBbg6DP
         aHzAL+owhPPtmiV8kUwXrnwMrSVSn5zB3MQBoG/W13kTXPib25bOfH8nWkuDtKn8H2XI
         vN5f/ixpv7jS2hsL0b6EV/oTaeBgoFX5HL4W5fBlH1wbI07LxZwmVseHGk8cBlx3ooYw
         CfRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5DjNG/5LrW+h84YK4KYw+ImmLTxQ10GkkIqN1ecfe50=;
        b=UX/TTGHYWZ6v0+IJOXTOCd1bEoBQNFEsJ9tFsMn0+4nEmms7c10cFxSMrT7Chbru5k
         dltxMNVS1XchNFR6GME60PGGM09rt/659wAB3IkO8HL0T6eWvYnlp06xDFNMXNhrd2Qy
         q4y2aPM+JIWC3/LcTl5Na8KBJqG6MNDh5fuBOUAbTC5xLAJQDRqTQssgv94zbMj4TuWH
         jM7XteP2nyU+TtpmTSjUuF+Mr65fousxehTHseRqlsJcBwdqxB5+yRd5F9WCM1/z+6ae
         Ap0+8hMpWyY3+cnv7+67SkmES9SIAEZkxsKdnMRPjVWqWyvN7usllJDPYTCIVISlPFB5
         e5NA==
X-Gm-Message-State: AOAM530a0QUmUPAC3dXWtbYUGiW+otHDYGA7ES1X5nbJYkGtX/asjB3w
        42TdlTbQnkHSEFw/BHM+LXB6Y/6B4TEO
X-Google-Smtp-Source: ABdhPJwzE0fiA+ui94SKI9ag06uXUpN6/xN+13AkJwieIj2mSxVaBw+2ipmvQVZW7nK8sWjK5SCrg5eB0O9I
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:ef90:beff:e92f:7ce0])
 (user=irogers job=sendgmr) by 2002:a25:43:: with SMTP id 64mr8267727yba.109.1623955355646;
 Thu, 17 Jun 2021 11:42:35 -0700 (PDT)
Date:   Thu, 17 Jun 2021 11:42:16 -0700
In-Reply-To: <20210617184216.2075588-1-irogers@google.com>
Message-Id: <20210617184216.2075588-4-irogers@google.com>
Mime-Version: 1.0
References: <20210617184216.2075588-1-irogers@google.com>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: [PATCH 4/4] perf test: Make stat bpf counters test more robust
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

If the test is run on a hypervisor then the cycles event may not be
counted, skip the test in this situation. Fail the test if cycles are
not counted in the subsequent bpf counter run.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat_bpf_counters.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/tests/shell/stat_bpf_counters.sh b/tools/perf/tests/shell/stat_bpf_counters.sh
index 81d61b6e1208..2aed20dc2262 100755
--- a/tools/perf/tests/shell/stat_bpf_counters.sh
+++ b/tools/perf/tests/shell/stat_bpf_counters.sh
@@ -31,7 +31,15 @@ if ! perf stat --bpf-counters true > /dev/null 2>&1; then
 fi
 
 base_cycles=$(perf stat --no-big-num -e cycles -- perf bench sched messaging -g 1 -l 100 -t 2>&1 | awk '/cycles/ {print $1}')
+if [ "$base_cycles" == "<not" ]; then
+	echo "Skipping: cycles event not counted"
+	exit 2
+fi
 bpf_cycles=$(perf stat --no-big-num --bpf-counters -e cycles -- perf bench sched messaging -g 1 -l 100 -t 2>&1 | awk '/cycles/ {print $1}')
+if [ "$bpf_cycles" == "<not" ]; then
+	echo "Failed: cycles not counted with --bpf-counters"
+	exit 1
+fi
 
 compare_number $base_cycles $bpf_cycles
 exit 0
-- 
2.32.0.288.g62a8d224e6-goog

