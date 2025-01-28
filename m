Return-Path: <bpf+bounces-49944-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C51A20688
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 09:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B08431885FBD
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 08:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B021DEFEE;
	Tue, 28 Jan 2025 08:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WlKLIwIh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01951DED67;
	Tue, 28 Jan 2025 08:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738054068; cv=none; b=BL+eQNyrmT7nM4OkgM1cglG786u16lx7STIVxWvaWRFvP13JFNh7ThP5HVWrAWtk4GS+0jCVCFLlkd30wfslxd9pwhHvdmQ8wwHXKeVDA8cY31lPGTnODMnrgikXhQQZJmn2Qn8la3W8y12jBcA2a6Tbn4gJ07+fqBuStMIZSAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738054068; c=relaxed/simple;
	bh=HSsKDqfsjp5fopc3ikPD6v9u+CpaF3o6GtowEZi30Uc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q/VVCYPwK8d/wEi5xej5K4r6O+M51rGGnXW7ChWdaaFB6zOS8ZdH9O/SPzq5k/W6xHYNMW0PbJHDB5a1/4OOWbvE7oEVbqp5tR6WWZwlzgGYv3xsBjZu5/nrbxU4puiej6OqVbwXD45BwEMxA1sBNPPXtDCSlQtlD5IhInMLTds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WlKLIwIh; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-216401de828so97142495ad.3;
        Tue, 28 Jan 2025 00:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738054066; x=1738658866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gbXhFqWfxeW6KXHCx6cQeU+eZI9I0iF185XwKjE3BUM=;
        b=WlKLIwIhCliqybl//M2OjL5EmWK/kWy6YnUhHTY91KKtWWCq01Slwv2MMZQk2nXySC
         triNCcGQd/e0/jk02UF0gkVZBFVSBXVn5XlWodAgthqyA/WlmqLKLtidnghEOxE/2PCv
         fz2s73JGu0xN5aXX7h6aKgCTVYxBhZj32OUXGV9v+Mo4Dk1zxXobsS8iOx+Cgvf/vCeC
         wIE4NXDTygclLXT+TdQVR4TX761cTGCc+USswpTinNBlDf79W0sYtUJrzcHNLg/qkeDV
         DQXUucn7ZMoRPx5a7beWKqOYgsX6WM5tBqiz+Qj1FhM5vZ32ItsfWSNjib7uS8q41Ge4
         Aa4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738054066; x=1738658866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gbXhFqWfxeW6KXHCx6cQeU+eZI9I0iF185XwKjE3BUM=;
        b=uQpbzd20GMi3csihxNJmT4UOzFx5HZcDxIdlrk9cH1KDWXzfsjn4RSnRh6AVOY5wLc
         WOTETSdxV3+k95VavPmlRB5VX782eW27NbleN3oXeLCgmEirVbat6vadLQEStyo4vfUS
         8NPZ+1jrsh6Z6FPdEo0fvsqWlbxXlbpO9VEYJFOPCCSlluMZ5PPsqpV8IhYGD9ZPkDtr
         8uqX5unOgyz5A3ZbLeDFvG+ln8tJve4pPKqSvbxXo14F080tAMFiv/FC0q4OSr1NK6o/
         f9fv6i8mNvW9HJobZAXpAmCfN6i+cCN0JlKeOH9dwb3P0R7JJv0g5HOUoW2EpRgIW9ci
         NbOA==
X-Forwarded-Encrypted: i=1; AJvYcCXhJeRcVhnZgHo9KXkDUlFKnwN7zGhJFJGAG1/H2Ci7JqpXECC4IotWXH/nKekTHW/k1fL0bJY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIvrVQitSA3n+xhzMVBrD1WPWH94HkxrHxEqunXmriwiqLzIfC
	c5SNrBWyOllq65Q3QPBpbm3gahYKmx0JcxEQTsbInRR+0gmapmZ3
X-Gm-Gg: ASbGnctf4sAkEiSY+g1Go53zXsmQ9pJP9nxa3rUgkg9E9VBqWVpZ7wx0DsvHJuID0sA
	5exQeE2dzu/WRSaKjy3sDC/STKRrjQXbO3Lx+10MR/bF9C+4rUfMcE3C9DFmRTP3W5cA5za2dip
	qwekEnnn7jHYM4WoICLK10gmaQEpCuAN0HRxErgf6ignG3rJg8oXgaO4imATJGWBSUknJrIJ15J
	MdaYncsswnxP+woksup/HovA3L+EGbCWrhtp6JfvB4/ofuagmIN8oKOnXac4cDDlqY3NzZm1x2u
	nLkEoMaNnlOEtM4MACuM7lIC9nhl9YM4RNd3vvchV1ROm4Ge0m3tCd2Vc4i7n/Pl
X-Google-Smtp-Source: AGHT+IFYAf/5X0dP5hKm17V+bZbPN1OiCMGd8qqMzz+iQbVbiNy7gVThbh6KIQjfd0zaoHY5YTfbUQ==
X-Received: by 2002:a17:902:c94d:b0:216:55a1:369 with SMTP id d9443c01a7336-21c3540179amr628897295ad.18.1738054065737;
        Tue, 28 Jan 2025 00:47:45 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.25.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da414e2b8sm75873275ad.205.2025.01.28.00.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 00:47:45 -0800 (PST)
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
	horms@kernel.org
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH bpf-next v7 13/13] bpf: add simple bpf tests in the tx path for so_timestamping feature
Date: Tue, 28 Jan 2025 16:46:20 +0800
Message-Id: <20250128084620.57547-14-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250128084620.57547-1-kerneljasonxing@gmail.com>
References: <20250128084620.57547-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Only check if we pass those three key points after we enable the
bpf extension for so_timestamping. During each point, we can choose
whether to print the current timestamp.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 .../bpf/prog_tests/so_timestamping.c          |  86 +++++
 .../selftests/bpf/progs/so_timestamping.c     | 299 ++++++++++++++++++
 2 files changed, 385 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/so_timestamping.c
 create mode 100644 tools/testing/selftests/bpf/progs/so_timestamping.c

diff --git a/tools/testing/selftests/bpf/prog_tests/so_timestamping.c b/tools/testing/selftests/bpf/prog_tests/so_timestamping.c
new file mode 100644
index 000000000000..ee7fdc381609
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/so_timestamping.c
@@ -0,0 +1,86 @@
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
+	if (!ASSERT_OK_FD(sfd, "start_server"))
+		goto out;
+
+	cfd = connect_to_fd(sfd, 0);
+	if (!ASSERT_OK_FD(cfd, "connect_to_fd_server"))
+		goto out;
+
+	n = write(cfd, buf, sizeof(buf));
+	if (!ASSERT_EQ(n, sizeof(buf), "send to server"))
+		goto out;
+
+	ASSERT_EQ(bss->nr_active, 1, "nr_active");
+	ASSERT_EQ(bss->nr_snd, 2, "nr_snd");
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
+	struct netns_obj *ns;
+
+	cg_fd = test__join_cgroup(CG_NAME);
+	if (cg_fd < 0)
+		return;
+
+	ns = netns_new("so_timestamping_ns", true);
+	if (!ASSERT_OK_PTR(ns, "create ns"))
+		return;
+
+	skel = so_timestamping__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open and load skel"))
+		goto done;
+
+	if (!ASSERT_OK(so_timestamping__attach(skel), "attach skel"))
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
+	netns_free(ns);
+	close(cg_fd);
+}
diff --git a/tools/testing/selftests/bpf/progs/so_timestamping.c b/tools/testing/selftests/bpf/progs/so_timestamping.c
new file mode 100644
index 000000000000..a893859ffe32
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/so_timestamping.c
@@ -0,0 +1,299 @@
+#include "vmlinux.h"
+#include "bpf_tracing_net.h"
+#include <bpf/bpf_core_read.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+#include "bpf_kfuncs.h"
+#define BPF_PROG_TEST_TCP_HDR_OPTIONS
+#include "test_tcp_hdr_options.h"
+#include <errno.h>
+
+#define SK_BPF_CB_FLAGS 1009
+#define SK_BPF_CB_TX_TIMESTAMPING 1
+
+int nr_active;
+int nr_snd;
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
+	const struct sock *sk;
+};
+
+struct sk_stg {
+	__u64 sendmsg_ns;	/* record ts when sendmsg is called */
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_SK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, struct sk_stg);
+} sk_stg_map SEC(".maps");
+
+
+struct delay_info {
+	u64 sendmsg_ns;		/* record ts when sendmsg is called */
+	u32 sched_delay;	/* SCHED_OPT_CB - sendmsg_ns */
+	u32 sw_snd_delay;	/* SW_OPT_CB - SCHED_OPT_CB */
+	u32 ack_delay;		/* ACK_OPT_CB - SW_OPT_CB */
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__type(key, u32);
+	__type(value, struct delay_info);
+	__uint(max_entries, 1024);
+} time_map SEC(".maps");
+
+static u64 delay_tolerance_nsec = 10000000000; /* 10 second as an example */
+
+static int bpf_test_sockopt_int(void *ctx, const struct sock *sk,
+				const struct sockopt_test *t,
+				int level)
+{
+	int new, opt, tmp;
+
+	opt = t->opt;
+	new = t->new;
+
+	if (bpf_setsockopt(ctx, level, opt, &new, sizeof(new)))
+		return 1;
+
+	if (bpf_getsockopt(ctx, level, opt, &tmp, sizeof(tmp)) ||
+	    tmp != new)
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
+static int bpf_test_sockopt(void *ctx, const struct sock *sk)
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
+static bool bpf_test_access_sockopt(void *ctx)
+{
+	const struct sockopt_test *t;
+	int tmp, ret, i = 0;
+	int level = SOL_SOCKET;
+
+	t = &sol_socket_tests[i];
+
+	for (; t->opt;) {
+		ret = bpf_setsockopt(ctx, level, t->opt, (void *)&t->new, sizeof(t->new));
+		if (ret != -EOPNOTSUPP)
+			return true;
+
+		ret = bpf_getsockopt(ctx, level, t->opt, &tmp, sizeof(tmp));
+		if (ret != -EOPNOTSUPP)
+			return true;
+
+		if (++i >= ARRAY_SIZE(sol_socket_tests))
+			break;
+	}
+
+	return false;
+}
+
+/* Adding a simple test to see if we can get an expected value */
+static bool bpf_test_access_load_hdr_opt(struct bpf_sock_ops *skops)
+{
+	struct tcp_opt reg_opt;
+	int load_flags = 0;
+	int ret;
+
+	reg_opt.kind = TCPOPT_EXP;
+	reg_opt.len = 0;
+	reg_opt.data32 = 0;
+	ret = bpf_load_hdr_opt(skops, &reg_opt, sizeof(reg_opt), load_flags);
+	if (ret != -EOPNOTSUPP)
+		return true;
+
+	return false;
+}
+
+/* Adding a simple test to see if we can get an expected value */
+static bool bpf_test_access_cb_flags_set(struct bpf_sock_ops *skops)
+{
+	int ret;
+
+	ret = bpf_sock_ops_cb_flags_set(skops, 0);
+	if (ret != -EOPNOTSUPP)
+		return true;
+
+	return false;
+}
+
+/* In the timestamping callbacks, we're not allowed to call the following
+ * BPF CALLs for the safety concern. Return false if expected.
+ */
+static int bpf_test_access_bpf_calls(struct bpf_sock_ops *skops,
+				     const struct sock *sk)
+{
+	if (bpf_test_access_sockopt(skops))
+		return true;
+
+	if (bpf_test_access_load_hdr_opt(skops))
+		return true;
+
+	if (bpf_test_access_cb_flags_set(skops))
+		return true;
+
+	return false;
+}
+
+static bool bpf_test_delay(struct bpf_sock_ops *skops, const struct sock *sk)
+{
+	struct bpf_sock_ops_kern *skops_kern;
+	u64 timestamp = bpf_ktime_get_ns();
+	struct skb_shared_info *shinfo;
+	struct delay_info dinfo = {0};
+	struct delay_info *val;
+	struct sk_buff *skb;
+	struct sk_stg *stg;
+	u64 prior_ts, delay;
+	u32 tskey;
+
+	if (bpf_test_access_bpf_calls(skops, sk))
+		return false;
+
+	skops_kern = bpf_cast_to_kern_ctx(skops);
+	skb = skops_kern->skb;
+	shinfo = bpf_core_cast(skb->head + skb->end, struct skb_shared_info);
+	tskey = shinfo->tskey;
+	if (!tskey)
+		return false;
+
+	if (skops->op == BPF_SOCK_OPS_TS_SND_CB) {
+		stg = bpf_sk_storage_get(&sk_stg_map, (void *)sk, 0, 0);
+		if (!stg)
+			return false;
+		dinfo.sendmsg_ns = stg->sendmsg_ns;
+		bpf_map_update_elem(&time_map, &tskey, &dinfo, BPF_ANY);
+		goto out;
+	}
+
+	val = bpf_map_lookup_elem(&time_map, &tskey);
+	if (!val)
+		return false;
+
+	switch (skops->op) {
+	case BPF_SOCK_OPS_TS_SCHED_OPT_CB:
+		delay = val->sched_delay = timestamp - val->sendmsg_ns;
+		break;
+	case BPF_SOCK_OPS_TS_SW_OPT_CB:
+		prior_ts = val->sched_delay + val->sendmsg_ns;
+		delay = val->sw_snd_delay = timestamp - prior_ts;
+		break;
+	case BPF_SOCK_OPS_TS_ACK_OPT_CB:
+		prior_ts = val->sw_snd_delay + val->sched_delay + val->sendmsg_ns;
+		delay = val->ack_delay = timestamp - prior_ts;
+		break;
+	}
+
+	if (delay >= delay_tolerance_nsec)
+		return false;
+
+	/* Since it's the last one, remove from the map after latency check */
+	if (skops->op == BPF_SOCK_OPS_TS_ACK_OPT_CB)
+		bpf_map_delete_elem(&time_map, &tskey);
+
+out:
+	return true;
+}
+
+SEC("fentry/tcp_sendmsg_locked")
+int BPF_PROG(trace_tcp_sendmsg_locked, struct sock *sk, struct msghdr *msg, size_t size)
+{
+	u64 timestamp = bpf_ktime_get_ns();
+	u32 flag = sk->sk_bpf_cb_flags;
+	struct sk_stg *stg;
+
+	if (!flag)
+		return 0;
+
+	stg = bpf_sk_storage_get(&sk_stg_map, sk, 0,
+				 BPF_SK_STORAGE_GET_F_CREATE);
+	if (!stg)
+		return 0;
+
+	stg->sendmsg_ns = timestamp;
+	nr_snd += 1;
+	return 0;
+}
+
+SEC("sockops")
+int skops_sockopt(struct bpf_sock_ops *skops)
+{
+	struct bpf_sock *bpf_sk = skops->sk;
+	const struct sock *sk;
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
+	case BPF_SOCK_OPS_TS_SND_CB:
+		if (bpf_test_delay(skops, sk))
+			nr_snd += 1;
+		break;
+	case BPF_SOCK_OPS_TS_SCHED_OPT_CB:
+		if (bpf_test_delay(skops, sk))
+			nr_sched += 1;
+		break;
+	case BPF_SOCK_OPS_TS_SW_OPT_CB:
+		if (bpf_test_delay(skops, sk))
+			nr_txsw += 1;
+		break;
+	case BPF_SOCK_OPS_TS_ACK_OPT_CB:
+		if (bpf_test_delay(skops, sk))
+			nr_ack += 1;
+		break;
+	}
+
+	return 1;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.43.5


