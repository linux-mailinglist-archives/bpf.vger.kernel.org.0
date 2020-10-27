Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5722F29BF9C
	for <lists+bpf@lfdr.de>; Tue, 27 Oct 2020 18:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1815653AbgJ0RDt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Oct 2020 13:03:49 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:38518 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1815601AbgJ0RD3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Oct 2020 13:03:29 -0400
Received: by mail-ej1-f68.google.com with SMTP id ce10so3286755ejc.5
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2020 10:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zqoXqcvWMBPlSXei6ErKneHNqWSBzP4hmrekRQ6svS4=;
        b=fNC63AfmPG0NHSC10dqVBDM3uNBAK7TLW/sS92s88m9ODkLb7LoaR1nMCuOxljKY7X
         Y8HE/wk09eqFUi0pA3cKfLDBR/VnyBJTrsaXsjz/qXnNf4QYxpME3VOj/V9xgDJs1T5c
         IKfIe/4YDTENuVSvUp382qThDt8UYKSivd5c0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zqoXqcvWMBPlSXei6ErKneHNqWSBzP4hmrekRQ6svS4=;
        b=PR3rLz5zohX/Acc5N6sq5YF1gsdrmTEHDMcyxoQdie8zrAScDLQasSRpIHmfBxw7Gq
         sc4mbjeCzpqpdZWBuNYno+ESNSIoLc4FB2PF3fLE2bnAakYzRcuKMOS2lbbSJJc61GXs
         IH9S//F+Iu+dxfRi1YcqNPy29qX6Wqf1AbCjqhJInZUHgOJ+cNoZKW3HXE4MhWcJxyZQ
         iJSdRpNlrZ10bTtoYjlef9oFOtnTOqBtOYS8g48jQiAUxe4O9TkAOUyeGABNcR+si7yl
         BAtqRB9Pxgh79s7shc1g2MSj6KUMYZX+3GWvq/wMcNzkao9NY1CYHfniZMOZXc1qnkXF
         qK0A==
X-Gm-Message-State: AOAM532bc+Ohkc07JCPNtAmJOkjs7tML45pPL1JzWr1pDu51KMNPiZL2
        G+bNkVs/G9iHgDGJLX7SAPIfQw==
X-Google-Smtp-Source: ABdhPJweX2pvG1phfMHU46cZlbs0xKBIkvFY94ledyRve6QiU1K71Z0TNZ24x399+8NW2RXCU5n3OA==
X-Received: by 2002:a17:906:23f2:: with SMTP id j18mr3290276ejg.526.1603818206443;
        Tue, 27 Oct 2020 10:03:26 -0700 (PDT)
Received: from kpsingh.zrh.corp.google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id ba6sm1315006edb.61.2020.10.27.10.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 10:03:25 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Hao Luo <haoluo@google.com>
Subject: [PATCH bpf-next 5/5] bpf: Add tests for task_local_storage
Date:   Tue, 27 Oct 2020 18:03:17 +0100
Message-Id: <20201027170317.2011119-6-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.0.rc2.309.g374f81d7ae-goog
In-Reply-To: <20201027170317.2011119-1-kpsingh@chromium.org>
References: <20201027170317.2011119-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

The test implements a simple MAC policy which denies an executable
from unlinking itself. The LSM program bprm_committed_creds sets a
task_local_storage with a pointer to the inode. This is then used to
detect if the task is trying to unlink itself in the inode_unlink LSM
hook.

The test copies /bin/rm to /tmp and executes it in a child thread with
the intention of deleting itself. A successful test should prevent the
the running executable from deleting itself.

The temporary file is cleaned up later in the test.

Signed-off-by: KP Singh <kpsingh@google.com>
---
 .../bpf/prog_tests/test_local_storage.c       | 89 ++++++++++++++++---
 .../selftests/bpf/progs/local_storage.c       | 44 +++++++--
 2 files changed, 116 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_local_storage.c b/tools/testing/selftests/bpf/prog_tests/test_local_storage.c
index 91cd6f357246..0e41b27f3471 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_local_storage.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_local_storage.c
@@ -4,30 +4,83 @@
  * Copyright (C) 2020 Google LLC.
  */
 
+#define _GNU_SOURCE
+
+#include <asm-generic/errno-base.h>
+#include <unistd.h>
+#include <sys/stat.h>
 #include <test_progs.h>
 #include <linux/limits.h>
 
 #include "local_storage.skel.h"
 #include "network_helpers.h"
 
-int create_and_unlink_file(void)
+/* Copies an rm binary to a temp file. dest is a mkstemp template */
+int copy_rm(char *dest)
 {
-	char fname[PATH_MAX] = "/tmp/fileXXXXXX";
-	int fd;
+	int ret, fd_in, fd_out;
+	struct stat stat;
+
+	fd_in = open("/bin/rm", O_RDONLY);
+	if (fd_in < 0)
+		return fd_in;
+
+	fd_out = mkstemp(dest);
+	if (fd_out < 0)
+		return fd_out;
 
-	fd = mkstemp(fname);
-	if (fd < 0)
-		return fd;
+	ret = fstat(fd_in, &stat);
+	if (ret == -1)
+		return errno;
 
-	close(fd);
-	unlink(fname);
+	ret = copy_file_range(fd_in, NULL, fd_out, NULL, stat.st_size, 0);
+	if (ret == -1)
+		return errno;
+
+	/* Set executable permission on the copied file */
+	ret = chmod(dest, 0100);
+	if (ret == -1)
+		return errno;
+
+	close(fd_in);
+	close(fd_out);
 	return 0;
 }
+/* Fork and exec the provided rm binary and return the exit code of the
+ * forked process and its pid.
+ */
+int run_self_unlink(int *monitored_pid, const char *rm_path)
+{
+	int child_pid, child_status, ret;
+	int null_fd;
+
+	child_pid = fork();
+	if (child_pid == 0) {
+		null_fd = open("/dev/null", O_WRONLY);
+		dup2(null_fd, STDOUT_FILENO);
+		dup2(null_fd, STDERR_FILENO);
+		close(null_fd);
+
+		*monitored_pid = getpid();
+		/* Use the copied /usr/bin/rm to delete itself
+		 * /tmp/copy_of_rm /tmp/copy_of_rm.
+		 */
+		ret = execlp(rm_path, rm_path, rm_path, NULL);
+		if (ret)
+			exit(errno);
+	} else if (child_pid > 0) {
+		waitpid(child_pid, &child_status, 0);
+		return WEXITSTATUS(child_status);
+	}
+
+	return -EINVAL;
+}
 
 void test_test_local_storage(void)
 {
 	struct local_storage *skel = NULL;
 	int err, duration = 0, serv_sk = -1;
+	char tmp_exec_path[PATH_MAX] = "/tmp/copy_of_rmXXXXXX";
 
 	skel = local_storage__open_and_load();
 	if (CHECK(!skel, "skel_load", "lsm skeleton failed\n"))
@@ -37,10 +90,26 @@ void test_test_local_storage(void)
 	if (CHECK(err, "attach", "lsm attach failed: %d\n", err))
 		goto close_prog;
 
+	err = copy_rm(tmp_exec_path);
+	if (CHECK(err < 0, "copy_executable", "err %d errno %d\n", err, errno))
+		goto close_prog;
+
+	/* Sets skel->bss->monitored_pid to the pid of the forked child
+	 * forks a child process that executes tmp_exec_path and tries to
+	 * unlink its executable. This operation should be denied by the loaded
+	 * LSM program.
+	 */
+	err = run_self_unlink(&skel->bss->monitored_pid, tmp_exec_path);
+	if (CHECK(err != EPERM, "run_self_unlink", "err %d want EPERM\n", err))
+		goto close_prog;
+
+	/* Set the process being monitored to be the current process */
 	skel->bss->monitored_pid = getpid();
 
-	err = create_and_unlink_file();
-	if (CHECK(err < 0, "exec_cmd", "err %d errno %d\n", err, errno))
+	/* Remove the temporary created executable */
+	err = unlink(tmp_exec_path);
+	if (CHECK(err != 0, "unlink", "unable to unlink %s: %d", tmp_exec_path,
+		  errno))
 		goto close_prog;
 
 	CHECK(skel->data->inode_storage_result != 0, "inode_storage_result",
diff --git a/tools/testing/selftests/bpf/progs/local_storage.c b/tools/testing/selftests/bpf/progs/local_storage.c
index 5acf9203a69a..eb280cd0c416 100644
--- a/tools/testing/selftests/bpf/progs/local_storage.c
+++ b/tools/testing/selftests/bpf/progs/local_storage.c
@@ -17,7 +17,8 @@ int monitored_pid = 0;
 int inode_storage_result = -1;
 int sk_storage_result = -1;
 
-struct dummy_storage {
+struct local_storage {
+	struct inode *exec_inode;
 	__u32 value;
 };
 
@@ -25,26 +26,40 @@ struct {
 	__uint(type, BPF_MAP_TYPE_INODE_STORAGE);
 	__uint(map_flags, BPF_F_NO_PREALLOC);
 	__type(key, int);
-	__type(value, struct dummy_storage);
+	__type(value, struct local_storage);
 } inode_storage_map SEC(".maps");
 
 struct {
 	__uint(type, BPF_MAP_TYPE_SK_STORAGE);
 	__uint(map_flags, BPF_F_NO_PREALLOC | BPF_F_CLONE);
 	__type(key, int);
-	__type(value, struct dummy_storage);
+	__type(value, struct local_storage);
 } sk_storage_map SEC(".maps");
 
+struct {
+	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC | BPF_F_CLONE);
+	__type(key, int);
+	__type(value, struct local_storage);
+} task_storage_map SEC(".maps");
+
 SEC("lsm/inode_unlink")
 int BPF_PROG(unlink_hook, struct inode *dir, struct dentry *victim)
 {
 	__u32 pid = bpf_get_current_pid_tgid() >> 32;
-	struct dummy_storage *storage;
+	struct local_storage *storage;
 	int err;
 
 	if (pid != monitored_pid)
 		return 0;
 
+	storage = bpf_task_storage_get(&task_storage_map,
+				       bpf_get_current_task_btf(), 0, 0);
+
+	/* Don't let an executable delete itself */
+	if (storage && storage->exec_inode == victim->d_inode)
+		return -EPERM;
+
 	storage = bpf_inode_storage_get(&inode_storage_map, victim->d_inode, 0,
 				     BPF_SK_STORAGE_GET_F_CREATE);
 	if (!storage)
@@ -65,7 +80,7 @@ int BPF_PROG(socket_bind, struct socket *sock, struct sockaddr *address,
 	     int addrlen)
 {
 	__u32 pid = bpf_get_current_pid_tgid() >> 32;
-	struct dummy_storage *storage;
+	struct local_storage *storage;
 	int err;
 
 	if (pid != monitored_pid)
@@ -91,7 +106,7 @@ int BPF_PROG(socket_post_create, struct socket *sock, int family, int type,
 	     int protocol, int kern)
 {
 	__u32 pid = bpf_get_current_pid_tgid() >> 32;
-	struct dummy_storage *storage;
+	struct local_storage *storage;
 
 	if (pid != monitored_pid)
 		return 0;
@@ -110,7 +125,7 @@ SEC("lsm/file_open")
 int BPF_PROG(file_open, struct file *file)
 {
 	__u32 pid = bpf_get_current_pid_tgid() >> 32;
-	struct dummy_storage *storage;
+	struct local_storage *storage;
 
 	if (pid != monitored_pid)
 		return 0;
@@ -126,3 +141,18 @@ int BPF_PROG(file_open, struct file *file)
 	storage->value = DUMMY_STORAGE_VALUE;
 	return 0;
 }
+
+/* This uses the local storage to remember the inode of the binary that a
+ * process was originally executing.
+ */
+SEC("lsm/bprm_committed_creds")
+void BPF_PROG(exec, struct linux_binprm *bprm)
+{
+	struct local_storage *storage;
+
+	storage = bpf_task_storage_get(&task_storage_map,
+				       bpf_get_current_task_btf(), 0,
+				       BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (storage)
+		storage->exec_inode = bprm->file->f_inode;
+}
-- 
2.29.0.rc2.309.g374f81d7ae-goog

