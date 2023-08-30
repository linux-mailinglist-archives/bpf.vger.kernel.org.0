Return-Path: <bpf+bounces-9010-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B4978E2F5
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 01:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF5AC1C203B5
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 23:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FAF68C06;
	Wed, 30 Aug 2023 23:01:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A328290D
	for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 23:01:52 +0000 (UTC)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9CD10C2;
	Wed, 30 Aug 2023 16:01:32 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-68becf931bfso156672b3a.0;
        Wed, 30 Aug 2023 16:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693436491; x=1694041291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=38/N/H/GLJ5V8hDWHlfIwHE79LQlHYidyaRMNuJVW2I=;
        b=iY0nP4F5gr5uu1Wxsfm3WEdPemKCrpt24jka5xz4SXjSES9M7l38aGKu2TB8d3JEcn
         H4fCY2OAx41+OlPQ9sE9WLY7JBTj409x3CulZwJAEzj6vXxsLEKdBqG/M3idcWJvwYAF
         srlVZvdqgcV4DPvPveh98cM6WNz3MfEV4N6fZ+dFqaGlPisr7u84SzA6lCze/YceB7FM
         ZcU0/pIyjLFIskXpVAQCSTzaAPUdmzH5wrxuvSb7rCZDLPu1LnObNt5UnmP5/7Nq1C2U
         wxOhGAXK3TiLbILTLnx+5KrW9GbnDBxlt22x+ofwNPD7/+EFe/vDmsd4oQqufzGgzA/k
         kBFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693436491; x=1694041291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=38/N/H/GLJ5V8hDWHlfIwHE79LQlHYidyaRMNuJVW2I=;
        b=QVvTyTpjG5YeMxBQ9c5gZtO5SNIqnMVs7zMw921AdWfonmz0MVaYVAvPcok6mFoptX
         +sYi7mH9k2vRk7XjMFrx3ttdEDtHi73N9vQWoS+YKicFpl+wUQJiC0kptQ+Up1u8N8pQ
         rC/ITP/CK7zXpb8zVEKTcFiHYSyIAyzfRh9C2E7kVerq1kQX3yA+ltwMs339qoG3kKNY
         og0XklU7JhYGthZrOYgfnGKBR/o1ruKwbojwnlKyuX+ngqtmPAtywuSntYNb7fhjXD4E
         y6yn0LdIJF1aCgWBmQh5TIQv/z6HglBi9vpNeb04Sl2+A5V2Wf+8rXRzBMQzVJpV8Bcs
         CeRg==
X-Gm-Message-State: AOJu0Yx0Diuy1SGauycxGAUM5WoFH9XTr3ETWgySq+lNnSPEazJY9elb
	iLrshsVrFH39KWDSS4vQWUU=
X-Google-Smtp-Source: AGHT+IFVBQ29ZdS7/4HgjFrEpJ24NutIBVg/N3aWKy2odlkHn9KE3ha9VEcT+aVWZaLO/JjElP21/A==
X-Received: by 2002:a05:6a00:150b:b0:68b:ff3b:e140 with SMTP id q11-20020a056a00150b00b0068bff3be140mr3712127pfu.8.1693436490771;
        Wed, 30 Aug 2023 16:01:30 -0700 (PDT)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:4366:cd91:1c34:2aa7])
        by smtp.gmail.com with ESMTPSA id j13-20020aa7928d000000b00689f8dc26c2sm92531pfa.133.2023.08.30.16.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 16:01:30 -0700 (PDT)
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
Date: Wed, 30 Aug 2023 16:01:22 -0700
Message-ID: <20230830230126.260508-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230830230126.260508-1-namhyung@kernel.org>
References: <20230830230126.260508-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The read_all_cgroups() is to build a tree of cgroups in the system and
users can look up a cgroup using __cgroup_find().

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


