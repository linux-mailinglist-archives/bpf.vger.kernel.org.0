Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D86440A158
	for <lists+bpf@lfdr.de>; Tue, 14 Sep 2021 01:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343951AbhIMXM0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Sep 2021 19:12:26 -0400
Received: from www62.your-server.de ([213.133.104.62]:42368 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349432AbhIMXL6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Sep 2021 19:11:58 -0400
Received: from 65.47.5.85.dynamic.wline.res.cust.swisscom.ch ([85.5.47.65] helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1mPv3T-000EhP-Kz; Tue, 14 Sep 2021 01:08:03 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, tj@kernel.org, davem@davemloft.net,
        m@lambda.lt, alexei.starovoitov@gmail.com, andrii@kernel.org,
        sdf@google.com, Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf v4 2/3] bpf, selftests: Add cgroup v1 net_cls classid helpers
Date:   Tue, 14 Sep 2021 01:07:58 +0200
Message-Id: <20210913230759.2313-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210913230759.2313-1-daniel@iogearbox.net>
References: <20210913230759.2313-1-daniel@iogearbox.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.2/26293/Mon Sep 13 10:23:39 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Minimal set of helpers for net_cls classid cgroupv1 management in order
to set an id, join from a process, initiate setup and teardown. cgroupv2
helpers are left as-is, but reused where possible.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 v2 -> v3:
  - Extend setup_classid_environment to mount if net_cls is not present
    as caught by BPF CI
 v3 -> v4:
  - Also had to mount tmpfs to get CI eventually working

 tools/testing/selftests/bpf/cgroup_helpers.c | 137 +++++++++++++++++--
 tools/testing/selftests/bpf/cgroup_helpers.h |  16 ++-
 2 files changed, 141 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/cgroup_helpers.c b/tools/testing/selftests/bpf/cgroup_helpers.c
index 033051717ba5..f3daa44a8266 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.c
+++ b/tools/testing/selftests/bpf/cgroup_helpers.c
@@ -12,27 +12,36 @@
 #include <unistd.h>
 #include <ftw.h>
 
-
 #include "cgroup_helpers.h"
 
 /*
  * To avoid relying on the system setup, when setup_cgroup_env is called
- * we create a new mount namespace, and cgroup namespace. The cgroup2
- * root is mounted at CGROUP_MOUNT_PATH
- *
- * Unfortunately, most people don't have cgroupv2 enabled at this point in time.
- * It's easier to create our own mount namespace and manage it ourselves.
+ * we create a new mount namespace, and cgroup namespace. The cgroupv2
+ * root is mounted at CGROUP_MOUNT_PATH. Unfortunately, most people don't
+ * have cgroupv2 enabled at this point in time. It's easier to create our
+ * own mount namespace and manage it ourselves. We assume /mnt exists.
  *
- * We assume /mnt exists.
+ * Related cgroupv1 helpers are named *classid*(), since we only use the
+ * net_cls controller for tagging net_cls.classid. We assume the default
+ * mount under /sys/fs/cgroup/net_cls, which should be the case for the
+ * vast majority of users.
  */
 
 #define WALK_FD_LIMIT			16
+
 #define CGROUP_MOUNT_PATH		"/mnt"
+#define CGROUP_MOUNT_DFLT		"/sys/fs/cgroup"
+#define NETCLS_MOUNT_PATH		CGROUP_MOUNT_DFLT "/net_cls"
 #define CGROUP_WORK_DIR			"/cgroup-test-work-dir"
+
 #define format_cgroup_path(buf, path) \
 	snprintf(buf, sizeof(buf), "%s%s%s", CGROUP_MOUNT_PATH, \
 		 CGROUP_WORK_DIR, path)
 
+#define format_classid_path(buf)				\
+	snprintf(buf, sizeof(buf), "%s%s", NETCLS_MOUNT_PATH,	\
+		 CGROUP_WORK_DIR)
+
 /**
  * enable_all_controllers() - Enable all available cgroup v2 controllers
  *
@@ -139,8 +148,7 @@ static int nftwfunc(const char *filename, const struct stat *statptr,
 	return 0;
 }
 
-
-static int join_cgroup_from_top(char *cgroup_path)
+static int join_cgroup_from_top(const char *cgroup_path)
 {
 	char cgroup_procs_path[PATH_MAX + 1];
 	pid_t pid = getpid();
@@ -313,3 +321,114 @@ int cgroup_setup_and_join(const char *path) {
 	}
 	return cg_fd;
 }
+
+/**
+ * setup_classid_environment() - Setup the cgroupv1 net_cls environment
+ *
+ * After calling this function, cleanup_classid_environment should be called
+ * once testing is complete.
+ *
+ * This function will print an error to stderr and return 1 if it is unable
+ * to setup the cgroup environment. If setup is successful, 0 is returned.
+ */
+int setup_classid_environment(void)
+{
+	char cgroup_workdir[PATH_MAX + 1];
+
+	format_classid_path(cgroup_workdir);
+
+	if (mount("tmpfs", CGROUP_MOUNT_DFLT, "tmpfs", 0, NULL) &&
+	    errno != EBUSY) {
+		log_err("mount cgroup base");
+		return 1;
+	}
+
+	if (mkdir(NETCLS_MOUNT_PATH, 0777) && errno != EEXIST) {
+		log_err("mkdir cgroup net_cls");
+		return 1;
+	}
+
+	if (mount("net_cls", NETCLS_MOUNT_PATH, "cgroup", 0, "net_cls") &&
+	    errno != EBUSY) {
+		log_err("mount cgroup net_cls");
+		return 1;
+	}
+
+	cleanup_classid_environment();
+
+	if (mkdir(cgroup_workdir, 0777) && errno != EEXIST) {
+		log_err("mkdir cgroup work dir");
+		return 1;
+	}
+
+	return 0;
+}
+
+/**
+ * set_classid() - Set a cgroupv1 net_cls classid
+ * @id: the numeric classid
+ *
+ * Writes the passed classid into the cgroup work dir's net_cls.classid
+ * file in order to later on trigger socket tagging.
+ *
+ * On success, it returns 0, otherwise on failure it returns 1. If there
+ * is a failure, it prints the error to stderr.
+ */
+int set_classid(unsigned int id)
+{
+	char cgroup_workdir[PATH_MAX - 42];
+	char cgroup_classid_path[PATH_MAX + 1];
+	int fd, rc = 0;
+
+	format_classid_path(cgroup_workdir);
+	snprintf(cgroup_classid_path, sizeof(cgroup_classid_path),
+		 "%s/net_cls.classid", cgroup_workdir);
+
+	fd = open(cgroup_classid_path, O_WRONLY);
+	if (fd < 0) {
+		log_err("Opening cgroup classid: %s", cgroup_classid_path);
+		return 1;
+	}
+
+	if (dprintf(fd, "%u\n", id) < 0) {
+		log_err("Setting cgroup classid");
+		rc = 1;
+	}
+
+	close(fd);
+	return rc;
+}
+
+/**
+ * join_classid() - Join a cgroupv1 net_cls classid
+ *
+ * This function expects the cgroup work dir to be already created, as we
+ * join it here. This causes the process sockets to be tagged with the given
+ * net_cls classid.
+ *
+ * On success, it returns 0, otherwise on failure it returns 1.
+ */
+int join_classid(void)
+{
+	char cgroup_workdir[PATH_MAX + 1];
+
+	format_classid_path(cgroup_workdir);
+	return join_cgroup_from_top(cgroup_workdir);
+}
+
+/**
+ * cleanup_classid_environment() - Cleanup the cgroupv1 net_cls environment
+ *
+ * At call time, it moves the calling process to the root cgroup, and then
+ * runs the deletion process.
+ *
+ * On failure, it will print an error to stderr, and try to continue.
+ */
+void cleanup_classid_environment(void)
+{
+	char cgroup_workdir[PATH_MAX + 1];
+
+	format_classid_path(cgroup_workdir);
+	join_cgroup_from_top(NETCLS_MOUNT_PATH);
+	nftw(cgroup_workdir, nftwfunc, WALK_FD_LIMIT, FTW_DEPTH | FTW_MOUNT);
+}
diff --git a/tools/testing/selftests/bpf/cgroup_helpers.h b/tools/testing/selftests/bpf/cgroup_helpers.h
index 5fe3d88e4f0d..629da3854b3e 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.h
+++ b/tools/testing/selftests/bpf/cgroup_helpers.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef __CGROUP_HELPERS_H
 #define __CGROUP_HELPERS_H
+
 #include <errno.h>
 #include <string.h>
 
@@ -8,12 +9,21 @@
 #define log_err(MSG, ...) fprintf(stderr, "(%s:%d: errno: %s) " MSG "\n", \
 	__FILE__, __LINE__, clean_errno(), ##__VA_ARGS__)
 
-
+/* cgroupv2 related */
 int cgroup_setup_and_join(const char *path);
 int create_and_get_cgroup(const char *path);
+unsigned long long get_cgroup_id(const char *path);
+
 int join_cgroup(const char *path);
+
 int setup_cgroup_environment(void);
 void cleanup_cgroup_environment(void);
-unsigned long long get_cgroup_id(const char *path);
 
-#endif
+/* cgroupv1 related */
+int set_classid(unsigned int id);
+int join_classid(void);
+
+int setup_classid_environment(void);
+void cleanup_classid_environment(void);
+
+#endif /* __CGROUP_HELPERS_H */
-- 
2.27.0

