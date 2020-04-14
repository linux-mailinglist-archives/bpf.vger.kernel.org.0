Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9A4B1A88B5
	for <lists+bpf@lfdr.de>; Tue, 14 Apr 2020 20:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503508AbgDNSLa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Apr 2020 14:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2503482AbgDNSLJ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 14 Apr 2020 14:11:09 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E44C061A0F
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2020 11:11:07 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id a67so12555101qke.0
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2020 11:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zcExPUIjugAT8xV6VI04RQsiRvISnNIvuUHEvy30OPQ=;
        b=ZBJvjQZ7S0H7g7dGFOCFUEHvsaRcW9EiWMXBZ2djyZfTOihoQcg+OCkWR5O9DVKrLP
         7NOBkGjPs2OgzNHER/gXrnr2mU4MSkH0UZfjq+EKsykmrHo87H4VRLNAq//Ige5b8zuv
         RRBArhBoOTQRZykqIvq2ECJKsEIF/s2vK3hU+oDK+tncfAH1007l9mOg5gHlCVr6Kt9o
         2+ixDpZydTNpJ/uvIFmw6ETeWO9KZC0w7gaQIPYg8pcRcLesNw/MCqpOtcaIqGZvDEyI
         t293S67vHrq58vdb41c2eN1Y9/BQ4rv6cKFzNSQJMRv/exAN0bbLJTWDM4hL6ku7n6fc
         qJUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zcExPUIjugAT8xV6VI04RQsiRvISnNIvuUHEvy30OPQ=;
        b=k3vrtW3YhvEJGDlA3CtXbGLr7LHxaieDBIVI3SZBt2BHS0Tc23m4djf773JGBsAutI
         maaWdLmfREt6k+H5rImQjbKeISFj7Zulpb2ekudkz1whOFebQWzLvkiQKFHBcds+eW/0
         nOQcfjVq8BQae27snkwCLyJJXyt8xgZePzvOeJ/VvGbypBLsy23tuLE+4CJrrRjo/gjg
         0tXL1kJ3W84kRXLKwVuSoZIbwfzMwbCko/4NUjfOzuoSwj7PiTeBWNpzKk3KeB6Y2Cgc
         gPKSEN33I2lLhKdyyuo7DTJTkKxjx4cBN318mbVsOQBcS6NMPrVuzdCWTU08r/eX2PYr
         hB/w==
X-Gm-Message-State: AGi0PuYGy8IUlXo3GjQxwtwM5ApMF55pAMTrT29w4kg4iR51MnZr1ofy
        PYbMuRTfTTt3n4Yf+lxec+wL7TO0nHNS
X-Google-Smtp-Source: APiQypL7lljiWPR9gDt9kyZti8EWxbZqDY0GWqpVMgq3xEKyNJazIUclxhN3genl9KEXl5Vgs1UG+EYue0iV
X-Received: by 2002:a0c:fd8c:: with SMTP id p12mr1256220qvr.163.1586887866597;
 Tue, 14 Apr 2020 11:11:06 -0700 (PDT)
Date:   Tue, 14 Apr 2020 11:10:53 -0700
In-Reply-To: <20200414181054.22435-1-irogers@google.com>
Message-Id: <20200414181054.22435-4-irogers@google.com>
Mime-Version: 1.0
References: <20200414181054.22435-1-irogers@google.com>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
Subject: [PATCH v9 3/4] perf pmu: add perf_pmu__find_by_type helper
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
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Igor Lubashev <ilubashe@akamai.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jiwei Sun <jiwei.sun@windriver.com>,
        yuzhoujian <yuzhoujian@didichuxing.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Stephane Eranian <eranian@google.com>

This is used by libpfm4 during event parsing to locate the pmu for an
event.

Signed-off-by: Stephane Eranian <eranian@google.com>
Reviewed-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 11 +++++++++++
 tools/perf/util/pmu.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index ef6a63f3d386..5e918ca740c6 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -869,6 +869,17 @@ static struct perf_pmu *pmu_find(const char *name)
 	return NULL;
 }
 
+struct perf_pmu *perf_pmu__find_by_type(unsigned int type)
+{
+	struct perf_pmu *pmu;
+
+	list_for_each_entry(pmu, &pmus, list)
+		if (pmu->type == type)
+			return pmu;
+
+	return NULL;
+}
+
 struct perf_pmu *perf_pmu__scan(struct perf_pmu *pmu)
 {
 	/*
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 5fb3f16828df..de3b868d912c 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -65,6 +65,7 @@ struct perf_pmu_alias {
 };
 
 struct perf_pmu *perf_pmu__find(const char *name);
+struct perf_pmu *perf_pmu__find_by_type(unsigned int type);
 int perf_pmu__config(struct perf_pmu *pmu, struct perf_event_attr *attr,
 		     struct list_head *head_terms,
 		     struct parse_events_error *error);
-- 
2.26.0.110.g2183baf09c-goog

