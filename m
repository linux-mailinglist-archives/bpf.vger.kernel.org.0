Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F69457D863
	for <lists+bpf@lfdr.de>; Fri, 22 Jul 2022 04:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234223AbiGVCOE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Jul 2022 22:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234130AbiGVCNp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Jul 2022 22:13:45 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CDF97A3B
        for <bpf@vger.kernel.org>; Thu, 21 Jul 2022 19:13:28 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-31cd7ade3d6so28912647b3.3
        for <bpf@vger.kernel.org>; Thu, 21 Jul 2022 19:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+WV7ert0ty8LIQsE/tdYaR0HAsGCng15D/9m8ABwNVc=;
        b=fqzHoZmhvYnYGcnZZF62lur7g5EIARjJu6MKLIFYzdKkfPlh1e9ZWKSDbngvVYh4+S
         87MgZTI4dySMSjMiUTFMbK2EkdQx+MYn+ecuzdUMXZMOAgtq/dme8f6Q3zKwolytCD60
         yZ3H0OTIOJxOZkmB6fqwkKLrIG0++um89Lx22qUX55kji7Zpau+AYgmxvoPagEeBxVat
         qohjdhSCPnoirsL9yv4BW7smNVGZH6dkqKKU7ejd+8igdnYWW6L1E5PQ8gbc33jhFQVx
         tGD8cb0eA8BiI1KP6n/xuR/eQ3cwGiSUpKB/mvpbs1C3ctvRbESIIwQl9+v3yZFW1bsl
         7Icg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+WV7ert0ty8LIQsE/tdYaR0HAsGCng15D/9m8ABwNVc=;
        b=5xPchmPv7NGpPpwlwYZFaB4mz0vzsip0t4CHKP3HE11ChfWs+bCUpsf2M+8KurrVlv
         j4Ll4nrLi6gPgr32NSc5uJsiHsK8+svAkwsY71s4Drs/SHLTBApAog80OLC5VbdUxFsf
         sDlHfpPmmE5QZrx2HCjMqCG1xKmnfKyOtF5ywjHokdG/faTgi2C0VJNdDvWGXy69brPH
         EVdYoU38PxLrBgWQ27M3Z0MrO0FhFX+D03X2phVVdygM+ivaDB9XxEHPB/IFHz6652g2
         u3KstkqjO2M3kfpE5DHbLbWHVByq6yiUptDyz6sMWdTrvF4ALxwmCXzxUbCM9prifSpt
         enHg==
X-Gm-Message-State: AJIora/lsMWG3RwW97Hwc54biB3VJ5IsQU5LHpcmUvGPaP5mt2MB+pn3
        bFq7xDDS9qOKndta4pFVQ09Nc7dNN3PJZRPE
X-Google-Smtp-Source: AGRyM1vXHd/+6wWJgY8funfoq2EF3MTv8Hhs3S6r1LwsBxlpeCPm43F6xP3aIvoygII+w7OZPDLkBYrliANOYcY3
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a81:49d7:0:b0:31e:5847:4408 with SMTP
 id w206-20020a8149d7000000b0031e58474408mr1333166ywa.120.1658456007603; Thu,
 21 Jul 2022 19:13:27 -0700 (PDT)
Date:   Fri, 22 Jul 2022 02:13:12 +0000
In-Reply-To: <20220722021313.3150035-1-yosryahmed@google.com>
Message-Id: <20220722021313.3150035-8-yosryahmed@google.com>
Mime-Version: 1.0
References: <20220722021313.3150035-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH bpf-next v4 7/8] selftests/bpf: extend cgroup helpers
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        David Rientjes <rientjes@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, cgroups@vger.kernel.org,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch extends bpf selftests cgroup helpers in various ways:
- Add enable_controllers() that allows tests to enable all or a
  subset of controllers for a specific cgroup.
- Add join_cgroup_parent(). The cgroup workdir is based on the pid,
  therefore a spawned child cannot join the same cgroup hierarchy of the
  test through join_cgroup(). join_cgroup_parent() is used in child
  processes to join a cgroup under the parent's workdir.
- Add write_cgroup_file() and write_cgroup_file_parent() (similar to
  join_cgroup_parent() above).
- Add get_root_cgroup() for tests that need to do checks on root cgroup.
- Distinguish relative and absolute cgroup paths in function arguments.
  Now relative paths are called relative_path, and absolute paths are
  called cgroup_path.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 tools/testing/selftests/bpf/cgroup_helpers.c | 201 +++++++++++++++----
 tools/testing/selftests/bpf/cgroup_helpers.h |  19 +-
 2 files changed, 173 insertions(+), 47 deletions(-)

diff --git a/tools/testing/selftests/bpf/cgroup_helpers.c b/tools/testing/selftests/bpf/cgroup_helpers.c
index 9d59c3990ca8..f06a5a255e19 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.c
+++ b/tools/testing/selftests/bpf/cgroup_helpers.c
@@ -33,49 +33,51 @@
 #define CGROUP_MOUNT_DFLT		"/sys/fs/cgroup"
 #define NETCLS_MOUNT_PATH		CGROUP_MOUNT_DFLT "/net_cls"
 #define CGROUP_WORK_DIR			"/cgroup-test-work-dir"
-#define format_cgroup_path(buf, path) \
+
+#define format_cgroup_path_pid(buf, path, pid) \
 	snprintf(buf, sizeof(buf), "%s%s%d%s", CGROUP_MOUNT_PATH, \
-	CGROUP_WORK_DIR, getpid(), path)
+	CGROUP_WORK_DIR, pid, path)
+
+#define format_cgroup_path(buf, path) \
+	format_cgroup_path_pid(buf, path, getpid())
+
+#define format_parent_cgroup_path(buf, path) \
+	format_cgroup_path_pid(buf, path, getppid())
 
 #define format_classid_path(buf)				\
 	snprintf(buf, sizeof(buf), "%s%s", NETCLS_MOUNT_PATH,	\
 		 CGROUP_WORK_DIR)
 
-/**
- * enable_all_controllers() - Enable all available cgroup v2 controllers
- *
- * Enable all available cgroup v2 controllers in order to increase
- * the code coverage.
- *
- * If successful, 0 is returned.
- */
-static int enable_all_controllers(char *cgroup_path)
+
+static int __enable_controllers(const char *cgroup_path, const char *controllers)
 {
 	char path[PATH_MAX + 1];
-	char buf[PATH_MAX];
+	char enable[PATH_MAX + 1];
 	char *c, *c2;
 	int fd, cfd;
 	ssize_t len;
 
-	snprintf(path, sizeof(path), "%s/cgroup.controllers", cgroup_path);
-	fd = open(path, O_RDONLY);
-	if (fd < 0) {
-		log_err("Opening cgroup.controllers: %s", path);
-		return 1;
-	}
+	/* If not controllers are passed, enable all available controllers */
+	if (!controllers) {
+		snprintf(path, sizeof(path), "%s/cgroup.controllers",
+			 cgroup_path);
+		fd = open(path, O_RDONLY);
+		if (fd < 0) {
+			log_err("Opening cgroup.controllers: %s", path);
+			return 1;
+		}
 
-	len = read(fd, buf, sizeof(buf) - 1);
-	if (len < 0) {
+		len = read(fd, enable, sizeof(enable) - 1);
+		if (len < 0) {
+			close(fd);
+			log_err("Reading cgroup.controllers: %s", path);
+			return 1;
+		} else if (len == 0) /* No controllers to enable */
+			return 0;
+		enable[len] = 0;
 		close(fd);
-		log_err("Reading cgroup.controllers: %s", path);
-		return 1;
-	}
-	buf[len] = 0;
-	close(fd);
-
-	/* No controllers available? We're probably on cgroup v1. */
-	if (len == 0)
-		return 0;
+	} else
+		strncpy(enable, controllers, sizeof(enable));
 
 	snprintf(path, sizeof(path), "%s/cgroup.subtree_control", cgroup_path);
 	cfd = open(path, O_RDWR);
@@ -84,7 +86,7 @@ static int enable_all_controllers(char *cgroup_path)
 		return 1;
 	}
 
-	for (c = strtok_r(buf, " ", &c2); c; c = strtok_r(NULL, " ", &c2)) {
+	for (c = strtok_r(enable, " ", &c2); c; c = strtok_r(NULL, " ", &c2)) {
 		if (dprintf(cfd, "+%s\n", c) <= 0) {
 			log_err("Enabling controller %s: %s", c, path);
 			close(cfd);
@@ -95,6 +97,87 @@ static int enable_all_controllers(char *cgroup_path)
 	return 0;
 }
 
+/**
+ * enable_controllers() - Enable cgroup v2 controllers
+ * @relative_path: The cgroup path, relative to the workdir
+ * @controllers: List of controllers to enable in cgroup.controllers format
+ *
+ *
+ * Enable given cgroup v2 controllers, if @controllers is NULL, enable all
+ * available controllers.
+ *
+ * If successful, 0 is returned.
+ */
+int enable_controllers(const char *relative_path, const char *controllers)
+{
+	char cgroup_path[PATH_MAX + 1];
+
+	format_cgroup_path(cgroup_path, relative_path);
+	return __enable_controllers(cgroup_path, controllers);
+}
+
+static int __write_cgroup_file(const char *cgroup_path, const char *file,
+			       const char *buf)
+{
+	char file_path[PATH_MAX + 1];
+	int fd;
+
+	snprintf(file_path, sizeof(file_path), "%s/%s", cgroup_path, file);
+	fd = open(file_path, O_RDWR);
+	if (fd < 0) {
+		log_err("Opening %s", file_path);
+		return 1;
+	}
+
+	if (dprintf(fd, "%s", buf) <= 0) {
+		log_err("Writing to %s", file_path);
+		close(fd);
+		return 1;
+	}
+	close(fd);
+	return 0;
+}
+
+/**
+ * write_cgroup_file() - Write to a cgroup file
+ * @relative_path: The cgroup path, relative to the workdir
+ * @file: The name of the file in cgroupfs to write to
+ * @buf: Buffer to write to the file
+ *
+ * Write to a file in the given cgroup's directory.
+ *
+ * If successful, 0 is returned.
+ */
+int write_cgroup_file(const char *relative_path, const char *file,
+		      const char *buf)
+{
+	char cgroup_path[PATH_MAX - 24];
+
+	format_cgroup_path(cgroup_path, relative_path);
+	return __write_cgroup_file(cgroup_path, file, buf);
+}
+
+/**
+ * write_cgroup_file_parent() - Write to a cgroup file in the parent process
+ *                              workdir
+ * @relative_path: The cgroup path, relative to the parent process workdir
+ * @file: The name of the file in cgroupfs to write to
+ * @buf: Buffer to write to the file
+ *
+ * Write to a file in the given cgroup's directory under the parent process
+ * workdir.
+ *
+ * If successful, 0 is returned.
+ */
+int write_cgroup_file_parent(const char *relative_path, const char *file,
+			     const char *buf)
+{
+	char cgroup_path[PATH_MAX - 24];
+
+	format_parent_cgroup_path(cgroup_path, relative_path);
+	return __write_cgroup_file(cgroup_path, file, buf);
+}
+
 /**
  * setup_cgroup_environment() - Setup the cgroup environment
  *
@@ -133,7 +216,9 @@ int setup_cgroup_environment(void)
 		return 1;
 	}
 
-	if (enable_all_controllers(cgroup_workdir))
+	/* Enable all available controllers to increase test coverage */
+	if (__enable_controllers(CGROUP_MOUNT_PATH, NULL) ||
+	    __enable_controllers(cgroup_workdir, NULL))
 		return 1;
 
 	return 0;
@@ -173,7 +258,7 @@ static int join_cgroup_from_top(const char *cgroup_path)
 
 /**
  * join_cgroup() - Join a cgroup
- * @path: The cgroup path, relative to the workdir, to join
+ * @relative_path: The cgroup path, relative to the workdir, to join
  *
  * This function expects a cgroup to already be created, relative to the cgroup
  * work dir, and it joins it. For example, passing "/my-cgroup" as the path
@@ -182,11 +267,27 @@ static int join_cgroup_from_top(const char *cgroup_path)
  *
  * On success, it returns 0, otherwise on failure it returns 1.
  */
-int join_cgroup(const char *path)
+int join_cgroup(const char *relative_path)
+{
+	char cgroup_path[PATH_MAX + 1];
+
+	format_cgroup_path(cgroup_path, relative_path);
+	return join_cgroup_from_top(cgroup_path);
+}
+
+/**
+ * join_parent_cgroup() - Join a cgroup in the parent process workdir
+ * @relative_path: The cgroup path, relative to parent process workdir, to join
+ *
+ * See join_cgroup().
+ *
+ * On success, it returns 0, otherwise on failure it returns 1.
+ */
+int join_parent_cgroup(const char *relative_path)
 {
 	char cgroup_path[PATH_MAX + 1];
 
-	format_cgroup_path(cgroup_path, path);
+	format_parent_cgroup_path(cgroup_path, relative_path);
 	return join_cgroup_from_top(cgroup_path);
 }
 
@@ -212,9 +313,27 @@ void cleanup_cgroup_environment(void)
 	nftw(cgroup_workdir, nftwfunc, WALK_FD_LIMIT, FTW_DEPTH | FTW_MOUNT);
 }
 
+/**
+ * get_root_cgroup() - Get the FD of the root cgroup
+ *
+ * On success, it returns the file descriptor. On failure, it returns -1.
+ * If there is a failure, it prints the error to stderr.
+ */
+int get_root_cgroup(void)
+{
+	int fd;
+
+	fd = open(CGROUP_MOUNT_PATH, O_RDONLY);
+	if (fd < 0) {
+		log_err("Opening root cgroup");
+		return -1;
+	}
+	return fd;
+}
+
 /**
  * create_and_get_cgroup() - Create a cgroup, relative to workdir, and get the FD
- * @path: The cgroup path, relative to the workdir, to join
+ * @relative_path: The cgroup path, relative to the workdir, to join
  *
  * This function creates a cgroup under the top level workdir and returns the
  * file descriptor. It is idempotent.
@@ -222,14 +341,14 @@ void cleanup_cgroup_environment(void)
  * On success, it returns the file descriptor. On failure it returns -1.
  * If there is a failure, it prints the error to stderr.
  */
-int create_and_get_cgroup(const char *path)
+int create_and_get_cgroup(const char *relative_path)
 {
 	char cgroup_path[PATH_MAX + 1];
 	int fd;
 
-	format_cgroup_path(cgroup_path, path);
+	format_cgroup_path(cgroup_path, relative_path);
 	if (mkdir(cgroup_path, 0777) && errno != EEXIST) {
-		log_err("mkdiring cgroup %s .. %s", path, cgroup_path);
+		log_err("mkdiring cgroup %s .. %s", relative_path, cgroup_path);
 		return -1;
 	}
 
@@ -244,13 +363,13 @@ int create_and_get_cgroup(const char *path)
 
 /**
  * get_cgroup_id() - Get cgroup id for a particular cgroup path
- * @path: The cgroup path, relative to the workdir, to join
+ * @relative_path: The cgroup path, relative to the workdir, to join
  *
  * On success, it returns the cgroup id. On failure it returns 0,
  * which is an invalid cgroup id.
  * If there is a failure, it prints the error to stderr.
  */
-unsigned long long get_cgroup_id(const char *path)
+unsigned long long get_cgroup_id(const char *relative_path)
 {
 	int dirfd, err, flags, mount_id, fhsize;
 	union {
@@ -261,7 +380,7 @@ unsigned long long get_cgroup_id(const char *path)
 	struct file_handle *fhp, *fhp2;
 	unsigned long long ret = 0;
 
-	format_cgroup_path(cgroup_workdir, path);
+	format_cgroup_path(cgroup_workdir, relative_path);
 
 	dirfd = AT_FDCWD;
 	flags = 0;
diff --git a/tools/testing/selftests/bpf/cgroup_helpers.h b/tools/testing/selftests/bpf/cgroup_helpers.h
index fcc9cb91b211..3358734356ab 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.h
+++ b/tools/testing/selftests/bpf/cgroup_helpers.h
@@ -10,11 +10,18 @@
 	__FILE__, __LINE__, clean_errno(), ##__VA_ARGS__)
 
 /* cgroupv2 related */
-int cgroup_setup_and_join(const char *path);
-int create_and_get_cgroup(const char *path);
-unsigned long long get_cgroup_id(const char *path);
-
-int join_cgroup(const char *path);
+int enable_controllers(const char *relative_path, const char *controllers);
+int write_cgroup_file(const char *relative_path, const char *file,
+		      const char *buf);
+int write_cgroup_file_parent(const char *relative_path, const char *file,
+			     const char *buf);
+int cgroup_setup_and_join(const char *relative_path);
+int get_root_cgroup(void);
+int create_and_get_cgroup(const char *relative_path);
+unsigned long long get_cgroup_id(const char *relative_path);
+
+int join_cgroup(const char *relative_path);
+int join_parent_cgroup(const char *relative_path);
 
 int setup_cgroup_environment(void);
 void cleanup_cgroup_environment(void);
@@ -26,4 +33,4 @@ int join_classid(void);
 int setup_classid_environment(void);
 void cleanup_classid_environment(void);
 
-#endif /* __CGROUP_HELPERS_H */
\ No newline at end of file
+#endif /* __CGROUP_HELPERS_H */
-- 
2.37.1.359.gd136c6c3e2-goog

