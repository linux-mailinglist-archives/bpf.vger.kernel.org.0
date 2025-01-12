Return-Path: <bpf+bounces-48654-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F9DA0A8B4
	for <lists+bpf@lfdr.de>; Sun, 12 Jan 2025 12:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD09B1687B9
	for <lists+bpf@lfdr.de>; Sun, 12 Jan 2025 11:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1D91B412E;
	Sun, 12 Jan 2025 11:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZsTEQ0II"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79311ACECA;
	Sun, 12 Jan 2025 11:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736681963; cv=none; b=rBfbQf+ZJMiTEi9GH28oyUXelgrtwDdg+fP7PtNQLRPBNBM+yo9BaebkWJ+bLz67wBiZM2YwZjJ6/oVCxAkPnGEFz5g27rL+cgfr1CdeQ1LzVvlMRlKrN9qsfpbA49iLf8adu9jxK1B8+moufWq8B6w//UvwLOFxfgf0DZpfekw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736681963; c=relaxed/simple;
	bh=qie5cqASySC/U0j2QNp25OG67rs+j7Wa6PDaYEkj/F0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZXGbKucam8P/92H1y4BEWI1r0IMoZF5L8Xy8tn1MSTdhrLDzq7sLajIepiiGrRqML+szUBPCIhE4s0Wuj+gY5ytlTH5WOVgwfZQmY8T+Uyv5xsTmZuHdDXMRp1XCKid5Sa0acRJcWuQdxK2Af7t6jZx/uNf5E6jYXuWf8o+xxxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZsTEQ0II; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-216395e151bso41035435ad.0;
        Sun, 12 Jan 2025 03:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736681961; x=1737286761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G58t1Ur4vm0+cBMS/y3fsRI/xjMWJbv6YU/kfITP+O4=;
        b=ZsTEQ0IIM0GX6OBM6rhxfjyRJXJXU+qRE0xarS6PAMdlbwrQNePADtNCRrYOLeftAO
         y5GG/Rbi7we9JrouufJAyXAh/LkD7lAzd4PfNgzDWKtSDw/qN2fNMH94JpIbtMyD89Oe
         4spOePTu1CSNT/8rctHGOLNIJ50tSYxkVZeuR5fEwV7dWLEdocThG2hHOFAwrbxPuBsZ
         cWQCYJrpVabqeg84lN/TUTJMr/KgBVluRpPOtag2TVH0Lxomabua1Ooojo/W4dC1hZNO
         aRirdsOfyw5EgB8xAdPQT9H/VQ9LcqXpCdHGgB6IMMqeiYwkQQ+uILaogjDwkz1NV6e5
         IJMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736681961; x=1737286761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G58t1Ur4vm0+cBMS/y3fsRI/xjMWJbv6YU/kfITP+O4=;
        b=CEQsOuY6r2tCUol5OewS5eTwZoWroBCbK7ZAqr7rIqmWXhngLolQkZjBYg48OtfEPe
         HZTQjxxoICitOnq6j9sb5emUI4u7cnFXoM49dgG4XbB3wQzb3QdhyCfMkX9p6zE2GEPI
         qSlsI3pRXMEvTQBs3RRbn/yI3nOICB6v1VyxAlLzxZN10kLEx3waOzsY6pf0TdIxKq3F
         6EBwi/Bd/afO4ZPwbwqDv81XG+BUGORKnU2FZRz6XTmEmg3xeGFIy8Zg9mA/8GVzC9vy
         M4fd824Du7Z7k1GBTTJqEOf4FESrsAV0s1vi9kqkFgTIJBH7a00hDARtUrBWSHHQlf+M
         O02w==
X-Forwarded-Encrypted: i=1; AJvYcCXJ22wHEDZu/oH3IgIO2YXMfC97DXdUiH4ayCAc/yOAWoHDz41fLfhQpaJk0f1xlqVRPVcdjcs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRypKpnj2IOz6KYD2E2qONRdFDdMdDGWRBwnu/c9xZ3bagC8Uh
	xCOFjcBsCYj83LS5PZgejG1m/qQViCc1TmXrmmxEuePTZc2HAkMx
X-Gm-Gg: ASbGncvaIjAXsm83wZunsxuLySlY/hsyuL6h0nCFHGtisZqLYufpuCDrxRtnz3m4F74
	K7y9UoZFWMMw0VZrfX1aqVHYEXbaDAg33syRPd49pypduYKy5w0gzMN6pVKvgwzUsS1ZJeRX8L+
	l2/9uXlNJyLBlb9QaqerEwOVVmjaXt/H0f6kiS3Lj/3TWcT6uafmyqcv25Fd5Y+U4dgyTm6onzg
	DpNLCC2AWMz2sBOax84XgTWjEftcodzaRsHTS+JqDZo/wdSiOAH3v3Q8SG/wue5RJRvppNXtkI/
	KIcCpAo3BuSuE0mHn1g=
X-Google-Smtp-Source: AGHT+IFlpVkANH+aE4mzVMrILualvAgNHHQdAQk43kMBp4xgnTaZvWrW6v+zbtUUDUm5oKZq15avfw==
X-Received: by 2002:a17:903:1cd:b0:216:59f1:c7d9 with SMTP id d9443c01a7336-21ad9f95d63mr68263195ad.19.1736681961030;
        Sun, 12 Jan 2025 03:39:21 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.29.174])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f253a98sm37353765ad.224.2025.01.12.03.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2025 03:39:20 -0800 (PST)
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
Subject: [PATCH net-next v5 15/15] bpf: add simple bpf tests in the tx path for so_timestamping feature
Date: Sun, 12 Jan 2025 19:37:48 +0800
Message-Id: <20250112113748.73504-16-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250112113748.73504-1-kerneljasonxing@gmail.com>
References: <20250112113748.73504-1-kerneljasonxing@gmail.com>
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
 .../bpf/prog_tests/so_timestamping.c          |  95 +++++++++
 .../selftests/bpf/progs/so_timestamping.c     | 186 ++++++++++++++++++
 2 files changed, 281 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/so_timestamping.c
 create mode 100644 tools/testing/selftests/bpf/progs/so_timestamping.c

diff --git a/tools/testing/selftests/bpf/prog_tests/so_timestamping.c b/tools/testing/selftests/bpf/prog_tests/so_timestamping.c
new file mode 100644
index 000000000000..77c347701e50
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/so_timestamping.c
@@ -0,0 +1,95 @@
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
+	ASSERT_EQ(bss->nr_tcp, 1, "nr_tcp");
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
index 000000000000..db0582564fba
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/so_timestamping.c
@@ -0,0 +1,186 @@
+#include "vmlinux.h"
+#include "bpf_tracing_net.h"
+#include <bpf/bpf_core_read.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+//#include <bpf/bpf_core_read.h>
+#include "bpf_misc.h"
+#include "bpf_kfuncs.h"
+
+#define SK_BPF_CB_FLAGS 1009
+#define SK_BPF_CB_TX_TIMESTAMPING 1
+
+int nr_active;
+int nr_tcp;
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
+static u64 delay_tolerance_nsec = 1000000000; /* 1 second as an example */
+
+static int bpf_test_sockopt_int(void *ctx, const struct sock *sk,
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
+static bool bpf_test_delay(struct bpf_sock_ops *skops, const struct sock *sk)
+{
+	const struct tcp_sock *tp = tcp_sk(sk);
+	struct bpf_sock_ops_kern *skops_kern;
+	u64 timestamp = bpf_ktime_get_ns();
+	struct skb_shared_info *shinfo;
+	struct delay_info dinfo = {0};
+	struct delay_info *val;
+	struct sk_buff *skb;
+	u32 delay, tskey;
+	u64 prior_ts;
+
+	skops_kern = bpf_cast_to_kern_ctx(skops);
+	skb = skops_kern->skb;
+	if (skb) {
+		shinfo = bpf_core_cast(skb->head + skb->end, struct skb_shared_info);
+		tskey = shinfo->tskey_bpf;
+	} else if (skops->op == BPF_SOCK_OPS_TS_TCP_SND_CB) {
+		dinfo.sendmsg_ns = timestamp;
+		tskey = tp->write_seq;
+		val = &dinfo;
+		goto out;
+	} else {
+		return false;
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
+	if (delay <= 0 || delay >= delay_tolerance_nsec)
+		return false;
+
+	/* Since it's the last one, remove from the map after latency check */
+	if (skops->op == BPF_SOCK_OPS_TS_ACK_OPT_CB)
+		bpf_map_delete_elem(&time_map, &tskey);
+
+out:
+	bpf_map_update_elem(&time_map, &tskey, val, BPF_ANY);
+	return true;
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
+	case BPF_SOCK_OPS_TS_TCP_SND_CB:
+		if (bpf_test_delay(skops, sk))
+			nr_tcp += 1;
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


