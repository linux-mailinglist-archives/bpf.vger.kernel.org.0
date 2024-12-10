Return-Path: <bpf+bounces-46478-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BEF9EA6EF
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 05:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D728716825D
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 04:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363B0226185;
	Tue, 10 Dec 2024 04:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="lHVAEolG"
X-Original-To: bpf@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950961D88BE;
	Tue, 10 Dec 2024 04:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733803459; cv=none; b=OeNLsZWU7vg76we3hRRC+Xs6xEqTGm831MQRzIoWZdiQEIvD1nKo8A4F/o6nkRoR3ChSujjpgJ0hRS48NyIj18LSlgaYEBx4nmu8Tn1gmnKhg9mQWWZ7HYAGP30DzXumxVCJnXhS62weTvaIPm/7ZOGg9S0APZ4g8jnkY6d5BBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733803459; c=relaxed/simple;
	bh=Bur7wMe5CNt8U8U0nLUgsvhEgiGkXeP06pNuElZiwdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fdwm5JoKp0AB/zrfis4CuS7kabW42smujMAFxgyr8KC8ApKjE4gSnbUMp0GF2HM5e3qctkeEJkItaD3i51BEWJjaZe1LTq8q6T1nx3nHaGl/Z8hdiSspfoIUxG8FaS1yhE8NswngT+FcaT6vHqMnqUHwsKr55RCr96t0bIheYMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=lHVAEolG; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733803454; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=vTSvP3e/ROYC5cFQaLa60zEsDF7ockvJdWEdUmNMjvs=;
	b=lHVAEolGuvMdSG/CFiSDX0Zas/5e2AuXyh1ZBL0tFh1a1F93mIlZiWsCASg4ifuzImof5g6mY9rlut5LkkkZqemekm5He12fWT7YFsVGjvgplafUydZSUvKTbjzWkjvFD1VTceY/6LRM3SimV733F4ziVkAdrU3uEiIWvNEaLek=
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WLDSEYr_1733803452 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 10 Dec 2024 12:04:13 +0800
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
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 5/5] bpf/selftests: add simple selftest for bpf_smc_ops
Date: Tue, 10 Dec 2024 12:04:04 +0800
Message-ID: <20241210040404.10606-6-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241210040404.10606-1-alibuda@linux.alibaba.com>
References: <20241210040404.10606-1-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This PATCH adds a tiny selftest for bpf_smc_ops, to verify the ability
to load and attach.

Follow the steps below to run this test.

make -C tools/testing/selftests/bpf
cd tools/testing/selftests/bpf
sudo ./test_progs -t smc

Results shows:
Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
---
 tools/testing/selftests/bpf/config            |  3 +++
 .../selftests/bpf/prog_tests/test_bpf_smc.c   | 25 +++++++++++++++++
 tools/testing/selftests/bpf/progs/bpf_smc.c   | 27 +++++++++++++++++++
 3 files changed, 55 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_bpf_smc.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_smc.c

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index c378d5d07e02..99f1cf10475f 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -113,3 +113,6 @@ CONFIG_XDP_SOCKETS=y
 CONFIG_XFRM_INTERFACE=y
 CONFIG_TCP_CONG_DCTCP=y
 CONFIG_TCP_CONG_BBR=y
+CONFIG_INFINIBAND=m
+CONFIG_SMC=m
+CONFIG_SMC_OPS=y
\ No newline at end of file
diff --git a/tools/testing/selftests/bpf/prog_tests/test_bpf_smc.c b/tools/testing/selftests/bpf/prog_tests/test_bpf_smc.c
new file mode 100644
index 000000000000..b24da7e8db66
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_bpf_smc.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+
+#include "bpf_smc.skel.h"
+
+static void load(void)
+{
+	struct bpf_smc *skel;
+	int ret;
+
+	skel = bpf_smc__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "bpf_smc__open_and_load"))
+		return;
+
+	ret = bpf_smc__attach(skel);
+	ASSERT_EQ(ret, 0, "bpf_smc__attach");
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
index 000000000000..32d15596f209
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_smc.c
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+SEC("struct_ops/bpf_smc_set_tcp_option_cond")
+int BPF_PROG(bpf_smc_set_tcp_option_cond, const struct tcp_sock *tp, struct inet_request_sock *ireq)
+{
+	return 0;
+}
+
+SEC("struct_ops/bpf_smc_set_tcp_option")
+int BPF_PROG(bpf_smc_set_tcp_option, struct tcp_sock *tp)
+{
+	return 1;
+}
+
+SEC(".struct_ops.link")
+struct smc_ops  sample_smc_ops = {
+	.name			= "sample",
+	.set_option		= (void *) bpf_smc_set_tcp_option,
+	.set_option_cond	= (void *) bpf_smc_set_tcp_option_cond,
+};
-- 
2.45.0


