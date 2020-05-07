Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 369271C8DE4
	for <lists+bpf@lfdr.de>; Thu,  7 May 2020 16:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbgEGOJs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 May 2020 10:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbgEGOJF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 May 2020 10:09:05 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F68C05BD16
        for <bpf@vger.kernel.org>; Thu,  7 May 2020 07:09:03 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id q57so7299314qte.3
        for <bpf@vger.kernel.org>; Thu, 07 May 2020 07:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=sCS1jCtEUZLDql23q/lHeTg7GUDYj0iuw701FY6e4C0=;
        b=qftf80dqY2OXb3xONvddbfejzztaLTIjQEIwPKcM6ty5NoFp+S0rNSk4kKOzA7ZEYy
         iWsbeqBvLRmjyugkJ6q/uTvgAPpyhStAcT+/iKqo4IIkfWCvQG9cPYB/o6Hny2LiMhRS
         XKgiUYWbcGhqKNs8rwh7NrOxVx52tGj8ZiHE5rlHy7vi6Xw22t3hLYi/xW5htypWnahh
         +rrJDNYr3peJ3FkroPEHttaLXJJ4P9FEnNFMIk8Edr78k6xohiY+Oz/cGsO+8YX4e39y
         OFvcdnfqEGMqf8sT8dQahr0FzrEKxal+eqWfJvT807dcBZwOl+AS1TxYf8fJ/lPkJNqf
         UCOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sCS1jCtEUZLDql23q/lHeTg7GUDYj0iuw701FY6e4C0=;
        b=VbNrQ/ByjKu+dJMhRV4yqHPx4pemq+/DxogsrzLNZuGf1EXV+YPhuqJODjCG0GxbaX
         JlEJnCXUx816/68JTHoPeglfDhSl60EaZX5Whw5ti/EW/N4V6XQcQ0sS7kN7ew7jI6+2
         hYYVlBk3upmzjVzZnfOoi9KwVjKe7kJvGFiLHNMfBXv81+NzQ7fACpcO+et2U8QP1IVd
         jUnaPUp+vg5BkxxH3sLhOrOQ/4H4QZhk2Bwirrpt+LVfD+EuOusRYLoH35NA8aofeSPy
         V1DIR6lglmz0PvOsQZz/1OW+RgloFAjVwHnjqEDTWGiScRQMGA/vIyvPQLHMFurXlM4u
         LFpA==
X-Gm-Message-State: AGi0PuaH9iHU7dzXA84wx88qfa3bidDZnoprZQZp2u6SYfBKEJDKEO/x
        DxHlTf/9Svvstu5XdG3cxIk1hW2uWjhY
X-Google-Smtp-Source: APiQypIVs1B8xC7PMmjnevHbOmOMRAmBnKmkx6u4qCCQevmlbcqOwlqULz1G9bUo7lrQ3XUBv0tl1j46ihsA
X-Received: by 2002:ad4:4d06:: with SMTP id l6mr13819775qvl.34.1588860543022;
 Thu, 07 May 2020 07:09:03 -0700 (PDT)
Date:   Thu,  7 May 2020 07:08:16 -0700
In-Reply-To: <20200507140819.126960-1-irogers@google.com>
Message-Id: <20200507140819.126960-21-irogers@google.com>
Mime-Version: 1.0
References: <20200507140819.126960-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [RFC PATCH v2 20/23] perf metricgroup: always place duration_time last
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

If a metric contains the duration_time event then the event is placed
outside of the metric's group of events. Rather than split the group,
make it so the duration_time is immediately after the group.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/metricgroup.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 2356dda92a07..48d0143b4b0c 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -421,8 +421,8 @@ static void metricgroup__add_metric_weak_group(struct strbuf *events,
 					       struct expr_parse_ctx *ctx)
 {
 	struct hashmap_entry *cur;
-	size_t bkt, i = 0;
-	bool no_group = false;
+	size_t bkt;
+	bool no_group = true, has_duration = false;
 
 	hashmap__for_each_entry((&ctx->ids), cur, bkt) {
 		pr_debug("found event %s\n", (const char*)cur->key);
@@ -432,20 +432,20 @@ static void metricgroup__add_metric_weak_group(struct strbuf *events,
 		 * group.
 		 */
 		if (!strcmp(cur->key, "duration_time")) {
-			if (i > 0)
-				strbuf_addf(events, "}:W,");
-			strbuf_addf(events, "duration_time");
-			no_group = true;
+			has_duration = true;
 			continue;
 		}
 		strbuf_addf(events, "%s%s",
-			i == 0 || no_group ? "{" : ",",
+			no_group ? "{" : ",",
 			(const char*)cur->key);
 		no_group = false;
-		i++;
 	}
-	if (!no_group)
-		strbuf_addf(events, "}:W");
+	if (!no_group) {
+                strbuf_addf(events, "}:W");
+		if (has_duration)
+			strbuf_addf(events, ",duration_time");
+	} else if (has_duration)
+		strbuf_addf(events, "duration_time");
 }
 
 static void metricgroup__add_metric_non_group(struct strbuf *events,
-- 
2.26.2.526.g744177e7f7-goog

