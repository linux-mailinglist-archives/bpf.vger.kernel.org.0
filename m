Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F4D59EEC3
	for <lists+bpf@lfdr.de>; Wed, 24 Aug 2022 00:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbiHWWLr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Aug 2022 18:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbiHWWLJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Aug 2022 18:11:09 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D57785A2
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 15:10:36 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-335ff2ef600so261867867b3.18
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 15:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=4T63H/7ulEFz0y7iN4SapyGcMaYqwoIDMM7/trBdyIM=;
        b=NG04TAKrMqD5yuCJUiZXkkkxUS8d8EDfmvANyx1CxoAGugcPRW6r4NL9uieW+hdrer
         TEyjfRtOTqmKH5WoG3B1dRvOEJgNEZ9oLTqhQLVZFGugh2K4zYhk1WMMtULqw7Pw45My
         wwRrDgOSSc0G2aalSmQbzGyz26agS4lYVgedBX7iIs9Q032UgiMNe5T49G2x5Wed58X1
         9Auuzt6oP9N3htE+FULLeAFtcpSlCOhwOugg8yvVImkhngV570xfN4TZv56Yc4cG0rgs
         kPLoic4tgb4tdlQLRaIeJK8GtZzR6WAfW547xvhh25gg3AfBJXkNGJc0qFSPi8RRQjXi
         yvOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=4T63H/7ulEFz0y7iN4SapyGcMaYqwoIDMM7/trBdyIM=;
        b=4ljq0eHkmXV0EKzs+vy/BQwzPunpfi7P62CZ+McnuPh4LngeaM6BvH3xO5+vjKIxAA
         xeWzy6NXpOBJZSuv7WumDWtA16FY+D0775C2jKu6+ycPKXznaKXd7vKOhkLrgY5QKVKI
         VH7k7430CCLeOA575AfHoKKOiwkcrM7oxrIacj6DTe0gs4DWGiJd3CLIrUgACvoSJngd
         5m3U9n4c5G299AoxGL1rMPjW48ZBZs1HnHFX7dFTg3M3iuA9jb47g77DwUanfwgX6bUr
         zJMZGml8I3HP190efAE8C06rFZiXk7pmfQhoRgh100Gn2fef1/FtsarObyN3Zwu/crCF
         nNcg==
X-Gm-Message-State: ACgBeo10FfHn5X6rXbUGh1oDGo7jBT2QeXAG/WUX+nOYUXGGAsjcgIJa
        m14Z6qgLy2JFERfoZxsGqDbnoqaCo1Fx
X-Google-Smtp-Source: AA6agR5fLgUmwOPH9u5c9mealhHzc7vyBsAFZgGD99BelmVEDn8hDSG9RnnaQJ2rHTdAVQEq7MRalAMAmhjQ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7dbd:c08f:de81:c2a3])
 (user=irogers job=sendgmr) by 2002:a25:6e87:0:b0:692:3f71:86c8 with SMTP id
 j129-20020a256e87000000b006923f7186c8mr27447174ybc.295.1661292635305; Tue, 23
 Aug 2022 15:10:35 -0700 (PDT)
Date:   Tue, 23 Aug 2022 15:09:15 -0700
In-Reply-To: <20220823220922.256001-1-irogers@google.com>
Message-Id: <20220823220922.256001-12-irogers@google.com>
Mime-Version: 1.0
References: <20220823220922.256001-1-irogers@google.com>
X-Mailer: git-send-email 2.37.2.609.g9ff673ca1a-goog
Subject: [PATCH v2 11/18] perf dso: Update use of pthread mutex
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Weiguo Li <liwg06@foxmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Dario Petrillo <dario.pk1@gmail.com>,
        Hewenliang <hewenliang4@huawei.com>,
        yaowenbin <yaowenbin1@huawei.com>,
        Wenyu Liu <liuwenyu7@huawei.com>,
        Song Liu <songliubraving@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Leo Yan <leo.yan@linaro.org>,
        Kim Phillips <kim.phillips@amd.com>,
        Pavithra Gurushankar <gpavithrasha@gmail.com>,
        Alexandre Truong <alexandre.truong@arm.com>,
        Quentin Monnet <quentin@isovalent.com>,
        William Cohen <wcohen@redhat.com>,
        Andres Freund <andres@anarazel.de>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "=?UTF-8?q?Martin=20Li=C5=A1ka?=" <mliska@suse.cz>,
        Colin Ian King <colin.king@intel.com>,
        James Clark <james.clark@arm.com>,
        Fangrui Song <maskray@google.com>,
        Stephane Eranian <eranian@google.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Zechuan Chen <chenzechuan1@huawei.com>,
        Jason Wang <wangborong@cdjrlc.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Remi Bernon <rbernon@codeweavers.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Switch to the use of mutex wrappers that provide better error checking.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dso.c    | 12 ++++++------
 tools/perf/util/dso.h    |  4 ++--
 tools/perf/util/symbol.c |  4 ++--
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 5ac13958d1bd..c7a5b42d1311 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -795,7 +795,7 @@ dso_cache__free(struct dso *dso)
 	struct rb_root *root = &dso->data.cache;
 	struct rb_node *next = rb_first(root);
 
-	pthread_mutex_lock(&dso->lock);
+	mutex_lock(&dso->lock);
 	while (next) {
 		struct dso_cache *cache;
 
@@ -804,7 +804,7 @@ dso_cache__free(struct dso *dso)
 		rb_erase(&cache->rb_node, root);
 		free(cache);
 	}
-	pthread_mutex_unlock(&dso->lock);
+	mutex_unlock(&dso->lock);
 }
 
 static struct dso_cache *__dso_cache__find(struct dso *dso, u64 offset)
@@ -841,7 +841,7 @@ dso_cache__insert(struct dso *dso, struct dso_cache *new)
 	struct dso_cache *cache;
 	u64 offset = new->offset;
 
-	pthread_mutex_lock(&dso->lock);
+	mutex_lock(&dso->lock);
 	while (*p != NULL) {
 		u64 end;
 
@@ -862,7 +862,7 @@ dso_cache__insert(struct dso *dso, struct dso_cache *new)
 
 	cache = NULL;
 out:
-	pthread_mutex_unlock(&dso->lock);
+	mutex_unlock(&dso->lock);
 	return cache;
 }
 
@@ -1297,7 +1297,7 @@ struct dso *dso__new_id(const char *name, struct dso_id *id)
 		dso->root = NULL;
 		INIT_LIST_HEAD(&dso->node);
 		INIT_LIST_HEAD(&dso->data.open_entry);
-		pthread_mutex_init(&dso->lock, NULL);
+		mutex_init(&dso->lock, /*pshared=*/false);
 		refcount_set(&dso->refcnt, 1);
 	}
 
@@ -1336,7 +1336,7 @@ void dso__delete(struct dso *dso)
 	dso__free_a2l(dso);
 	zfree(&dso->symsrc_filename);
 	nsinfo__zput(dso->nsinfo);
-	pthread_mutex_destroy(&dso->lock);
+	mutex_destroy(&dso->lock);
 	free(dso);
 }
 
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index 66981c7a9a18..58d94175e714 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -2,7 +2,6 @@
 #ifndef __PERF_DSO
 #define __PERF_DSO
 
-#include <pthread.h>
 #include <linux/refcount.h>
 #include <linux/types.h>
 #include <linux/rbtree.h>
@@ -11,6 +10,7 @@
 #include <stdio.h>
 #include <linux/bitops.h>
 #include "build-id.h"
+#include "mutex.h"
 
 struct machine;
 struct map;
@@ -145,7 +145,7 @@ struct dso_cache {
 struct auxtrace_cache;
 
 struct dso {
-	pthread_mutex_t	 lock;
+	struct mutex	 lock;
 	struct list_head node;
 	struct rb_node	 rb_node;	/* rbtree node sorted by long name */
 	struct rb_root	 *root;		/* root of rbtree that rb_node is in */
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index a4b22caa7c24..656d9b4dd456 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1800,7 +1800,7 @@ int dso__load(struct dso *dso, struct map *map)
 	}
 
 	nsinfo__mountns_enter(dso->nsinfo, &nsc);
-	pthread_mutex_lock(&dso->lock);
+	mutex_lock(&dso->lock);
 
 	/* check again under the dso->lock */
 	if (dso__loaded(dso)) {
@@ -1964,7 +1964,7 @@ int dso__load(struct dso *dso, struct map *map)
 		ret = 0;
 out:
 	dso__set_loaded(dso);
-	pthread_mutex_unlock(&dso->lock);
+	mutex_unlock(&dso->lock);
 	nsinfo__mountns_exit(&nsc);
 
 	return ret;
-- 
2.37.2.609.g9ff673ca1a-goog

