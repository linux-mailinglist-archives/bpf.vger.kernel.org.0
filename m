Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7A41C8DC6
	for <lists+bpf@lfdr.de>; Thu,  7 May 2020 16:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbgEGOIx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 May 2020 10:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728273AbgEGOIw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 May 2020 10:08:52 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4B5C05BD09
        for <bpf@vger.kernel.org>; Thu,  7 May 2020 07:08:52 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id n205so7153683ybf.14
        for <bpf@vger.kernel.org>; Thu, 07 May 2020 07:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Ve3vTS0dwDdHMAI90bDwVWc9K4DFzuQRhEm67DLvdBI=;
        b=lbUftswRGuCrRuSDMQVv7QQFtav3DLN2nC+AJjBSkxsnaBHC7iKy0uJd7EKTCNaDg1
         CLxaiDJZvANlLtuq/LB6/KlBWLheGA9hAewgYFSg91xzSO2hv/TIDD9tUYMGI4mlWRvb
         4m9vzlLfjeAdcYEavO1HWBOWJkOH9AjZhuQFTiVUfNKi6MManhqsM0d3C1e7eiKkXQqx
         t1LHW2snJWq7YdvAKGFHVq3fHupKGZSOZcpsEbeYmHCAII4KOSAN2MRMvMr0OKRVNy2W
         Gev+KuTdKRm6uCWsWWjobmm54+xvn7jiy1nUQehPTcL14z5OoLl9hL2AS95tjODjDSps
         Fw7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Ve3vTS0dwDdHMAI90bDwVWc9K4DFzuQRhEm67DLvdBI=;
        b=AEZvkup8gQ0zclKYvmsPyQ7Xxklla6wr1xAPn3kGkrVYF4EER3wF906ahh2JEI8mfy
         CXV9wWNCtMXkXOw8mHHPSoFHiEqyJOJpvzJe5QqNKlEcuBY356vt6qoI+hjm/sMVV5r3
         vwqfBfqdu4HcQFXssdJ/wAeMQa7ZD5VVMeXo7XWL8zC8kdxqjab7qiXGwmLR2TrA5DEn
         A0j9z92H0w4tWak3zEa0eyhBYAOIvAYhGTEJaEZOsCrLJg94R8S4xxYWS4PuqeN0rsd+
         O63x89cs2IfIISoboNfSYWxqjqW2Je5MwxCWfieHW/Ksp/tn9DCWoWcHNSB9K3Okk/Fs
         ylqQ==
X-Gm-Message-State: AGi0PuZF/4iMY69fYTKrUAx0Z57lFufuwtJeF1aZ7+1Og6HGp2T56uoo
        I784R57JOYCKfbUDryAPyworXBQNqDf8
X-Google-Smtp-Source: APiQypJ9zFoVHWckQaXG3T28mHyFiegp2diKQ3EvA4SHc3hFfwK0egNkZBbLgu2vxUAvXrCkXzC91nGmj7/E
X-Received: by 2002:a25:d90d:: with SMTP id q13mr23881563ybg.125.1588860531193;
 Thu, 07 May 2020 07:08:51 -0700 (PDT)
Date:   Thu,  7 May 2020 07:08:10 -0700
In-Reply-To: <20200507140819.126960-1-irogers@google.com>
Message-Id: <20200507140819.126960-15-irogers@google.com>
Mime-Version: 1.0
References: <20200507140819.126960-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [RFC PATCH v2 14/23] libbpf: Fix memory leak and possible double-free
 in hashmap__clear
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
        Alston Tang <alston64@fb.com>, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Andrii Nakryiko <andriin@fb.com>

Fix memory leak in hashmap_clear() not freeing hashmap_entry structs for each
of the remaining entries. Also NULL-out bucket list to prevent possible
double-free between hashmap__clear() and hashmap__free().

Running test_progs-asan flavor clearly showed this problem.

Reported-by: Alston Tang <alston64@fb.com>
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Link: https://lore.kernel.org/bpf/20200429012111.277390-5-andriin@fb.com
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/bpf/hashmap.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/lib/bpf/hashmap.c b/tools/lib/bpf/hashmap.c
index 54c30c802070..cffb96202e0d 100644
--- a/tools/lib/bpf/hashmap.c
+++ b/tools/lib/bpf/hashmap.c
@@ -59,7 +59,14 @@ struct hashmap *hashmap__new(hashmap_hash_fn hash_fn,
 
 void hashmap__clear(struct hashmap *map)
 {
+	struct hashmap_entry *cur, *tmp;
+	int bkt;
+
+	hashmap__for_each_entry_safe(map, cur, tmp, bkt) {
+		free(cur);
+	}
 	free(map->buckets);
+	map->buckets = NULL;
 	map->cap = map->cap_bits = map->sz = 0;
 }
 
-- 
2.26.2.526.g744177e7f7-goog

