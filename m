Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93C601DBCA6
	for <lists+bpf@lfdr.de>; Wed, 20 May 2020 20:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbgETSVB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 May 2020 14:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbgETSUa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 May 2020 14:20:30 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5839C05BD43
        for <bpf@vger.kernel.org>; Wed, 20 May 2020 11:20:28 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id y189so2646892ybc.14
        for <bpf@vger.kernel.org>; Wed, 20 May 2020 11:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wGTE29BsgrWmThr3Ae7vqwYEGfSpg6F0IAHZFs59Yr0=;
        b=BqrxCMwi98i1HwXU41vZdhF0qgF0kyjIMD1sY8wwJrYyMo2ScsVqgIB0vWqiuF6MA5
         D+D5pBEyhD7bLaBZxA8uP24t3Q0a1x750RottBh2pRXHRyTWBkMcFAs2C9J/kBfEVdyu
         nAnGVC7ARuETDVU5oYIXtcrG03KZQIRFld/4Q3pBhaIL08ZE3xM7Xilce+S2e9T5RcYO
         SHq1ZR6LZr7vxenQOc9nVBL38Q3VyUm2fUUxudtUXdhcCd6yMZF8Y/OMUeA3kW6Bufyi
         QpgpYFmuU6X6z4UJ8+Lb/y1JH3zhPigjBqmuXFX8FM10d+fELo3MQIiyLl2k7b6jTU3H
         CoIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wGTE29BsgrWmThr3Ae7vqwYEGfSpg6F0IAHZFs59Yr0=;
        b=NhOhLJnH6zm2JM9i/9cTKaycXrck7MMQAAuC3WNeDZrIBwu/RBcYhsT6rUrLGGySuU
         u/z8abIwJrR5OymsCAIBbkfJNOwhvShYeRinTvtqDd+eQ3eWikeE3QvHDMCTS3oa8tmt
         DvJ0mbYFWO5oXryzLZcveghzyimCMJy6HO/rUuN9YYMLIfQ9s+/XQS3J3TRBuWC0q3xp
         5QkAGz3dBfHEahvQmvFxVA9cV3y2/R23unYx8gW5YxqHLNb4eFHeV2LXh/m2YL6P26oH
         ZCQpUVirtyRdFkNmxthzLTunAqkbdHR8yUa8GEdK2f179B+6kmsIaEs+qZzUTPrbCjMU
         WxSQ==
X-Gm-Message-State: AOAM531oUZDUXLvihEpMLYxNpRbtRwCBuGPtbanoe9XfSxzcCmgtuWq5
        DYzY+epATtSeUzSid9VYF/le6hvdKhEC
X-Google-Smtp-Source: ABdhPJwzdQK/jWwCpO0ZVm1Kg2j9m8W4jwQAQLCGOfG7f3sAz59C9o8AjdQ1WP1XUcT7BdmkhPNemNU/qYOy
X-Received: by 2002:a25:9709:: with SMTP id d9mr8866827ybo.85.1589998827956;
 Wed, 20 May 2020 11:20:27 -0700 (PDT)
Date:   Wed, 20 May 2020 11:20:08 -0700
In-Reply-To: <20200520182011.32236-1-irogers@google.com>
Message-Id: <20200520182011.32236-5-irogers@google.com>
Mime-Version: 1.0
References: <20200520182011.32236-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH v2 4/7] perf metricgroup: Order event groups by size
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
index dca433520b92..bac63524d12f 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -508,7 +508,21 @@ static int __metricgroup__add_metric(struct list_head *group_list,
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
2.26.2.761.g0e0b3e54be-goog

