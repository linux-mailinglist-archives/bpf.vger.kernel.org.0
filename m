Return-Path: <bpf+bounces-50982-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAAFBA2EEB8
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 14:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 442AE3A3709
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 13:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A32230D10;
	Mon, 10 Feb 2025 13:48:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8D9225A25;
	Mon, 10 Feb 2025 13:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739195316; cv=none; b=FHF/8TyhR9nv+DmxXAUHsTizgMUndVSh9vw3feWm2GtAvc+8F5oLUgzm78NZEjDDY2VaRBVGzwSX4Q6+EGeyh3yan6NUvXneYYzw7a28OyNRUf351AcFVzyYPzTLRls855KS2+OubE04nVIo5JA5fj19WRAESPOVMFxDkLPaeo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739195316; c=relaxed/simple;
	bh=N99ZGav6k1lM+YsIFsqbv9nxpIHKc6sAHd6Faaoohhk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A99KECovLF4FEYSCqStr5nNhu3AuKg951g4GLCHHDvOje1rbRGrJ6LYQQstggYx43nQ1iWRktlVty0xrGdtBqpSDsAE73lruL+ZM1dm8XHX/53SyTGv9TbwBiXjrhn3rmWW8S0F4V+E6YKT4VNV/YYh03sYME/u9XcCsr/rD2XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Ys5RL6FkTz2FdL9;
	Mon, 10 Feb 2025 21:44:46 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 5EE1718001B;
	Mon, 10 Feb 2025 21:48:30 +0800 (CST)
Received: from kwepemn200003.china.huawei.com (7.202.194.126) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 10 Feb 2025 21:48:30 +0800
Received: from localhost.localdomain (10.175.101.6) by
 kwepemn200003.china.huawei.com (7.202.194.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 10 Feb 2025 21:48:28 +0800
From: zhangmingyi <zhangmingyi5@huawei.com>
To: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
	<haoluo@google.com>, <jolsa@kernel.org>
CC: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <yanan@huawei.com>,
	<wuchangye@huawei.com>, <xiesongyang@huawei.com>, <liuxin350@huawei.com>,
	<liwei883@huawei.com>, <tianmuyang@huawei.com>, <zhangmingyi5@huawei.com>
Subject: [PATCH v2 2/2] bpf-next: selftest for TCP_ULP in bpf_setsockopt
Date: Mon, 10 Feb 2025 21:45:50 +0800
Message-ID: <20250210134550.3189616-3-zhangmingyi5@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250210134550.3189616-1-zhangmingyi5@huawei.com>
References: <20250210134550.3189616-1-zhangmingyi5@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemn200003.china.huawei.com (7.202.194.126)

From: Mingyi Zhang <zhangmingyi5@huawei.com>

We try to use bpf_set/getsockopt to set/get TCP_ULP in sockops, and "tls"
need connect is established.To avoid impacting other test cases, I have
written a separate test case file.

Signed-off-by: Mingyi Zhang <zhangmingyi5@huawei.com>
Signed-off-by: Xin Liu <liuxin350@huawei.com>
---
 .../bpf/prog_tests/setget_sockopt_tcp_ulp.c   | 78 +++++++++++++++++++
 .../bpf/progs/setget_sockopt_tcp_ulp.c        | 33 ++++++++
 2 files changed, 111 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/setget_sockopt_tcp_ulp.c
 create mode 100644 tools/testing/selftests/bpf/progs/setget_sockopt_tcp_ulp.c

diff --git a/tools/testing/selftests/bpf/prog_tests/setget_sockopt_tcp_ulp.c b/tools/testing/selftests/bpf/prog_tests/setget_sockopt_tcp_ulp.c
new file mode 100644
index 000000000000..748da2c7d255
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/setget_sockopt_tcp_ulp.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) Meta Platforms, Inc. and affiliates. */
+
+#define _GNU_SOURCE
+#include <net/if.h>
+
+#include "test_progs.h"
+#include "network_helpers.h"
+
+#include "setget_sockopt_tcp_ulp.skel.h"
+
+#define CG_NAME "/setget-sockopt-tcp-ulp-test"
+
+static const char addr4_str[] = "127.0.0.1";
+static const char addr6_str[] = "::1";
+static struct setget_sockopt_tcp_ulp *skel;
+static int cg_fd;
+
+static int create_netns(void)
+{
+	if (!ASSERT_OK(unshare(CLONE_NEWNET), "create netns"))
+		return -1;
+	if (!ASSERT_OK(system("ip link set dev lo up"), "set lo up"))
+		return -1;
+	return 0;
+}
+
+static int modprobe_tls(void)
+{
+	if (!ASSERT_OK(system("modprobe tls"), "tls modprobe failed"))
+		return -1;
+	return 0;
+}
+
+static void test_tcp_ulp(int family)
+{
+	struct setget_sockopt_tcp_ulp__bss *bss = skel->bss;
+	int sfd, cfd;
+
+	memset(bss, 0, sizeof(*bss));
+	sfd = start_server(family, SOCK_STREAM,
+			   family == AF_INET6 ? addr6_str : addr4_str, 0, 0);
+	if (!ASSERT_GE(sfd, 0, "start_server"))
+		return;
+
+	cfd = connect_to_fd(sfd, 0);
+	if (!ASSERT_GE(cfd, 0, "connect_to_fd_server")) {
+		close(sfd);
+		return;
+	}
+	close(sfd);
+	close(cfd);
+
+	ASSERT_EQ(bss->nr_tcp_ulp, 3, "nr_tcp_ulp");
+}
+
+void test_setget_sockopt_tcp_ulp(void)
+{
+	cg_fd = test__join_cgroup(CG_NAME);
+	if (cg_fd < 0)
+		return;
+	if (create_netns() && modprobe_tls())
+		goto done;
+	skel = setget_sockopt_tcp_ulp__open();
+	if (!ASSERT_OK_PTR(skel, "open skel"))
+		goto done;
+	if (!ASSERT_OK(setget_sockopt_tcp_ulp__load(skel), "load skel"))
+		goto done;
+	skel->links.skops_sockopt_tcp_ulp =
+		bpf_program__attach_cgroup(skel->progs.skops_sockopt_tcp_ulp, cg_fd);
+	if (!ASSERT_OK_PTR(skel->links.skops_sockopt_tcp_ulp, "attach_cgroup"))
+		goto done;
+	test_tcp_ulp(AF_INET);
+	test_tcp_ulp(AF_INET6);
+done:
+	setget_sockopt_tcp_ulp__destroy(skel);
+	close(cg_fd);
+}
diff --git a/tools/testing/selftests/bpf/progs/setget_sockopt_tcp_ulp.c b/tools/testing/selftests/bpf/progs/setget_sockopt_tcp_ulp.c
new file mode 100644
index 000000000000..bd1009766463
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/setget_sockopt_tcp_ulp.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include "bpf_tracing_net.h"
+#include <bpf/bpf_helpers.h>
+
+int nr_tcp_ulp;
+
+SEC("sockops")
+int skops_sockopt_tcp_ulp(struct bpf_sock_ops *skops)
+{
+	static const char target_ulp[] = "tls";
+	char verify_ulp[sizeof(target_ulp)];
+
+	switch (skops->op) {
+	case BPF_SOCK_OPS_ACTIVE_ESTABLISHED_CB:
+		if (bpf_setsockopt(skops, IPPROTO_TCP, TCP_ULP, (void *)target_ulp,
+							sizeof(target_ulp)) != 0)
+			return 1;
+		nr_tcp_ulp++;
+		if (bpf_getsockopt(skops, IPPROTO_TCP, TCP_ULP, verify_ulp,
+							sizeof(verify_ulp)) != 0)
+			return 1;
+		nr_tcp_ulp++;
+		if (bpf_strncmp(verify_ulp, sizeof(target_ulp), "tls") != 0)
+			return 1;
+		nr_tcp_ulp++;
+	}
+	return 1;
+}
+
+char _license[] SEC("license") = "GPL";
\ No newline at end of file
-- 
2.43.0


