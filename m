Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA17267756
	for <lists+bpf@lfdr.de>; Sat, 12 Sep 2020 04:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725821AbgILC5h (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Sep 2020 22:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbgILC5H (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Sep 2020 22:57:07 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F321DC06179B
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2020 19:57:05 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id a2so7114200qkg.19
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2020 19:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Xn4xTNQ0qrRVMBBl5RrCT8xh1AzgDEH+Hh8mfK+j8Yk=;
        b=QutX05kiuQW6lndX/80w/avnHkC238HxIrwzu3IbdbXxJWLTzWFGH+8HuOghrTpfmL
         wwMWkvBe7Yy/hZ4r7aoo8tHwu1/cwiClrGmQ39sjnyBnRofWi0Jx+Z5kGDfHKsk3hH/K
         67wm/P4PCyWexfp8iiNGJQiK8Db3xjMCeYmMYrR5/hqkLH8liQgOzqt/4vDGStUKf33L
         D8IZ3Bxu5S8BP1doX3H4M8TCHkFfOytpFo+cICv65DUFaSF+0SX5afX7dbDaAblcja9L
         oYXHBJRohnqUSLgSN1Pyh7Itvt/vCSOShGztNo0jyM43HxTcDOV/CbwHwouBZFXDx4jq
         a+XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Xn4xTNQ0qrRVMBBl5RrCT8xh1AzgDEH+Hh8mfK+j8Yk=;
        b=WkD7d4LF9cQNvVX+NN1PSuejgMEvIGuWmwKb8yGqkWeUWTTK9nS4/uxZzZwUKSq2Iq
         xesyou3YsqYPRvm1J8jTmnPx8jCDTINFutztT/Tti1hZhseuMLeNKlYjRXOut6DsnvIn
         GlMEFKtjc4b16EBzBWst0yssqV5pknN++H1FEZfPg93niqM9P6o5SXh5xxSn9zDRJ9Po
         qSD7DUuKigLp2AwEQW1IE5INd3+LIQIqCvKO6NTvroc+lrtdfP9Hy6Y27aHqmvVHwT6X
         g29Zuccsb4cjb8oN9c0c2oBEZF3IqQm/uRFqy4SO63pzEVVRkW9qGWU6OH5MvcouFmN/
         +1pg==
X-Gm-Message-State: AOAM530uI4zYr+QiSfj8fXP3sH8rY5oJ47irlLJz6nZsqMqQF3hF6w0D
        8/4RDo56QkPcH2a/3GC0zcnfkGnFp+64
X-Google-Smtp-Source: ABdhPJzjQi8hLV5O6tVcvN8UXIcPGAfrLlUvmEtGO53XDuBnmARnB4Tf2/XKdqB/W8CB8j6/ENen+FfOVP7F
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:f693:9fff:fef4:4583])
 (user=irogers job=sendgmr) by 2002:ad4:57a7:: with SMTP id
 g7mr4839251qvx.10.1599879424736; Fri, 11 Sep 2020 19:57:04 -0700 (PDT)
Date:   Fri, 11 Sep 2020 19:56:55 -0700
In-Reply-To: <20200912025655.1337192-1-irogers@google.com>
Message-Id: <20200912025655.1337192-5-irogers@google.com>
Mime-Version: 1.0
References: <20200912025655.1337192-1-irogers@google.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [PATCH v3 4/4] perf test: Leader sampling shouldn't clear sample period
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

Add test that a sibling with leader sampling doesn't have its period
cleared.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/attr/README             |  1 +
 tools/perf/tests/attr/test-record-group2 | 29 ++++++++++++++++++++++++
 2 files changed, 30 insertions(+)
 create mode 100644 tools/perf/tests/attr/test-record-group2

diff --git a/tools/perf/tests/attr/README b/tools/perf/tests/attr/README
index 6cd408108595..a36f49fb4dbe 100644
--- a/tools/perf/tests/attr/README
+++ b/tools/perf/tests/attr/README
@@ -49,6 +49,7 @@ Following tests are defined (with perf commands):
   perf record --call-graph fp kill              (test-record-graph-fp)
   perf record --group -e cycles,instructions kill (test-record-group)
   perf record -e '{cycles,instructions}' kill   (test-record-group1)
+  perf record -e '{cycles/period=1/,instructions/period=2/}:S' kill (test-record-group2)
   perf record -D kill                           (test-record-no-delay)
   perf record -i kill                           (test-record-no-inherit)
   perf record -n kill                           (test-record-no-samples)
diff --git a/tools/perf/tests/attr/test-record-group2 b/tools/perf/tests/attr/test-record-group2
new file mode 100644
index 000000000000..6b9f8d182ce1
--- /dev/null
+++ b/tools/perf/tests/attr/test-record-group2
@@ -0,0 +1,29 @@
+[config]
+command = record
+args    = --no-bpf-event -e '{cycles/period=1234000/,instructions/period=6789000/}:S' kill >/dev/null 2>&1
+ret     = 1
+
+[event-1:base-record]
+fd=1
+group_fd=-1
+config=0|1
+sample_period=1234000
+sample_type=87
+read_format=12
+inherit=0
+freq=0
+
+[event-2:base-record]
+fd=2
+group_fd=1
+config=0|1
+sample_period=6789000
+sample_type=87
+read_format=12
+disabled=0
+inherit=0
+mmap=0
+comm=0
+freq=0
+enable_on_exec=0
+task=0
-- 
2.28.0.618.gf4bc123cb7-goog

