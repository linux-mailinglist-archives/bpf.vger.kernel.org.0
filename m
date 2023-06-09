Return-Path: <bpf+bounces-2277-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A329172A651
	for <lists+bpf@lfdr.de>; Sat, 10 Jun 2023 00:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C63D281AD9
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 22:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893E85381;
	Fri,  9 Jun 2023 22:40:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533FD408D0
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 22:40:28 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3BC35BE
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 15:40:26 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba82ed6e450so2880021276.2
        for <bpf@vger.kernel.org>; Fri, 09 Jun 2023 15:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686350425; x=1688942425;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VJ/oCWzA+yOfgNosg7yCARX3f3WD532lX89SwknwbFE=;
        b=up80m5SgFVzhZozVGd7h5+yoFepYS10VKiUM7q0OAiqDntEVj7GafQ14HZn+uPBk64
         6n2gAkyi3+fXuv8Sw/b3tlssJq9ft2kCgJYnz88+DTzbvRS7vVqkJOGeKHJopvjSecWt
         i00r7gSkfgUm36l++A7YZ1Yl8Q0zClAmnzTOvJK0u51yoWHaJVvU6xT02NjjiEw9xLX8
         Z8NawuDU+eCmx4FngQI50q4FboVe5yWrWYMFujM9BrhzzdXgyHKT10KTwONMbJMWhdR8
         eb1ZWbvlDOiJ583IRtGINOq3NvFd1aeTj027/vw8u4/w/PJudjREkjY8uU2l8Ngksapy
         Dg2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686350425; x=1688942425;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VJ/oCWzA+yOfgNosg7yCARX3f3WD532lX89SwknwbFE=;
        b=RNv6AaK9EkNUeTcu+50WWlCKDe+1ARL4MnWIkvxgQezUap/I65+cOBU2S5i/+yEst7
         awNyjIleLGYJ9tIngHM5JDU4ilDqnteAsCoMkiwaryTYYqbUFzbyPfkoXJkd3ELRrfa0
         KPCnc41N/eF7i1Y4xK4B9g5k+PjPuf2ae6KcUPUpcUzMmvOxRbflrc1QX0NlocpPQh9n
         Bu5912ZOMMLnMHliIOy2/nL3aopCBHtNJCqRWSVjebn1YhWqzN7pY6kcMXRoOLzBJ9Ji
         oZsZsPhgkLJPl+ZuVW7zW0bHizMONpyP84jB7+oEbmK4K7MZrIFtbBadNMfKwximOMKQ
         BQig==
X-Gm-Message-State: AC+VfDxGJWN7Zf6NZ5+f9U99fcLdkxbkDyArWzUxmaIabT1WXeZSOfyA
	2+zTo+BEBi8L4fTa8Bid2Q8S5kmqnzFK
X-Google-Smtp-Source: ACHHUZ4QD/zHlekmm6G++eWjoFjIqxdft4G6xFO/NIzF/aNyLSaHnGtFgWHuzpnDDHO4X5aO01Vp5iGLUT1G
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:55f2:1922:c44b:472d])
 (user=irogers job=sendgmr) by 2002:a25:ab87:0:b0:bad:252:9f73 with SMTP id
 v7-20020a25ab87000000b00bad02529f73mr711064ybi.0.1686350425476; Fri, 09 Jun
 2023 15:40:25 -0700 (PDT)
Date: Fri,  9 Jun 2023 15:40:04 -0700
Message-Id: <20230609224004.180988-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v1] tools api fs: More thread safety for global filesystem variables
From: Ian Rogers <irogers@google.com>
To: Arnaldo Carvalho de Melo <acme@redhat.com>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Multiple threads, such as with "perf top", may race to initialize a
file system path like hugetlbfs. The racy initialization of the path
leads to at least memory leaks. To avoid this initialize each fs for
reading the mount point path with pthread_once.

Mounting the file system may also be racy, so introduce a mutex over
the function. This does mean that the path is being accessed with and
without a mutex, which is inherently racy but hopefully benign,
especially as there are fewer callers to fs__mount.

Remove the fs__entries by directly using global variables, this was
done as no argument like the index can be passed to the init once
routine.

Issue found and tested with "perf top" and address sanitizer.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/api/fs/fs.c | 211 +++++++++++++++++-------------------------
 1 file changed, 86 insertions(+), 125 deletions(-)

diff --git a/tools/lib/api/fs/fs.c b/tools/lib/api/fs/fs.c
index 22d34a0be8b4..5cb0eeec2c8a 100644
--- a/tools/lib/api/fs/fs.c
+++ b/tools/lib/api/fs/fs.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <assert.h>
 #include <ctype.h>
 #include <errno.h>
 #include <limits.h>
@@ -10,6 +11,7 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
+#include <pthread.h>
 #include <unistd.h>
 #include <sys/mount.h>
 
@@ -43,7 +45,7 @@
 #define BPF_FS_MAGIC           0xcafe4a11
 #endif
 
-static const char * const sysfs__fs_known_mountpoints[] = {
+static const char * const sysfs__known_mountpoints[] = {
 	"/sys",
 	0,
 };
@@ -86,69 +88,70 @@ static const char * const bpf_fs__known_mountpoints[] = {
 };
 
 struct fs {
-	const char		*name;
-	const char * const	*mounts;
+	const char *		 const name;
+	const char * const *	 const mounts;
 	char			*path;
-	bool			 found;
-	bool			 checked;
-	long			 magic;
-};
-
-enum {
-	FS__SYSFS   = 0,
-	FS__PROCFS  = 1,
-	FS__DEBUGFS = 2,
-	FS__TRACEFS = 3,
-	FS__HUGETLBFS = 4,
-	FS__BPF_FS = 5,
+	pthread_mutex_t		 mount_mutex;
+	const long		 magic;
 };
 
 #ifndef TRACEFS_MAGIC
 #define TRACEFS_MAGIC 0x74726163
 #endif
 
-static struct fs fs__entries[] = {
-	[FS__SYSFS] = {
-		.name	= "sysfs",
-		.mounts	= sysfs__fs_known_mountpoints,
-		.magic	= SYSFS_MAGIC,
-		.checked = false,
-	},
-	[FS__PROCFS] = {
-		.name	= "proc",
-		.mounts	= procfs__known_mountpoints,
-		.magic	= PROC_SUPER_MAGIC,
-		.checked = false,
-	},
-	[FS__DEBUGFS] = {
-		.name	= "debugfs",
-		.mounts	= debugfs__known_mountpoints,
-		.magic	= DEBUGFS_MAGIC,
-		.checked = false,
-	},
-	[FS__TRACEFS] = {
-		.name	= "tracefs",
-		.mounts	= tracefs__known_mountpoints,
-		.magic	= TRACEFS_MAGIC,
-		.checked = false,
-	},
-	[FS__HUGETLBFS] = {
-		.name	= "hugetlbfs",
-		.mounts = hugetlbfs__known_mountpoints,
-		.magic	= HUGETLBFS_MAGIC,
-		.checked = false,
-	},
-	[FS__BPF_FS] = {
-		.name	= "bpf",
-		.mounts = bpf_fs__known_mountpoints,
-		.magic	= BPF_FS_MAGIC,
-		.checked = false,
-	},
-};
+static void fs__init_once(struct fs *fs);
+static const char *fs__mountpoint(const struct fs *fs);
+static const char *fs__mount(struct fs *fs);
+
+#define FS(lower_name, fs_name, upper_name)		\
+static struct fs fs__##lower_name = {			\
+	.name = #fs_name,				\
+	.mounts = lower_name##__known_mountpoints,	\
+	.magic = upper_name##_MAGIC,			\
+	.mount_mutex = PTHREAD_MUTEX_INITIALIZER,	\
+};							\
+							\
+static void lower_name##_init_once(void)		\
+{							\
+	struct fs *fs = &fs__##lower_name;		\
+							\
+	fs__init_once(fs);				\
+}							\
+							\
+const char *lower_name##__mountpoint(void)		\
+{							\
+	static pthread_once_t init_once = PTHREAD_ONCE_INIT;	\
+	struct fs *fs = &fs__##lower_name;		\
+							\
+	pthread_once(&init_once, lower_name##_init_once);	\
+	return fs__mountpoint(fs);			\
+}							\
+							\
+const char *lower_name##__mount(void)			\
+{							\
+	const char *mountpoint = lower_name##__mountpoint();	\
+	struct fs *fs = &fs__##lower_name;		\
+							\
+	if (mountpoint)					\
+		return mountpoint;			\
+							\
+	return fs__mount(fs);				\
+}							\
+							\
+bool lower_name##__configured(void)			\
+{							\
+	return lower_name##__mountpoint() != NULL;	\
+}
+
+FS(sysfs, sysfs, SYSFS);
+FS(procfs, procfs, PROC_SUPER);
+FS(debugfs, debugfs, DEBUGFS);
+FS(tracefs, tracefs, TRACEFS);
+FS(hugetlbfs, hugetlbfs, HUGETLBFS);
+FS(bpf_fs, bpf, BPF_FS);
 
 static bool fs__read_mounts(struct fs *fs)
 {
-	bool found = false;
 	char type[100];
 	FILE *fp;
 	char path[PATH_MAX + 1];
@@ -157,22 +160,17 @@ static bool fs__read_mounts(struct fs *fs)
 	if (fp == NULL)
 		return false;
 
-	while (!found &&
-	       fscanf(fp, "%*s %" STR(PATH_MAX) "s %99s %*s %*d %*d\n",
+	while (fscanf(fp, "%*s %" STR(PATH_MAX) "s %99s %*s %*d %*d\n",
 		      path, type) == 2) {
 
 		if (strcmp(type, fs->name) == 0) {
-			free(fs->path);
 			fs->path = strdup(path);
-			if (!fs->path)
-				return false;
-			found = true;
+			fclose(fp);
+			return fs->path != NULL;
 		}
 	}
-
 	fclose(fp);
-	fs->checked = true;
-	return fs->found = found;
+	return false;
 }
 
 static int fs__valid_mount(const char *fs, long magic)
@@ -194,11 +192,9 @@ static bool fs__check_mounts(struct fs *fs)
 	ptr = fs->mounts;
 	while (*ptr) {
 		if (fs__valid_mount(*ptr, fs->magic) == 0) {
-			free(fs->path);
 			fs->path = strdup(*ptr);
 			if (!fs->path)
 				return false;
-			fs->found = true;
 			return true;
 		}
 		ptr++;
@@ -236,45 +232,26 @@ static bool fs__env_override(struct fs *fs)
 	if (!override_path)
 		return false;
 
-	free(fs->path);
 	fs->path = strdup(override_path);
 	if (!fs->path)
 		return false;
-	fs->found = true;
-	fs->checked = true;
 	return true;
 }
 
-static const char *fs__get_mountpoint(struct fs *fs)
+static void fs__init_once(struct fs *fs)
 {
-	if (fs__env_override(fs))
-		return fs->path;
-
-	if (fs__check_mounts(fs))
-		return fs->path;
-
-	if (fs__read_mounts(fs))
-		return fs->path;
-
-	return NULL;
+	if (!fs__env_override(fs) &&
+	    !fs__check_mounts(fs) &&
+	    !fs__read_mounts(fs)) {
+		assert(!fs->path);
+	} else {
+		assert(fs->path);
+	}
 }
 
-static const char *fs__mountpoint(int idx)
+static const char *fs__mountpoint(const struct fs *fs)
 {
-	struct fs *fs = &fs__entries[idx];
-
-	if (fs->found)
-		return (const char *)fs->path;
-
-	/* the mount point was already checked for the mount point
-	 * but and did not exist, so return NULL to avoid scanning again.
-	 * This makes the found and not found paths cost equivalent
-	 * in case of multiple calls.
-	 */
-	if (fs->checked)
-		return NULL;
-
-	return fs__get_mountpoint(fs);
+	return fs->path;
 }
 
 static const char *mount_overload(struct fs *fs)
@@ -289,45 +266,29 @@ static const char *mount_overload(struct fs *fs)
 	return getenv(upper_name) ?: *fs->mounts;
 }
 
-static const char *fs__mount(int idx)
+static const char *fs__mount(struct fs *fs)
 {
-	struct fs *fs = &fs__entries[idx];
 	const char *mountpoint;
 
-	if (fs__mountpoint(idx))
-		return (const char *)fs->path;
+	pthread_mutex_lock(&fs->mount_mutex);
 
-	mountpoint = mount_overload(fs);
+	/* Check if path found inside the mutex to avoid races with other callers of mount. */
+	mountpoint = fs__mountpoint(fs);
+	if (mountpoint)
+		goto out;
 
-	if (mount(NULL, mountpoint, fs->name, 0, NULL) < 0)
-		return NULL;
-
-	return fs__check_mounts(fs) ? fs->path : NULL;
-}
+	mountpoint = mount_overload(fs);
 
-#define FS(name, idx)				\
-const char *name##__mountpoint(void)		\
-{						\
-	return fs__mountpoint(idx);		\
-}						\
-						\
-const char *name##__mount(void)			\
-{						\
-	return fs__mount(idx);			\
-}						\
-						\
-bool name##__configured(void)			\
-{						\
-	return name##__mountpoint() != NULL;	\
+	if (mount(NULL, mountpoint, fs->name, 0, NULL) == 0 &&
+	    fs__valid_mount(mountpoint, fs->magic) == 0) {
+		fs->path = strdup(mountpoint);
+		mountpoint = fs->path;
+	}
+out:
+	pthread_mutex_unlock(&fs->mount_mutex);
+	return mountpoint;
 }
 
-FS(sysfs,   FS__SYSFS);
-FS(procfs,  FS__PROCFS);
-FS(debugfs, FS__DEBUGFS);
-FS(tracefs, FS__TRACEFS);
-FS(hugetlbfs, FS__HUGETLBFS);
-FS(bpf_fs, FS__BPF_FS);
-
 int filename__read_int(const char *filename, int *value)
 {
 	char line[64];
-- 
2.41.0.162.gfafddb0af9-goog


