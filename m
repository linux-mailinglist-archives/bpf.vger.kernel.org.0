Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C388D6AB8A9
	for <lists+bpf@lfdr.de>; Mon,  6 Mar 2023 09:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjCFInS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Mar 2023 03:43:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjCFInH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Mar 2023 03:43:07 -0500
Received: from out-22.mta1.migadu.com (out-22.mta1.migadu.com [IPv6:2001:41d0:203:375::16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2321F493
        for <bpf@vger.kernel.org>; Mon,  6 Mar 2023 00:43:02 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1678092181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vBNsXXMoEa7WZGUK+uVqXJf3nAVsv0q2RbgNEIyFzQM=;
        b=WmBjOlLPmHFhbNoloGz0KmRY4Ua4aR8ueRjIx5692k2VicHDqpR8ATI7FXhzI5KIJZwJtW
        bvVyBeIVqz+ht5MCgTgRkV2PnBl58TdM4jZutRuGTucndFPQiFxwRBCcKkxtnNp9iIZgsD
        YpmdFf7w6Db090B3O3w5RP6lmkqfoMM=
From:   Martin KaFai Lau <martin.lau@linux.dev>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@meta.com
Subject: [PATCH bpf-next 14/16] selftests/bpf: Replace CHECK with ASSERT in test_local_storage
Date:   Mon,  6 Mar 2023 00:42:14 -0800
Message-Id: <20230306084216.3186830-15-martin.lau@linux.dev>
In-Reply-To: <20230306084216.3186830-1-martin.lau@linux.dev>
References: <20230306084216.3186830-1-martin.lau@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Martin KaFai Lau <martin.lau@kernel.org>

This patch migrates the CHECK macro to ASSERT macro.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 .../bpf/prog_tests/test_local_storage.c       | 49 +++++++------------
 1 file changed, 19 insertions(+), 30 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_local_storage.c b/tools/testing/selftests/bpf/prog_tests/test_local_storage.c
index 9c77cd6b1eaf..c33f840f4880 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_local_storage.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_local_storage.c
@@ -13,8 +13,6 @@
 #include "network_helpers.h"
 #include "task_local_storage_helpers.h"
 
-static unsigned int duration;
-
 #define TEST_STORAGE_VALUE 0xbeefdead
 
 struct storage {
@@ -60,36 +58,32 @@ static bool check_syscall_operations(int map_fd, int obj_fd)
 
 	/* Looking up an existing element should fail initially */
 	err = bpf_map_lookup_elem_flags(map_fd, &obj_fd, &lookup_val, 0);
-	if (CHECK(!err || errno != ENOENT, "bpf_map_lookup_elem",
-		  "err:%d errno:%d\n", err, errno))
+	if (!ASSERT_ERR(err, "bpf_map_lookup_elem") ||
+	    !ASSERT_EQ(errno, ENOENT, "errno"))
 		return false;
 
 	/* Create a new element */
 	err = bpf_map_update_elem(map_fd, &obj_fd, &val, BPF_NOEXIST);
-	if (CHECK(err < 0, "bpf_map_update_elem", "err:%d errno:%d\n", err,
-		  errno))
+	if (!ASSERT_OK(err, "bpf_map_update_elem"))
 		return false;
 
 	/* Lookup the newly created element */
 	err = bpf_map_lookup_elem_flags(map_fd, &obj_fd, &lookup_val, 0);
-	if (CHECK(err < 0, "bpf_map_lookup_elem", "err:%d errno:%d", err,
-		  errno))
+	if (!ASSERT_OK(err, "bpf_map_lookup_elem"))
 		return false;
 
 	/* Check the value of the newly created element */
-	if (CHECK(lookup_val.value != val.value, "bpf_map_lookup_elem",
-		  "value got = %x errno:%d", lookup_val.value, val.value))
+	if (!ASSERT_EQ(lookup_val.value, val.value, "bpf_map_lookup_elem"))
 		return false;
 
 	err = bpf_map_delete_elem(map_fd, &obj_fd);
-	if (CHECK(err, "bpf_map_delete_elem()", "err:%d errno:%d\n", err,
-		  errno))
+	if (!ASSERT_OK(err, "bpf_map_delete_elem()"))
 		return false;
 
 	/* The lookup should fail, now that the element has been deleted */
 	err = bpf_map_lookup_elem_flags(map_fd, &obj_fd, &lookup_val, 0);
-	if (CHECK(!err || errno != ENOENT, "bpf_map_lookup_elem",
-		  "err:%d errno:%d\n", err, errno))
+	if (!ASSERT_ERR(err, "bpf_map_lookup_elem") ||
+	    !ASSERT_EQ(errno, ENOENT, "errno"))
 		return false;
 
 	return true;
@@ -104,35 +98,32 @@ void test_test_local_storage(void)
 	char cmd[256];
 
 	skel = local_storage__open_and_load();
-	if (CHECK(!skel, "skel_load", "lsm skeleton failed\n"))
+	if (!ASSERT_OK_PTR(skel, "skel_load"))
 		goto close_prog;
 
 	err = local_storage__attach(skel);
-	if (CHECK(err, "attach", "lsm attach failed: %d\n", err))
+	if (!ASSERT_OK(err, "attach"))
 		goto close_prog;
 
 	task_fd = sys_pidfd_open(getpid(), 0);
-	if (CHECK(task_fd < 0, "pidfd_open",
-		  "failed to get pidfd err:%d, errno:%d", task_fd, errno))
+	if (!ASSERT_GE(task_fd, 0, "pidfd_open"))
 		goto close_prog;
 
 	if (!check_syscall_operations(bpf_map__fd(skel->maps.task_storage_map),
 				      task_fd))
 		goto close_prog;
 
-	if (CHECK(!mkdtemp(tmp_dir_path), "mkdtemp",
-		  "unable to create tmpdir: %d\n", errno))
+	if (!ASSERT_OK_PTR(mkdtemp(tmp_dir_path), "mkdtemp"))
 		goto close_prog;
 
 	snprintf(tmp_exec_path, sizeof(tmp_exec_path), "%s/copy_of_rm",
 		 tmp_dir_path);
 	snprintf(cmd, sizeof(cmd), "cp /bin/rm %s", tmp_exec_path);
-	if (CHECK_FAIL(system(cmd)))
+	if (!ASSERT_OK(system(cmd), "system(cp)"))
 		goto close_prog_rmdir;
 
 	rm_fd = open(tmp_exec_path, O_RDONLY);
-	if (CHECK(rm_fd < 0, "open", "failed to open %s err:%d, errno:%d",
-		  tmp_exec_path, rm_fd, errno))
+	if (!ASSERT_GE(rm_fd, 0, "open(tmp_exec_path)"))
 		goto close_prog_rmdir;
 
 	if (!check_syscall_operations(bpf_map__fd(skel->maps.inode_storage_map),
@@ -145,7 +136,7 @@ void test_test_local_storage(void)
 	 * LSM program.
 	 */
 	err = run_self_unlink(&skel->bss->monitored_pid, tmp_exec_path);
-	if (CHECK(err != EPERM, "run_self_unlink", "err %d want EPERM\n", err))
+	if (!ASSERT_EQ(err, EPERM, "run_self_unlink"))
 		goto close_prog_rmdir;
 
 	/* Set the process being monitored to be the current process */
@@ -156,18 +147,16 @@ void test_test_local_storage(void)
 	 */
 	snprintf(cmd, sizeof(cmd), "mv %s/copy_of_rm %s/check_null_ptr",
 		 tmp_dir_path, tmp_dir_path);
-	if (CHECK_FAIL(system(cmd)))
+	if (!ASSERT_OK(system(cmd), "system(mv)"))
 		goto close_prog_rmdir;
 
-	CHECK(skel->data->inode_storage_result != 0, "inode_storage_result",
-	      "inode_local_storage not set\n");
+	ASSERT_EQ(skel->data->inode_storage_result, 0, "inode_storage_result");
 
 	serv_sk = start_server(AF_INET6, SOCK_STREAM, NULL, 0, 0);
-	if (CHECK(serv_sk < 0, "start_server", "failed to start server\n"))
+	if (!ASSERT_GE(serv_sk, 0, "start_server"))
 		goto close_prog_rmdir;
 
-	CHECK(skel->data->sk_storage_result != 0, "sk_storage_result",
-	      "sk_local_storage not set\n");
+	ASSERT_EQ(skel->data->sk_storage_result, 0, "sk_storage_result");
 
 	if (!check_syscall_operations(bpf_map__fd(skel->maps.sk_storage_map),
 				      serv_sk))
-- 
2.30.2

