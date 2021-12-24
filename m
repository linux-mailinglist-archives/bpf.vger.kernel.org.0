Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5906A47EFD4
	for <lists+bpf@lfdr.de>; Fri, 24 Dec 2021 16:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353079AbhLXP32 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Dec 2021 10:29:28 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:55366 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238876AbhLXP32 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Dec 2021 10:29:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30C7C62051
        for <bpf@vger.kernel.org>; Fri, 24 Dec 2021 15:29:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B955C36AED;
        Fri, 24 Dec 2021 15:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640359767;
        bh=21CmYBYSAXqR6+gmD90xJtib32Ki8rYk3bSGclXBEbo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TXEVRGq+8+j8TwwsuMkESrhlCmxxR3NGIwGsreo0inWksZD4tUqb6HwrizIJdEI2W
         wudTf33k/rceS8GzMeltJt3f2ExucIFBaFyEY+I9sB0bJqWwUQTuVZSTFUwatYw8cE
         VVTHzqnA+0LCyFzsrAVJQHEni3uGMcdaiYTFJWLymvpFydMIp8VuRnmEUS14py6QTt
         Dr4hNhuxwV0T2s4WP1DIKf5ueSonN9XAdXQF5XMi3DJEyj3N68QDM0x5tKqZe1y6H8
         4BbQyOXmtKbT7IYHEt33kBwUBUKxbCjR+6W6r03acg+CymQ718qfaKFrjBbEFJ78ku
         9cf0uzqr/EYZA==
From:   KP Singh <kpsingh@kernel.org>
To:     bpf@vger.kernel.org
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v3 bpf-next 2/2] bpf/selftests: Update local storage selftest for sleepable programs
Date:   Fri, 24 Dec 2021 15:29:16 +0000
Message-Id: <20211224152916.1550677-3-kpsingh@kernel.org>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
In-Reply-To: <20211224152916.1550677-1-kpsingh@kernel.org>
References: <20211224152916.1550677-1-kpsingh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Remove the spin lock logic and update the selftests to use sleepable
programs to use a mix of sleepable and non-sleepable programs. It's more
useful to test the sleepable programs since the tests don't really need
spinlocks.

Acked-by: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 .../bpf/prog_tests/test_local_storage.c       | 20 +++++-----------
 .../selftests/bpf/progs/local_storage.c       | 24 ++++---------------
 2 files changed, 11 insertions(+), 33 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_local_storage.c b/tools/testing/selftests/bpf/prog_tests/test_local_storage.c
index d2c16eaae367..26ac26a88026 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_local_storage.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_local_storage.c
@@ -28,10 +28,6 @@ static unsigned int duration;
 struct storage {
 	void *inode;
 	unsigned int value;
-	/* Lock ensures that spin locked versions of local stoage operations
-	 * also work, most operations in this tests are still single threaded
-	 */
-	struct bpf_spin_lock lock;
 };
 
 /* Fork and exec the provided rm binary and return the exit code of the
@@ -66,27 +62,24 @@ static int run_self_unlink(int *monitored_pid, const char *rm_path)
 
 static bool check_syscall_operations(int map_fd, int obj_fd)
 {
-	struct storage val = { .value = TEST_STORAGE_VALUE, .lock = { 0 } },
-		       lookup_val = { .value = 0, .lock = { 0 } };
+	struct storage val = { .value = TEST_STORAGE_VALUE },
+		       lookup_val = { .value = 0 };
 	int err;
 
 	/* Looking up an existing element should fail initially */
-	err = bpf_map_lookup_elem_flags(map_fd, &obj_fd, &lookup_val,
-					BPF_F_LOCK);
+	err = bpf_map_lookup_elem_flags(map_fd, &obj_fd, &lookup_val, 0);
 	if (CHECK(!err || errno != ENOENT, "bpf_map_lookup_elem",
 		  "err:%d errno:%d\n", err, errno))
 		return false;
 
 	/* Create a new element */
-	err = bpf_map_update_elem(map_fd, &obj_fd, &val,
-				  BPF_NOEXIST | BPF_F_LOCK);
+	err = bpf_map_update_elem(map_fd, &obj_fd, &val, BPF_NOEXIST);
 	if (CHECK(err < 0, "bpf_map_update_elem", "err:%d errno:%d\n", err,
 		  errno))
 		return false;
 
 	/* Lookup the newly created element */
-	err = bpf_map_lookup_elem_flags(map_fd, &obj_fd, &lookup_val,
-					BPF_F_LOCK);
+	err = bpf_map_lookup_elem_flags(map_fd, &obj_fd, &lookup_val, 0);
 	if (CHECK(err < 0, "bpf_map_lookup_elem", "err:%d errno:%d", err,
 		  errno))
 		return false;
@@ -102,8 +95,7 @@ static bool check_syscall_operations(int map_fd, int obj_fd)
 		return false;
 
 	/* The lookup should fail, now that the element has been deleted */
-	err = bpf_map_lookup_elem_flags(map_fd, &obj_fd, &lookup_val,
-					BPF_F_LOCK);
+	err = bpf_map_lookup_elem_flags(map_fd, &obj_fd, &lookup_val, 0);
 	if (CHECK(!err || errno != ENOENT, "bpf_map_lookup_elem",
 		  "err:%d errno:%d\n", err, errno))
 		return false;
diff --git a/tools/testing/selftests/bpf/progs/local_storage.c b/tools/testing/selftests/bpf/progs/local_storage.c
index 95868bc7ada9..9b1f9b75d5c2 100644
--- a/tools/testing/selftests/bpf/progs/local_storage.c
+++ b/tools/testing/selftests/bpf/progs/local_storage.c
@@ -20,7 +20,6 @@ int sk_storage_result = -1;
 struct local_storage {
 	struct inode *exec_inode;
 	__u32 value;
-	struct bpf_spin_lock lock;
 };
 
 struct {
@@ -58,9 +57,7 @@ int BPF_PROG(unlink_hook, struct inode *dir, struct dentry *victim)
 				       bpf_get_current_task_btf(), 0, 0);
 	if (storage) {
 		/* Don't let an executable delete itself */
-		bpf_spin_lock(&storage->lock);
 		is_self_unlink = storage->exec_inode == victim->d_inode;
-		bpf_spin_unlock(&storage->lock);
 		if (is_self_unlink)
 			return -EPERM;
 	}
@@ -68,7 +65,7 @@ int BPF_PROG(unlink_hook, struct inode *dir, struct dentry *victim)
 	return 0;
 }
 
-SEC("lsm/inode_rename")
+SEC("lsm.s/inode_rename")
 int BPF_PROG(inode_rename, struct inode *old_dir, struct dentry *old_dentry,
 	     struct inode *new_dir, struct dentry *new_dentry,
 	     unsigned int flags)
@@ -89,10 +86,8 @@ int BPF_PROG(inode_rename, struct inode *old_dir, struct dentry *old_dentry,
 	if (!storage)
 		return 0;
 
-	bpf_spin_lock(&storage->lock);
 	if (storage->value != DUMMY_STORAGE_VALUE)
 		inode_storage_result = -1;
-	bpf_spin_unlock(&storage->lock);
 
 	err = bpf_inode_storage_delete(&inode_storage_map, old_dentry->d_inode);
 	if (!err)
@@ -101,7 +96,7 @@ int BPF_PROG(inode_rename, struct inode *old_dir, struct dentry *old_dentry,
 	return 0;
 }
 
-SEC("lsm/socket_bind")
+SEC("lsm.s/socket_bind")
 int BPF_PROG(socket_bind, struct socket *sock, struct sockaddr *address,
 	     int addrlen)
 {
@@ -117,10 +112,8 @@ int BPF_PROG(socket_bind, struct socket *sock, struct sockaddr *address,
 	if (!storage)
 		return 0;
 
-	bpf_spin_lock(&storage->lock);
 	if (storage->value != DUMMY_STORAGE_VALUE)
 		sk_storage_result = -1;
-	bpf_spin_unlock(&storage->lock);
 
 	err = bpf_sk_storage_delete(&sk_storage_map, sock->sk);
 	if (!err)
@@ -129,7 +122,7 @@ int BPF_PROG(socket_bind, struct socket *sock, struct sockaddr *address,
 	return 0;
 }
 
-SEC("lsm/socket_post_create")
+SEC("lsm.s/socket_post_create")
 int BPF_PROG(socket_post_create, struct socket *sock, int family, int type,
 	     int protocol, int kern)
 {
@@ -144,9 +137,7 @@ int BPF_PROG(socket_post_create, struct socket *sock, int family, int type,
 	if (!storage)
 		return 0;
 
-	bpf_spin_lock(&storage->lock);
 	storage->value = DUMMY_STORAGE_VALUE;
-	bpf_spin_unlock(&storage->lock);
 
 	return 0;
 }
@@ -154,7 +145,7 @@ int BPF_PROG(socket_post_create, struct socket *sock, int family, int type,
 /* This uses the local storage to remember the inode of the binary that a
  * process was originally executing.
  */
-SEC("lsm/bprm_committed_creds")
+SEC("lsm.s/bprm_committed_creds")
 void BPF_PROG(exec, struct linux_binprm *bprm)
 {
 	__u32 pid = bpf_get_current_pid_tgid() >> 32;
@@ -166,18 +157,13 @@ void BPF_PROG(exec, struct linux_binprm *bprm)
 	storage = bpf_task_storage_get(&task_storage_map,
 				       bpf_get_current_task_btf(), 0,
 				       BPF_LOCAL_STORAGE_GET_F_CREATE);
-	if (storage) {
-		bpf_spin_lock(&storage->lock);
+	if (storage)
 		storage->exec_inode = bprm->file->f_inode;
-		bpf_spin_unlock(&storage->lock);
-	}
 
 	storage = bpf_inode_storage_get(&inode_storage_map, bprm->file->f_inode,
 					0, BPF_LOCAL_STORAGE_GET_F_CREATE);
 	if (!storage)
 		return;
 
-	bpf_spin_lock(&storage->lock);
 	storage->value = DUMMY_STORAGE_VALUE;
-	bpf_spin_unlock(&storage->lock);
 }
-- 
2.34.1.448.ga2b2bfdf31-goog

