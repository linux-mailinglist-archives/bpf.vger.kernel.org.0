Return-Path: <bpf+bounces-41587-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF54998BE2
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 17:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79E991F20FEF
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 15:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514171CC888;
	Thu, 10 Oct 2024 15:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WWw46Rh5"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B665B1CC140
	for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 15:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728574752; cv=none; b=rTd8xjkuwgsIKocsoDswZ6BBnr2HKxWkTvkKI2wXGhHxCkhVUEiB/2nE5ZxYw3qQTY+67McZRfaIfegEIV8WTbgbjxnWMlwi3JyMf25VFNBhJbiyO/zB9P6kZ5PV0CrSSVuYcEw5z5PsTpW1LFag3NSjmvR8L0H30UXF+wxDSb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728574752; c=relaxed/simple;
	bh=PN8olCMX8ZbCDs2iWOFeApWpYd2PDL1lFinsr5dfZgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gBsNY2z/J6dW3M2dJZLoK9eLUZoGVTXUKvjg9jMe+C3EZVeDy6AroM9g6r0l0HOrpdrtciiWAZcPswI0BmWux38jrikA94S521B94Ku+9khbXhK3Moa+8JA2uHH7SvZnP8hVlHtrulBvDj95THHXeLjIJfqO2lDKAlzxPLiszEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WWw46Rh5; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728574747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0NRl9gJj7LZCw6qkIuaf1RgQA1DeyCgutryfS6VsNDk=;
	b=WWw46Rh5sVoKR+zEjJ9mu295LDRt1yPQBBGzR4zpx6IFXsffJFveqQRJqPonflaxo4eLjd
	YXtnlyTG4YnqK9g+PDZ6E7acf35cv7cFjNb3w1zuWf5hmOg5g7Rboq97Z7ADIRF3oBQqjS
	rd87Ly7KL/AGbq281Vnjfyr+vVjcCOs=
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
Subject: [PATCH bpf-next v7 2/2] selftests/bpf: Add test to verify tailcall and freplace restrictions
Date: Thu, 10 Oct 2024 23:38:35 +0800
Message-ID: <20241010153835.26984-3-leon.hwang@linux.dev>
In-Reply-To: <20241010153835.26984-1-leon.hwang@linux.dev>
References: <20241010153835.26984-1-leon.hwang@linux.dev>
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

cd tools/testing/selftests/bpf; ./test_progs -t tailcalls
335/26  tailcalls/tailcall_bpf2bpf_freplace:OK
335     tailcalls:OK
Summary: 1/26 PASSED, 0 SKIPPED, 0 FAILED

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 .../selftests/bpf/prog_tests/tailcalls.c      | 98 ++++++++++++++++++-
 .../testing/selftests/bpf/progs/tc_bpf2bpf.c  |  5 +-
 2 files changed, 99 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/tailcalls.c b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
index 21c5a37846ade..244d1959bbc7f 100644
--- a/tools/testing/selftests/bpf/prog_tests/tailcalls.c
+++ b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
@@ -1525,7 +1525,7 @@ static void test_tailcall_freplace(void)
 
 	prog_fd = bpf_program__fd(tc_skel->progs.entry_tc);
 	freplace_prog = freplace_skel->progs.entry_freplace;
-	err = bpf_program__set_attach_target(freplace_prog, prog_fd, "subprog");
+	err = bpf_program__set_attach_target(freplace_prog, prog_fd, "subprog_tc");
 	if (!ASSERT_OK(err, "set_attach_target"))
 		goto out;
 
@@ -1534,7 +1534,7 @@ static void test_tailcall_freplace(void)
 		goto out;
 
 	freplace_link = bpf_program__attach_freplace(freplace_prog, prog_fd,
-						     "subprog");
+						     "subprog_tc");
 	if (!ASSERT_OK_PTR(freplace_link, "attach_freplace"))
 		goto out;
 
@@ -1556,6 +1556,98 @@ static void test_tailcall_freplace(void)
 	tailcall_freplace__destroy(freplace_skel);
 }
 
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
+	key = 0;
+	map_fd = bpf_map__fd(freplace_skel->maps.jmp_table);
+	err = bpf_map_update_elem(map_fd, &key, &prog_fd, BPF_ANY);
+	if (!ASSERT_OK(err, "update jmp_table"))
+		goto out;
+
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
+
+out:
+	bpf_link__destroy(freplace_link);
+	tailcall_freplace__destroy(freplace_skel);
+	tc_bpf2bpf__destroy(tc_skel);
+}
+
 void test_tailcalls(void)
 {
 	if (test__start_subtest("tailcall_1"))
@@ -1606,4 +1698,6 @@ void test_tailcalls(void)
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


