Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21B591C8DCE
	for <lists+bpf@lfdr.de>; Thu,  7 May 2020 16:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbgEGOJG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 May 2020 10:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728290AbgEGOJB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 May 2020 10:09:01 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6047FC05BD0C
        for <bpf@vger.kernel.org>; Thu,  7 May 2020 07:09:00 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id f56so6859080qte.18
        for <bpf@vger.kernel.org>; Thu, 07 May 2020 07:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4jAiujVPIH0XWZpTZgSL+DGkUTq2TxINaqAiEYunye0=;
        b=OWjt0cmmDJtrLcHfOyx07Pd7ZWS1bTL7QtJqX9WIcFChAEZPOaNzMYdlSVT526pV0o
         yZdsnzJCDchwGOSakJU0J+2seLJ1mkdouix6YDtOQvbUQ4kYETtyOgJ5wVS6a3GFzb5T
         mR57ppTz6YgZK4PhDDj6e0NCA0dA+3iGztRk+UZbeJ8WpbEtc67qTQzY+GCVGUSQRZ+T
         BhEMxczZAvt4ehmDa9XSgIoG+vwPnJaGoYi4/+UOSfRRAV3FNyEe5ZsXElCFEY+6r/hF
         xJMUQMBoiqmmCFG1ARULmxmZTb/RUAj/Xi+Fe/K5ySD+tIOhL8nLeVhyoCNxXlwGevOA
         /Z7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4jAiujVPIH0XWZpTZgSL+DGkUTq2TxINaqAiEYunye0=;
        b=chIFgh1BVOUX0yPjuHKgKZGQFuvTy2rENQbZzRCCrbC4+mlA+Oo4GufdYswYvlqZL/
         RQz9c+LPpuYIKyvtzWsIMeBIKu1BkmhpR5ZGVCD5YUYO3lbfSYfKD99yziZcwHw2qRyr
         yTJ9SdzDGU9/kncRESNkVLPEEC26CMe+0V7K/RoYu+go/L3Ttz1unMul7teXPh4pcPk3
         j9is+WlgL5i+GeZwmNF0ktCypu181BKHbGu+1o+dGuEO7/IiH3aEdgpfQcSxx1e03NGH
         O+gA/El2aI1klG+E+AKuKIXVg0C7LGG3y0QzxelgspgfPiYZ/6xF9Tdr7deoFT9GOc5p
         DoMA==
X-Gm-Message-State: AGi0PuZanpl/lCcBD4UjCKkQ7GKIorGTdwC7ljUi8eLdX49X3SY+Dzz4
        jNqVxfwsW2miQ3FU720l4iFyrIEjWGp4
X-Google-Smtp-Source: APiQypJynXo+2GQgY/FhVJpSh9Npi2Q9Ujr/+Qm0xSxEm4rmqQMP45NuYZEi2MjxUe9HRfDru9P5mWgx13f3
X-Received: by 2002:a05:6214:1812:: with SMTP id o18mr13705387qvw.64.1588860539386;
 Thu, 07 May 2020 07:08:59 -0700 (PDT)
Date:   Thu,  7 May 2020 07:08:14 -0700
In-Reply-To: <20200507140819.126960-1-irogers@google.com>
Message-Id: <20200507140819.126960-19-irogers@google.com>
Mime-Version: 1.0
References: <20200507140819.126960-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [RFC PATCH v2 18/23] perf metricgroup: change evlist_used to a bitmap
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

