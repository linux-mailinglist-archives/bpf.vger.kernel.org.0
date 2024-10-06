Return-Path: <bpf+bounces-41067-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55174991E59
	for <lists+bpf@lfdr.de>; Sun,  6 Oct 2024 15:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98785B20FA4
	for <lists+bpf@lfdr.de>; Sun,  6 Oct 2024 13:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC64317625F;
	Sun,  6 Oct 2024 13:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DTRTsSFz"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FBC1714CA
	for <bpf@vger.kernel.org>; Sun,  6 Oct 2024 13:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728219718; cv=none; b=H2MvPxALWXkG5ZIV83GCxMEXg7QixpdjGnrlkQfxuyR9gSUiZ1jTJfvWdgmBnW8WZ8r9DbI5uthiQtcaDWqxjj7d/Op44XK1lglZk/sWHeGJJVehd4lL2AI0koA0PYzixFn/3mQ4SszLLbf80LdR2kAiz5qFmLKxVqi9gSpSDY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728219718; c=relaxed/simple;
	bh=BrTdLoiyecOydf+gQn7r2d++I9wD0GS7HjY1tHl9mQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gKt6K6Pj3ASfYgAj+97Fg7Ae4z+Xu61q90hyW2epDZBw6tuSKcpTKADVfjEFBzgOm98YWaufktfZzTIqZBwwS8Pyl0r2l1nyk2zyFBD6PkLcIDEaJvJJ/hDadcuVAMK1k+Iuj+bW47lr5QSPyH94Hj8D98Bxlvvkj1Xc1abvC08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DTRTsSFz; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728219714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LXH4TEyTyCpmffZ/AQBGWW5qkNpq1ttl9gYNsiMSSMw=;
	b=DTRTsSFzMsFFLHNXiBJM6ya2KR8Sz+5Xy3Kac9r3HOxPh25lplJTLLH/xb6shZruU4ZHXq
	ksyG0g6mjosO+J8MB544mw+lDecJiqLPqdM5Bc7eUyfezxReLr/qHuHFwriylCNy67Nw6v
	l7OOCCyT42hOpyrPkGj+mpY0TvmzIHY=
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
Subject: [PATCH bpf-next v5 3/3] selftests/bpf: Add cases to test tailcall in freplace
Date: Sun,  6 Oct 2024 21:01:29 +0800
Message-ID: <20241006130130.77125-4-leon.hwang@linux.dev>
In-Reply-To: <20241006130130.77125-1-leon.hwang@linux.dev>
References: <20241006130130.77125-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

cd tools/testing/selftests/bpf; ./test_progs -t tailcalls
335/27  tailcalls/tailcall_bpf2bpf_hierarchy_freplace_1:OK
335/28  tailcalls/tailcall_bpf2bpf_hierarchy_freplace_2:OK
335     tailcalls:OK
Summary: 1/28 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 .../selftests/bpf/prog_tests/tailcalls.c      | 97 +++++++++++++++++++
 .../tailcall_bpf2bpf_hierarchy_freplace.c     | 30 ++++++
 .../testing/selftests/bpf/progs/tc_bpf2bpf.c  | 13 +++
 3 files changed, 140 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy_freplace.c

diff --git a/tools/testing/selftests/bpf/prog_tests/tailcalls.c b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
index fa3f3bb11b098..0564ad6c9b288 100644
--- a/tools/testing/selftests/bpf/prog_tests/tailcalls.c
+++ b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
@@ -5,6 +5,7 @@
 #include "tailcall_poke.skel.h"
 #include "tailcall_bpf2bpf_hierarchy2.skel.h"
 #include "tailcall_bpf2bpf_hierarchy3.skel.h"
+#include "tailcall_bpf2bpf_hierarchy_freplace.skel.h"
 #include "tailcall_freplace.skel.h"
 #include "tc_bpf2bpf.skel.h"
 
@@ -1649,6 +1650,98 @@ static void test_tailcall_bpf2bpf_freplace(void)
 	tc_bpf2bpf__destroy(tc_skel);
 }
 
+static void test_tailcall_bpf2bpf_hierarchy_freplace(bool freplace_subprog,
+						     bool target_entry2,
+						     int count1, int count2)
+{
+	struct tailcall_bpf2bpf_hierarchy_freplace *freplace_skel = NULL;
+	struct bpf_link *freplace_link = NULL;
+	struct tc_bpf2bpf *tc_skel = NULL;
+	int prog_fd, map_fd;
+	char buff[128] = {};
+	int err, key, val;
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
+	prog_fd = bpf_program__fd(target_entry2 ? tc_skel->progs.entry_tc_2 :
+				  tc_skel->progs.entry_tc);
+	freplace_skel = tailcall_bpf2bpf_hierarchy_freplace__open();
+	if (!ASSERT_OK_PTR(freplace_skel, "tailcall_bpf2bpf_hierarchy_freplace__open"))
+		goto out;
+
+	err = bpf_program__set_attach_target(freplace_skel->progs.entry_freplace,
+					     prog_fd, freplace_subprog ?
+					     "subprog_tailcall_tc" : "entry_tc");
+	if (!ASSERT_OK(err, "set_attach_target"))
+		goto out;
+
+	err = tailcall_bpf2bpf_hierarchy_freplace__load(freplace_skel);
+	if (!ASSERT_OK(err, "tailcall_bpf2bpf_hierarchy_freplace__load"))
+		goto out;
+
+	val = bpf_program__fd(freplace_skel->progs.entry_freplace);
+	map_fd = bpf_map__fd(freplace_skel->maps.jmp_table);
+	key = 0;
+	err = bpf_map_update_elem(map_fd, &key, &val, BPF_ANY);
+	if (!ASSERT_OK(err, "update jmp_table"))
+		goto out;
+
+	freplace_link = bpf_program__attach_freplace(freplace_skel->progs.entry_freplace,
+						     prog_fd, freplace_subprog ?
+						     "subprog_tailcall_tc" : "entry_tc");
+	if (!ASSERT_OK_PTR(freplace_link, "attach_freplace"))
+		goto out;
+
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "test_run_opts");
+	ASSERT_EQ(topts.retval, count1, "test_run_opts retval");
+
+	err = bpf_map_delete_elem(map_fd, &key);
+	if (!ASSERT_OK(err, "delete_elem from jmp_table"))
+		goto out;
+
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "test_run_opts again");
+	ASSERT_EQ(topts.retval, count2, "test_run_opts retval again");
+
+out:
+	bpf_link__destroy(freplace_link);
+	tailcall_bpf2bpf_hierarchy_freplace__destroy(freplace_skel);
+	tc_bpf2bpf__destroy(tc_skel);
+}
+
+/* test_tailcall_bpf2bpf_hierarchy_freplace_1 checks the count value of tail
+ * call limit enforcement matches with expectation for the case:
+ *
+ *                                    subprog_tail --tailcall-> entry_freplace
+ * entry_tc --jump-> entry_freplace <
+ *                                    subprog_tail --tailcall-> entry_freplace
+ */
+static void test_tailcall_bpf2bpf_hierarchy_freplace_1(void)
+{
+	test_tailcall_bpf2bpf_hierarchy_freplace(false, false, 34, 35);
+}
+
+/* test_tailcall_bpf2bpf_hierarchy_freplace_2 checks the count value of tail
+ * call limit enforcement matches with expectation for the case:
+ *
+ *                                                                              subprog_tail --tailcall-> entry_freplace
+ * entry_tc_2 --> subprog_tailcall_tc (call 10 times) --jump-> entry_freplace <
+ *                                                                              subprog_tail --tailcall-> entry_freplace
+ */
+static void test_tailcall_bpf2bpf_hierarchy_freplace_2(void)
+{
+	test_tailcall_bpf2bpf_hierarchy_freplace(true, true, 340, 350);
+}
+
 void test_tailcalls(void)
 {
 	if (test__start_subtest("tailcall_1"))
@@ -1701,4 +1794,8 @@ void test_tailcalls(void)
 		test_tailcall_freplace();
 	if (test__start_subtest("tailcall_bpf2bpf_freplace"))
 		test_tailcall_bpf2bpf_freplace();
+	if (test__start_subtest("tailcall_bpf2bpf_hierarchy_freplace_1"))
+		test_tailcall_bpf2bpf_hierarchy_freplace_1();
+	if (test__start_subtest("tailcall_bpf2bpf_hierarchy_freplace_2"))
+		test_tailcall_bpf2bpf_hierarchy_freplace_2();
 }
diff --git a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy_freplace.c b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy_freplace.c
new file mode 100644
index 0000000000000..6f7c1fac9ddb7
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy_freplace.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 1);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u32));
+} jmp_table SEC(".maps");
+
+int count = 0;
+
+static __noinline
+int subprog_tail(struct __sk_buff *skb)
+{
+	bpf_tail_call_static(skb, &jmp_table, 0);
+	return 0;
+}
+
+SEC("freplace")
+int entry_freplace(struct __sk_buff *skb)
+{
+	count++;
+	subprog_tail(skb);
+	subprog_tail(skb);
+	return count;
+}
+
+char __license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/tc_bpf2bpf.c b/tools/testing/selftests/bpf/progs/tc_bpf2bpf.c
index 34f3c780194e4..beacf60a52677 100644
--- a/tools/testing/selftests/bpf/progs/tc_bpf2bpf.c
+++ b/tools/testing/selftests/bpf/progs/tc_bpf2bpf.c
@@ -39,4 +39,17 @@ int entry_tc(struct __sk_buff *skb)
 	return subprog_tailcall_tc(skb);
 }
 
+SEC("tc")
+int entry_tc_2(struct __sk_buff *skb)
+{
+	int ret, i;
+
+	for (i = 0; i < 10; i++) {
+		ret = subprog_tailcall_tc(skb);
+		__sink(ret);
+	}
+
+	return ret;
+}
+
 char __license[] SEC("license") = "GPL";
-- 
2.44.0


