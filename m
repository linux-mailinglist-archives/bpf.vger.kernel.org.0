Return-Path: <bpf+bounces-38695-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1422967FD7
	for <lists+bpf@lfdr.de>; Mon,  2 Sep 2024 08:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 306DE1F21D37
	for <lists+bpf@lfdr.de>; Mon,  2 Sep 2024 06:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20EC156993;
	Mon,  2 Sep 2024 06:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZCrNfGqw"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68EC15B0FE
	for <bpf@vger.kernel.org>; Mon,  2 Sep 2024 06:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725260318; cv=none; b=fcXUbO9l3uqKA+J4SYAwmaqoXbQPx/FPTnFw+P/hxoknuZtn/sHOFe+YWV8wdeC6n5kDzFZqjfqYVypszsEiBcG+XDW9e1sgqAplrFIURC6zch6j874aGFBfMdYIB4hrUtsuLDMOlCBKcRAKjHvDOkk4KAEm9mKMS/PP8ZtO+eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725260318; c=relaxed/simple;
	bh=aKmShiE9OA1pMxhe+iNcsmE5IpCEX/+T4K3cwEW7a94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gzzqD4J5Hv2bMRaKG7WClwk8LpJ1MhryoNS/LC9AEmUHIJt1SY8rw/9lT8MP/YjaQ6kHEfIHam3gtQyQ+Gmz5cctRvbwFUvqtqMBU9HjPwv4fhC7J2ODsoUUh4cMr0AduNkal9x68QjTi+wlXWwlCaVEURH77NrEg4Mfjnd0IN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZCrNfGqw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725260315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LFHU9WopqFuOOI3SIwujmRQA94qsaoktB/l3biNMxk8=;
	b=ZCrNfGqw6f+y/C5txOQi0q9gSqNpzqtHBd1yEcqLtHb30lfbXpjky9FA6l/LADoO+Damdc
	gXaIfalnjAv9vrjPfsN/yLbYN2pLBUcrCGLGjxk9QTASuNOj2Jp2axi/CFL7lc8amT12AE
	DJwInK2Z2H2H3mvVv8DcIvnFK8x/lBg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-8-75Nqns5pNMS43L8RM3EKrA-1; Mon,
 02 Sep 2024 02:58:33 -0400
X-MC-Unique: 75Nqns5pNMS43L8RM3EKrA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C30DE1955BF8;
	Mon,  2 Sep 2024 06:58:30 +0000 (UTC)
Received: from vmalik-fedora.redhat.com (unknown [10.45.225.48])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3B0B519560A3;
	Mon,  2 Sep 2024 06:58:26 +0000 (UTC)
From: Viktor Malik <vmalik@redhat.com>
To: bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Viktor Malik <vmalik@redhat.com>
Subject: [RFC bpf-next 3/3] selftests/bpf: Add tests for aliased programs
Date: Mon,  2 Sep 2024 08:58:03 +0200
Message-ID: <6351e73916133f35582f100eb09828cbac6b0f68.1725016029.git.vmalik@redhat.com>
In-Reply-To: <cover.1725016029.git.vmalik@redhat.com>
References: <cover.1725016029.git.vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

The previous two commits added libbpf support for BPF objects containing
multiple programs sharing the same instructions using the compiler
`__attribute__((alias("...")))`.

This adds tests for such objects. The tests check that different kinds
of relocations (namely for global vars, maps, subprogs, and CO-RE) are
correctly performed in both the original and the aliasing BPF program
and that both programs hit when the target event occurs.

Signed-off-by: Viktor Malik <vmalik@redhat.com>
---
 .../selftests/bpf/prog_tests/fentry_alias.c   | 41 +++++++++
 .../selftests/bpf/progs/fentry_alias.c        | 83 +++++++++++++++++++
 2 files changed, 124 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fentry_alias.c
 create mode 100644 tools/testing/selftests/bpf/progs/fentry_alias.c

diff --git a/tools/testing/selftests/bpf/prog_tests/fentry_alias.c b/tools/testing/selftests/bpf/prog_tests/fentry_alias.c
new file mode 100644
index 000000000000..6b9c6895b374
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/fentry_alias.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include "fentry_alias.skel.h"
+
+void test_fentry_alias(void)
+{
+	struct fentry_alias *fentry_skel = NULL;
+	int err, prog_fd;
+	__u64 key = 0, val;
+
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+
+	fentry_skel = fentry_alias__open_and_load();
+	if (!ASSERT_OK_PTR(fentry_skel, "fentry_skel_load"))
+		goto cleanup;
+
+	err = fentry_alias__attach(fentry_skel);
+	if (!ASSERT_OK(err, "fentry_attach"))
+		goto cleanup;
+
+	fentry_skel->bss->real_pid = getpid();
+
+	prog_fd = bpf_program__fd(fentry_skel->progs.test1);
+	err = bpf_prog_test_run_opts(prog_fd, &opts);
+
+	ASSERT_EQ(fentry_skel->bss->test1_hit_cnt, 2,
+		  "fentry_alias_test1_result");
+
+	err = bpf_map__lookup_elem(fentry_skel->maps.map, &key, sizeof(key),
+				   &val, sizeof(val), 0);
+	ASSERT_OK(err, "hashmap lookup");
+	ASSERT_EQ(val, 2, "fentry_alias_test2_result");
+
+	ASSERT_EQ(fentry_skel->bss->test3_hit_cnt, 2,
+		  "fentry_alias_test3_result");
+
+	ASSERT_EQ(fentry_skel->bss->test4_hit_cnt, 2,
+		  "fentry_alias_test4_result");
+cleanup:
+	fentry_alias__destroy(fentry_skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/fentry_alias.c b/tools/testing/selftests/bpf/progs/fentry_alias.c
new file mode 100644
index 000000000000..5d7b492c7f95
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/fentry_alias.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+
+char _license[] SEC("license") = "GPL";
+
+struct task_struct {
+	int tgid;
+} __attribute__((preserve_access_index));
+
+int real_pid = 0;
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 1);
+	__type(key, __u64);
+	__type(value, __u64);
+} map SEC(".maps");
+
+/* test1 - glob var relocations */
+__u64 test1_hit_cnt = 0;
+
+SEC("fentry/bpf_fentry_test1")
+int BPF_PROG(test1, int a)
+{
+	test1_hit_cnt++;
+	return 0;
+}
+
+int test1_alias(int a) __attribute__((alias("test1")));
+
+/* test2 - map relocations */
+SEC("fentry/bpf_fentry_test1")
+int BPF_PROG(test2, int a)
+{
+	__u64 key = 0, *value, new_value;
+
+	value = bpf_map_lookup_elem(&map, &key);
+	new_value = value ? *value + 1 : 1;
+	bpf_map_update_elem(&map, &key, &new_value, 0);
+	return 0;
+}
+
+int test2_alias(int a) __attribute__((alias("test2")));
+
+/* test3 - subprog relocations */
+__u64 test3_hit_cnt = 0;
+
+static __noinline void test3_subprog(void)
+{
+	test3_hit_cnt++;
+}
+
+SEC("fentry/bpf_fentry_test1")
+int BPF_PROG(test3, int a)
+{
+	test3_subprog();
+	return 0;
+}
+
+int test3_alias(int a) __attribute__((alias("test3")));
+
+/* test4 - CO-RE relocations */
+__u64 test4_hit_cnt = 0;
+
+SEC("fentry/bpf_fentry_test1")
+int BPF_PROG(test4, int a)
+{
+	struct task_struct *task;
+	int pid;
+
+	task = (void *)bpf_get_current_task();
+	pid = BPF_CORE_READ(task, tgid);
+
+	if (pid == real_pid)
+		test4_hit_cnt++;
+
+	return 0;
+}
+
+int test4_alias(int a) __attribute__((alias("test4")));
-- 
2.46.0


