Return-Path: <bpf+bounces-49327-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BC3A175C3
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 02:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDDE23A4829
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 01:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0A6149E0E;
	Tue, 21 Jan 2025 01:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ri9qlLLJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E497C3987D;
	Tue, 21 Jan 2025 01:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737423028; cv=none; b=SxTtK5St+fjLez/dxYQZkdcdOfzHoGzP8Gv6utdFQQfcwO3HbeWK8edEeQ1iNcyBxmKt0Ct6duwhtKAxIbg0unXNih37Jw7Qb27+ilJu4ghKvlCoLeyshH6+lenkLhuT8btN4GTFmoSEyBDAj4g0iPJL8tfQC236QI6gk/Rbji0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737423028; c=relaxed/simple;
	bh=1+Y13KFg6TudVkGfZMxPc913WZTlIJRmj13qG/6FzVI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iwVFtisvSTW4lYyZjj+bkOkndR/fzO+g71ora7RvhU+bfWLWqD0ZREkS2D9xguw04oRWhKW8IhmF1vCMrEShGuW6wiwwMvuKxNPSUYGOg7dRIa00flOg4HzD75V42rEK0Ezlsjp2guRv7oSyGxB5xP2Vsw6A2N0FfuvhQRZG5Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ri9qlLLJ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2166360285dso95429015ad.1;
        Mon, 20 Jan 2025 17:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737423026; x=1738027826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z04//87PXGsZ1MumqUfbZNDDq5PygrFIxndVNdxtz4I=;
        b=Ri9qlLLJxCQLZjsXI9rFgSPEF97ZvqQMCbrbqPm2IYiKVaRJRJ33yg3HrUdXYA9Wd4
         fHFfDUtnXpNIX1fPZXem+fmRP/2cpn59Y+Lpu9XHsz83ZsE/8gzRn2mjfJB6WbdNRW+f
         rp3XRhpKPWNfxv0fLGp7ZfY3YVNluupgAecf1cTU8SRnbC1MHRZa+WMeWxicBPId+TaS
         DAUARNfD4iR6qDLH0BRq9AfRH94/64xzEsbShHtFrE5Gq3yZHEIbwIlxz+SGoQDqTfJF
         SK+2byAi+iyQoTYshI0E8MI7EPdq+Aprr1j4VP3bhVcDuNEKEuQkHsdqLqzRSNFpmuxa
         zNsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737423026; x=1738027826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z04//87PXGsZ1MumqUfbZNDDq5PygrFIxndVNdxtz4I=;
        b=Zbpiz5NYOIT0imTdedQr7bWY6uNuRZGtoUqkHPyHAV+12630wtDQKZRQS8fA9BPa7F
         ItNMj/kJDi2UrAEbua3AV1fqz01nIT5eUW3cw8yAtIue8v+PGvyp7FnMX5/0tTRgp1tK
         Q1ZKCbSktbRWE5P2KowoJlfboSZuLCyelMP67KFjzUTffDq16VS91aUim9E2RR+OlYxi
         64ABvP6XTnVXC0aUICqXdfJqdaIvGM4ro7MilC+uiBnocmtLRjNzZaBc80b1o/CSrGIL
         ZxhLmjsHDQNlnUUQ47NrXW8XTSi80g7WeM8/37GiWboQ+nQXTHj0eHXZVA8wmIT+tfsC
         /BNw==
X-Forwarded-Encrypted: i=1; AJvYcCWALbj+ylcR8KrcX1H4UZxfnaaqqvlbNNFnmvT4q7QfbKtZb/pXbGmGbf7sKn36fHlVAUqi+wo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQnwimgokw76oArbEsAajjIJfLOETYJU5OckIEMKPrO8b9dYIl
	hHULgqr2IwFCK3VrpzurtsatOhakkZexTyZx/Fn8H7Xz/H2tCf1G
X-Gm-Gg: ASbGncs8QI1EwnVRJbb6Vs6i/wvdBh9Dd+W8gnX9PL0sKBXw9j8j9pgeT5zy4o1L1vL
	/6OdrvZ+90TJ2H2eLaJN/FBC8c4JVPNhrgd/3i21KdC0tz1bFbA12kHs4jHg1AYmqv+z9uBZuVx
	kAX9OBcJ6KowH0I0+J9TluGS50j2+3swnswUNTpAjk9t2NogTdbeIJN3i2L6nvqWh1ue14pa9xB
	cQB9amuDMon+8wS1jf3fRqZ2UGmwsQ2x2h70TS75C4fqQ3syMegcY0OpRskUew2w4tolUw0svF+
	fUT8WtOjSHPcUqs2+Uxljr5E8Bg89QOY
X-Google-Smtp-Source: AGHT+IE7SGTlrC+gCZxvKSAFW9KnjvZFGkMbmzeIIAlBYcICp51pI+QyURxQTa0MI/CrDKyJ4jO+1A==
X-Received: by 2002:a05:6a20:2450:b0:1e1:aef4:9ce8 with SMTP id adf61e73a8af0-1eb215902e2mr26722986637.28.1737423026181;
        Mon, 20 Jan 2025 17:30:26 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.29.174])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72daba55c13sm7702059b3a.129.2025.01.20.17.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 17:30:25 -0800 (PST)
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
Subject: [RFC PATCH net-next v6 13/13] bpf: add simple bpf tests in the tx path for so_timestamping feature
Date: Tue, 21 Jan 2025 09:29:01 +0800
Message-Id: <20250121012901.87763-14-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250121012901.87763-1-kerneljasonxing@gmail.com>
References: <20250121012901.87763-1-kerneljasonxing@gmail.com>
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
 .../bpf/prog_tests/so_timestamping.c          |  98 ++++++++
 .../selftests/bpf/progs/so_timestamping.c     | 227 ++++++++++++++++++
 2 files changed, 325 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/so_timestamping.c
 create mode 100644 tools/testing/selftests/bpf/progs/so_timestamping.c

diff --git a/tools/testing/selftests/bpf/prog_tests/so_timestamping.c b/tools/testing/selftests/bpf/prog_tests/so_timestamping.c
new file mode 100644
index 000000000000..bbfa7eb38cfb
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/so_timestamping.c
@@ -0,0 +1,98 @@
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
+	close(cg_fd);
+}
diff --git a/tools/testing/selftests/bpf/progs/so_timestamping.c b/tools/testing/selftests/bpf/progs/so_timestamping.c
new file mode 100644
index 000000000000..f4708e84c243
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/so_timestamping.c
@@ -0,0 +1,227 @@
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
+static u64 delay_tolerance_nsec = 1000000000; /* 1 second as an example */
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
+	    tmp != new) {
+		return 1;
+	}
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
+	struct bpf_sock_ops_kern *skops_kern;
+	u64 timestamp = bpf_ktime_get_ns();
+	struct skb_shared_info *shinfo;
+	struct delay_info dinfo = {0};
+	struct delay_info *val;
+	struct sk_buff *skb;
+	struct sk_stg *stg;
+	u32 delay, tskey;
+	u64 prior_ts;
+
+	skops_kern = bpf_cast_to_kern_ctx(skops);
+	skb = skops_kern->skb;
+	shinfo = bpf_core_cast(skb->head + skb->end, struct skb_shared_info);
+	tskey = shinfo->tskey;
+	if (!tskey)
+		return false;
+
+	if (skops->op == BPF_SOCK_OPS_TS_TCP_SND_CB) {
+		stg = bpf_sk_storage_get(&sk_stg_map, (void *)sk, 0, 0);
+		if (!stg)
+			return false;
+		dinfo.sendmsg_ns = stg->sendmsg_ns;
+		val = &dinfo;
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
+	if (delay <= 0 || delay >= delay_tolerance_nsec)
+		return false;
+
+	/* Since it's the last one, remove from the map after latency check */
+	if (skops->op == BPF_SOCK_OPS_TS_ACK_OPT_CB) {
+		bpf_map_delete_elem(&time_map, &tskey);
+		return true;
+	}
+
+out:
+	bpf_map_update_elem(&time_map, &tskey, val, BPF_ANY);
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
+	case BPF_SOCK_OPS_TS_TCP_SND_CB:
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


