Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48FC91AD2B1
	for <lists+bpf@lfdr.de>; Fri, 17 Apr 2020 00:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbgDPWPq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Apr 2020 18:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728778AbgDPWPN (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 16 Apr 2020 18:15:13 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D18FC061A0C
        for <bpf@vger.kernel.org>; Thu, 16 Apr 2020 15:15:13 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 62so4523433pgh.5
        for <bpf@vger.kernel.org>; Thu, 16 Apr 2020 15:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=a6tQ7DnVmCoPtEQQNpyDptK3byF4qMP4x4cRpQx2XV4=;
        b=VSpuvb+QoQf9QGJO/bKkb6a0mMCT1c3qTQfqf3ZY85vjlilCuSXENOmeQHb62koM9w
         XbeY0yOTY99mBk2z8OYdIwryXikTZYnpqid/PoniY/ODL3f752x75QbCGFJP/uOO4Q6I
         H+Wn9lzayNhLqbP+JKr9O4A76GE6/GwcYAyu3QAIHZVIOuGle7F+ed9VytOMVZWkQZLt
         Y7OyGpM5qn5aKjI3NIpX2F4PF+N5jwGswsfjHTZjAnY0rSaRg+8XF7lLkLtXIwOHe29o
         FM731+xhUXrdyelizdVpWsBZ60c6tfI3OcnmpeOQQXrQNfcR5OCsxtaizgyQmbo/Fk+6
         GeQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=a6tQ7DnVmCoPtEQQNpyDptK3byF4qMP4x4cRpQx2XV4=;
        b=I9289xJMlNtu/VAx40owIltNM405VLNf4vi+aeLCdeUeB0ytF5R4of64haW+1AIogU
         cnC3kIjZXTQATwP2yrTfnrtZRZ1d04BDIEE73zJ2OFY2EzdWgF1XFz2iaI1DEAdNOh+A
         /s0ntyjEsdMYhIB4rApVqyJTfIYtdLJdzShD2rI4kQbsLcijV5yb+eY62zYX286nEKAd
         J3jFGXOZltW4mBrEj92pF1TXbou9Tc2Oe3x6Grs18DNVDgr8kDWzsXyltoCqPo/ikNxc
         pfRAmsEvOS6lvVsqAxz2jb2WZ4EM2WRO5RvZXDY2FjB9WJFbADRF9eftKHH8lTmlMRIB
         Cwkw==
X-Gm-Message-State: AGi0PuaUXvo1PBua7DJ8F/e30ZaniRr381nhR6Wc/LsYJob24nttvcq4
        Gv/fgZWQyrBBG0fObg9YkydB9BfJrXqa
X-Google-Smtp-Source: APiQypIDOMildhMQgDP32zuTFSthoR2gRh2sx0VRQzNoI4pCDN4T3ENCpQgvTfArzjKf2QHi410X4TPtHJKc
X-Received: by 2002:a17:90a:f689:: with SMTP id cl9mr596069pjb.43.1587075312472;
 Thu, 16 Apr 2020 15:15:12 -0700 (PDT)
Date:   Thu, 16 Apr 2020 15:14:56 -0700
In-Reply-To: <20200416221457.46710-1-irogers@google.com>
Message-Id: <20200416221457.46710-4-irogers@google.com>
Mime-Version: 1.0
References: <20200416221457.46710-1-irogers@google.com>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
Subject: [PATCH v11 3/4] perf pmu: add perf_pmu__find_by_type helper
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
2.26.1.301.g55bc3eb7cb9-goog

