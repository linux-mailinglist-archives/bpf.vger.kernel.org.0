Return-Path: <bpf+bounces-9346-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F12A9794237
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 19:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F1C12813E0
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 17:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A721118D;
	Wed,  6 Sep 2023 17:49:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13BA10940
	for <bpf@vger.kernel.org>; Wed,  6 Sep 2023 17:49:09 +0000 (UTC)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942E2BD;
	Wed,  6 Sep 2023 10:49:07 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-5733789a44cso39161eaf.2;
        Wed, 06 Sep 2023 10:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694022547; x=1694627347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PBQ5G2FX24MM3CgYsRh2BznK6RgK/ifaz8ZcxdhCQEw=;
        b=oF1j3wX38wASrXvwTUlviqu0776yIpO+kr6NBdV7ZdWyYP4d+PgL6kwyOMRbSLFp37
         SXZdJmr5fnVtSQ3yigypioWqWina5SUSsD9Id2pS4Oamh2JQPq2AGLA7XVH8/TGpZIFz
         kNCRFHedsPjbuOgflqYwBJq0PrEiyHuyFGwpAO5+DyhZjs42nFr7bsUUadaE8pzlUT0/
         vtJ9FVylM3MeOxDcZlaaGhQKE+dc5Cd0Ie2of6j0YxR9bxS+cy1jitVziLG58T2t8vq6
         PKboA3E+6iFPd+5XOw7OF8wA75xnyXUy48tgWP2VJvSnSAfgnTLaoPqYUSNq/Fe8Xf5A
         I1wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694022547; x=1694627347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PBQ5G2FX24MM3CgYsRh2BznK6RgK/ifaz8ZcxdhCQEw=;
        b=BSINu5f1WUNKl4X7t9E9kfY888qWUzV00ciP5WIkEF9nlF2r6DzUh1pSt73rF5YiZb
         kuCjMuEeEJaqROJlZRJ3wVu5Ct6n87YHkvtPR8xlkOmw+ELrMrEk3G5ruX7+g2QPA7RV
         gGQN/eCPx8E1lVK7PSj3ZHQv0sNhkHP//y3+l8503GR2fergTJTNHQdg/xGXRtB1j0Vr
         4S53ZEj6ez7gc5/63Lp/liYac3InvLlYUwyV675GXjnZ7sKa/9y73KFW+tzRpaMVm4mx
         kiV4b9vdxkZs4zc41lWbo5/mXlcXI1CA3bvZUpKxyvBcJrTG10uLYhYeOX/x/rcIbUrj
         PxSA==
X-Gm-Message-State: AOJu0Yz8+Yw1Jx1sEfg5t2gLhf4PurYa5zJ/oSUNwkpG3bg/OFQmCBgM
	w/+/xWe90L4dYH0VKMHMhIU=
X-Google-Smtp-Source: AGHT+IHpaczWiQhmc3kppZcNKp/jtOF7byv8+L0SKDn71OBpR5ykPGEvw9W9yP2nZqPQQ13gIgQm/Q==
X-Received: by 2002:a05:6358:418b:b0:13c:cdef:25ab with SMTP id w11-20020a056358418b00b0013ccdef25abmr3499752rwc.24.1694022546735;
        Wed, 06 Sep 2023 10:49:06 -0700 (PDT)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:5035:1b47:9a3f:312c])
        by smtp.gmail.com with ESMTPSA id p11-20020a17090ad30b00b00262eccfa29fsm63564pju.33.2023.09.06.10.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 10:49:06 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	bpf@vger.kernel.org
Subject: [PATCH 1/5] perf tools: Add read_all_cgroups() and __cgroup_find()
Date: Wed,  6 Sep 2023 10:48:59 -0700
Message-ID: <20230906174903.346486-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230906174903.346486-1-namhyung@kernel.org>
References: <20230906174903.346486-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The read_all_cgroups() is to build a tree of cgroups in the system and
users can look up a cgroup using __cgroup_find().

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/cgroup.c | 61 ++++++++++++++++++++++++++++++++++------
 tools/perf/util/cgroup.h |  4 +++
 2 files changed, 57 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index bfb13306d82c..2e969d1464f4 100644
--- a/tools/perf/util/cgroup.c
+++ b/tools/perf/util/cgroup.c
@@ -48,28 +48,36 @@ static int open_cgroup(const char *name)
 }
 
 #ifdef HAVE_FILE_HANDLE
-int read_cgroup_id(struct cgroup *cgrp)
+static u64 __read_cgroup_id(const char *path)
 {
-	char path[PATH_MAX + 1];
-	char mnt[PATH_MAX + 1];
 	struct {
 		struct file_handle fh;
 		uint64_t cgroup_id;
 	} handle;
 	int mount_id;
 
+	handle.fh.handle_bytes = sizeof(handle.cgroup_id);
+	if (name_to_handle_at(AT_FDCWD, path, &handle.fh, &mount_id, 0) < 0)
+		return -1ULL;
+
+	return handle.cgroup_id;
+}
+
+int read_cgroup_id(struct cgroup *cgrp)
+{
+	char path[PATH_MAX + 1];
+	char mnt[PATH_MAX + 1];
+
 	if (cgroupfs_find_mountpoint(mnt, PATH_MAX + 1, "perf_event"))
 		return -1;
 
 	scnprintf(path, PATH_MAX, "%s/%s", mnt, cgrp->name);
 
-	handle.fh.handle_bytes = sizeof(handle.cgroup_id);
-	if (name_to_handle_at(AT_FDCWD, path, &handle.fh, &mount_id, 0) < 0)
-		return -1;
-
-	cgrp->id = handle.cgroup_id;
+	cgrp->id = __read_cgroup_id(path);
 	return 0;
 }
+#else
+static inline u64 __read_cgroup_id(const char *path) { return -1ULL; }
 #endif  /* HAVE_FILE_HANDLE */
 
 #ifndef CGROUP2_SUPER_MAGIC
@@ -562,6 +570,11 @@ struct cgroup *cgroup__findnew(struct perf_env *env, uint64_t id,
 	return cgrp;
 }
 
+struct cgroup *__cgroup__find(struct rb_root *root, uint64_t id)
+{
+	return __cgroup__findnew(root, id, /*create=*/false, /*path=*/NULL);
+}
+
 struct cgroup *cgroup__find(struct perf_env *env, uint64_t id)
 {
 	struct cgroup *cgrp;
@@ -587,3 +600,35 @@ void perf_env__purge_cgroups(struct perf_env *env)
 	}
 	up_write(&env->cgroups.lock);
 }
+
+void read_all_cgroups(struct rb_root *root)
+{
+	char mnt[PATH_MAX];
+	struct cgroup_name *cn;
+	int prefix_len;
+
+	if (cgroupfs_find_mountpoint(mnt, sizeof(mnt), "perf_event"))
+		return;
+
+	/* cgroup_name will have a full path, skip the root directory */
+	prefix_len = strlen(mnt);
+
+	/* collect all cgroups in the cgroup_list */
+	if (nftw(mnt, add_cgroup_name, 20, 0) < 0)
+		return;
+
+	list_for_each_entry(cn, &cgroup_list, list) {
+		const char *name;
+		u64 cgrp_id;
+
+		/* cgroup_name might have a full path, skip the prefix */
+		name = cn->name + prefix_len;
+		if (name[0] == '\0')
+			name = "/";
+
+		cgrp_id = __read_cgroup_id(cn->name);
+		__cgroup__findnew(root, cgrp_id, /*create=*/true, name);
+	}
+
+	release_cgroup_list();
+}
diff --git a/tools/perf/util/cgroup.h b/tools/perf/util/cgroup.h
index 12256b78608c..beb6fe1012ed 100644
--- a/tools/perf/util/cgroup.h
+++ b/tools/perf/util/cgroup.h
@@ -37,6 +37,7 @@ int parse_cgroups(const struct option *opt, const char *str, int unset);
 struct cgroup *cgroup__findnew(struct perf_env *env, uint64_t id,
 			       const char *path);
 struct cgroup *cgroup__find(struct perf_env *env, uint64_t id);
+struct cgroup *__cgroup__find(struct rb_root *root, uint64_t id);
 
 void perf_env__purge_cgroups(struct perf_env *env);
 
@@ -49,6 +50,9 @@ static inline int read_cgroup_id(struct cgroup *cgrp __maybe_unused)
 }
 #endif  /* HAVE_FILE_HANDLE */
 
+/* read all cgroups in the system and save them in the rbtree */
+void read_all_cgroups(struct rb_root *root);
+
 int cgroup_is_v2(const char *subsys);
 
 #endif /* __CGROUP_H__ */
-- 
2.42.0.283.g2d96d420d3-goog


