Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 020291C847D
	for <lists+bpf@lfdr.de>; Thu,  7 May 2020 10:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbgEGIPN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 May 2020 04:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727110AbgEGIPB (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 7 May 2020 04:15:01 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D40BC061A41
        for <bpf@vger.kernel.org>; Thu,  7 May 2020 01:15:00 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id ce16so5128115qvb.15
        for <bpf@vger.kernel.org>; Thu, 07 May 2020 01:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wdUpgcjdyvRHeAuiwINZJwatakpGlpcmPaMYucAxya4=;
        b=a1D0g4qgq2DeZVYxZXmwzJvFe80E+NY6Bl81ZXr1D2+xAl8ZNsS0+tJz9pxiOODZQE
         6pJFFiDn3fEWNQQ5lrrjMYapn6poOSYZtu6PN0DoTmMrD4O2LkXxmyYf4XoZdMLy2FDP
         kEmpHV/MX3b6DZcKXWZYgy29uupIcAuwPc/RJzfEZ/Rn1SypACWfGKtvagqouxnMc+Se
         fJp0uZhkxRe7LTOnqHzqpSKdGKl375V2yIAzJ1aw5aG8/v7YD4el/AuJZKSYXHgff9PO
         9695v/gBHe1pjJ7KY1yMmDhcIQNhKpQUkImim277Mw6mGWUzKGp3FctFIkMGsnx6HxE4
         2FcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wdUpgcjdyvRHeAuiwINZJwatakpGlpcmPaMYucAxya4=;
        b=ke7kFyMKMasxERTfsIqphcIe2XNucM/+ghUqvi59CPGx/YGHjVZJwnNCm4zofJyp6H
         y9xTsAMbLN0Q2OAnc8ZYe1MK7ItLiFlOzq79S3S102zCqvPhRDZB6Wi9mY894SdJJ8l7
         Xj00idulwK4uTuWRWq8qmLGdIN40m1T7c0e1JtGKmfaolCDMrWPIRg+Uhnf0Aq1osovy
         K0wee6VXwV4cvrvnfrtrhWmpWp+4zuxDwUO2B7SvcQEDvT8I7kfBKCOoKotaZ7/4MspI
         CwVZg0CICZh9oT3hh+He/NQ4W7ASkGzl0Vos1BWEKmeQAndMBJ9xIZeuWsgAphkGTVZ5
         /LkA==
X-Gm-Message-State: AGi0PuYLJVyEpaNIt9u6Irzr7fO56FhluLAZKVMV7TrR3Ov/9PpYGQnm
        cfV3eEm1c7RkacFSGmjLDalNExvpXEY/
X-Google-Smtp-Source: APiQypKfY5bUdzcKD5EFsOUTDzmIo6WlYY0MBP0ESNMa+3S6spMM1XtYeHvtMwk6ZY1SEl8iBwSWx7hYrFlz
X-Received: by 2002:ad4:4f01:: with SMTP id fb1mr12775550qvb.162.1588839299303;
 Thu, 07 May 2020 01:14:59 -0700 (PDT)
Date:   Thu,  7 May 2020 01:14:35 -0700
In-Reply-To: <20200507081436.49071-1-irogers@google.com>
Message-Id: <20200507081436.49071-7-irogers@google.com>
Mime-Version: 1.0
References: <20200507081436.49071-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [RFC PATCH 6/7] perf metricgroup: order event groups by size
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

When adding event groups to the group list, insert them in size order.
This performs an insertion sort on the group list. By placing the
largest groups at the front of the group list it is possible to see if a
larger group contains the same events as a later group. This can make
the later group redundant - it can reuse the events from the large group.
A later patch will add this sharing.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/metricgroup.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 0a00c0f87872..25e3e8df6b45 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -519,7 +519,21 @@ static int __metricgroup__add_metric(struct list_head *group_list,
 		return -EINVAL;
 	}
 
-	list_add_tail(&eg->nd, group_list);
+	if (list_empty(group_list))
+		list_add(&eg->nd, group_list);
+	else {
+		struct list_head *pos;
+
+		/* Place the largest groups at the front. */
+		list_for_each_prev(pos, group_list) {
+			struct egroup *old = list_entry(pos, struct egroup, nd);
+
+			if (hashmap__size(&eg->pctx.ids) <=
+			    hashmap__size(&old->pctx.ids))
+				break;
+		}
+		list_add(&eg->nd, pos);
+	}
 
 	return 0;
 }
-- 
2.26.2.526.g744177e7f7-goog

