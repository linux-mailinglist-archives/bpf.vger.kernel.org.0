Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98C7E1C8498
	for <lists+bpf@lfdr.de>; Thu,  7 May 2020 10:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgEGIQB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 May 2020 04:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725809AbgEGIOx (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 7 May 2020 04:14:53 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A784C03C1A6
        for <bpf@vger.kernel.org>; Thu,  7 May 2020 01:14:52 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id i62so6056047ybc.11
        for <bpf@vger.kernel.org>; Thu, 07 May 2020 01:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4jAiujVPIH0XWZpTZgSL+DGkUTq2TxINaqAiEYunye0=;
        b=U7wRbdfzR+TPabVXRkSFeJE9tthG2dbucEQJlAe7mIkrJqQjNyRHem0kHXtghq8bnr
         D5W15KCkFJS8JPclkWuahr8m2Or7W3s1CRJK6fwG+ha+JsvVJK6oHhAhhaQ+53kgckBX
         jo0+hIoMrvB++vfIC/LRimiKx41T5K6kdLlQi0AWa4ykCIJCFJGXa2NhsIC7LoB8wikT
         jx/5iUJ6bIJ/75C1HiSa2uzwXOvqkOW/tLz/fSHRtA0uk/PJ/11XwFNOGH3bgv3gXs3n
         B+2rSOwVUo+gQoTo/Rh8zPvAp6P9EVr9PTU9s/+KCG4AAgfUVIvxV30NhAkerMPUB5+/
         02Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4jAiujVPIH0XWZpTZgSL+DGkUTq2TxINaqAiEYunye0=;
        b=AOsLkL7JL7X6NIze0t45MLTDXB+cU5BiQYZPt7vtveUakNa7YbOu7e1MMNtWDGmZJl
         8uA5YHL47F+5nf3tBC+EtDTS/8LaO/FH+Z01pV9IW2gmsNPRj3gTnQJV/n75qiXogSBB
         m5U8DMYmSianjBBtJ4xNh4ZZ9qKH4W1BueaWV3RyEyu7wBfy98rXSDSs9cdvMgDCr9qY
         3wn1FraOhgajBVtoyi8pQdly5SOC4V2aPPXa+IQG1Q/n3AIFIXT+FVK15O0BQJhcFPk5
         zjYpYPHNpsr52VjDFpMA9sqXEzzJL29/czpcr+qKTuCij48L3FWOPxXeQnIG2c3H2BsZ
         pw3Q==
X-Gm-Message-State: AGi0PubZfe513b10eg5AxfTo+2qlzqOODuXFl3vugsx6LcUZnaagNDEc
        ez9E2DOIRgtKWLTBh+S01WppH733cKae
X-Google-Smtp-Source: APiQypKwLkD+uB2It9ZWT/f91/xVIyTeXDlbilbCRc/Jf9xhtrEOmeGyY8IG713wAfAF70bC8hWyMwFCX2YI
X-Received: by 2002:a25:6f56:: with SMTP id k83mr20697937ybc.248.1588839291471;
 Thu, 07 May 2020 01:14:51 -0700 (PDT)
Date:   Thu,  7 May 2020 01:14:31 -0700
In-Reply-To: <20200507081436.49071-1-irogers@google.com>
Message-Id: <20200507081436.49071-3-irogers@google.com>
Mime-Version: 1.0
References: <20200507081436.49071-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [RFC PATCH 2/7] perf metricgroup: change evlist_used to a bitmap
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

Use a bitmap rather than an array of bools.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/metricgroup.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 2f92dbc05226..dcd175c05872 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -95,7 +95,7 @@ struct egroup {
 static struct evsel *find_evsel_group(struct evlist *perf_evlist,
 				      struct expr_parse_ctx *pctx,
 				      struct evsel **metric_events,
-				      bool *evlist_used)
+				      unsigned long *evlist_used)
 {
 	struct evsel *ev;
 	bool leader_found;
@@ -105,7 +105,7 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
 	double *val_ptr;
 
 	evlist__for_each_entry (perf_evlist, ev) {
-		if (evlist_used[j++])
+		if (test_bit(j++, evlist_used))
 			continue;
 		if (hashmap__find(&pctx->ids, ev->name, (void**)&val_ptr)) {
 			if (!metric_events[i])
@@ -149,7 +149,7 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
 			j++;
 		}
 		ev = metric_events[i];
-		evlist_used[ev->idx] = true;
+		set_bit(ev->idx, evlist_used);
 	}
 
 	return metric_events[0];
@@ -165,13 +165,11 @@ static int metricgroup__setup_events(struct list_head *groups,
 	int ret = 0;
 	struct egroup *eg;
 	struct evsel *evsel;
-	bool *evlist_used;
+	unsigned long *evlist_used;
 
-	evlist_used = calloc(perf_evlist->core.nr_entries, sizeof(bool));
-	if (!evlist_used) {
-		ret = -ENOMEM;
-		return ret;
-	}
+	evlist_used = bitmap_alloc(perf_evlist->core.nr_entries);
+	if (!evlist_used)
+		return -ENOMEM;
 
 	list_for_each_entry (eg, groups, nd) {
 		struct evsel **metric_events;
@@ -209,7 +207,7 @@ static int metricgroup__setup_events(struct list_head *groups,
 		list_add(&expr->nd, &me->head);
 	}
 
-	free(evlist_used);
+	bitmap_free(evlist_used);
 
 	return ret;
 }
-- 
2.26.2.526.g744177e7f7-goog

