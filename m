Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3B31C8491
	for <lists+bpf@lfdr.de>; Thu,  7 May 2020 10:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgEGIP3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 May 2020 04:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726963AbgEGIO4 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 7 May 2020 04:14:56 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FBDCC03C1A6
        for <bpf@vger.kernel.org>; Thu,  7 May 2020 01:14:56 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id z1so2298187ybm.5
        for <bpf@vger.kernel.org>; Thu, 07 May 2020 01:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=sCS1jCtEUZLDql23q/lHeTg7GUDYj0iuw701FY6e4C0=;
        b=C0QKxnSqdHFtz+CRo7QjFhWvM+7DIxxGWsQCgCGoSuiM3h1SDPz51ol74GRCagamPW
         qAchUF2n+Y/Hkowd9VnNJrdCr4lG4ojkGNIwq/Eey7FH7rxTKFP0AYXo5KfGknbp7inX
         2GGmmJTDE+IgTwAANhMOTeEN50LnMXxDa5hDg5V9DtZ6natb6jRn7PO6iL+gdflLUMvj
         coH6tmWUtDoXULSlSCANtWXnFkWCYHftdAErvKRFp9/BD65Qzd1AQvyt0W+mnxsWe6Ni
         d/DRWZ/xg5XvpPK+vI7kpbPa0uKyFXuUt6XNTND4u90+Dpziz50xA2VvjFTHoaeO/syH
         d8xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sCS1jCtEUZLDql23q/lHeTg7GUDYj0iuw701FY6e4C0=;
        b=negZcobTreFy6qw9iYin3cSwSsZx5TfMNx7AeWDbHNib1ct8OZxnBOR/QTh6MCQVjx
         7kOY7yW9bH7nIwzXOB5jdBZ4It9EuzokG1yD5w8/FRjcXhOHxXujBUwJxEcvQ/FFfJwT
         D/WynvokRP+zr2y5QTGaq4YF3jL/tLRhFsQxyRo0GaKpko5Wmzp2UFRipRdaraPnwy3u
         vtIz7J19inFbIR3MYOqY0wXNkwEXWVmmpV39JMpR/9w495W7zQ/2FxWOoNCYqdAtsCzJ
         zsM0kLzx5CKYi2G3by5VvKK7wneUoA1wLMwz/KlApseb/Vf0O6UG+3KhPAzfL0pc4vtv
         PD3g==
X-Gm-Message-State: AGi0PuZ6hDwgoVYaq+x25+flogpHhx4Ytv0lqQObrupykd65yT2a7n1T
        kBen0/FePk43lQgWzz6KGv9jGhWeVbhk
X-Google-Smtp-Source: APiQypLicba0n1ZdHNM4nUUa5fD9wGJNUt+gST4Snsmj66XJ33XVpsWiBgB9Bu5FTvpXabk08ynYTGT40AjW
X-Received: by 2002:a25:2544:: with SMTP id l65mr18343110ybl.155.1588839295435;
 Thu, 07 May 2020 01:14:55 -0700 (PDT)
Date:   Thu,  7 May 2020 01:14:33 -0700
In-Reply-To: <20200507081436.49071-1-irogers@google.com>
Message-Id: <20200507081436.49071-5-irogers@google.com>
Mime-Version: 1.0
References: <20200507081436.49071-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [RFC PATCH 4/7] perf metricgroup: always place duration_time last
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

