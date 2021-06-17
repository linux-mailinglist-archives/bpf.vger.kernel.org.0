Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F20413ABBFB
	for <lists+bpf@lfdr.de>; Thu, 17 Jun 2021 20:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233086AbhFQSor (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Jun 2021 14:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233284AbhFQSop (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Jun 2021 14:44:45 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65956C061574
        for <bpf@vger.kernel.org>; Thu, 17 Jun 2021 11:42:34 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id x4-20020a3763040000b02903ab95237c25so2912574qkb.0
        for <bpf@vger.kernel.org>; Thu, 17 Jun 2021 11:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=P2HhH8guhta86S5605kqN5Fpf4VPJ3qSwUq040gmRik=;
        b=RnWQmXgJd+ZC16mQntBSthlxeSP5ca9Ii4s+Yhqyatut7+iaz9MqeF+t2ipQxypPwj
         wHNg1IIfJUC/s69tD3+GRzAEtY21jdDJTBi/HG4C4Ey3c1zSHdb0ZJjzeL88Gs8GZboY
         QDx8rO81Ic2V+Bql6lvvtpqXPZ2GzZsZ5tiyPu05NDejj5P8dBzcOTTAq918VWdV8XpG
         sjkwP5F1atnfmddHdtQ82gedkNMTCnQQMA32vPRmsEPfJmVONsb3Tnno+BPuyu+DeljG
         hiiz/9TJdzR4fpMhOfk75uA6oppsI4MQy8PCf0yzeM7hoq8RfXzehYUuOE/mMzgLAzU5
         l/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=P2HhH8guhta86S5605kqN5Fpf4VPJ3qSwUq040gmRik=;
        b=OL9l1lvLIx+G+hcEdSMXvJONKRs42gkMqv4JeTOE+dF89ymnzsVTk6SK+ESLr9a3eS
         vd2JRef6WNFssw1mHzUO+nJRSwNPvyv/sq+62mrjc8w6pxk/C3XZYGGQ6ywt6w1bCIGH
         O4EGHwoYHTfjG843KK/p7DOcrh/ttzu4gFytFe71B5/IkV+jmncNkmOxhzfuqhP5dohk
         jPD67quV6awId9LZEXVF+C07QOFi+IxxDthAqYQ88qja5dGL+ceiMk/eI/+gJKEjTeuy
         7O4d+JAEa+muC4KO+LpTn8fK+AsNB+6OhjcltEnR+th6ypX7Z/EWXhAphwdyAlOeOtYZ
         9yEQ==
X-Gm-Message-State: AOAM531EKYTUyEDo6+k6jDo+bw5BRrrilvcXQLO/mEWo/kb/lNJwLjGB
        yctG9dg4iWz+eplHso74zMIZc/rWOpDc
X-Google-Smtp-Source: ABdhPJzpOiTvkOQp/eLCOVbVooNjGST6jvV4yRj+qNFTjDSTcCx78tUUwFs1zh4lcm2s9a1yti7ljdeVtC/I
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:ef90:beff:e92f:7ce0])
 (user=irogers job=sendgmr) by 2002:a25:be44:: with SMTP id
 d4mr8061096ybm.497.1623955353529; Thu, 17 Jun 2021 11:42:33 -0700 (PDT)
Date:   Thu, 17 Jun 2021 11:42:15 -0700
In-Reply-To: <20210617184216.2075588-1-irogers@google.com>
Message-Id: <20210617184216.2075588-3-irogers@google.com>
Mime-Version: 1.0
References: <20210617184216.2075588-1-irogers@google.com>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: [PATCH 3/4] perf test: Add verbose skip output for bpf counters
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

Provide additional context for when the stat bpf counters test skips.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat_bpf_counters.sh | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/stat_bpf_counters.sh b/tools/perf/tests/shell/stat_bpf_counters.sh
index 2f9948b3d943..81d61b6e1208 100755
--- a/tools/perf/tests/shell/stat_bpf_counters.sh
+++ b/tools/perf/tests/shell/stat_bpf_counters.sh
@@ -22,7 +22,13 @@ compare_number()
 }
 
 # skip if --bpf-counters is not supported
-perf stat --bpf-counters true > /dev/null 2>&1 || exit 2
+if ! perf stat --bpf-counters true > /dev/null 2>&1; then
+	if [ "$1" == "-v" ]; then
+		echo "Skipping: --bpf-counters not supported"
+		perf --no-pager stat --bpf-counters true || true
+	fi
+	exit 2
+fi
 
 base_cycles=$(perf stat --no-big-num -e cycles -- perf bench sched messaging -g 1 -l 100 -t 2>&1 | awk '/cycles/ {print $1}')
 bpf_cycles=$(perf stat --no-big-num --bpf-counters -e cycles -- perf bench sched messaging -g 1 -l 100 -t 2>&1 | awk '/cycles/ {print $1}')
-- 
2.32.0.288.g62a8d224e6-goog

