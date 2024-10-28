Return-Path: <bpf+bounces-43297-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 594DC9B2E88
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 12:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 793B31C218BD
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 11:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1344C1E0488;
	Mon, 28 Oct 2024 11:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBaFzwDw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3761DFE37;
	Mon, 28 Oct 2024 11:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730113647; cv=none; b=GHsxB894Rto2aAmJJXCDBbcBVnZ3AqitdtTsFtfG1jXrF3qrv2XPUqlUPvP5yzLYUSByx3MuzILutxf/B4QdIsB11mPoVufknShYpeXUGSggXACBZJa+cjFgk36YJv6vgoWLC7+J3LvVhMzEkM6duUO+ItAPOC52UtSlk4tR95k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730113647; c=relaxed/simple;
	bh=1+7fJFm/WoUOYEe4hnI20HbseEwTxTSjEVJEfPkt8eI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J3mUkF6tRfxqXUr9YWFRqYlLNeO5nXQTca/N6eJikd1IQUyokB9QC6iSSstBeeek+MKHce6jQO8Fe7tbv3HnKY3jqbs3JJOqc6gcc+GR6iPcQp6bHnzkHGbYJAepacZfu6PZv7Rpd1Uf88fL/SAHJc91eak/L+Kk4NcePszX74c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EBaFzwDw; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20ca388d242so35732675ad.2;
        Mon, 28 Oct 2024 04:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730113645; x=1730718445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g8LljQEp1G0JwNkGMQ7KCHMGGWnguu0SHPLITgEM4cM=;
        b=EBaFzwDwTaMF14/Z1+edRnyUoDPJKgr6p5dDq24/CwIvAEOdfpaSDVbTiHsob76Y5A
         MwrevyN0YPr+wjpeyDGr8m8wZzbCQogFVJALwKb3G8QHYoqIb+50wVMLrwsOXm4bzvIh
         eroznvdRFnkU6Bjx2SAwxahQeG1wQ8GKbGT2tIGhPajVxE2HyUmfbbu4fr+2PoRboudU
         p3rxOHe7cxBdhZK6C8XosSZa9GYOa4OBydNIywEREgUTLc1hd2+Y/vfQKPm58hD+E6ad
         9NMuqwdEUGsgKuV8rIJuMVhu/uTyKYl+YeM8yG488kRdsOSPYFYzREUTZ61KBTcpyhhA
         PYBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730113645; x=1730718445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g8LljQEp1G0JwNkGMQ7KCHMGGWnguu0SHPLITgEM4cM=;
        b=etaXFepTa51AV/8S2nsqTT5CkEvGidOc9wO3YAgITYAG5ZidzkNAsB8MW/+PhBO5eq
         Aq6qIa0RZZ9eQ8ozvoDi4ZEfNGg4AVP761Z2ZtA/Ht5JEED0O/z8H6WlkjEfJuwsKFxF
         A7aWhVOlCjgkUmRMC1BIlCF2ZIx9kuQ7EqPyAnFtko+jB5MW2dUKYCqjV2wyA6UcHhnk
         s1qKLDRt+obhLCQgOq13t/DMU/jRW2u+L/cRlP8HIbuXTwyJM6DINWwkFqcMhNUAM5pe
         Qdg5JqEANA9NqJp4TUohTKtpJ8u9j65Ba5ZaMDE4lFFTvM0r/nZjxkSVo6eWIU+NJpDy
         5sLQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3fJGXxLhWc6CQNe9nCHOHF3iyXYxy5xZ2IcuIn9yYd7GmdiB9cqHH8kwauvwSt7r06Hgcg98=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQunQHk9SMLSUQbHZIQVxokfMQwrC2BwWn6iae+aECZeQvcjNY
	7KQM2q5PUs/CAdSfliQiB92Ei+HdeUVVo5ZtHxi3Gpp9DyEuVNAO
X-Google-Smtp-Source: AGHT+IE2QnZZq1TnagujvGe5bzFXg1gaxEsnAyYVOZdbTJl659nRCT/T+nSVtKwMnR+t7aLwoPZH6Q==
X-Received: by 2002:a17:902:fc4c:b0:20c:aa41:9968 with SMTP id d9443c01a7336-210c6c83057mr101119875ad.53.1730113644888;
        Mon, 28 Oct 2024 04:07:24 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc04bdb6sm48130905ad.255.2024.10.28.04.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 04:07:24 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	willemdebruijn.kernel@gmail.com,
	willemb@google.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	ykolal@fb.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v3 14/14] bpf: add simple bpf tests in the tx path for so_timstamping feature
Date: Mon, 28 Oct 2024 19:05:35 +0800
Message-Id: <20241028110535.82999-15-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20241028110535.82999-1-kerneljasonxing@gmail.com>
References: <20241028110535.82999-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Only check if we pass those three key points after we enable the
bpf extension for so_timestamping. During each point, we can choose
whether to print the current timestamp.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 .../bpf/prog_tests/so_timestamping.c          |  98 ++++++++++++++
 .../selftests/bpf/progs/so_timestamping.c     | 123 ++++++++++++++++++
 2 files changed, 221 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/so_timestamping.c
 create mode 100644 tools/testing/selftests/bpf/progs/so_timestamping.c

diff --git a/tools/testing/selftests/bpf/prog_tests/so_timestamping.c b/tools/testing/selftests/bpf/prog_tests/so_timestamping.c
new file mode 100644
index 000000000000..dfb7588c246d
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/so_timestamping.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Tencent */
+
+#define _GNU_SOURCE
+#include <sched.h>
+#include <linux/socket.h>
+#include <linux/tls.h>
+#include <net/if.h>
+
+#include "test_progs.h"
+#include "cgroup_helpers.h"
+#include "network_helpers.h"
+
+#include "so_timestamping.skel.h"
+
+#define CG_NAME "/so-timestamping-test"
+
+static const char addr4_str[] = "127.0.0.1";
+static const char addr6_str[] = "::1";
+static struct so_timestamping *skel;
+static int cg_fd;
+
+static int create_netns(void)
+{
+	if (!ASSERT_OK(unshare(CLONE_NEWNET), "create netns"))
+		return -1;
+
+	if (!ASSERT_OK(system("ip link set dev lo up"), "set lo up"))
+		return -1;
+
+	return 0;
+}
+
+static void test_tcp(int family)
+{
+	struct so_timestamping__bss *bss = skel->bss;
+	char buf[] = "testing testing";
+	int sfd = -1, cfd = -1;
+	int n;
+
+	memset(bss, 0, sizeof(*bss));
+
+	sfd = start_server(family, SOCK_STREAM,
+			   family == AF_INET6 ? addr6_str : addr4_str, 0, 0);
+	if (!ASSERT_GE(sfd, 0, "start_server"))
+		goto out;
+
+	cfd = connect_to_fd(sfd, 0);
+	if (!ASSERT_GE(cfd, 0, "connect_to_fd_server")) {
+		close(sfd);
+		goto out;
+	}
+
+	n = write(cfd, buf, sizeof(buf));
+	if (!ASSERT_EQ(n, sizeof(buf), "send to server"))
+		goto out;
+
+	ASSERT_EQ(bss->nr_active, 1, "nr_active");
+	ASSERT_EQ(bss->nr_passive, 1, "nr_passive");
+	ASSERT_EQ(bss->nr_sched, 1, "nr_sched");
+	ASSERT_EQ(bss->nr_txsw, 1, "nr_txsw");
+	ASSERT_EQ(bss->nr_ack, 1, "nr_ack");
+
+out:
+	if (sfd >= 0)
+		close(sfd);
+	if (cfd >= 0)
+		close(cfd);
+}
+
+void test_so_timestamping(void)
+{
+	cg_fd = test__join_cgroup(CG_NAME);
+	if (cg_fd < 0)
+		return;
+
+	if (create_netns())
+		goto done;
+
+	skel = so_timestamping__open();
+	if (!ASSERT_OK_PTR(skel, "open skel"))
+		goto done;
+
+	if (!ASSERT_OK(so_timestamping__load(skel), "load skel"))
+		goto done;
+
+	skel->links.skops_sockopt =
+		bpf_program__attach_cgroup(skel->progs.skops_sockopt, cg_fd);
+	if (!ASSERT_OK_PTR(skel->links.skops_sockopt, "attach cgroup"))
+		goto done;
+
+	test_tcp(AF_INET6);
+	test_tcp(AF_INET);
+
+done:
+	so_timestamping__destroy(skel);
+	close(cg_fd);
+}
diff --git a/tools/testing/selftests/bpf/progs/so_timestamping.c b/tools/testing/selftests/bpf/progs/so_timestamping.c
new file mode 100644
index 000000000000..a15317951786
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/so_timestamping.c
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Tencent */
+
+#include "vmlinux.h"
+#include "bpf_tracing_net.h"
+#include <bpf/bpf_core_read.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+
+#define SO_TIMESTAMPING 37
+#define SOF_TIMESTAMPING_BPF_SUPPPORTED_MASK (SOF_TIMESTAMPING_SOFTWARE | \
+					      SOF_TIMESTAMPING_TX_SCHED | \
+					      SOF_TIMESTAMPING_TX_SOFTWARE | \
+					      SOF_TIMESTAMPING_TX_ACK | \
+					      SOF_TIMESTAMPING_OPT_ID | \
+					      SOF_TIMESTAMPING_OPT_ID_TCP)
+
+extern unsigned long CONFIG_HZ __kconfig;
+
+int nr_active;
+int nr_passive;
+int nr_sched;
+int nr_txsw;
+int nr_ack;
+
+struct sockopt_test {
+	int opt;
+	int new;
+	int expected;
+};
+
+static const struct sockopt_test sol_socket_tests[] = {
+	{ .opt = SO_TIMESTAMPING, .new = SOF_TIMESTAMPING_TX_SCHED, .expected = 256, },
+	{ .opt = SO_TIMESTAMPING, .new = SOF_TIMESTAMPING_BPF_SUPPPORTED_MASK, .expected = 66450, },
+	{ .opt = 0, },
+};
+
+struct loop_ctx {
+	void *ctx;
+	struct sock *sk;
+};
+
+static int bpf_test_sockopt_int(void *ctx, struct sock *sk,
+				const struct sockopt_test *t,
+				int level)
+{
+	int tmp, new, expected, opt;
+
+	opt = t->opt;
+	new = t->new;
+	expected = t->expected;
+
+	if (bpf_setsockopt(ctx, level, opt, &new, sizeof(new)))
+		return 1;
+	if (bpf_getsockopt(ctx, level, opt, &tmp, sizeof(tmp)) ||
+	    tmp != expected)
+		return 1;
+
+	return 0;
+}
+
+static int bpf_test_socket_sockopt(__u32 i, struct loop_ctx *lc)
+{
+	const struct sockopt_test *t;
+
+	if (i >= ARRAY_SIZE(sol_socket_tests))
+		return 1;
+
+	t = &sol_socket_tests[i];
+	if (!t->opt)
+		return 1;
+
+	return bpf_test_sockopt_int(lc->ctx, lc->sk, t, SOL_SOCKET);
+}
+
+static int bpf_test_sockopt(void *ctx, struct sock *sk)
+{
+	struct loop_ctx lc = { .ctx = ctx, .sk = sk, };
+	int n;
+
+	n = bpf_loop(ARRAY_SIZE(sol_socket_tests), bpf_test_socket_sockopt, &lc, 0);
+	if (n != ARRAY_SIZE(sol_socket_tests))
+		return -1;
+
+	return 0;
+}
+
+SEC("sockops")
+int skops_sockopt(struct bpf_sock_ops *skops)
+{
+	struct bpf_sock *bpf_sk = skops->sk;
+	struct sock *sk;
+
+	if (!bpf_sk)
+		return 1;
+
+	sk = (struct sock *)bpf_skc_to_tcp_sock(bpf_sk);
+	if (!sk)
+		return 1;
+
+	switch (skops->op) {
+	case BPF_SOCK_OPS_ACTIVE_ESTABLISHED_CB:
+		nr_active += !bpf_test_sockopt(skops, sk);
+		break;
+	case BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB:
+		nr_passive += !bpf_test_sockopt(skops, sk);
+		break;
+	case BPF_SOCK_OPS_TS_SCHED_OPT_CB:
+		nr_sched += 1;
+		break;
+	case BPF_SOCK_OPS_TS_SW_OPT_CB:
+		nr_txsw += 1;
+		break;
+	case BPF_SOCK_OPS_TS_ACK_OPT_CB:
+		nr_ack += 1;
+		break;
+	}
+
+	return 1;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.37.3


