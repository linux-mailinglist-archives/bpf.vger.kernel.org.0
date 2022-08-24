Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34FAE59FE99
	for <lists+bpf@lfdr.de>; Wed, 24 Aug 2022 17:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239763AbiHXPlY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 11:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239765AbiHXPlM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 11:41:12 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF192C66F
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 08:40:56 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-336c3b72da5so292144167b3.6
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 08:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=xlT9MOZYXzUPT/ZDHnandhyG3BP+skGqSNfy5v3dYOQ=;
        b=Ax9rsWi3lfd8bOMtr/j2oSo7AH03ac86M7P94AmgByoEZE8Td5iln0u0dL5H2dm739
         NGcnb6xMCvDnhWV2f/x/qFBg9SAEK3MP8B2qMY8hGgaj3EVJesu6bYRly6xOM0fcjsgd
         wKS2MM3kbf0J5R2XGLKTbH2/aQMJpzdiNQPltTyC3pnj3dz8TpobS5+EInH974WWmoew
         3jeKW3BtxNYMqjtxIvLj5m9SqC8mTbHFYjpk3zcnOc3YbL2Z6lcEDU0oEC5I5VqgU0FK
         bJuE7Aaxwf6V1bWPyQBQjyhJY9bgpwu5BxBTdtNiq+GpfOyiO3C54308KHQDlP84nIgO
         AWVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=xlT9MOZYXzUPT/ZDHnandhyG3BP+skGqSNfy5v3dYOQ=;
        b=62few+4d+yLRzKPoa5fH4L1VN0Z9TFX5NZXRkUckXEenAwZfb/c6UefsrgnCGpTLJ3
         rC/WHn4Fq8rLglt0TB48tPQZ/iAd7DdD+Z6nnMY8JvzsZ7rmtzHFaZVWySY7bkXPsWsx
         Pl4bx7fw9XgAe7QtBBNZh3GyDdwN1mpNsdBT98SvplAWBJSWX3fPwi6aO+BbTlPwi9uu
         PgExhx9FwB83twHiEJuTYG8NJCr7pt3jPCBHyQ19Ckvso46k0BK4c9hM2lj7tOQgXYxp
         V/ST5PpHqpjoGloYgl+Q6IgQn0giajDuMVOBmTuLrVL4aWPi1hwQvkPYkf3E2D3T7sXR
         rTlw==
X-Gm-Message-State: ACgBeo0KXVeOOkQqyGauraOoIEBr9Y2RYqY0GEEwXxaO0cKsO87YK4e5
        M0V4GZ2VRUSLZmTQdINCfNm5WEDGazgP
X-Google-Smtp-Source: AA6agR7OmlPSpm29Es16/F2xILnxdFS0+FffZRzWtCgTOm2ELsxIFcSaEXb0DiIGDWXKKwu2GGJGL+7MhZB6
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:ab82:a348:500d:1fc4])
 (user=irogers job=sendgmr) by 2002:a25:75d7:0:b0:66f:cdfc:a986 with SMTP id
 q206-20020a2575d7000000b0066fcdfca986mr27893557ybc.268.1661355655884; Wed, 24
 Aug 2022 08:40:55 -0700 (PDT)
Date:   Wed, 24 Aug 2022 08:38:57 -0700
In-Reply-To: <20220824153901.488576-1-irogers@google.com>
Message-Id: <20220824153901.488576-15-irogers@google.com>
Mime-Version: 1.0
References: <20220824153901.488576-1-irogers@google.com>
X-Mailer: git-send-email 2.37.2.609.g9ff673ca1a-goog
Subject: [PATCH v3 14/18] perf dso: Hold lock when accessing nsinfo
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

There may be threads racing to update dso->nsinfo:
https://lore.kernel.org/linux-perf-users/CAP-5=fWZH20L4kv-BwVtGLwR=Em3AOOT+Q4QGivvQuYn5AsPRg@mail.gmail.com/
Holding the dso->lock avoids use-after-free, memory leaks and other
such bugs. Apply the fix in:
https://lore.kernel.org/linux-perf-users/20211118193714.2293728-1-irogers@google.com/
of there being a missing nsinfo__put now that the accesses are data race
free. Fixes test "Lookup mmap thread" when compiled with address
sanitizer.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-inject.c   |  4 ++++
 tools/perf/util/annotate.c    |  2 ++
 tools/perf/util/build-id.c    | 12 +++++++++---
 tools/perf/util/dso.c         |  7 ++++++-
 tools/perf/util/map.c         |  3 +++
 tools/perf/util/probe-event.c |  3 +++
 tools/perf/util/symbol.c      |  2 +-
 7 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 8ec955402488..e254f18986f7 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -436,8 +436,10 @@ static struct dso *findnew_dso(int pid, int tid, const char *filename,
 	}
 
 	if (dso) {
+		mutex_lock(&dso->lock);
 		nsinfo__put(dso->nsinfo);
 		dso->nsinfo = nsi;
+		mutex_unlock(&dso->lock);
 	} else
 		nsinfo__put(nsi);
 
@@ -620,6 +622,7 @@ static int dso__read_build_id(struct dso *dso)
 	if (dso->has_build_id)
 		return 0;
 
+	mutex_lock(&dso->lock);
 	nsinfo__mountns_enter(dso->nsinfo, &nsc);
 	if (filename__read_build_id(dso->long_name, &dso->bid) > 0)
 		dso->has_build_id = true;
@@ -633,6 +636,7 @@ static int dso__read_build_id(struct dso *dso)
 		free(new_name);
 	}
 	nsinfo__mountns_exit(&nsc);
+	mutex_unlock(&dso->lock);
 
 	return dso->has_build_id ? 0 : -1;
 }
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 9d7dd6489a05..5bc63c9e0324 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1697,6 +1697,7 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
 		 */
 		__symbol__join_symfs(filename, filename_size, dso->long_name);
 
+		mutex_lock(&dso->lock);
 		if (access(filename, R_OK) && errno == ENOENT && dso->nsinfo) {
 			char *new_name = filename_with_chroot(dso->nsinfo->pid,
 							      filename);
@@ -1705,6 +1706,7 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
 				free(new_name);
 			}
 		}
+		mutex_unlock(&dso->lock);
 	}
 
 	free(build_id_path);
diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index ec18ed5caf3e..a839b30c981b 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -898,11 +898,15 @@ static int filename__read_build_id_ns(const char *filename,
 static bool dso__build_id_mismatch(struct dso *dso, const char *name)
 {
 	struct build_id bid;
+	bool ret = false;
 
-	if (filename__read_build_id_ns(name, &bid, dso->nsinfo) < 0)
-		return false;
+	mutex_lock(&dso->lock);
+	if (filename__read_build_id_ns(name, &bid, dso->nsinfo) >= 0)
+		ret = !dso__build_id_equal(dso, &bid);
 
-	return !dso__build_id_equal(dso, &bid);
+	mutex_unlock(&dso->lock);
+
+	return ret;
 }
 
 static int dso__cache_build_id(struct dso *dso, struct machine *machine,
@@ -941,8 +945,10 @@ static int dso__cache_build_id(struct dso *dso, struct machine *machine,
 	if (!is_kallsyms && dso__build_id_mismatch(dso, name))
 		goto out_free;
 
+	mutex_lock(&dso->lock);
 	ret = build_id_cache__add_b(&dso->bid, name, dso->nsinfo,
 				    is_kallsyms, is_vdso, proper_name, root_dir);
+	mutex_unlock(&dso->lock);
 out_free:
 	free(allocated_name);
 	return ret;
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index a9789a955403..f1a14c0ad26d 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -501,6 +501,7 @@ static int __open_dso(struct dso *dso, struct machine *machine)
 	if (!name)
 		return -ENOMEM;
 
+	mutex_lock(&dso->lock);
 	if (machine)
 		root_dir = machine->root_dir;
 
@@ -541,6 +542,7 @@ static int __open_dso(struct dso *dso, struct machine *machine)
 		unlink(name);
 
 out:
+	mutex_unlock(&dso->lock);
 	free(name);
 	return fd;
 }
@@ -559,8 +561,11 @@ static int open_dso(struct dso *dso, struct machine *machine)
 	int fd;
 	struct nscookie nsc;
 
-	if (dso->binary_type != DSO_BINARY_TYPE__BUILD_ID_CACHE)
+	if (dso->binary_type != DSO_BINARY_TYPE__BUILD_ID_CACHE) {
+		mutex_lock(&dso->lock);
 		nsinfo__mountns_enter(dso->nsinfo, &nsc);
+		mutex_unlock(&dso->lock);
+	}
 	fd = __open_dso(dso, machine);
 	if (dso->binary_type != DSO_BINARY_TYPE__BUILD_ID_CACHE)
 		nsinfo__mountns_exit(&nsc);
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index e0aa4a254583..f3a3d9b3a40d 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -181,7 +181,10 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
 			if (!(prot & PROT_EXEC))
 				dso__set_loaded(dso);
 		}
+		mutex_lock(&dso->lock);
+		nsinfo__put(dso->nsinfo);
 		dso->nsinfo = nsi;
+		mutex_unlock(&dso->lock);
 
 		if (build_id__is_defined(bid)) {
 			dso__set_build_id(dso, bid);
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 785246ff4179..0c24bc7afbca 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -29,6 +29,7 @@
 #include "color.h"
 #include "map.h"
 #include "maps.h"
+#include "mutex.h"
 #include "symbol.h"
 #include <api/fs/fs.h>
 #include "trace-event.h"	/* For __maybe_unused */
@@ -180,8 +181,10 @@ struct map *get_target_map(const char *target, struct nsinfo *nsi, bool user)
 
 		map = dso__new_map(target);
 		if (map && map->dso) {
+			mutex_lock(&map->dso->lock);
 			nsinfo__put(map->dso->nsinfo);
 			map->dso->nsinfo = nsinfo__get(nsi);
+			mutex_unlock(&map->dso->lock);
 		}
 		return map;
 	} else {
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 656d9b4dd456..a3a165ae933a 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1791,6 +1791,7 @@ int dso__load(struct dso *dso, struct map *map)
 	char newmapname[PATH_MAX];
 	const char *map_path = dso->long_name;
 
+	mutex_lock(&dso->lock);
 	perfmap = strncmp(dso->name, "/tmp/perf-", 10) == 0;
 	if (perfmap) {
 		if (dso->nsinfo && (dso__find_perf_map(newmapname,
@@ -1800,7 +1801,6 @@ int dso__load(struct dso *dso, struct map *map)
 	}
 
 	nsinfo__mountns_enter(dso->nsinfo, &nsc);
-	mutex_lock(&dso->lock);
 
 	/* check again under the dso->lock */
 	if (dso__loaded(dso)) {
-- 
2.37.2.609.g9ff673ca1a-goog

