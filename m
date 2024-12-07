Return-Path: <bpf+bounces-46362-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 081419E815C
	for <lists+bpf@lfdr.de>; Sat,  7 Dec 2024 18:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B3ED1885229
	for <lists+bpf@lfdr.de>; Sat,  7 Dec 2024 17:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C031509A5;
	Sat,  7 Dec 2024 17:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lItRufW3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62DC1487E9;
	Sat,  7 Dec 2024 17:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733593157; cv=none; b=BRd+MdrFiWGu4/NC1hI6g8gd9TlIn79D5ApUVRirpN2WFIAafMMVEzoI6tHh02t9HfsoKL93VGc1dajOltHDR3xNYx1PDPpZLFfJhDE75MnzLSG+vldmLGVs8oAHlWW1lDVNLmfPfUcONTyB7l7QB3bwbx+xq7pr7fgPJ9phmiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733593157; c=relaxed/simple;
	bh=OfuqCYx0LkuAEA+N2CIKTw4Tv5CskIi9y8M3re4pq70=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q79NJP1xmrykb0uqvQlV1eIGxNLL16LAjqPHGfAahqhAkJlZrtghKctx0ZMBkwHkMp8oXI1DmJA/Q2EPz21ak+sCzK1qJPU1qFiUgbXenyTpMJK63zkyuwZe39FdhG8x6sQmyT3WZYrXEHPajwS3eZjikAjp6+0qlLE7o7Kn3pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lItRufW3; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7ee11ff7210so2712026a12.1;
        Sat, 07 Dec 2024 09:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733593155; x=1734197955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S+bRND6c89v6YUTrH2nfxLUxnD0B/zRYvjhdTrLjOsA=;
        b=lItRufW3DN2yDdnnADDWaYk74M+LzDdtwYLlxV16OXVZ2WEE+OPyDaUqG0l803Pxtn
         UIOLqalYI74NvwN1fOv8+6tSQHfzEl9nlR13b6ubWfxehbx0P7HfXhxeG8RoPMhWmU9S
         RKqP74S4Qp+EA6tvb86AniAHV014hAMdehLo8sgmu2O3iX+n71PmEGoSdDcIxyXzC5Q5
         MKKPIGC7LZSTSV6GGKepf5QGPTKSreQn79sPWGi4wPyzk/9fDvWvRptsdCcB705tHub6
         Zx1AxXBJyWJP0JFE4S5wi/KvUEGToj6R0MGMql2xBM7UF6w3hpRwiq0JviOzjvcERaR4
         xbUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733593155; x=1734197955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S+bRND6c89v6YUTrH2nfxLUxnD0B/zRYvjhdTrLjOsA=;
        b=b5Z6QqWNgMexrjjSSAYaac/lv1X6qfwYbeh2vJbnj2jWpks6R6l/uI9KHDuWHI/2LD
         KW5Y6TzTCPQyzLL1GTcitUlpKFG5kvgwbhtCkDKPsR3sZHQMO8j7ni8x/a27ITAZXaPY
         mLu7JwSCt4KIuTXi+T6eI5Xyqi4fUMQCdPeEe2eiZYRexa8fd05AntBdV5ihY0SHUZ/3
         feq6KP9kywdriZgmsfbnFueM5fLD9v3+Mf8uIBlODzLCwML1QJFCBi0KTovFsrKdTNlW
         dSRMJPeURYgL/KCUGWdoDHIZf8/ee+RbCXjbFeBwbrysBnDUO6BUZoFejBqUpaVKurfS
         CDfA==
X-Forwarded-Encrypted: i=1; AJvYcCUj4ikgsoohncScTMPQH4AtnGjfB1uwLyefXnvpQYn5rhJ3ib683WJRwRD6HJmBndDhP+LeS/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMgS/jnOmzZ+Bzm070Pe9XVnULhH6VHhZXseJgqIpYdfrT9wyb
	EzOecRPOp8cZpkFzbYLWnZ3sU3rU5cru30/p903svDfoSiDyJT3b
X-Gm-Gg: ASbGncv9WpiabLMJFET/ExJv/QVF1wRk5vJNJqPygaDrpSG9Iz0r/bvOLkVqhZB+iuU
	5QZ9v1Ka8Hrl+6dXfXM07ruN9Swb/cnDkVaydqd2ehcXZs/JWRIXE9fP1S815exdarNjLFTvDdR
	+8Pd4GagMAGQXAnYte7x+lng68Oa4eL9mfGKE/zBMkJPBpMGXD8A+Gd8WaGeWbgcZy8lXe814G5
	tW4Sjq7wj4IQAw/SVo5YgQ41jWcdEHnfKNA2rRp7+I2HOBBAIQS4a05D8nf4sMkzCrQyTx9jo+H
	Vbqd8yRB4kuQ
X-Google-Smtp-Source: AGHT+IFQFS01I9bBCRycKh7rQSiWKUe2lwikvqjoOnHkVUBOqqv5LSL+UKahzGmnIC+aHNHiezMkfg==
X-Received: by 2002:a17:90b:3bce:b0:2ee:acb4:fee0 with SMTP id 98e67ed59e1d1-2ef69e1279bmr12341295a91.16.1733593155088;
        Sat, 07 Dec 2024 09:39:15 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.29.174])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef2708b807sm6963793a91.43.2024.12.07.09.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Dec 2024 09:39:14 -0800 (PST)
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
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v4 11/11] bpf: add simple bpf tests in the tx path for so_timstamping feature
Date: Sun,  8 Dec 2024 01:38:03 +0800
Message-Id: <20241207173803.90744-12-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20241207173803.90744-1-kerneljasonxing@gmail.com>
References: <20241207173803.90744-1-kerneljasonxing@gmail.com>
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
 .../bpf/prog_tests/so_timestamping.c          |  97 +++++++++++++
 .../selftests/bpf/progs/so_timestamping.c     | 135 ++++++++++++++++++
 2 files changed, 232 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/so_timestamping.c
 create mode 100644 tools/testing/selftests/bpf/progs/so_timestamping.c

diff --git a/tools/testing/selftests/bpf/prog_tests/so_timestamping.c b/tools/testing/selftests/bpf/prog_tests/so_timestamping.c
new file mode 100644
index 000000000000..c5978444f9c8
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/so_timestamping.c
@@ -0,0 +1,97 @@
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
index 000000000000..f64e94dbd70e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/so_timestamping.c
@@ -0,0 +1,135 @@
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
+#define SK_BPF_CB_FLAGS 1009
+#define SK_BPF_CB_TX_TIMESTAMPING 1
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
+};
+
+static const struct sockopt_test sol_socket_tests[] = {
+	{ .opt = SK_BPF_CB_FLAGS, .new = SK_BPF_CB_TX_TIMESTAMPING, },
+	{ .opt = 0, },
+};
+
+struct loop_ctx {
+	void *ctx;
+	struct sock *sk;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__type(key, u32);
+	__type(value, u64);
+	__uint(max_entries, 1024);
+} hash_map SEC(".maps");
+
+static u64 delay_tolerance_nsec = 5000000;
+
+static int bpf_test_sockopt_int(void *ctx, struct sock *sk,
+				const struct sockopt_test *t,
+				int level)
+{
+	int new, opt;
+
+	opt = t->opt;
+	new = t->new;
+
+	if (bpf_setsockopt(ctx, level, opt, &new, sizeof(new)))
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
+static bool bpf_test_delay(struct bpf_sock_ops *skops)
+{
+	u64 timestamp = bpf_ktime_get_ns();
+	u32 seq = skops->args[2];
+	u64 *value;
+
+	value = bpf_map_lookup_elem(&hash_map, &seq);
+	if (value && (timestamp - *value > delay_tolerance_nsec)) {
+		bpf_printk("time delay: %lu", timestamp - *value);
+		return false;
+	}
+
+	bpf_map_update_elem(&hash_map, &seq, &timestamp, BPF_ANY);
+	return true;
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
+	case BPF_SOCK_OPS_TS_SCHED_OPT_CB:
+		if (bpf_test_delay(skops))
+			nr_sched += 1;
+		break;
+	case BPF_SOCK_OPS_TS_SW_OPT_CB:
+		if (bpf_test_delay(skops))
+			nr_txsw += 1;
+		break;
+	case BPF_SOCK_OPS_TS_ACK_OPT_CB:
+		if (bpf_test_delay(skops))
+			nr_ack += 1;
+		break;
+	}
+
+	return 1;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.37.3


