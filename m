Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 544181DAC16
	for <lists+bpf@lfdr.de>; Wed, 20 May 2020 09:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgETH3C (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 May 2020 03:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbgETH2b (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 May 2020 03:28:31 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D68C061A0E
        for <bpf@vger.kernel.org>; Wed, 20 May 2020 00:28:31 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id y189so1014262ybc.14
        for <bpf@vger.kernel.org>; Wed, 20 May 2020 00:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LKKy4EOgcjxJnFjWUFUBMKy8IeFiRStXwAEvj/pKQVw=;
        b=CEYhJcwg0f4hgHy2KLu81eyGz7ACAd9la5BDRLXj9Lvo+9VU0bpSkYhmftvVnSkJXa
         Z6xsHILnqtSr1rxriSmbEBdrTHp1WBRBQkbupoV+zq7OWb+2kqcgXkHEeQ8bNv+5VrvN
         /RyrbVpaFiVYvIYl/BBnzpupmA9j+ADQLD8ggT1EJHRF/1DCJk9axgJN/oMS2laBy/cZ
         wjeFpNcv4tf5YCwIRCLAtNbNP1UXdqsa3LlDjI4CDOXp/zjXXmBD+jWQTta/WtNzR+Zs
         eLlxtYkZna6h6KeDoC+jsO7PPZLGTbNtgELVQi+f9OhW+wVnBg8iftO8HcquGuMPjyQF
         MsPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LKKy4EOgcjxJnFjWUFUBMKy8IeFiRStXwAEvj/pKQVw=;
        b=kmiC7YmH5k3B9eDt84jEp5OXGU9rNjs/fIAgW9LWJyd5pi3pAGCwHul02ibF2fSpfY
         adz6k23XbrPjk6GVlb8Zj75y155oW+FxHyADc0pYwmwyQXT9yuscChYvX7tYe1Dm4+Bm
         D0UKz7AlPV9TQnMYcMs/AxltQeb+AUp0/cmVoaF8Y7ZFCC0WxZwOKKC0NjwDPGmNovo3
         eymBjOFKEL0T0f2230npOqDPZFY9hYxmPB61vtmLIrokYAtc4XUlHsI0pBsomycoOUVa
         opNflv/YpDNfgOC9JKLrBhqXKMcPBkUUkVIA4oPB/+8jNr6sxYfJUOwjv4CBi/2eSe/0
         +16A==
X-Gm-Message-State: AOAM532wYiiuMQcU9d0hlO9Ai88+IHhZEkNmceBiSEXGXn4Xckk24b6H
        tmxXKODy708UnGg8Z1feh+dC7eolMKA5
X-Google-Smtp-Source: ABdhPJwQ50lnRVO0QJ4LMsurz9oD9nYh8VxhBcPlPXBME3O2v0MTpRxh/x4lo31Qvxr+4ILJYejvme4sdhkO
X-Received: by 2002:a5b:14a:: with SMTP id c10mr4688572ybp.369.1589959710270;
 Wed, 20 May 2020 00:28:30 -0700 (PDT)
Date:   Wed, 20 May 2020 00:28:11 -0700
In-Reply-To: <20200520072814.128267-1-irogers@google.com>
Message-Id: <20200520072814.128267-5-irogers@google.com>
Mime-Version: 1.0
References: <20200520072814.128267-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH 4/7] perf metricgroup: Order event groups by size
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
index afd960d03a77..52e4c3e4748a 100644
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

