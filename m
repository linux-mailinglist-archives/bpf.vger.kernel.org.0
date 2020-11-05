Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3811A2A814D
	for <lists+bpf@lfdr.de>; Thu,  5 Nov 2020 15:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730788AbgKEOsh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Nov 2020 09:48:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731234AbgKEOsJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Nov 2020 09:48:09 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9C9C0613CF
        for <bpf@vger.kernel.org>; Thu,  5 Nov 2020 06:48:07 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id o9so3035220ejg.1
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2020 06:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bfcTcfxBUXUo/rquci5lcju84a9v0kx0TTqHn8xfiB8=;
        b=cByYGzeOhKbBKKt/IJItzWV2OgmXSUFWIiiXeh5AgJWec35nxzns+Kw0thKdSPoDjM
         lnadI+Uho/jTyQhVuMhnlefT0cpKaqj90PvWhWnEnDAzJv5DP4NJHEsFUVjVyBIPNIIT
         W32LNCG8yIIctVPuEOhR2MrY0zqqqFFdru4cA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bfcTcfxBUXUo/rquci5lcju84a9v0kx0TTqHn8xfiB8=;
        b=DZPQkuIc8JIF1UnXOeBHenuRjRdukPT/88EcYqW5UlCxu7qXV3BOF1UbIuw5eihrxF
         Je3+2W9IldC43ixMPQUyAP58MGMPnzrQwKeIERmvD1sGpgHkAOlXA3nOka7NPmhzFUk5
         RlesXLb5mqbDDxu5zXa6RxZnF8cX2RWs0oTsCDRHluJGB9y2MxRvFY3ppDjNBndaBINE
         ZrdWHdR+DvOhrSWW7+HAJp9GFr1KBMH6WKJVFPPPn1lXGSqjjMgQ5udJ2mRnxcVimM+x
         4+qQKBs08Rpf1ZTpk98ORACReNpNZU2inIq6nmrdz04KTteZjKFPbGXoOjrTbOpS5PKa
         PemA==
X-Gm-Message-State: AOAM533kAF74UeTkc0MchZvzpGe+E5fKzRhFfA7slPu5p0TFrIdTf+Iw
        u+bYnfQw77y837bW42UXyBK4XA==
X-Google-Smtp-Source: ABdhPJyB0SQNzaU7TgBb0Bwdv8xS1UZwLgEpFznSOywqp0DD5Qb54p+huc0VqvPHkrJmj8VHMASFSw==
X-Received: by 2002:a17:906:d7b7:: with SMTP id pk23mr2760167ejb.214.1604587686460;
        Thu, 05 Nov 2020 06:48:06 -0800 (PST)
Received: from kpsingh.zrh.corp.google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id z13sm1075870ejp.30.2020.11.05.06.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 06:48:05 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>, Hao Luo <haoluo@google.com>
Subject: [PATCH bpf-next v4 8/9] bpf: Add tests for task_local_storage
Date:   Thu,  5 Nov 2020 15:47:54 +0100
Message-Id: <20201105144755.214341-9-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201105144755.214341-1-kpsingh@chromium.org>
References: <20201105144755.214341-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

The test exercises the syscall based map operations by creating a pidfd
for the current process.

For verifying kernel / LSM functionality, the test implements a simple
MAC policy which denies an executable from unlinking itself. The LSM
program bprm_committed_creds sets a task_local_storage with a pointer to
the inode. This is then used to detect if the task is trying to unlink
itself in the inode_unlink LSM hook.

The test copies /bin/rm to /tmp and executes it in a child thread with
the intention of deleting itself. A successful test should prevent the
the running executable from deleting itself.

The bpf programs are also updated to call bpf_spin_{lock, unlock} to
trigger the verfier checks for spin locks.

The temporary file is cleaned up later in the test.

Signed-off-by: KP Singh <kpsingh@google.com>
---
 .../bpf/prog_tests/test_local_storage.c       | 167 ++++++++++++++++--
 .../selftests/bpf/progs/local_storage.c       |  61 ++++++-
 2 files changed, 210 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_local_storage.c b/tools/testing/selftests/bpf/prog_tests/test_local_storage.c
index 91cd6f357246..feba23f8848b 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_local_storage.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_local_storage.c
@@ -4,30 +4,149 @@
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
+static inline int sys_pidfd_open(pid_t pid, unsigned int flags)
+{
+	return syscall(__NR_pidfd_open, pid, flags);
+}
+
+unsigned int duration;
+
+#define TEST_STORAGE_VALUE 0xbeefdead
+
+struct storage {
+	void *inode;
+	unsigned int value;
+	/* Lock ensures that spin locked versions of local stoage operations
+	 * also work, most operations in this tests are still single threaded
+	 */
+	struct bpf_spin_lock lock;
+};
+
+/* Copies an rm binary to a temp file. dest is a mkstemp template */
+int copy_rm(char *dest)
 {
-	char fname[PATH_MAX] = "/tmp/fileXXXXXX";
-	int fd;
+	int ret, fd_in, fd_out;
+	struct stat stat;
 
-	fd = mkstemp(fname);
-	if (fd < 0)
-		return fd;
+	fd_in = open("/bin/rm", O_RDONLY);
+	if (fd_in < 0)
+		return fd_in;
 
-	close(fd);
-	unlink(fname);
+	fd_out = mkstemp(dest);
+	if (fd_out < 0)
+		return fd_out;
+
+	ret = fstat(fd_in, &stat);
+	if (ret == -1)
+		return errno;
+
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
+
+bool check_syscall_operations(int map_fd, int obj_fd)
+{
+	struct storage val = { .value = TEST_STORAGE_VALUE, .lock = { 0 } },
+		       lookup_val = { .value = 0, .lock = { 0 } };
+	int err;
+
+	/* Looking up an existing element should fail initially */
+	err = bpf_map_lookup_elem_flags(map_fd, &obj_fd, &lookup_val,
+					BPF_F_LOCK);
+	if (CHECK(!err || errno != ENOENT, "bpf_map_lookup_elem",
+		  "err:%d errno:%d\n", err, errno))
+		return false;
+
+	/* Create a new element */
+	err = bpf_map_update_elem(map_fd, &obj_fd, &val,
+				  BPF_NOEXIST | BPF_F_LOCK);
+	if (CHECK(err < 0, "bpf_map_update_elem", "err:%d errno:%d\n", err,
+		  errno))
+		return false;
+
+	/* Lookup the newly created element */
+	err = bpf_map_lookup_elem_flags(map_fd, &obj_fd, &lookup_val,
+					BPF_F_LOCK);
+	if (CHECK(err < 0, "bpf_map_lookup_elem", "err:%d errno:%d", err,
+		  errno))
+		return false;
+
+	/* Check the value of the newly created element */
+	if (CHECK(lookup_val.value != val.value, "bpf_map_lookup_elem",
+		  "value got = %x errno:%d", lookup_val.value, val.value))
+		return false;
+
+	err = bpf_map_delete_elem(map_fd, &obj_fd);
+	if (CHECK(err, "bpf_map_delete_elem()", "err:%d errno:%d\n", err,
+		  errno))
+		return false;
+
+	/* The lookup should fail, now that the element has been deleted */
+	err = bpf_map_lookup_elem_flags(map_fd, &obj_fd, &lookup_val,
+					BPF_F_LOCK);
+	if (CHECK(!err || errno != ENOENT, "bpf_map_lookup_elem",
+		  "err:%d errno:%d\n", err, errno))
+		return false;
+
+	return true;
+}
+
 void test_test_local_storage(void)
 {
+	char tmp_exec_path[PATH_MAX] = "/tmp/copy_of_rmXXXXXX";
+	int err, serv_sk = -1, task_fd = -1;
 	struct local_storage *skel = NULL;
-	int err, duration = 0, serv_sk = -1;
 
 	skel = local_storage__open_and_load();
 	if (CHECK(!skel, "skel_load", "lsm skeleton failed\n"))
@@ -37,10 +156,35 @@ void test_test_local_storage(void)
 	if (CHECK(err, "attach", "lsm attach failed: %d\n", err))
 		goto close_prog;
 
+	task_fd = sys_pidfd_open(getpid(), 0);
+	if (CHECK(task_fd < 0, "pidfd_open",
+		  "failed to get pidfd err:%d, errno:%d", task_fd, errno))
+		goto close_prog;
+
+	if (!check_syscall_operations(bpf_map__fd(skel->maps.task_storage_map),
+				      task_fd))
+		goto close_prog;
+
+	err = copy_rm(tmp_exec_path);
+	if (CHECK(err < 0, "copy_rm", "err %d errno %d\n", err, errno))
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
@@ -56,5 +200,6 @@ void test_test_local_storage(void)
 	close(serv_sk);
 
 close_prog:
+	close(task_fd);
 	local_storage__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/local_storage.c b/tools/testing/selftests/bpf/progs/local_storage.c
index ef3822bc7542..3e3de130f28f 100644
--- a/tools/testing/selftests/bpf/progs/local_storage.c
+++ b/tools/testing/selftests/bpf/progs/local_storage.c
@@ -17,41 +17,64 @@ int monitored_pid = 0;
 int inode_storage_result = -1;
 int sk_storage_result = -1;
 
-struct dummy_storage {
+struct local_storage {
+	struct inode *exec_inode;
 	__u32 value;
+	struct bpf_spin_lock lock;
 };
 
 struct {
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
+	__uint(map_flags, BPF_F_NO_PREALLOC);
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
+	bool is_self_unlink;
 	int err;
 
 	if (pid != monitored_pid)
 		return 0;
 
+	storage = bpf_task_storage_get(&task_storage_map,
+				       bpf_get_current_task_btf(), 0, 0);
+	if (storage) {
+		/* Don't let an executable delete itself */
+		bpf_spin_lock(&storage->lock);
+		is_self_unlink = storage->exec_inode == victim->d_inode;
+		bpf_spin_unlock(&storage->lock);
+		if (is_self_unlink)
+			return -EPERM;
+	}
+
 	storage = bpf_inode_storage_get(&inode_storage_map, victim->d_inode, 0,
 					BPF_LOCAL_STORAGE_GET_F_CREATE);
 	if (!storage)
 		return 0;
 
+	bpf_spin_lock(&storage->lock);
 	if (storage->value != DUMMY_STORAGE_VALUE)
 		inode_storage_result = -1;
+	bpf_spin_unlock(&storage->lock);
 
 	err = bpf_inode_storage_delete(&inode_storage_map, victim->d_inode);
 	if (!err)
@@ -65,7 +88,7 @@ int BPF_PROG(socket_bind, struct socket *sock, struct sockaddr *address,
 	     int addrlen)
 {
 	__u32 pid = bpf_get_current_pid_tgid() >> 32;
-	struct dummy_storage *storage;
+	struct local_storage *storage;
 	int err;
 
 	if (pid != monitored_pid)
@@ -76,8 +99,10 @@ int BPF_PROG(socket_bind, struct socket *sock, struct sockaddr *address,
 	if (!storage)
 		return 0;
 
+	bpf_spin_lock(&storage->lock);
 	if (storage->value != DUMMY_STORAGE_VALUE)
 		sk_storage_result = -1;
+	bpf_spin_unlock(&storage->lock);
 
 	err = bpf_sk_storage_delete(&sk_storage_map, sock->sk);
 	if (!err)
@@ -91,7 +116,7 @@ int BPF_PROG(socket_post_create, struct socket *sock, int family, int type,
 	     int protocol, int kern)
 {
 	__u32 pid = bpf_get_current_pid_tgid() >> 32;
-	struct dummy_storage *storage;
+	struct local_storage *storage;
 
 	if (pid != monitored_pid)
 		return 0;
@@ -101,7 +126,9 @@ int BPF_PROG(socket_post_create, struct socket *sock, int family, int type,
 	if (!storage)
 		return 0;
 
+	bpf_spin_lock(&storage->lock);
 	storage->value = DUMMY_STORAGE_VALUE;
+	bpf_spin_unlock(&storage->lock);
 
 	return 0;
 }
@@ -110,7 +137,7 @@ SEC("lsm/file_open")
 int BPF_PROG(file_open, struct file *file)
 {
 	__u32 pid = bpf_get_current_pid_tgid() >> 32;
-	struct dummy_storage *storage;
+	struct local_storage *storage;
 
 	if (pid != monitored_pid)
 		return 0;
@@ -123,6 +150,26 @@ int BPF_PROG(file_open, struct file *file)
 	if (!storage)
 		return 0;
 
+	bpf_spin_lock(&storage->lock);
 	storage->value = DUMMY_STORAGE_VALUE;
+	bpf_spin_unlock(&storage->lock);
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
+	if (storage) {
+		bpf_spin_lock(&storage->lock);
+		storage->exec_inode = bprm->file->f_inode;
+		bpf_spin_unlock(&storage->lock);
+	}
+}
-- 
2.29.1.341.ge80a0c044ae-goog

