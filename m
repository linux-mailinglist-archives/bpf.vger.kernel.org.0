Return-Path: <bpf+bounces-18386-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 377F281A0C9
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 15:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69B521C233B8
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 14:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7244F38F9F;
	Wed, 20 Dec 2023 14:09:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140BD38F96;
	Wed, 20 Dec 2023 14:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R641e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VyumN3k_1703081361;
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0VyumN3k_1703081361)
          by smtp.aliyun-inc.com;
          Wed, 20 Dec 2023 22:09:22 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com>
To: pablo@netfilter.org,
	kadlec@netfilter.org,
	fw@strlen.de
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	coreteam@netfilter.org,
	netfilter-devel@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org
Subject: [RFC nf-next v3 2/2] selftests/bpf: Add netfilter link prog update test
Date: Wed, 20 Dec 2023 22:09:11 +0800
Message-Id: <1703081351-85579-3-git-send-email-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1703081351-85579-1-git-send-email-alibuda@linux.alibaba.com>
References: <1703081351-85579-1-git-send-email-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

From: "D. Wythe" <alibuda@linux.alibaba.com>

Update prog for active links and verify whether
the prog has been successfully replaced.

Expected output:

./test_progs -t netfilter_link_update_prog
Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
---
 .../bpf/prog_tests/netfilter_link_update_prog.c    | 83 ++++++++++++++++++++++
 .../bpf/progs/test_netfilter_link_update_prog.c    | 24 +++++++
 2 files changed, 107 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/netfilter_link_update_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_netfilter_link_update_prog.c

diff --git a/tools/testing/selftests/bpf/prog_tests/netfilter_link_update_prog.c b/tools/testing/selftests/bpf/prog_tests/netfilter_link_update_prog.c
new file mode 100644
index 00000000..d23b544
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/netfilter_link_update_prog.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <test_progs.h>
+#include <linux/netfilter.h>
+#include <network_helpers.h>
+#include "test_netfilter_link_update_prog.skel.h"
+
+#define SERVER_ADDR "127.0.0.1"
+#define SERVER_PORT 12345
+
+static const char dummy_message[] = "A dummy message";
+
+static int send_dummy(int client_fd)
+{
+	struct sockaddr_storage saddr;
+	struct sockaddr *saddr_p;
+	socklen_t saddr_len;
+	int err;
+
+	saddr_p = (struct sockaddr *)&saddr;
+	err = make_sockaddr(AF_INET, SERVER_ADDR, SERVER_PORT, &saddr, &saddr_len);
+	if (!ASSERT_OK(err, "make_sockaddr"))
+		return -1;
+
+	err = sendto(client_fd, dummy_message, sizeof(dummy_message) - 1, 0, saddr_p, saddr_len);
+	if (!ASSERT_GE(err, 0, "sendto"))
+		return -1;
+
+	return 0;
+}
+
+void test_netfilter_link_update_prog(void)
+{
+	LIBBPF_OPTS(bpf_netfilter_opts, opts,
+		.pf = NFPROTO_IPV4,
+		.hooknum = NF_INET_LOCAL_OUT,
+		.priority = 100);
+	struct test_netfilter_link_update_prog *skel;
+	struct bpf_program *prog;
+	int server_fd, client_fd;
+	int err;
+
+	skel = test_netfilter_link_update_prog__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "test_netfilter_link_update_prog__open_and_load"))
+		goto out;
+
+	prog = skel->progs.nf_link_prog;
+
+	if (!ASSERT_OK_PTR(prog, "load program"))
+		goto out;
+
+	skel->links.nf_link_prog = bpf_program__attach_netfilter(prog, &opts);
+	if (!ASSERT_OK_PTR(skel->links.nf_link_prog, "attach netfilter program"))
+		goto out;
+
+	server_fd = start_server(AF_INET, SOCK_DGRAM, SERVER_ADDR, SERVER_PORT, 0);
+	if (!ASSERT_GE(server_fd, 0, "start_server"))
+		goto out;
+
+	client_fd = connect_to_fd(server_fd, 0);
+	if (!ASSERT_GE(client_fd, 0, "connect_to_fd"))
+		goto out;
+
+	send_dummy(client_fd);
+
+	ASSERT_EQ(skel->bss->counter, 0, "counter should be zero");
+
+	err = bpf_link__update_program(skel->links.nf_link_prog, skel->progs.nf_link_prog_new);
+	if (!ASSERT_OK(err, "bpf_link__update_program"))
+		goto out;
+
+	send_dummy(client_fd);
+	ASSERT_GE(skel->bss->counter, 0, "counter should be greater than zero");
+out:
+	if (client_fd > 0)
+		close(client_fd);
+	if (server_fd > 0)
+		close(server_fd);
+
+	test_netfilter_link_update_prog__destroy(skel);
+}
+
+
diff --git a/tools/testing/selftests/bpf/progs/test_netfilter_link_update_prog.c b/tools/testing/selftests/bpf/progs/test_netfilter_link_update_prog.c
new file mode 100644
index 00000000..42ae332
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_netfilter_link_update_prog.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+
+#define NF_ACCEPT 1
+
+SEC("netfilter")
+int nf_link_prog(struct bpf_nf_ctx *ctx)
+{
+	return NF_ACCEPT;
+}
+
+u64 counter = 0;
+
+SEC("netfilter")
+int nf_link_prog_new(struct bpf_nf_ctx *ctx)
+{
+	counter++;
+	return NF_ACCEPT;
+}
+
+char _license[] SEC("license") = "GPL";
+
-- 
1.8.3.1


