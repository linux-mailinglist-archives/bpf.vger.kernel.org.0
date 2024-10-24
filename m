Return-Path: <bpf+bounces-43002-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55ECF9ADA1C
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 04:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 867571C21A14
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 02:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B5E155336;
	Thu, 24 Oct 2024 02:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="wm7uSVrh"
X-Original-To: bpf@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868311E51D;
	Thu, 24 Oct 2024 02:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729738112; cv=none; b=tCNqxjsY4cfcRM9sEEJ6W+EadvwSLhp5lFjeOTX9yfkVSMznzzLyiCH93q+zpJxgSXBX7zC0RF6kaPxCe+xcYuLcSWQI3vQQHYib62c9MDf6epk1yCefB9IL5R4nXFd5eEjE22TF3/Mavb5bJoHCsS/NTchAVbkmvitr34xTUCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729738112; c=relaxed/simple;
	bh=pDBnVwV4TrSz9x6jHbsxWa5WmwTlfzb/lAVwo0dzrhc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=DlAhQyBOSw0PuVxwCB4S6q7D6xDr/4Ba033lcMf5VsZ+SR5NXDHn93/4ASc2mryPwdct3zvkFqBJUmp9PYk0fb06Np8yhB93WDD5uO4EhJuejivC7/jrnRx1hRILoM/ul0QzXx0ShcCwYM5PLNhGTWU+AINw5VU4iEH3XhEXdbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=wm7uSVrh; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729738100; h=From:To:Subject:Date:Message-Id;
	bh=9jvqQZLq79EKmM2QtBsiWqAED1EfuumssWsjxKW9xfc=;
	b=wm7uSVrhEyHL4EtJ5yrE0EfuyL++xuqviL4PenWQstX0vlOfzhCrQjQxCZLUk7ryPA2PcynL5khZckwkX6vOJSj8B8My/0QjdqWawAKNoa9PYH8dh0eyJ1AaW3Xhn4m3cxSclU0Q6xGX6kSaf8r6cVEmzvYltOyTs3j6gfbxTKI=
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WHnU0H6_1729737776 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 24 Oct 2024 10:42:57 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com>
To: kgraul@linux.ibm.com,
	wenjia@linux.ibm.com,
	jaka@linux.ibm.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	pabeni@redhat.com,
	song@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	yhs@fb.com,
	edumazet@google.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	jolsa@kernel.org,
	guwen@linux.alibaba.com
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	bpf@vger.kernel.org,
	dtcccc@linux.alibaba.com
Subject: [PATCH bpf-next 4/4] bpf/selftests: add simple selftest for bpf_smc_ops
Date: Thu, 24 Oct 2024 10:42:48 +0800
Message-Id: <1729737768-124596-5-git-send-email-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1729737768-124596-1-git-send-email-alibuda@linux.alibaba.com>
References: <1729737768-124596-1-git-send-email-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

From: "D. Wythe" <alibuda@linux.alibaba.com>

This PATCH adds a tiny selftest for bpf_smc_ops, to verify the ability
to attach and write access.

Follow the steps below to run this test.

make -C tools/testing/selftests/bpf
cd tools/testing/selftests/bpf
sudo ./test_progs -t smc

Results shows:
Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
---
 .../selftests/bpf/prog_tests/test_bpf_smc.c        | 21 +++++++++++
 tools/testing/selftests/bpf/progs/bpf_smc.c        | 44 ++++++++++++++++++++++
 2 files changed, 65 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_bpf_smc.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_smc.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_bpf_smc.c b/tools/testing/selftests/bpf/prog_tests/test_bpf_smc.c
new file mode 100644
index 00000000..2299853
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_bpf_smc.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+
+#include "bpf_smc.skel.h"
+
+static void load(void)
+{
+	struct bpf_smc *skel;
+
+	skel = bpf_smc__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "bpf_smc__open_and_load"))
+		return;
+
+	bpf_smc__destroy(skel);
+}
+
+void test_bpf_smc(void)
+{
+	if (test__start_subtest("load"))
+		load();
+}
diff --git a/tools/testing/selftests/bpf/progs/bpf_smc.c b/tools/testing/selftests/bpf/progs/bpf_smc.c
new file mode 100644
index 00000000..ebff477
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_smc.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+struct smc_bpf_ops_ctx {
+	struct {
+		struct tcp_sock *tp;
+	} set_option;
+	struct {
+		const struct tcp_sock *tp;
+		struct inet_request_sock *ireq;
+		int smc_ok;
+	} set_option_cond;
+};
+
+struct smc_bpf_ops {
+	void (*set_option)(struct smc_bpf_ops_ctx *ctx);
+	void (*set_option_cond)(struct smc_bpf_ops_ctx *ctx);
+};
+
+SEC("struct_ops/bpf_smc_set_tcp_option_cond")
+void BPF_PROG(bpf_smc_set_tcp_option_cond, struct smc_bpf_ops_ctx *arg)
+{
+	arg->set_option_cond.smc_ok = 1;
+}
+
+SEC("struct_ops/bpf_smc_set_tcp_option")
+void BPF_PROG(bpf_smc_set_tcp_option, struct smc_bpf_ops_ctx *arg)
+{
+	struct tcp_sock *tp = arg->set_option.tp;
+
+	tp->syn_smc = 1;
+}
+
+SEC(".struct_ops.link")
+struct smc_bpf_ops sample_smc_bpf_ops = {
+	.set_option         = (void *) bpf_smc_set_tcp_option,
+	.set_option_cond    = (void *) bpf_smc_set_tcp_option_cond,
+};
-- 
1.8.3.1


