Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8D912F2955
	for <lists+bpf@lfdr.de>; Tue, 12 Jan 2021 08:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392167AbhALH4R (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jan 2021 02:56:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:43492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392150AbhALH4Q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jan 2021 02:56:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4A1AF22EBD;
        Tue, 12 Jan 2021 07:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610438134;
        bh=iTIDmGrXo7i+7N3e+qPRh9L3dx867Q2gqvhZr1bfDEs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jSqNCnLrwGw+NKqJRLaBErAsOSmjj3/FETPh+oFvCStRI729rZj9YeSzbqfq8Lxml
         dFS3Hqu39VUrW2/zrAz3bEySO/dgNUe4lqaQkxGRE1W+gu2Qn2gzSPKwymYoQpQjTU
         YYCeJHlcXsya7SJ6PKVnXhbzn30Lh5tbRy2IVQXbuGFnrOaElljl49dgF3O/FcXDVq
         5cpRBAFENfk2cMwaSJqYnfV/ADoE4ORWHBtW8NknZJqg/6C1dZsIeBU+lap1+cRHEF
         CME39gGxt4nPZVP7KoRJ28PbXWSszRBxnMHp3a4XAblvMT7ueukpb9KG8wvxRNGF3v
         E2CWVrEHDp9KQ==
From:   KP Singh <kpsingh@kernel.org>
To:     bpf@vger.kernel.org
Cc:     Gilad Reti <gilad.reti@gmail.com>, Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH bpf v3 1/3] bpf: update local storage test to check handling of null ptrs
Date:   Tue, 12 Jan 2021 07:55:23 +0000
Message-Id: <20210112075525.256820-2-kpsingh@kernel.org>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
In-Reply-To: <20210112075525.256820-1-kpsingh@kernel.org>
References: <20210112075525.256820-1-kpsingh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

It was found in [1] that bpf_inode_storage_get helper did not check
the nullness of the passed owner ptr which caused an oops when
dereferenced. This change incorporates the example suggested in [1] into
the local storage selftest.

The test is updated to create a temporary directory instead of just
using a tempfile. In order to replicate the issue this copied rm binary
is renamed tiggering the inode_rename with a null pointer for the
new_inode. The logic to verify the setting and deletion of the inode
local storage of the old inode is also moved to this LSM hook.

The change also removes the copy_rm function and simply shells out
to copy files and recursively delete directories and consolidates the
logic of setting the initial inode storage to the bprm_committed_creds
hook and removes the file_open hook.

[1]: https://lore.kernel.org/bpf/CANaYP3HWkH91SN=wTNO9FL_2ztHfqcXKX38SSE-JJ2voh+vssw@mail.gmail.com

Suggested-by: Gilad Reti <gilad.reti@gmail.com>
Acked-by: Yonghong Song <yhs@fb.com>
Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 .../bpf/prog_tests/test_local_storage.c       | 96 +++++--------------
 .../selftests/bpf/progs/local_storage.c       | 62 ++++++------
 2 files changed, 61 insertions(+), 97 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_local_storage.c b/tools/testing/selftests/bpf/prog_tests/test_local_storage.c
index c0fe73a17ed1..3bfcf00c0a67 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_local_storage.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_local_storage.c
@@ -34,61 +34,6 @@ struct storage {
 	struct bpf_spin_lock lock;
 };
 
-/* Copies an rm binary to a temp file. dest is a mkstemp template */
-static int copy_rm(char *dest)
-{
-	int fd_in, fd_out = -1, ret = 0;
-	struct stat stat;
-	char *buf = NULL;
-
-	fd_in = open("/bin/rm", O_RDONLY);
-	if (fd_in < 0)
-		return -errno;
-
-	fd_out = mkstemp(dest);
-	if (fd_out < 0) {
-		ret = -errno;
-		goto out;
-	}
-
-	ret = fstat(fd_in, &stat);
-	if (ret == -1) {
-		ret = -errno;
-		goto out;
-	}
-
-	buf = malloc(stat.st_blksize);
-	if (!buf) {
-		ret = -errno;
-		goto out;
-	}
-
-	while (ret = read(fd_in, buf, stat.st_blksize), ret > 0) {
-		ret = write(fd_out, buf, ret);
-		if (ret < 0) {
-			ret = -errno;
-			goto out;
-
-		}
-	}
-	if (ret < 0) {
-		ret = -errno;
-		goto out;
-
-	}
-
-	/* Set executable permission on the copied file */
-	ret = chmod(dest, 0100);
-	if (ret == -1)
-		ret = -errno;
-
-out:
-	free(buf);
-	close(fd_in);
-	close(fd_out);
-	return ret;
-}
-
 /* Fork and exec the provided rm binary and return the exit code of the
  * forked process and its pid.
  */
@@ -168,9 +113,11 @@ static bool check_syscall_operations(int map_fd, int obj_fd)
 
 void test_test_local_storage(void)
 {
-	char tmp_exec_path[PATH_MAX] = "/tmp/copy_of_rmXXXXXX";
+	char tmp_dir_path[64] = "/tmp/local_storageXXXXXX";
 	int err, serv_sk = -1, task_fd = -1, rm_fd = -1;
 	struct local_storage *skel = NULL;
+	char tmp_exec_path[64];
+	char cmd[256];
 
 	skel = local_storage__open_and_load();
 	if (CHECK(!skel, "skel_load", "lsm skeleton failed\n"))
@@ -189,18 +136,24 @@ void test_test_local_storage(void)
 				      task_fd))
 		goto close_prog;
 
-	err = copy_rm(tmp_exec_path);
-	if (CHECK(err < 0, "copy_rm", "err %d errno %d\n", err, errno))
+	if (CHECK(!mkdtemp(tmp_dir_path), "mkdtemp",
+		  "unable to create tmpdir: %d\n", errno))
 		goto close_prog;
 
+	snprintf(tmp_exec_path, sizeof(tmp_exec_path), "%s/copy_of_rm",
+		 tmp_dir_path);
+	snprintf(cmd, sizeof(cmd), "cp /bin/rm %s", tmp_exec_path);
+	if (CHECK_FAIL(system(cmd)))
+		goto close_prog_rmdir;
+
 	rm_fd = open(tmp_exec_path, O_RDONLY);
 	if (CHECK(rm_fd < 0, "open", "failed to open %s err:%d, errno:%d",
 		  tmp_exec_path, rm_fd, errno))
-		goto close_prog;
+		goto close_prog_rmdir;
 
 	if (!check_syscall_operations(bpf_map__fd(skel->maps.inode_storage_map),
 				      rm_fd))
-		goto close_prog;
+		goto close_prog_rmdir;
 
 	/* Sets skel->bss->monitored_pid to the pid of the forked child
 	 * forks a child process that executes tmp_exec_path and tries to
@@ -209,33 +162,36 @@ void test_test_local_storage(void)
 	 */
 	err = run_self_unlink(&skel->bss->monitored_pid, tmp_exec_path);
 	if (CHECK(err != EPERM, "run_self_unlink", "err %d want EPERM\n", err))
-		goto close_prog_unlink;
+		goto close_prog_rmdir;
 
 	/* Set the process being monitored to be the current process */
 	skel->bss->monitored_pid = getpid();
 
-	/* Remove the temporary created executable */
-	err = unlink(tmp_exec_path);
-	if (CHECK(err != 0, "unlink", "unable to unlink %s: %d", tmp_exec_path,
-		  errno))
-		goto close_prog_unlink;
+	/* Move copy_of_rm to a new location so that it triggers the
+	 * inode_rename LSM hook with a new_dentry that has a NULL inode ptr.
+	 */
+	snprintf(cmd, sizeof(cmd), "mv %s/copy_of_rm %s/check_null_ptr",
+		 tmp_dir_path, tmp_dir_path);
+	if (CHECK_FAIL(system(cmd)))
+		goto close_prog_rmdir;
 
 	CHECK(skel->data->inode_storage_result != 0, "inode_storage_result",
 	      "inode_local_storage not set\n");
 
 	serv_sk = start_server(AF_INET6, SOCK_STREAM, NULL, 0, 0);
 	if (CHECK(serv_sk < 0, "start_server", "failed to start server\n"))
-		goto close_prog;
+		goto close_prog_rmdir;
 
 	CHECK(skel->data->sk_storage_result != 0, "sk_storage_result",
 	      "sk_local_storage not set\n");
 
 	if (!check_syscall_operations(bpf_map__fd(skel->maps.sk_storage_map),
 				      serv_sk))
-		goto close_prog;
+		goto close_prog_rmdir;
 
-close_prog_unlink:
-	unlink(tmp_exec_path);
+close_prog_rmdir:
+	snprintf(cmd, sizeof(cmd), "rm -rf %s", tmp_dir_path);
+	system(cmd);
 close_prog:
 	close(serv_sk);
 	close(rm_fd);
diff --git a/tools/testing/selftests/bpf/progs/local_storage.c b/tools/testing/selftests/bpf/progs/local_storage.c
index 3e3de130f28f..95868bc7ada9 100644
--- a/tools/testing/selftests/bpf/progs/local_storage.c
+++ b/tools/testing/selftests/bpf/progs/local_storage.c
@@ -50,7 +50,6 @@ int BPF_PROG(unlink_hook, struct inode *dir, struct dentry *victim)
 	__u32 pid = bpf_get_current_pid_tgid() >> 32;
 	struct local_storage *storage;
 	bool is_self_unlink;
-	int err;
 
 	if (pid != monitored_pid)
 		return 0;
@@ -66,8 +65,27 @@ int BPF_PROG(unlink_hook, struct inode *dir, struct dentry *victim)
 			return -EPERM;
 	}
 
-	storage = bpf_inode_storage_get(&inode_storage_map, victim->d_inode, 0,
-					BPF_LOCAL_STORAGE_GET_F_CREATE);
+	return 0;
+}
+
+SEC("lsm/inode_rename")
+int BPF_PROG(inode_rename, struct inode *old_dir, struct dentry *old_dentry,
+	     struct inode *new_dir, struct dentry *new_dentry,
+	     unsigned int flags)
+{
+	__u32 pid = bpf_get_current_pid_tgid() >> 32;
+	struct local_storage *storage;
+	int err;
+
+	/* new_dentry->d_inode can be NULL when the inode is renamed to a file
+	 * that did not exist before. The helper should be able to handle this
+	 * NULL pointer.
+	 */
+	bpf_inode_storage_get(&inode_storage_map, new_dentry->d_inode, 0,
+			      BPF_LOCAL_STORAGE_GET_F_CREATE);
+
+	storage = bpf_inode_storage_get(&inode_storage_map, old_dentry->d_inode,
+					0, 0);
 	if (!storage)
 		return 0;
 
@@ -76,7 +94,7 @@ int BPF_PROG(unlink_hook, struct inode *dir, struct dentry *victim)
 		inode_storage_result = -1;
 	bpf_spin_unlock(&storage->lock);
 
-	err = bpf_inode_storage_delete(&inode_storage_map, victim->d_inode);
+	err = bpf_inode_storage_delete(&inode_storage_map, old_dentry->d_inode);
 	if (!err)
 		inode_storage_result = err;
 
@@ -133,37 +151,18 @@ int BPF_PROG(socket_post_create, struct socket *sock, int family, int type,
 	return 0;
 }
 
-SEC("lsm/file_open")
-int BPF_PROG(file_open, struct file *file)
-{
-	__u32 pid = bpf_get_current_pid_tgid() >> 32;
-	struct local_storage *storage;
-
-	if (pid != monitored_pid)
-		return 0;
-
-	if (!file->f_inode)
-		return 0;
-
-	storage = bpf_inode_storage_get(&inode_storage_map, file->f_inode, 0,
-					BPF_LOCAL_STORAGE_GET_F_CREATE);
-	if (!storage)
-		return 0;
-
-	bpf_spin_lock(&storage->lock);
-	storage->value = DUMMY_STORAGE_VALUE;
-	bpf_spin_unlock(&storage->lock);
-	return 0;
-}
-
 /* This uses the local storage to remember the inode of the binary that a
  * process was originally executing.
  */
 SEC("lsm/bprm_committed_creds")
 void BPF_PROG(exec, struct linux_binprm *bprm)
 {
+	__u32 pid = bpf_get_current_pid_tgid() >> 32;
 	struct local_storage *storage;
 
+	if (pid != monitored_pid)
+		return;
+
 	storage = bpf_task_storage_get(&task_storage_map,
 				       bpf_get_current_task_btf(), 0,
 				       BPF_LOCAL_STORAGE_GET_F_CREATE);
@@ -172,4 +171,13 @@ void BPF_PROG(exec, struct linux_binprm *bprm)
 		storage->exec_inode = bprm->file->f_inode;
 		bpf_spin_unlock(&storage->lock);
 	}
+
+	storage = bpf_inode_storage_get(&inode_storage_map, bprm->file->f_inode,
+					0, BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (!storage)
+		return;
+
+	bpf_spin_lock(&storage->lock);
+	storage->value = DUMMY_STORAGE_VALUE;
+	bpf_spin_unlock(&storage->lock);
 }
-- 
2.30.0.284.gd98b1dd5eaa7-goog

