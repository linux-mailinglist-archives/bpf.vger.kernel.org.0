Return-Path: <bpf+bounces-50865-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC53AA2D594
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 11:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 752A07A5075
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 10:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638331BCA19;
	Sat,  8 Feb 2025 10:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecc0Qo8a"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310E37DA8C;
	Sat,  8 Feb 2025 10:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739010813; cv=none; b=qO91JiUk3B4tUnZ+SYMLJkcMGeiJBjeMZkU5Yhuqmqetvmtk8v3dkTfOgBFaCEqQl5z39yISq3Vab18RMKuSLBDP4rHqo9hOYdmwOo85ukDFGdPln+Fct1nfuPtG5MktREtKLlaQUGmGMLueZCJCoAz4JN34QeJgP/Jmbsg0da0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739010813; c=relaxed/simple;
	bh=dlSRdpt2ITUSt5diLpEoyrE1DpZZ8Oi8bS8bS6JqHC0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g3dSLtA0mHCPra289vdyB+O1rocfK86x8iN/aeJDGv9pStPk4Bi571kgAVr8GjL7uIB9V53Yguk4jaaurrLPl2JcB/R1xq627MaSdOirPr+EPZMFGmmzyZ0mJVH5KVzu6in6V/usXcTx0CFhmYkKjYP92C/Hl5EQK4S8GQVD7Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ecc0Qo8a; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21f6a47d617so6908825ad.2;
        Sat, 08 Feb 2025 02:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739010811; x=1739615611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=trnKcvL/7ZWLD7eydlcY8QHFZw3zVQLPacf8LkGaFu8=;
        b=ecc0Qo8agJZlh2t3WSY+lT5HeOAZ1moQsdbZJbu9PEBYFAPAz5UVZZNE1BAhXlqbSD
         YfAfiUW0z7yaFtHajO5fLmeQfy3/ZJNbgZ9E22Erc3IsUfAwY4UPkZhrt0H2MMvq6Jif
         QF0H6MZQ45MYEhcu5qdvbyNm4mXw8HeJQKp9lceeJ6L/RefrvnMPRr825NhiynZTmDrc
         XDFRxT4TtPuAuBu03IHhEZD1sHwZ4gEc0hEc++nsus2f23pu28yxg+SyzE+hQN0CIKCk
         C6ig+6Q7wKtDr2AiSuw51MfsDdDsmTLsvtrNQeaC637PsUgUWF6DdZwvcChHjozwCs3t
         krOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739010811; x=1739615611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=trnKcvL/7ZWLD7eydlcY8QHFZw3zVQLPacf8LkGaFu8=;
        b=I3M3Dn5GV0cMSr/CMgXMDUkRgdL+IKNZbaZQOobID1S8a3BryCQIVKIM3P/4wwp/0d
         IQW20N/NuVb3g8vbQO4dqWX0uDfhDH9RppOz6ZJCtr8+BV+VK068zE0g5Yjd5DqqOrWj
         zss5RcD9mzosO7/8845yn/gKAeJ1Qvmxso8YLgbR0NbDXUXlode4rB2gcdF0zm64kg8n
         bJSSlsYB40L1pHSOUc2/LjRF3lI2oplwL+PATuPDV8RKWNyXEAsbtdRBLEXY1zXYH9QB
         7TQUVNFyGnUCwvITNPwQc3WEjsqUo+O1Fd6Xj07Wt22GZdLmPDhtjgUuPofRIgc66ptA
         ahGg==
X-Forwarded-Encrypted: i=1; AJvYcCVD6WC6eF+IA+nOD3RpiBbtRkXDG32XV0f3mWOu5YbLYDGDhmi/ZKVFtHkNC2YAIAuztifYZkc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpP8Nhz6Vk5PDfuEHLboFRegXpE+UYQ0MU6vZUF/3VfuNERJEM
	FaeSLV3kMOwh17TmI/+dFCvDVqaMAr5Z3A5iITXzlRaQ8Z4MCpxs
X-Gm-Gg: ASbGncuRyFuNQwpWUhGE21fKdQt93r6BHD2wKg7rbvd44sWXENDd59XYnIci+sJ68aD
	Ne+PXD33pUE1d0/Rh4UtgrSOII+qqS0WhGG63wr27AuQ7l4vWnIyo8lKJrlUy8KM+ld6TdWFH7a
	ptG0hIGoWMI8n9vp30vlPCF/NjmqRr0HDDEb9i3l+Rex3NgI/BSFKzZ4Iz9cAF2IOWcOUMXpVR8
	yl6SE4711WixFALBjOhmmaUmTvO2kBIGIORfJLf/6X+c+710nm2oW0A0IAZVphNCZzHx0wnmvDX
	mxn0uxpVDYvcPkwrCaaTq1fEGmRBny2jm2MWLK6jHCn4W37780dNTg==
X-Google-Smtp-Source: AGHT+IEtkPAboRQ7FDT6VZmfM+tfR2H0lM2xM0ZY77w9cllZvXrLbM26Hcb8B4VW7agd5x8dCVkmnw==
X-Received: by 2002:a17:903:234e:b0:216:4883:fb43 with SMTP id d9443c01a7336-21f4e7594e5mr114626615ad.32.1739010811311;
        Sat, 08 Feb 2025 02:33:31 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.25.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3653af58sm44527835ad.70.2025.02.08.02.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2025 02:33:30 -0800 (PST)
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
Subject: [PATCH bpf-next v9 12/12] selftests/bpf: add simple bpf tests in the tx path for timestamping feature
Date: Sat,  8 Feb 2025 18:32:20 +0800
Message-Id: <20250208103220.72294-13-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250208103220.72294-1-kerneljasonxing@gmail.com>
References: <20250208103220.72294-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bpf prog calculates a couple of latency delta between each tx points
which SO_TIMESTAMPING feature has already implemented. It can be used
in the real world to diagnose the behaviour in the tx path.

Also, check the safety issues by accessing a few bpf calls in
bpf_test_access_bpf_calls().

There remains a few realistic things[1][2] to highlight:
1. in general a packet may pass through multiple qdiscs. For instance
with bonding or tunnel virtual devices in the egress path.
2. packets may be resent, in which case an ACK might precede a repeat
SCHED and SND.
3. erroneous or malicious peers may also just never send an ACK.

[1]: https://lore.kernel.org/all/67a389af981b0_14e0832949d@willemb.c.googlers.com.notmuch/
[2]: https://lore.kernel.org/all/c329a0c1-239b-4ca1-91f2-cb30b8dd2f6a@linux.dev/

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 .../bpf/prog_tests/so_timestamping.c          |  79 +++++
 .../selftests/bpf/progs/so_timestamping.c     | 312 ++++++++++++++++++
 2 files changed, 391 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/so_timestamping.c
 create mode 100644 tools/testing/selftests/bpf/progs/so_timestamping.c

diff --git a/tools/testing/selftests/bpf/prog_tests/so_timestamping.c b/tools/testing/selftests/bpf/prog_tests/so_timestamping.c
new file mode 100644
index 000000000000..1829f93bc52e
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/so_timestamping.c
@@ -0,0 +1,79 @@
+#include "test_progs.h"
+#include "network_helpers.h"
+
+#include "so_timestamping.skel.h"
+
+#define CG_NAME "/so-timestamping-test"
+
+static const char addr4_str[] = "127.0.0.1";
+static const char addr6_str[] = "::1";
+static struct so_timestamping *skel;
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
+	int cg_fd;
+
+	cg_fd = test__join_cgroup(CG_NAME);
+	if (!ASSERT_OK_FD(cg_fd, "join cgroup"))
+		return;
+
+	ns = netns_new("so_timestamping_ns", true);
+	if (!ASSERT_OK_PTR(ns, "create ns"))
+		goto done;
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
index 000000000000..4974552cdecb
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/so_timestamping.c
@@ -0,0 +1,312 @@
+#include "vmlinux.h"
+#include "bpf_tracing_net.h"
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
+struct sk_tskey {
+	u64 cookie;
+	u32 tskey;
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
+	__uint(type, BPF_MAP_TYPE_SK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, struct sk_stg);
+} sk_stg_map SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__type(key, struct sk_tskey);
+	__type(value, struct delay_info);
+	__uint(max_entries, 1024);
+} time_map SEC(".maps");
+
+static u64 delay_tolerance_nsec = 10000000000; /* 10 second as an example */
+
+extern int bpf_sock_ops_enable_tx_tstamp(struct bpf_sock_ops_kern *skops) __ksym;
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
+static bool bpf_test_access_bpf_calls(struct bpf_sock_ops *skops,
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
+	struct sk_tskey key = {0};
+	struct delay_info *val;
+	struct sk_buff *skb;
+	struct sk_stg *stg;
+	u64 prior_ts, delay;
+
+	if (bpf_test_access_bpf_calls(skops, sk))
+		return false;
+
+	skops_kern = bpf_cast_to_kern_ctx(skops);
+	skb = skops_kern->skb;
+	shinfo = bpf_core_cast(skb->head + skb->end, struct skb_shared_info);
+
+	key.cookie = bpf_get_socket_cookie(skops);
+	if (!key.cookie)
+		return false;
+
+	if (skops->op == BPF_SOCK_OPS_TS_SND_CB) {
+		stg = bpf_sk_storage_get(&sk_stg_map, (void *)sk, 0, 0);
+		if (!stg)
+			return false;
+		dinfo.sendmsg_ns = stg->sendmsg_ns;
+		bpf_sock_ops_enable_tx_tstamp(skops_kern);
+		key.tskey = shinfo->tskey;
+		if (!key.tskey)
+			return false;
+		bpf_map_update_elem(&time_map, &key, &dinfo, BPF_ANY);
+		return true;
+	}
+
+	key.tskey = shinfo->tskey;
+	if (!key.tskey)
+		return false;
+
+	val = bpf_map_lookup_elem(&time_map, &key);
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
+		bpf_map_delete_elem(&time_map, &key);
+
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


