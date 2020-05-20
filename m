Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 726251DBC9F
	for <lists+bpf@lfdr.de>; Wed, 20 May 2020 20:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgETSUZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 May 2020 14:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbgETSUY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 May 2020 14:20:24 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6EAC08C5C0
        for <bpf@vger.kernel.org>; Wed, 20 May 2020 11:20:23 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id y8so2624424ybn.20
        for <bpf@vger.kernel.org>; Wed, 20 May 2020 11:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=nbhZ9P8EBn/6lSfkuc6XkauJvve4e394c9GAeFVHVtc=;
        b=ERNLTMCuGSsUvR4ZHD8o4TPpu1gI33gfIaKtor2dYnBOBZxClZH50a1Bdpk2IPGVs+
         tXlIA7jzmJxUzjgCheueIraN9TURLzov08p/k//zxiFAiNcQNa2vBYaAVUQ57lPwnO86
         uwJZIah6SuXv499SbR3x/yw4rMGWJ54+gkDFogsSwsferCvHbgwr0c0cr0mdShlOhmhn
         DoAYOF2tMO/DNvBu3sXamvhLl6zt2csn2/j30OgADaKm6JUXRtXmMKhWUrjln4/sD0B5
         s8RiDK9bgKHShpj7yQCV0SLqaCWKIe31nTnN6r7Cam5XIB49yU7x2BtjUw9q0cMOVr3D
         lhGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nbhZ9P8EBn/6lSfkuc6XkauJvve4e394c9GAeFVHVtc=;
        b=PD88A7Pgy3QTVuMElJNdk4g7gFAbIJOso6oAB0zu+q47doQBPzemCdx/XLWFo4IGW5
         siRSnLroOjY/zduUEaPA45Mpj5AA6w2bK0wFdQ52N37I1Mw75XNIBdlhi050FlMYHtjY
         zIhZctT40XYHgLXDMfhI32CnAcXeEI2dxRWBnRo6kEFVP88RSGktRZb7vmgDdYeZX94X
         GGrBpmSKgW0rxdzgHNJGNFZdTEF2lflwKDaXz0xTztjwn+Q5jIwAz8JlDiHlpv7e8QAv
         bZeuXn2WEHn71qqKSzoAVwoD5361XeKDE4wew2uoUtyjEGhOLvpROB/qgB8sCw/5+44X
         0YGQ==
X-Gm-Message-State: AOAM533UhRSAIdJS6zwCRiHMG/T5Ek/Tze2nZ/Z6PDTNoW75oaqTViDZ
        jmW6ymGftJ7vuZkKARB4wgYdClVygzLl
X-Google-Smtp-Source: ABdhPJxJE4GhVQOLdNOx5d0k2G1puroT5shTBCTJfE0J9SPJmLN+vC0wuoq8WE06pQt8OCaNfvDYhI4Ph2jk
X-Received: by 2002:a25:3627:: with SMTP id d39mr5892945yba.278.1589998823002;
 Wed, 20 May 2020 11:20:23 -0700 (PDT)
Date:   Wed, 20 May 2020 11:20:06 -0700
In-Reply-To: <20200520182011.32236-1-irogers@google.com>
Message-Id: <20200520182011.32236-3-irogers@google.com>
Mime-Version: 1.0
References: <20200520182011.32236-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH v2 2/7] perf metricgroup: Use early return in add_metric
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Paul Clarke <pc@us.ibm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Vince Weaver <vincent.weaver@maine.edu>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Use early return in metricgroup__add_metric and try to make the intent
of the returns more intention revealing.

Suggested-by: Jiri Olsa <jolsa@redhat.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/metricgroup.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 7a43ee0a2e40..5c0603ef4c75 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -524,7 +524,8 @@ static int metricgroup__add_metric(const char *metric, struct strbuf *events,
 {
 	struct pmu_events_map *map = perf_pmu__find_map(NULL);
 	struct pmu_event *pe;
-	int i, ret = -EINVAL;
+	int i, ret;
+	bool has_match = false;
 
 	if (!map)
 		return 0;
@@ -532,17 +533,23 @@ static int metricgroup__add_metric(const char *metric, struct strbuf *events,
 	for (i = 0; ; i++) {
 		pe = &map->table[i];
 
-		if (!pe->name && !pe->metric_group && !pe->metric_name)
+		if (!pe->name && !pe->metric_group && !pe->metric_name) {
+			/* End of pmu events. */
+			if (!has_match)
+				return -EINVAL;
 			break;
+		}
 		if (!pe->metric_expr)
 			continue;
 		if (match_metric(pe->metric_group, metric) ||
 		    match_metric(pe->metric_name, metric)) {
-
+			has_match = true;
 			pr_debug("metric expr %s for %s\n", pe->metric_expr, pe->metric_name);
 
 			if (!strstr(pe->metric_expr, "?")) {
 				ret = __metricgroup__add_metric(events, group_list, pe, 1);
+				if (ret)
+					return ret;
 			} else {
 				int j, count;
 
@@ -553,14 +560,15 @@ static int metricgroup__add_metric(const char *metric, struct strbuf *events,
 				 * those events to group_list.
 				 */
 
-				for (j = 0; j < count; j++)
+				for (j = 0; j < count; j++) {
 					ret = __metricgroup__add_metric(events, group_list, pe, j);
+					if (ret)
+						return ret;
+				}
 			}
-			if (ret == -ENOMEM)
-				break;
 		}
 	}
-	return ret;
+	return 0;
 }
 
 static int metricgroup__add_metric_list(const char *list, struct strbuf *events,
-- 
2.26.2.761.g0e0b3e54be-goog

