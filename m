Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9FA2305E9
	for <lists+bpf@lfdr.de>; Tue, 28 Jul 2020 10:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbgG1I6A (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Jul 2020 04:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728362AbgG1I5n (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Jul 2020 04:57:43 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11375C0619D4
        for <bpf@vger.kernel.org>; Tue, 28 Jul 2020 01:57:43 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id 1so13529009qkm.19
        for <bpf@vger.kernel.org>; Tue, 28 Jul 2020 01:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=q3XkGvkSp73lf1KyQuDb99nbGEDl/ReSCh9uyduGkdU=;
        b=qXtWjiaX/X6jEvENfZzMiQ6bR2rwgKrF5oawDZFJvh7JYW6DBI6Q5Leoj87XZUrx1Z
         6+tP83e7P1y1/U/iBST/jiMqIfqw94WXHOB/tDJL9XsjwP1M7e9L+rPIBNm4/5DFh4H7
         Q96VMUzyaKqGnMQT+urC/PqUrZg0qEs9KXJ3ZHKQfk375qNKjDrVJNSgQ9F+P+i79MWQ
         REGmPxyqHZ+W1PgAVmEsDjrwoi/V8XFNH2ZEh9Bh8li641FJxE3mr7VM6sNv4caeqH+D
         kmIj/EtUe0XInSOR+HaRxRHQj6vvDZvKXIcirg4Qhr/NU9RYMumF5lG20sdyQEgmsYjt
         Vw4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=q3XkGvkSp73lf1KyQuDb99nbGEDl/ReSCh9uyduGkdU=;
        b=B3rA37nbxuGqQHONI6ZjDqcE/xJfQQ3z3hBV3TbNPnGr52G1buMmQEtchaO+pMV4y2
         rMM36EN2aSS7QgWdRUDeGjCh7ZdW+99Fkfr8rC9iWr2s3wWwi9HHXKxOrYqBbMnCjxm2
         XbSVOVyHak7nk0zWnb6q/UvgJ/Pf2csN81v42LfjSwGflNYchEZpcNxXL60VtoCKS8tu
         u+oxuzkRpPO0M6inQoUOvl/W32ngvSJywNecKOQSOwJjAZfq7Jc9FRVDnZ0cHukpDUwV
         yCLoe9oTRulC1pvNiLvkZJyoO2ZPxZD8gR3vgZWbhY3fjbKjfbE8J0WmfhsXl2IpKNdg
         RS0Q==
X-Gm-Message-State: AOAM531IQBmg1SxFAzsDmiDMXt1A4tvu0L0ou79y5rnergktj2KxVdz7
        tbG8TPRkp9G0HZxBdb5RWsX2b/AR2I9q
X-Google-Smtp-Source: ABdhPJx+iEtRDw+ObO5QJWeLCfNTNad7nt4l5nFw31VuVCSw5kTb0RhobnC7LyOnVY3dXLgBgQ+3uho2FoTI
X-Received: by 2002:a0c:c60b:: with SMTP id v11mr1006575qvi.122.1595926662092;
 Tue, 28 Jul 2020 01:57:42 -0700 (PDT)
Date:   Tue, 28 Jul 2020 01:57:32 -0700
In-Reply-To: <20200728085734.609930-1-irogers@google.com>
Message-Id: <20200728085734.609930-4-irogers@google.com>
Mime-Version: 1.0
References: <20200728085734.609930-1-irogers@google.com>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH v2 3/5] perf test: Ensure sample_period is set libpfm4 events
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
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Test that a command line option doesn't override the period set on a
libpfm4 event.
Without libpfm4 test passes as unsupported.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/attr/README                 | 1 +
 tools/perf/tests/attr/test-record-pfm-period | 9 +++++++++
 2 files changed, 10 insertions(+)
 create mode 100644 tools/perf/tests/attr/test-record-pfm-period

diff --git a/tools/perf/tests/attr/README b/tools/perf/tests/attr/README
index 430024f618f1..6cd408108595 100644
--- a/tools/perf/tests/attr/README
+++ b/tools/perf/tests/attr/README
@@ -53,6 +53,7 @@ Following tests are defined (with perf commands):
   perf record -i kill                           (test-record-no-inherit)
   perf record -n kill                           (test-record-no-samples)
   perf record -c 100 -P kill                    (test-record-period)
+  perf record -c 1 --pfm-events=cycles:period=2 (test-record-pfm-period)
   perf record -R kill                           (test-record-raw)
   perf stat -e cycles kill                      (test-stat-basic)
   perf stat kill                                (test-stat-default)
diff --git a/tools/perf/tests/attr/test-record-pfm-period b/tools/perf/tests/attr/test-record-pfm-period
new file mode 100644
index 000000000000..368f5b814094
--- /dev/null
+++ b/tools/perf/tests/attr/test-record-pfm-period
@@ -0,0 +1,9 @@
+[config]
+command = record
+args    = --no-bpf-event -c 10000 --pfm-events=cycles:period=77777 kill >/dev/null 2>&1
+ret     = 1
+
+[event:base-record]
+sample_period=77777
+sample_type=7
+freq=0
-- 
2.28.0.163.g6104cc2f0b6-goog

