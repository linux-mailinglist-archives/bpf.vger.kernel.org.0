Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5D11BFDFB
	for <lists+bpf@lfdr.de>; Thu, 30 Apr 2020 16:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbgD3OYa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Apr 2020 10:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728159AbgD3OY3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Apr 2020 10:24:29 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B0BC08ED7D
        for <bpf@vger.kernel.org>; Thu, 30 Apr 2020 07:24:29 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id i13so7785030ybl.13
        for <bpf@vger.kernel.org>; Thu, 30 Apr 2020 07:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=DpLe2/yxlpy0aFc7LjjFR8EhmIvjlgt7hqTB0OaUzqw=;
        b=nTwgcui2CiV0+/Jpql/konVUDAJxIwSvypifzKGqEa5N2zt4MIbFjb1mAn7/qwLihf
         vu0iHY6F0lUJ/lpzYGDHglar1oftRe5QKFNt+SxbDedcCmm3YwssWXQMsdKVrr1yW/L0
         hbh2CMDDfsfgS8wpd1ItOELZ2zX2gZZfj9jv7hfUNZD/Cc3RQHB8NT+5HAVgLV5wmXhh
         KUN8zSWgRRWlB4hEaPTS+sqCnIBgbPDRp47GrFog6FH1+9HvnApAy15WlVS+opecoFkk
         JN0c9NKlKH12GdzFIkaOkli7Zj9XnFSyHT2bAMW34rF9aCYVPepdqiv+fA60MYvdLQ0C
         bpWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DpLe2/yxlpy0aFc7LjjFR8EhmIvjlgt7hqTB0OaUzqw=;
        b=S1HJ55pPhoEKKh90Ek4a44f/jq9tUOTPLm6Vl7CoBJdJYoKOPvaA4wZVOutBVT75Mz
         tu6gvzK9Pq+/+0SXsuQJZqZ+5+osPojxjn+FETFVx/5KTiGcgqbgPoSEv//7i3xmzZsc
         LkNe3WzDYDwNoTur5Uc1ATM9+6qY7KhiE5ZT2fMDYaKRndSoiR39eOo910GMjXrbOqjb
         jc8ch+iP1BJngLwOpQ5X1YHaAAvl7QlCWHjkz16BFHHYU2P4Io0Ft9EL/e2BCThqH7m7
         /uV11gaZejHNI95fzAajiz83IkobSP8r/LhgDLc5E4/qmFwgDJNPWgzfRRnvbp24AYmb
         8VRQ==
X-Gm-Message-State: AGi0PubZIWTBHH8K/o08zkLQlj+MEpZ9Q6JnY2l5CdxdfrQbG+1lSpO5
        bJ87MHfXAfZjeE/GOXqzACm49D0UEPid
X-Google-Smtp-Source: APiQypLSBWwmxXdbCXvEwu6BQZ0SdYLx5+Wv2iv/ATKlzHHRCUjvZTfhpTl6ZunjIVWUzi0myR4aFnFZeter
X-Received: by 2002:a25:9306:: with SMTP id f6mr5949447ybo.375.1588256668309;
 Thu, 30 Apr 2020 07:24:28 -0700 (PDT)
Date:   Thu, 30 Apr 2020 07:24:18 -0700
In-Reply-To: <20200430142419.252180-1-irogers@google.com>
Message-Id: <20200430142419.252180-4-irogers@google.com>
Mime-Version: 1.0
References: <20200430142419.252180-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH v13 3/4] perf pmu: add perf_pmu__find_by_type helper
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
index 5642de7f8be7..92bd7fafcce6 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -871,6 +871,17 @@ static struct perf_pmu *pmu_find(const char *name)
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
index 1edd214b75a5..cb6fbec50313 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -72,6 +72,7 @@ struct perf_pmu_alias {
 };
 
 struct perf_pmu *perf_pmu__find(const char *name);
+struct perf_pmu *perf_pmu__find_by_type(unsigned int type);
 int perf_pmu__config(struct perf_pmu *pmu, struct perf_event_attr *attr,
 		     struct list_head *head_terms,
 		     struct parse_events_error *error);
-- 
2.26.2.303.gf8c07b1a785-goog

