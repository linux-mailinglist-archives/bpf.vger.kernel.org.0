Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70DBD2A49DF
	for <lists+bpf@lfdr.de>; Tue,  3 Nov 2020 16:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbgKCPb6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Nov 2020 10:31:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728962AbgKCPbq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Nov 2020 10:31:46 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57ABAC0613D1
        for <bpf@vger.kernel.org>; Tue,  3 Nov 2020 07:31:46 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id b8so19035105wrn.0
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2020 07:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VC6mEFvtl4/35bpsK317njxOKI+jwd/2EvcHUJfLEuQ=;
        b=aTQsKBPHbA/P1C8SVEVAhGumhzoVlvGEQSaoun6y0HdMZw4mPGnqx5+XMxTylbTnX4
         gnHJXxSGnKLN4NxvluY+c6W1GBQ7+6UCZO/ccbOtjzyF8RuYQPMk83Ab7cz0UsHQr1Kc
         PymfNqNXJBxmaE84b2X+4um09JGD00Hn/lXGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VC6mEFvtl4/35bpsK317njxOKI+jwd/2EvcHUJfLEuQ=;
        b=dDIv6M6acdYzbDiETX7PjQHLAiX23yedtpUszaRmFPCs0XceOjfoYH2ZYbFju+8VZG
         Jr0Tvzf3h8FctCzTQvpCL2z8Zw0iEP22xVZnI7H7bp+yUJweMAF87thmxDja6jEZVvYT
         C7uTiJAdHNP6CN9a0sJOug1NRGwMPPzkmokBohDB9O11iNNOQ2uhf/T9+h7SwztOE5iL
         N/2a4uauFaGdPqOtZokDdsu/Qjw4GVAWoUNjCmUlSdC25tLfPbp1amzjuTEh61aYHafm
         IPbu5YS+s55lgPRnBPjp+yax0HITCrOVY6WgSuSYBA7xcLFuktLujFyjAV9SyxZicfIu
         gPzA==
X-Gm-Message-State: AOAM530oyeiU7hdoM5C2wIgxNOuclF/KRNEM1EAyqjTl6pdK8l4vjDPZ
        wMar2/7aRb/GtC9Z385gi8aOuQ==
X-Google-Smtp-Source: ABdhPJyKhpW6xZw6etW2VK0/d+ksKcrcoBX+CRNWyTCXffq3k2KTUEjKtYQsO2Yi+fX89g60ofZejA==
X-Received: by 2002:a5d:518e:: with SMTP id k14mr27806627wrv.60.1604417505009;
        Tue, 03 Nov 2020 07:31:45 -0800 (PST)
Received: from kpsingh.zrh.corp.google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id m126sm2451966wmm.0.2020.11.03.07.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 07:31:44 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>, Hao Luo <haoluo@google.com>
Subject: [PATCH bpf-next v2 7/8] bpf: Add tests for task_local_storage
Date:   Tue,  3 Nov 2020 16:31:31 +0100
Message-Id: <20201103153132.2717326-8-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201103153132.2717326-1-kpsingh@chromium.org>
References: <20201103153132.2717326-1-kpsingh@chromium.org>
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

The temporary file is cleaned up later in the test.

Signed-off-by: KP Singh <kpsingh@google.com>
---
 .../bpf/prog_tests/test_local_storage.c       | 167 ++++++++++++++++--
 .../selftests/bpf/progs/local_storage.c       |  45 ++++-
 2 files changed, 194 insertions(+), 18 deletions(-)

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
index ef3822bc7542..a4979982ce80 100644
--- a/tools/testing/selftests/bpf/progs/local_storage.c
+++ b/tools/testing/selftests/bpf/progs/local_storage.c
@@ -17,34 +17,50 @@ int monitored_pid = 0;
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
 					BPF_LOCAL_STORAGE_GET_F_CREATE);
 	if (!storage)
@@ -65,7 +81,7 @@ int BPF_PROG(socket_bind, struct socket *sock, struct sockaddr *address,
 	     int addrlen)
 {
 	__u32 pid = bpf_get_current_pid_tgid() >> 32;
-	struct dummy_storage *storage;
+	struct local_storage *storage;
 	int err;
 
 	if (pid != monitored_pid)
@@ -91,7 +107,7 @@ int BPF_PROG(socket_post_create, struct socket *sock, int family, int type,
 	     int protocol, int kern)
 {
 	__u32 pid = bpf_get_current_pid_tgid() >> 32;
-	struct dummy_storage *storage;
+	struct local_storage *storage;
 
 	if (pid != monitored_pid)
 		return 0;
@@ -110,7 +126,7 @@ SEC("lsm/file_open")
 int BPF_PROG(file_open, struct file *file)
 {
 	__u32 pid = bpf_get_current_pid_tgid() >> 32;
-	struct dummy_storage *storage;
+	struct local_storage *storage;
 
 	if (pid != monitored_pid)
 		return 0;
@@ -126,3 +142,18 @@ int BPF_PROG(file_open, struct file *file)
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
2.29.1.341.ge80a0c044ae-goog

