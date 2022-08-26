Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 792745A2CAE
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 18:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344806AbiHZQqo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 12:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344813AbiHZQqR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 12:46:17 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075EA2655E
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 09:45:15 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-33f8988daecso24991017b3.12
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 09:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=P/ieWH4vlM/8h5LESv9iguXPsGFEK+Ic1rlbsC/GugE=;
        b=izKuMNaT1OBd/uCYzdvuUjEkJFXVDOPZrd+ZHfYyTXDR6ldY/aTFaM75nG8Au/gJ+u
         OsVKLUHvG+lUblgaeDbJ7FVInI7L97a5Ib6F/c9+0jFbMPFgX6UeMhdPNtETwMs6viDN
         UpY6+LLumhbuz0Ek634XZr+0Qm4MUyir30u7J/RS7aY0eSB/W2JBOrkhXvFDaNAfoKED
         Tt2LRLvbbqGMP3oSv8JDOjEy+H17r9Z2ESnpevGbPit+QwL1+dcAW4UZvkhNMZF6wUq/
         cLcEpuNESV++aK0Pl9SVropz/2tqIC4F4t0CKWrS8cYnCShWDEAnhsTu2VCXoaq5W+qU
         Hytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=P/ieWH4vlM/8h5LESv9iguXPsGFEK+Ic1rlbsC/GugE=;
        b=eT3nkK8agTn9LBRIcb0keozF2jzQJu0Ob9sOFMsbZ1xIK90AKi7F6m6jGBrrgAb/X3
         XCOXsw0/r2fwnIFTzND2U2yV5U+2bq4Gt942+TQ0IuLD3HsaS4RAjQg3tyilNSx21plU
         iv+oWNiQN3OHmDpEZPxx5kLic+JeuWpcpe6eyVWo1ayCVavRZxHGOYUyEYJ6jslD/GZm
         Lycr/mrN9naf17yd7U8SiAH4RTdFPKMiMkZNMHvTPsz3XtbouOOJ24yiOzWfryx5f2mx
         cCQ4+zUbx7OrdQTEmJOZ9XT4Wk0tGUV1IZ+RLH+nqyUrppnyZaAcnIAS+VPl+ahvVx/U
         EHWw==
X-Gm-Message-State: ACgBeo39Dfwh2PAhnIpCgnjCZKg2ElQFI+9LdWfzsipLB5Z6I0b4NB9t
        8k1u5yx53xmbc6b+N9EmvkjtsN5SvU3A
X-Google-Smtp-Source: AA6agR7np94rG4awV3eXa8XCOc67AhRQf42xpkRPMpvE1bBB9l7bmkbyLJ+5gTzEUA3V38h3QZFbnPKhuX5X
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:ccb1:c46b:7044:2508])
 (user=irogers job=sendgmr) by 2002:a05:6902:1544:b0:696:69c7:2431 with SMTP
 id r4-20020a056902154400b0069669c72431mr469630ybu.385.1661532315319; Fri, 26
 Aug 2022 09:45:15 -0700 (PDT)
Date:   Fri, 26 Aug 2022 09:42:38 -0700
In-Reply-To: <20220826164242.43412-1-irogers@google.com>
Message-Id: <20220826164242.43412-15-irogers@google.com>
Mime-Version: 1.0
References: <20220826164242.43412-1-irogers@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Subject: [PATCH v4 14/18] perf dso: Hold lock when accessing nsinfo
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
        autolearn=ham autolearn_force=no version=3.4.6
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
2.37.2.672.g94769d06f0-goog

