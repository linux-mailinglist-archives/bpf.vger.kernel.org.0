Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDE92A9482
	for <lists+bpf@lfdr.de>; Fri,  6 Nov 2020 11:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgKFKiS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 Nov 2020 05:38:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbgKFKh5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 Nov 2020 05:37:57 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4219C0613CF
        for <bpf@vger.kernel.org>; Fri,  6 Nov 2020 02:37:56 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id w14so781410wrs.9
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2020 02:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VOjUYF8vFC/trHWXXBK1OSejFtCBM07TKv2xo05GlH0=;
        b=Kfa1Fj1Ag6sdWIxijuECdzyrC5cIAigZf9EfVZXDar3gxLBCdXKxtRSuYOl/+k92Ic
         4Cdysll9VxaM/a2sz7GC7X428P7TQ3E6bXBjlJ3MC3tQslIztkZZBW446PL1ahYqBWa/
         DXiZlXfckAm8I2K14Gs1mQAnUrrVNAHWUW/U0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VOjUYF8vFC/trHWXXBK1OSejFtCBM07TKv2xo05GlH0=;
        b=s3kMscQAQBcDctmu3czXFPQXniGr2SlkjSqSzs02aSh4haYcpkp9CBQ20hYSWjMe9z
         1RBZh3Hzn1Pq6aT+tONx4387pG/RsCXxm7ndgAsFIrThpLQMdrRIjGQcKTsJhuPjp4e/
         2juXfjoy3W5bNckEZao1r1atOzQZF4fHXoPD7ZtgCGjbGeWUQC2jRDrxpc0/gS4e9+m1
         OJQuMro0TF6LprZY+Ne+4lQ+XO4e3o92uemVVHFEjsBJMksruu8mxeu+uAScAG99vrFB
         bRQaRYkRpXKwrZ84khPBIafjL8ZuY1p+5T6ovk401PytUCzuy8PP0Z8oTImrdq2o5573
         kh5g==
X-Gm-Message-State: AOAM5308eTru0/KUcwOIw8btFe+FGskzWni9Q3OtV1vwMUOT0sR7/nQz
        hMH2RnT3+9ECrbqTi3SKuhX6ng==
X-Google-Smtp-Source: ABdhPJwvyT0PoR/4aueD2uVd2JddtIaZeORKWHt2HmTX4m/m0zODG+juf6/U10lRS/rJFv6E2F3GJg==
X-Received: by 2002:adf:8366:: with SMTP id 93mr1878090wrd.321.1604659075678;
        Fri, 06 Nov 2020 02:37:55 -0800 (PST)
Received: from kpsingh.c.googlers.com.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id t1sm1537639wrs.48.2020.11.06.02.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 02:37:54 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>, Hao Luo <haoluo@google.com>
Subject: [PATCH bpf-next v6 8/9] bpf: Add tests for task_local_storage
Date:   Fri,  6 Nov 2020 10:37:46 +0000
Message-Id: <20201106103747.2780972-9-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201106103747.2780972-1-kpsingh@chromium.org>
References: <20201106103747.2780972-1-kpsingh@chromium.org>
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

Acked-by: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: KP Singh <kpsingh@google.com>
---
 .../bpf/prog_tests/test_local_storage.c       | 185 ++++++++++++++++--
 .../selftests/bpf/progs/local_storage.c       |  61 +++++-
 2 files changed, 226 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_local_storage.c b/tools/testing/selftests/bpf/prog_tests/test_local_storage.c
index 91cd6f357246..4e7f6a4965f2 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_local_storage.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_local_storage.c
@@ -4,30 +4,161 @@
  * Copyright (C) 2020 Google LLC.
  */
 
+#include <asm-generic/errno-base.h>
+#include <sys/stat.h>
 #include <test_progs.h>
 #include <linux/limits.h>
 
 #include "local_storage.skel.h"
 #include "network_helpers.h"
 
-int create_and_unlink_file(void)
+static inline int sys_pidfd_open(pid_t pid, unsigned int flags)
 {
-	char fname[PATH_MAX] = "/tmp/fileXXXXXX";
-	int fd;
+	return syscall(__NR_pidfd_open, pid, flags);
+}
+
+static inline ssize_t copy_file_range(int fd_in, loff_t *off_in, int fd_out,
+				      loff_t *off_out, size_t len,
+				      unsigned int flags)
+{
+	return syscall(__NR_copy_file_range, fd_in, off_in, fd_out, off_out,
+		       len, flags);
+}
+
+static unsigned int duration;
+
+#define TEST_STORAGE_VALUE 0xbeefdead
 
-	fd = mkstemp(fname);
-	if (fd < 0)
-		return fd;
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
+static int copy_rm(char *dest)
+{
+	int fd_in, fd_out = -1, ret = 0;
+	struct stat stat;
+
+	fd_in = open("/bin/rm", O_RDONLY);
+	if (fd_in < 0)
+		return -errno;
+
+	fd_out = mkstemp(dest);
+	if (fd_out < 0) {
+		ret = -errno;
+		goto out;
+	}
+
+	ret = fstat(fd_in, &stat);
+	if (ret == -1) {
+		ret = -errno;
+		goto out;
+	}
+
+	ret = copy_file_range(fd_in, NULL, fd_out, NULL, stat.st_size, 0);
+	if (ret == -1) {
+		ret = -errno;
+		goto out;
+	}
+
+	/* Set executable permission on the copied file */
+	ret = chmod(dest, 0100);
+	if (ret == -1)
+		ret = -errno;
+
+out:
+	close(fd_in);
+	close(fd_out);
+	return ret;
+}
+
+/* Fork and exec the provided rm binary and return the exit code of the
+ * forked process and its pid.
+ */
+static int run_self_unlink(int *monitored_pid, const char *rm_path)
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
 
-	close(fd);
-	unlink(fname);
-	return 0;
+static bool check_syscall_operations(int map_fd, int obj_fd)
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
 }
 
 void test_test_local_storage(void)
 {
+	char tmp_exec_path[PATH_MAX] = "/tmp/copy_of_rmXXXXXX";
+	int err, serv_sk = -1, task_fd = -1;
 	struct local_storage *skel = NULL;
-	int err, duration = 0, serv_sk = -1;
 
 	skel = local_storage__open_and_load();
 	if (CHECK(!skel, "skel_load", "lsm skeleton failed\n"))
@@ -37,12 +168,37 @@ void test_test_local_storage(void)
 	if (CHECK(err, "attach", "lsm attach failed: %d\n", err))
 		goto close_prog;
 
-	skel->bss->monitored_pid = getpid();
+	task_fd = sys_pidfd_open(getpid(), 0);
+	if (CHECK(task_fd < 0, "pidfd_open",
+		  "failed to get pidfd err:%d, errno:%d", task_fd, errno))
+		goto close_prog;
 
-	err = create_and_unlink_file();
-	if (CHECK(err < 0, "exec_cmd", "err %d errno %d\n", err, errno))
+	if (!check_syscall_operations(bpf_map__fd(skel->maps.task_storage_map),
+				      task_fd))
 		goto close_prog;
 
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
+		goto close_prog_unlink;
+
+	/* Set the process being monitored to be the current process */
+	skel->bss->monitored_pid = getpid();
+
+	/* Remove the temporary created executable */
+	err = unlink(tmp_exec_path);
+	if (CHECK(err != 0, "unlink", "unable to unlink %s: %d", tmp_exec_path,
+		  errno))
+		goto close_prog_unlink;
+
 	CHECK(skel->data->inode_storage_result != 0, "inode_storage_result",
 	      "inode_local_storage not set\n");
 
@@ -55,6 +211,9 @@ void test_test_local_storage(void)
 
 	close(serv_sk);
 
+close_prog_unlink:
+	unlink(tmp_exec_path);
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

