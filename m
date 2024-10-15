Return-Path: <bpf+bounces-42061-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E93C499F098
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 17:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EC9E1C235E2
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 15:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7271B392F;
	Tue, 15 Oct 2024 15:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Md4dD1k/"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3925E1B2193
	for <bpf@vger.kernel.org>; Tue, 15 Oct 2024 15:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729004551; cv=none; b=FtDbEahpqyphq8wbHtAO4j7r8PVppFWaEHp5GtFDYgw9ax7q/pUdkNv1bJsJpFOsBI+Hux4NXBlZsJlf9B4YqidbwAsU5qQqWKkZ/Yx5O3pQWo3lsNpUdgRNuCaNHz3LlvHjNbQmgWfel1QB38iiR/+/60pQ4zIqrcrnGOaJUbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729004551; c=relaxed/simple;
	bh=9PrDa982r+DsNlO6nRq9JY+wHoWvVDCtxstRrxhrh28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n0BUeyMHyx0Hf4r6jnFlaI9fDX181xB/H3JvClZ7wud3TNjlH1KoY8rPmgW9vz2m6IMHJMo0+DEkVJgD+Y/RK3LCZC/FwEfguyZqNgJHfzNmIu1A0sbA5HaGpq5pk/A16Oh4M1w4fcNFRuU4gyqFKcXX8tFO7kkm1ATU73GOwKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Md4dD1k/; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729004546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xm7vD+ot9hV0jmvDOnv/maUvrHWU6TJadixg8YRieMo=;
	b=Md4dD1k/thU5fhoFoKMusInIUOSRXuCcFSi5BkAHFyCOyV+oAvt3PeeKtXh+ppvinr+dL3
	FDx3Ln90vFso6pP9D+1VjeXB9wNA9BsQ0JQ9xMfKLofSJo6vaf55sZxp5ZmJZ64WBpdmg2
	p69SsCgdmN6sjXDR4W459k9gKfzlKbY=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	toke@redhat.com,
	martin.lau@kernel.org,
	yonghong.song@linux.dev,
	puranjay@kernel.org,
	xukuohai@huaweicloud.com,
	eddyz87@gmail.com,
	iii@linux.ibm.com,
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v8 2/2] selftests/bpf: Add test to verify tailcall and freplace restrictions
Date: Tue, 15 Oct 2024 23:02:07 +0800
Message-ID: <20241015150207.70264-3-leon.hwang@linux.dev>
In-Reply-To: <20241015150207.70264-1-leon.hwang@linux.dev>
References: <20241015150207.70264-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add a test case to ensure that attaching a tail callee program with an
freplace program fails, and that updating an extended program to a
prog_array map is also prohibited.

This test is designed to prevent the potential infinite loop issue caused
by the combination of tail calls and freplace, ensuring the correct
behavior and stability of the system.

Additionally, fix the broken tailcalls/tailcall_freplace selftest
because an extension prog should not be tailcalled.

cd tools/testing/selftests/bpf; ./test_progs -t tailcalls
337/25  tailcalls/tailcall_freplace:OK
337/26  tailcalls/tailcall_bpf2bpf_freplace:OK
337     tailcalls:OK
Summary: 1/26 PASSED, 0 SKIPPED, 0 FAILED

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 .../selftests/bpf/prog_tests/tailcalls.c      | 120 ++++++++++++++++--
 .../testing/selftests/bpf/progs/tc_bpf2bpf.c  |   5 +-
 2 files changed, 109 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/tailcalls.c b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
index 21c5a37846ade..40f22454cf05b 100644
--- a/tools/testing/selftests/bpf/prog_tests/tailcalls.c
+++ b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
@@ -1496,8 +1496,8 @@ static void test_tailcall_bpf2bpf_hierarchy_3(void)
 	RUN_TESTS(tailcall_bpf2bpf_hierarchy3);
 }
 
-/* test_tailcall_freplace checks that the attached freplace prog is OK to
- * update the prog_array map.
+/* test_tailcall_freplace checks that the freplace prog fails to update the
+ * prog_array map, no matter whether the freplace prog attaches to its target.
  */
 static void test_tailcall_freplace(void)
 {
@@ -1505,7 +1505,7 @@ static void test_tailcall_freplace(void)
 	struct bpf_link *freplace_link = NULL;
 	struct bpf_program *freplace_prog;
 	struct tc_bpf2bpf *tc_skel = NULL;
-	int prog_fd, map_fd;
+	int prog_fd, tc_prog_fd, map_fd;
 	char buff[128] = {};
 	int err, key;
 
@@ -1523,9 +1523,10 @@ static void test_tailcall_freplace(void)
 	if (!ASSERT_OK_PTR(tc_skel, "tc_bpf2bpf__open_and_load"))
 		goto out;
 
-	prog_fd = bpf_program__fd(tc_skel->progs.entry_tc);
+	tc_prog_fd = bpf_program__fd(tc_skel->progs.entry_tc);
 	freplace_prog = freplace_skel->progs.entry_freplace;
-	err = bpf_program__set_attach_target(freplace_prog, prog_fd, "subprog");
+	err = bpf_program__set_attach_target(freplace_prog, tc_prog_fd,
+					     "subprog_tc");
 	if (!ASSERT_OK(err, "set_attach_target"))
 		goto out;
 
@@ -1533,27 +1534,116 @@ static void test_tailcall_freplace(void)
 	if (!ASSERT_OK(err, "tailcall_freplace__load"))
 		goto out;
 
-	freplace_link = bpf_program__attach_freplace(freplace_prog, prog_fd,
-						     "subprog");
+	map_fd = bpf_map__fd(freplace_skel->maps.jmp_table);
+	prog_fd = bpf_program__fd(freplace_prog);
+	key = 0;
+	err = bpf_map_update_elem(map_fd, &key, &prog_fd, BPF_ANY);
+	ASSERT_ERR(err, "update jmp_table failure");
+
+	freplace_link = bpf_program__attach_freplace(freplace_prog, tc_prog_fd,
+						     "subprog_tc");
 	if (!ASSERT_OK_PTR(freplace_link, "attach_freplace"))
 		goto out;
 
-	map_fd = bpf_map__fd(freplace_skel->maps.jmp_table);
-	prog_fd = bpf_program__fd(freplace_prog);
+	err = bpf_map_update_elem(map_fd, &key, &prog_fd, BPF_ANY);
+	ASSERT_ERR(err, "update jmp_table failure");
+
+out:
+	bpf_link__destroy(freplace_link);
+	tailcall_freplace__destroy(freplace_skel);
+	tc_bpf2bpf__destroy(tc_skel);
+}
+
+/* test_tailcall_bpf2bpf_freplace checks the failure that fails to attach a tail
+ * callee prog with freplace prog or fails to update an extended prog to
+ * prog_array map.
+ */
+static void test_tailcall_bpf2bpf_freplace(void)
+{
+	struct tailcall_freplace *freplace_skel = NULL;
+	struct bpf_link *freplace_link = NULL;
+	struct tc_bpf2bpf *tc_skel = NULL;
+	char buff[128] = {};
+	int prog_fd, map_fd;
+	int err, key;
+
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		    .data_in = buff,
+		    .data_size_in = sizeof(buff),
+		    .repeat = 1,
+	);
+
+	tc_skel = tc_bpf2bpf__open_and_load();
+	if (!ASSERT_OK_PTR(tc_skel, "tc_bpf2bpf__open_and_load"))
+		goto out;
+
+	prog_fd = bpf_program__fd(tc_skel->progs.entry_tc);
+	freplace_skel = tailcall_freplace__open();
+	if (!ASSERT_OK_PTR(freplace_skel, "tailcall_freplace__open"))
+		goto out;
+
+	err = bpf_program__set_attach_target(freplace_skel->progs.entry_freplace,
+					     prog_fd, "subprog_tc");
+	if (!ASSERT_OK(err, "set_attach_target"))
+		goto out;
+
+	err = tailcall_freplace__load(freplace_skel);
+	if (!ASSERT_OK(err, "tailcall_freplace__load"))
+		goto out;
+
+	/* OK to attach then detach freplace prog. */
+
+	freplace_link = bpf_program__attach_freplace(freplace_skel->progs.entry_freplace,
+						     prog_fd, "subprog_tc");
+	if (!ASSERT_OK_PTR(freplace_link, "attach_freplace"))
+		goto out;
+
+	err = bpf_link__destroy(freplace_link);
+	if (!ASSERT_OK(err, "destroy link"))
+		goto out;
+
+	/* OK to update prog_array map then delete element from the map. */
+
 	key = 0;
+	map_fd = bpf_map__fd(freplace_skel->maps.jmp_table);
 	err = bpf_map_update_elem(map_fd, &key, &prog_fd, BPF_ANY);
 	if (!ASSERT_OK(err, "update jmp_table"))
 		goto out;
 
-	prog_fd = bpf_program__fd(tc_skel->progs.entry_tc);
-	err = bpf_prog_test_run_opts(prog_fd, &topts);
-	ASSERT_OK(err, "test_run");
-	ASSERT_EQ(topts.retval, 34, "test_run retval");
+	err = bpf_map_delete_elem(map_fd, &key);
+	if (!ASSERT_OK(err, "delete_elem from jmp_table"))
+		goto out;
+
+	/* Fail to attach a tail callee prog with freplace prog. */
+
+	err = bpf_map_update_elem(map_fd, &key, &prog_fd, BPF_ANY);
+	if (!ASSERT_OK(err, "update jmp_table"))
+		goto out;
+
+	freplace_link = bpf_program__attach_freplace(freplace_skel->progs.entry_freplace,
+						     prog_fd, "subprog_tc");
+	if (!ASSERT_ERR_PTR(freplace_link, "attach_freplace failure"))
+		goto out;
+
+	err = bpf_map_delete_elem(map_fd, &key);
+	if (!ASSERT_OK(err, "delete_elem from jmp_table"))
+		goto out;
+
+	/* Fail to update an extended prog to prog_array map. */
+
+	freplace_link = bpf_program__attach_freplace(freplace_skel->progs.entry_freplace,
+						     prog_fd, "subprog_tc");
+	if (!ASSERT_OK_PTR(freplace_link, "attach_freplace"))
+		goto out;
+
+	err = bpf_map_update_elem(map_fd, &key, &prog_fd, BPF_ANY);
+	if (!ASSERT_ERR(err, "update jmp_table failure"))
+		goto out;
 
 out:
 	bpf_link__destroy(freplace_link);
-	tc_bpf2bpf__destroy(tc_skel);
 	tailcall_freplace__destroy(freplace_skel);
+	tc_bpf2bpf__destroy(tc_skel);
 }
 
 void test_tailcalls(void)
@@ -1606,4 +1696,6 @@ void test_tailcalls(void)
 	test_tailcall_bpf2bpf_hierarchy_3();
 	if (test__start_subtest("tailcall_freplace"))
 		test_tailcall_freplace();
+	if (test__start_subtest("tailcall_bpf2bpf_freplace"))
+		test_tailcall_bpf2bpf_freplace();
 }
diff --git a/tools/testing/selftests/bpf/progs/tc_bpf2bpf.c b/tools/testing/selftests/bpf/progs/tc_bpf2bpf.c
index 8a0632c37839a..d1a57f7d09bd8 100644
--- a/tools/testing/selftests/bpf/progs/tc_bpf2bpf.c
+++ b/tools/testing/selftests/bpf/progs/tc_bpf2bpf.c
@@ -5,10 +5,11 @@
 #include "bpf_misc.h"
 
 __noinline
-int subprog(struct __sk_buff *skb)
+int subprog_tc(struct __sk_buff *skb)
 {
 	int ret = 1;
 
+	__sink(skb);
 	__sink(ret);
 	return ret;
 }
@@ -16,7 +17,7 @@ int subprog(struct __sk_buff *skb)
 SEC("tc")
 int entry_tc(struct __sk_buff *skb)
 {
-	return subprog(skb);
+	return subprog_tc(skb);
 }
 
 char __license[] SEC("license") = "GPL";
-- 
2.44.0


