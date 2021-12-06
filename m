Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91662469F47
	for <lists+bpf@lfdr.de>; Mon,  6 Dec 2021 16:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380163AbhLFPq5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Dec 2021 10:46:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388107AbhLFPcT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Dec 2021 10:32:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60664C08E84D
        for <bpf@vger.kernel.org>; Mon,  6 Dec 2021 07:19:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41FDA6133D
        for <bpf@vger.kernel.org>; Mon,  6 Dec 2021 15:19:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69B6BC341C5;
        Mon,  6 Dec 2021 15:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638803957;
        bh=vz/t6HteZsn+kqWUROc2480lsSAaDKdLb7pLhpClRPc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nHVoxq6hslT7E3wajza6nFratuCLxGyrZVdfDR15mbbq9+1V79x3Xpe69U7Z1rmUp
         WaUCr3zbxecc3xtwFX5gV0nWU/xmQZmaqbQ4TsqJNjcQp96LjjIt9zy4ERqXJBtbui
         OCPNReu+80urXFa36QFc165TvYZtX+5GadlJRVFrYx/ytGj3RGPYks6P+TPEbX8urD
         RMaOy1pFCTbbsoVzBy9BFOqXWoD7zUaHMvh7f8Yb41Ye/FywC88Vf0ceqWR2G/kKtj
         3QxHwxTstaYNkpXGaOSsmDVprFRwLqa9Anke7F2yQ4TY8xrZLA0dmfePYO4/jo9J9f
         hfiztpflzzbGg==
From:   KP Singh <kpsingh@kernel.org>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH v2 bpf-next 2/2] bpf/selftests: Update local storage selftest for sleepable programs
Date:   Mon,  6 Dec 2021 15:19:09 +0000
Message-Id: <20211206151909.951258-3-kpsingh@kernel.org>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
In-Reply-To: <20211206151909.951258-1-kpsingh@kernel.org>
References: <20211206151909.951258-1-kpsingh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Remove the spin lock logic and update the selftests to use sleepable
programs to use a mix of sleepable and non-sleepable programs. It's more
useful to test the sleepable programs since the tests don't really need
spinlocks.

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
2.34.1.400.ga245620fadb-goog

