Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A41206C5904
	for <lists+bpf@lfdr.de>; Wed, 22 Mar 2023 22:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjCVVxI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Mar 2023 17:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjCVVxG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Mar 2023 17:53:06 -0400
Received: from out-27.mta0.migadu.com (out-27.mta0.migadu.com [IPv6:2001:41d0:1004:224b::1b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52792694
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 14:53:02 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1679521981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c+5T2Cmu5wjsH6SkTJc2B6oEo3qeG/UtZKDzB2CyWB4=;
        b=mQd9+HwJaWp8JkuwMmZv4pC7AZ3uupqeH+gCPw/1dVs451w4EcAPahk+JasCDELRvGOBbZ
        WaZg2uYj7nCp8JHZ4JsDbMabFOKlbWRuas0fxfOBasIKtkTEcXjDIVHgXcP8Gp7MHVD5Mm
        yP7nSxVd/Pftq3/q2zvBz3HSCTubkJw=
From:   Martin KaFai Lau <martin.lau@linux.dev>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@meta.com
Subject: [PATCH v3 bpf-next 4/5] selftests/bpf: Test task storage when local_storage->smap is NULL
Date:   Wed, 22 Mar 2023 14:52:45 -0700
Message-Id: <20230322215246.1675516-5-martin.lau@linux.dev>
In-Reply-To: <20230322215246.1675516-1-martin.lau@linux.dev>
References: <20230322215246.1675516-1-martin.lau@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Martin KaFai Lau <martin.lau@kernel.org>

The current sk storage test ensures the memory free works when
the local_storage->smap is NULL.

This patch adds a task storage test to ensure the memory free
code path works when local_storage->smap is NULL.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 .../bpf/prog_tests/test_local_storage.c       |  7 ++-
 .../selftests/bpf/progs/local_storage.c       | 56 ++++++++++++++-----
 2 files changed, 46 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_local_storage.c b/tools/testing/selftests/bpf/prog_tests/test_local_storage.c
index 563a9c746b7b..bcf2e1905ed7 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_local_storage.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_local_storage.c
@@ -23,7 +23,7 @@ struct storage {
 /* Fork and exec the provided rm binary and return the exit code of the
  * forked process and its pid.
  */
-static int run_self_unlink(int *monitored_pid, const char *rm_path)
+static int run_self_unlink(struct local_storage *skel, const char *rm_path)
 {
 	int child_pid, child_status, ret;
 	int null_fd;
@@ -35,7 +35,7 @@ static int run_self_unlink(int *monitored_pid, const char *rm_path)
 		dup2(null_fd, STDERR_FILENO);
 		close(null_fd);
 
-		*monitored_pid = getpid();
+		skel->bss->monitored_pid = getpid();
 		/* Use the copied /usr/bin/rm to delete itself
 		 * /tmp/copy_of_rm /tmp/copy_of_rm.
 		 */
@@ -44,6 +44,7 @@ static int run_self_unlink(int *monitored_pid, const char *rm_path)
 			exit(errno);
 	} else if (child_pid > 0) {
 		waitpid(child_pid, &child_status, 0);
+		ASSERT_EQ(skel->data->task_storage_result, 0, "task_storage_result");
 		return WEXITSTATUS(child_status);
 	}
 
@@ -133,7 +134,7 @@ void test_test_local_storage(void)
 	 * unlink its executable. This operation should be denied by the loaded
 	 * LSM program.
 	 */
-	err = run_self_unlink(&skel->bss->monitored_pid, tmp_exec_path);
+	err = run_self_unlink(skel, tmp_exec_path);
 	if (!ASSERT_EQ(err, EPERM, "run_self_unlink"))
 		goto close_prog_rmdir;
 
diff --git a/tools/testing/selftests/bpf/progs/local_storage.c b/tools/testing/selftests/bpf/progs/local_storage.c
index c8ba7207f5a5..bc8ea56671a1 100644
--- a/tools/testing/selftests/bpf/progs/local_storage.c
+++ b/tools/testing/selftests/bpf/progs/local_storage.c
@@ -16,6 +16,7 @@ char _license[] SEC("license") = "GPL";
 int monitored_pid = 0;
 int inode_storage_result = -1;
 int sk_storage_result = -1;
+int task_storage_result = -1;
 
 struct local_storage {
 	struct inode *exec_inode;
@@ -50,26 +51,57 @@ struct {
 	__type(value, struct local_storage);
 } task_storage_map SEC(".maps");
 
+struct {
+	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, struct local_storage);
+} task_storage_map2 SEC(".maps");
+
 SEC("lsm/inode_unlink")
 int BPF_PROG(unlink_hook, struct inode *dir, struct dentry *victim)
 {
 	__u32 pid = bpf_get_current_pid_tgid() >> 32;
+	struct bpf_local_storage *local_storage;
 	struct local_storage *storage;
+	struct task_struct *task;
 	bool is_self_unlink;
 
 	if (pid != monitored_pid)
 		return 0;
 
-	storage = bpf_task_storage_get(&task_storage_map,
-				       bpf_get_current_task_btf(), 0, 0);
-	if (storage) {
-		/* Don't let an executable delete itself */
-		is_self_unlink = storage->exec_inode == victim->d_inode;
-		if (is_self_unlink)
-			return -EPERM;
-	}
+	task = bpf_get_current_task_btf();
+	if (!task)
+		return 0;
 
-	return 0;
+	task_storage_result = -1;
+
+	storage = bpf_task_storage_get(&task_storage_map, task, 0, 0);
+	if (!storage)
+		return 0;
+
+	/* Don't let an executable delete itself */
+	is_self_unlink = storage->exec_inode == victim->d_inode;
+
+	storage = bpf_task_storage_get(&task_storage_map2, task, 0,
+				       BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (!storage || storage->value)
+		return 0;
+
+	if (bpf_task_storage_delete(&task_storage_map, task))
+		return 0;
+
+	/* Ensure that the task_storage_map is disconnected from the storage.
+	 * The storage memory should not be freed back to the
+	 * bpf_mem_alloc.
+	 */
+	local_storage = task->bpf_storage;
+	if (!local_storage || local_storage->smap)
+		return 0;
+
+	task_storage_result = 0;
+
+	return is_self_unlink ? -EPERM : 0;
 }
 
 SEC("lsm.s/inode_rename")
@@ -139,11 +171,7 @@ int BPF_PROG(socket_bind, struct socket *sock, struct sockaddr *address,
 	if (bpf_sk_storage_delete(&sk_storage_map, sock->sk))
 		return 0;
 
-	/* Ensure that the sk_storage_map is disconnected from the storage.
-	 * The storage memory should not be freed back to the
-	 * bpf_mem_alloc of the sk_bpf_storage_map because
-	 * sk_bpf_storage_map may have been gone.
-	 */
+	/* Ensure that the sk_storage_map is disconnected from the storage. */
 	if (!sock->sk->sk_bpf_storage || sock->sk->sk_bpf_storage->smap)
 		return 0;
 
-- 
2.34.1

