Return-Path: <bpf+bounces-43000-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7C59ADA13
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 04:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0852A2836FC
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 02:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE6415C120;
	Thu, 24 Oct 2024 02:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="tYjMZiAL"
X-Original-To: bpf@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CB714A0A3;
	Thu, 24 Oct 2024 02:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729737790; cv=none; b=bXkZSqUSGyYPJvQR3IzXHkAYfEcTA97PfMETrp7b2d9MEisHREkVUoOxvy4LRBMuSMzoBrGQjVvj1hklbZij+SN2goNir/2ahIe4viZ92gCl5zvDQA7vaBrcbLaKDIKCmqsso1gOJSYgRdQqJr7EFlEIeqGkLUVLrlYvaU167b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729737790; c=relaxed/simple;
	bh=DKBvk1xnRNRqGjV3giFfSk4wNFWQxVrfFgjMR0/OlHc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=RNQTD2s64LrNoYGBn4ywAMYQYHU3lwRcai+4lcTlIV5u3vjCbNtddnfSCxre2YLtpFtX9Ftw81i5dp072rQtSAl2b7rQoRiTrgQjl8XderGWbpNST2NcDdJCeMh07HECa/IgWXHBiBr0sOtYsZAUFUuzWMObGxNqZ5Dn8BfZGb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=tYjMZiAL; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729737777; h=From:To:Subject:Date:Message-Id;
	bh=IqrLxvN2Jt2jCdGGw9i8wBz+4UY2NuDbkYM8GGqWoPg=;
	b=tYjMZiALzTn2C6NQXMNdP3mx7NJ9Z0oy3Fgp2r+LcJpKI4JXcF8VVALzkgaJ8dnM4KSHrMX9/jUdHwKUr2YTv8bM8HBwFhL8fEPnpPMO2NiROrBqFUleGWZwoblELtxliqiJLFLsFdkxbuBW6lFTYljv/vmlRdKZaWec57oL0Xo=
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WHnU0Go_1729737775 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 24 Oct 2024 10:42:56 +0800
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
Subject: [PATCH net-next 3/4] net/smc: Introduce smc_bpf_ops
Date: Thu, 24 Oct 2024 10:42:47 +0800
Message-Id: <1729737768-124596-4-git-send-email-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1729737768-124596-1-git-send-email-alibuda@linux.alibaba.com>
References: <1729737768-124596-1-git-send-email-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

From: "D. Wythe" <alibuda@linux.alibaba.com>

The introduction of IPPROTO_SMC enables eBPF programs to determine
whether to use SMC based on the context of socket creation, such as
network namespaces, PID and comm name, etc.

As a subsequent enhancement, this patch introduces a new hook for eBPF
programs that allows decisions on whether to use SMC or not at runtime,
including but not limited to local/remote IP address or ports. In
simpler words, this feature allows modifications to syn_smc through eBPF
programs before the TCP three-way handshake got established.

Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
---
 include/linux/tcp.h   |   2 +-
 include/net/smc.h     |  47 +++++++++++
 include/net/tcp.h     |   6 ++
 net/ipv4/tcp_input.c  |   3 +-
 net/ipv4/tcp_output.c |  14 +++-
 net/smc/Kconfig       |  12 +++
 net/smc/Makefile      |   1 +
 net/smc/af_smc.c      |  38 ++++++---
 net/smc/smc.h         |   4 +
 net/smc/smc_bpf.c     | 212 ++++++++++++++++++++++++++++++++++++++++++++++++++
 net/smc/smc_bpf.h     |  34 ++++++++
 11 files changed, 357 insertions(+), 16 deletions(-)
 create mode 100644 net/smc/smc_bpf.c
 create mode 100644 net/smc/smc_bpf.h

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 6a5e08b..4ef160a 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -478,7 +478,7 @@ struct tcp_sock {
 #endif
 #if IS_ENABLED(CONFIG_SMC)
 	bool	syn_smc;	/* SYN includes SMC */
-	bool	(*smc_hs_congested)(const struct sock *sk);
+	struct tcpsmc_ctx *smc;
 #endif
 
 #if defined(CONFIG_TCP_MD5SIG) || defined(CONFIG_TCP_AO)
diff --git a/include/net/smc.h b/include/net/smc.h
index db84e4e..34ab2c6 100644
--- a/include/net/smc.h
+++ b/include/net/smc.h
@@ -18,6 +18,8 @@
 #include "linux/ism.h"
 
 struct sock;
+struct tcp_sock;
+struct inet_request_sock;
 
 #define SMC_MAX_PNETID_LEN	16	/* Max. length of PNET id */
 
@@ -97,4 +99,49 @@ struct smcd_dev {
 	u8 going_away : 1;
 };
 
+/*
+ * This structure is used to store the parameters passed to the member of struct_ops.
+ * Due to the BPF verifier cannot restrict the writing of bit fields, such as limiting
+ * it to only write ireq->smc_ok. Using kfunc can solve this issue, but we don't want
+ * to introduce a kfunc with such a narrow function.
+ *
+ * Moreover, using this structure for unified parameters also addresses another
+ * potential issue. Currently, kfunc cannot recognize the calling context
+ * through BPF's existing structure. In the future, we can solve this problem
+ * by passing this ctx to kfunc.
+ */
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
+	/* priavte */
+
+	struct list_head	list;
+
+	/* public */
+
+	/* Invoked before computing SMC option for SYN packets.
+	 * We can control whether to set SMC options by modifying
+	 * ctx->set_option->tp->syn_smc.
+	 * This's also the only member that can be modified now.
+	 * Only member in ctx->set_option is valid for this callback.
+	 */
+	void (*set_option)(struct smc_bpf_ops_ctx *ctx);
+
+	/* Invoked before Set up SMC options for SYN-ACK packets
+	 * We can control whether to respond SMC options by modifying
+	 * ctx->set_option_cond.smc_ok.
+	 * Only member in ctx->set_option_cond is valid for this callback.
+	 */
+	void (*set_option_cond)(struct smc_bpf_ops_ctx *ctx);
+};
+
 #endif	/* _SMC_H */
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 739a9fb..c322443 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2730,6 +2730,12 @@ static inline void tcp_bpf_rtt(struct sock *sk, long mrtt, u32 srtt)
 
 #if IS_ENABLED(CONFIG_SMC)
 extern struct static_key_false tcp_have_smc;
+struct tcpsmc_ctx {
+	/* Invoked before computing SMC option for SYN packets. */
+	void (*set_option)(struct tcp_sock *tp);
+	/* Invoked before Set up SMC options for SYN-ACK packets */
+	void (*set_option_cond)(const struct tcp_sock *tp, struct inet_request_sock *ireq);
+};
 #endif
 
 #if IS_ENABLED(CONFIG_TLS_DEVICE)
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 2d844e1..8ebd529 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -7070,8 +7070,7 @@ static void tcp_openreq_init(struct request_sock *req,
 	ireq->ir_num = ntohs(tcp_hdr(skb)->dest);
 	ireq->ir_mark = inet_request_mark(sk, skb);
 #if IS_ENABLED(CONFIG_SMC)
-	ireq->smc_ok = rx_opt->smc_ok && !(tcp_sk(sk)->smc_hs_congested &&
-			tcp_sk(sk)->smc_hs_congested(sk));
+	ireq->smc_ok = rx_opt->smc_ok;
 #endif
 }
 
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 054244ce..5ab47dd 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -759,14 +759,17 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
 	mptcp_options_write(th, ptr, tp, opts);
 }
 
-static void smc_set_option(const struct tcp_sock *tp,
+static void smc_set_option(struct tcp_sock *tp,
 			   struct tcp_out_options *opts,
 			   unsigned int *remaining)
 {
 #if IS_ENABLED(CONFIG_SMC)
 	if (static_branch_unlikely(&tcp_have_smc)) {
 		if (tp->syn_smc) {
-			if (*remaining >= TCPOLEN_EXP_SMC_BASE_ALIGNED) {
+			if (tp->smc && tp->smc->set_option)
+				tp->smc->set_option(tp);
+			/* set_option may modify syn_smc, so it needs to be checked again */
+			if (tp->syn_smc && *remaining >= TCPOLEN_EXP_SMC_BASE_ALIGNED) {
 				opts->options |= OPTION_SMC;
 				*remaining -= TCPOLEN_EXP_SMC_BASE_ALIGNED;
 			}
@@ -776,14 +779,17 @@ static void smc_set_option(const struct tcp_sock *tp,
 }
 
 static void smc_set_option_cond(const struct tcp_sock *tp,
-				const struct inet_request_sock *ireq,
+				struct inet_request_sock *ireq,
 				struct tcp_out_options *opts,
 				unsigned int *remaining)
 {
 #if IS_ENABLED(CONFIG_SMC)
 	if (static_branch_unlikely(&tcp_have_smc)) {
 		if (tp->syn_smc && ireq->smc_ok) {
-			if (*remaining >= TCPOLEN_EXP_SMC_BASE_ALIGNED) {
+			if (tp->smc && tp->smc->set_option_cond)
+				tp->smc->set_option_cond(tp, ireq);
+			/* set_option_cond may modify smc_ok, so it needs to be checked again */
+			if (ireq->smc_ok && *remaining >= TCPOLEN_EXP_SMC_BASE_ALIGNED) {
 				opts->options |= OPTION_SMC;
 				*remaining -= TCPOLEN_EXP_SMC_BASE_ALIGNED;
 			}
diff --git a/net/smc/Kconfig b/net/smc/Kconfig
index ba5e6a2..1eca835 100644
--- a/net/smc/Kconfig
+++ b/net/smc/Kconfig
@@ -33,3 +33,15 @@ config SMC_LO
 	  of architecture or hardware.
 
 	  if unsure, say N.
+
+config SMC_BPF
+	bool "eBPF support for SMC subsystem"
+	depends on SMC && BPF_SYSCALL
+	default n
+	help
+	  This option enables support for eBPF programs for SMC
+	  subsystem. eBPF programs offer much greater flexibility
+	  in modifying the behavior of the SMC protocol stack compared
+	  to a complete kernel-based approach.
+
+	  if unsure, say N.
diff --git a/net/smc/Makefile b/net/smc/Makefile
index 60f1c87..1c04906 100644
--- a/net/smc/Makefile
+++ b/net/smc/Makefile
@@ -7,3 +7,4 @@ smc-y += smc_cdc.o smc_tx.o smc_rx.o smc_close.o smc_ism.o smc_netlink.o smc_sta
 smc-y += smc_tracepoint.o smc_inet.o
 smc-$(CONFIG_SYSCTL) += smc_sysctl.o
 smc-$(CONFIG_SMC_LO) += smc_loopback.o
+smc-$(CONFIG_SMC_BPF) += smc_bpf.o
\ No newline at end of file
diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 0316217..316c8a1 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -55,6 +55,7 @@
 #include "smc_sysctl.h"
 #include "smc_loopback.h"
 #include "smc_inet.h"
+#include "smc_bpf.h"
 
 static DEFINE_MUTEX(smc_server_lgr_pending);	/* serialize link group
 						 * creation on server
@@ -156,19 +157,25 @@ static struct sock *smc_tcp_syn_recv_sock(const struct sock *sk,
 	return NULL;
 }
 
-static bool smc_hs_congested(const struct sock *sk)
+static void smc_set_tcp_option_cond(const struct tcp_sock *tp, struct inet_request_sock *ireq)
 {
 	const struct smc_sock *smc;
 
-	smc = smc_clcsock_user_data(sk);
+	smc = smc_clcsock_user_data(&tp->inet_conn.icsk_inet.sk);
 
 	if (!smc)
-		return true;
+		goto no_smc;
 
-	if (workqueue_congested(WORK_CPU_UNBOUND, smc_hs_wq))
-		return true;
+	if (smc->limit_smc_hs && workqueue_congested(WORK_CPU_UNBOUND, smc_hs_wq))
+		goto no_smc;
 
-	return false;
+#if IS_ENABLED(CONFIG_SMC_BPF)
+	bpf_smc_set_tcp_option_cond(tp, ireq);
+#endif /* CONFIG_SMC_BPF */
+
+	return;
+no_smc:
+	ireq->smc_ok = 0;
 }
 
 struct smc_hashinfo smc_v4_hashinfo = {
@@ -2650,9 +2657,6 @@ int smc_listen(struct socket *sock, int backlog)
 
 	inet_csk(smc->clcsock->sk)->icsk_af_ops = &smc->af_ops;
 
-	if (smc->limit_smc_hs)
-		tcp_sk(smc->clcsock->sk)->smc_hs_congested = smc_hs_congested;
-
 	rc = kernel_listen(smc->clcsock, backlog);
 	if (rc) {
 		write_lock_bh(&smc->clcsock->sk->sk_callback_lock);
@@ -3324,6 +3328,13 @@ int smc_create_clcsk(struct net *net, struct sock *sk, int family)
 	sk->sk_net_refcnt = 1;
 	get_net_track(net, &sk->ns_tracker, GFP_KERNEL);
 	sock_inuse_add(net, 1);
+
+	/* init tcp_smc_ctx */
+#if IS_ENABLED(CONFIG_SMC_BPF)
+	smc->tcp_smc_ctx.set_option = bpf_smc_set_tcp_option;
+#endif /* CONFIG_SMC_BPF */
+	smc->tcp_smc_ctx.set_option_cond = smc_set_tcp_option_cond;
+	tcp_sk(sk)->smc = &smc->tcp_smc_ctx;
 	return 0;
 }
 
@@ -3574,8 +3585,17 @@ static int __init smc_init(void)
 		pr_err("%s: smc_inet_init fails with %d\n", __func__, rc);
 		goto out_ulp;
 	}
+
+	rc = smc_bpf_struct_ops_init();
+	if (rc) {
+		pr_err("%s: smc_bpf_struct_ops_init fails with %d\n", __func__, rc);
+		goto out_inet;
+	}
+
 	static_branch_enable(&tcp_have_smc);
 	return 0;
+out_inet:
+	smc_inet_exit();
 out_ulp:
 	tcp_unregister_ulp(&smc_ulp_ops);
 out_lo:
diff --git a/net/smc/smc.h b/net/smc/smc.h
index 78ae10d..a9794fb 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -16,6 +16,7 @@
 #include <linux/compiler.h> /* __aligned */
 #include <net/genetlink.h>
 #include <net/sock.h>
+#include <net/tcp.h>
 
 #include "smc_ib.h"
 
@@ -328,6 +329,9 @@ struct smc_sock {				/* smc sock container */
 						/* protects clcsock of a listen
 						 * socket
 						 * */
+
+	/* smc context for tcp stack */
+	struct tcpsmc_ctx	tcp_smc_ctx;
 };
 
 #define smc_sk(ptr) container_of_const(ptr, struct smc_sock, sk)
diff --git a/net/smc/smc_bpf.c b/net/smc/smc_bpf.c
new file mode 100644
index 00000000..fa90406
--- /dev/null
+++ b/net/smc/smc_bpf.c
@@ -0,0 +1,212 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  Shared Memory Communications over RDMA (SMC-R) and RoCE
+ *
+ *  support for eBPF programs in SMC subsystem.
+ *
+ *  Copyright IBM Corp. 2016
+ *  Copyright (c) 2024, Alibaba Inc.
+ *
+ *  Author: D. Wythe <alibuda@linux.alibaba.com>
+ */
+
+#include <linux/bpf_verifier.h>
+#include <linux/spinlock.h>
+#include <linux/module.h>
+#include <linux/bpf.h>
+#include <linux/btf.h>
+#include <net/smc.h>
+
+#include "smc_bpf.h"
+
+static DEFINE_SPINLOCK(smc_bpf_ops_list_lock);
+static LIST_HEAD(smc_bpf_ops_list);
+
+static u32 tcp_sock_id, smc_bpf_ops_ctx_id;
+static const struct btf_type *smc_bpf_ops_type;
+static const struct btf *saved_btf;
+
+static int smc_bpf_ops_init(struct btf *btf)
+{
+	s32 type_id;
+
+	type_id = btf_find_by_name_kind(btf, "tcp_sock", BTF_KIND_STRUCT);
+	if (type_id < 0)
+		return -EINVAL;
+	tcp_sock_id = type_id;
+
+	type_id = btf_find_by_name_kind(btf, "smc_bpf_ops_ctx", BTF_KIND_STRUCT);
+	if (type_id < 0)
+		return -EINVAL;
+	smc_bpf_ops_ctx_id = type_id;
+
+	type_id = btf_find_by_name_kind(btf, "smc_bpf_ops", BTF_KIND_STRUCT);
+	if (type_id < 0)
+		return -EINVAL;
+	smc_bpf_ops_type = btf_type_by_id(btf, type_id);
+
+	saved_btf = btf;
+	return 0;
+}
+
+static int smc_bpf_ops_init_member(const struct btf_type *t,
+				   const struct btf_member *member,
+				   void *kdata, const void *udata)
+{
+	struct smc_bpf_ops *k_ops;
+	u32 moff;
+
+	k_ops = (struct smc_bpf_ops *)kdata;
+
+	moff = __btf_member_bit_offset(t, member) / 8;
+	switch (moff) {
+	case offsetof(struct smc_bpf_ops, list):
+		INIT_LIST_HEAD(&k_ops->list);
+		return 1;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int smc_bpf_ops_check_member(const struct btf_type *t,
+				    const struct btf_member *member,
+				    const struct bpf_prog *prog)
+{
+	u32 moff = __btf_member_bit_offset(t, member) / 8;
+
+	switch (moff) {
+	case offsetof(struct smc_bpf_ops, set_option):
+	case offsetof(struct smc_bpf_ops, set_option_cond):
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int smc_bpf_ops_reg(void *kdata, struct bpf_link *link)
+{
+	struct smc_bpf_ops *ops = kdata;
+
+	/* Prevent the same ops from being registered repeatedly. */
+	if (!list_empty(&ops->list))
+		return -EINVAL;
+
+	spin_lock(&smc_bpf_ops_list_lock);
+	list_add_tail_rcu(&ops->list, &smc_bpf_ops_list);
+	spin_unlock(&smc_bpf_ops_list_lock);
+
+	return 0;
+}
+
+static void smc_bpf_ops_unreg(void *kdata, struct bpf_link *link)
+{
+	struct smc_bpf_ops *ops = kdata;
+
+	spin_lock(&smc_bpf_ops_list_lock);
+	list_del_rcu(&ops->list);
+	spin_unlock(&smc_bpf_ops_list_lock);
+
+	/* Ensure that all readers to complete */
+	synchronize_rcu();
+}
+
+static void __bpf_smc_stub_set_tcp_option(struct smc_bpf_ops_ctx *ops_ctx) {}
+static void __bpf_smc_stub_set_tcp_option_cond(struct smc_bpf_ops_ctx *ops_ctx) {}
+
+static struct smc_bpf_ops __bpf_smc_bpf_ops = {
+	.set_option = __bpf_smc_stub_set_tcp_option,
+	.set_option_cond = __bpf_smc_stub_set_tcp_option_cond,
+};
+
+static int smc_bpf_ops_btf_struct_access(struct bpf_verifier_log *log,
+					 const struct bpf_reg_state *reg,
+					 const struct bpf_prog *prog,
+					 int off, int size)
+{
+	const struct btf_member *member;
+	const char *mname;
+	int member_idx;
+
+	member_idx = prog->expected_attach_type;
+	if (member_idx >= btf_type_vlen(smc_bpf_ops_type))
+		goto out_err;
+
+	member = &btf_type_member(smc_bpf_ops_type)[member_idx];
+	mname = btf_str_by_offset(saved_btf, member->name_off);
+
+	if (!strcmp(mname, "set_option")) {
+		/* only support to modify tcp_sock->syn_smc */
+		if (reg->btf_id == tcp_sock_id &&
+		    off == offsetof(struct tcp_sock, syn_smc) &&
+		    off + size == offsetofend(struct tcp_sock, syn_smc))
+			return 0;
+	} else if (!strcmp(mname, "set_option_cond")) {
+		/* only support to modify smc_bpf_ops_ctx->smc_ok */
+		if (reg->btf_id == smc_bpf_ops_ctx_id &&
+		    off == offsetof(struct smc_bpf_ops_ctx, set_option_cond.smc_ok) &&
+		    off + size == offsetofend(struct smc_bpf_ops_ctx, set_option_cond.smc_ok))
+			return 0;
+	}
+
+out_err:
+	return -EACCES;
+}
+
+static const struct bpf_verifier_ops smc_bpf_verifier_ops = {
+	.get_func_proto = bpf_base_func_proto,
+	.is_valid_access = bpf_tracing_btf_ctx_access,
+	.btf_struct_access = smc_bpf_ops_btf_struct_access,
+};
+
+static struct bpf_struct_ops bpf_smc_bpf_ops = {
+	.init = smc_bpf_ops_init,
+	.name = "smc_bpf_ops",
+	.reg = smc_bpf_ops_reg,
+	.unreg = smc_bpf_ops_unreg,
+	.cfi_stubs = &__bpf_smc_bpf_ops,
+	.verifier_ops = &smc_bpf_verifier_ops,
+	.init_member = smc_bpf_ops_init_member,
+	.check_member = smc_bpf_ops_check_member,
+	.owner = THIS_MODULE,
+};
+
+int smc_bpf_struct_ops_init(void)
+{
+	return register_bpf_struct_ops(&bpf_smc_bpf_ops, smc_bpf_ops);
+}
+
+void bpf_smc_set_tcp_option(struct tcp_sock *tp)
+{
+	struct smc_bpf_ops_ctx ops_ctx = {};
+	struct smc_bpf_ops *ops;
+
+	ops_ctx.set_option.tp = tp;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(ops, &smc_bpf_ops_list, list) {
+		ops->set_option(&ops_ctx);
+	}
+	rcu_read_unlock();
+}
+
+void bpf_smc_set_tcp_option_cond(const struct tcp_sock *tp, struct inet_request_sock *ireq)
+{
+	struct smc_bpf_ops_ctx ops_ctx = {};
+	struct smc_bpf_ops *ops;
+
+	ops_ctx.set_option_cond.tp = tp;
+	ops_ctx.set_option_cond.ireq = ireq;
+	ops_ctx.set_option_cond.smc_ok = ireq->smc_ok;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(ops, &smc_bpf_ops_list, list) {
+		ops->set_option_cond(&ops_ctx);
+	}
+	rcu_read_unlock();
+
+	ireq->smc_ok = ops_ctx.set_option_cond.smc_ok;
+}
diff --git a/net/smc/smc_bpf.h b/net/smc/smc_bpf.h
new file mode 100644
index 00000000..a5ed0fc
--- /dev/null
+++ b/net/smc/smc_bpf.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *  Shared Memory Communications over RDMA (SMC-R) and RoCE
+ *
+ *  support for eBPF programs in SMC subsystem.
+ *
+ *  Copyright IBM Corp. 2016
+ *  Copyright (c) 2024, Alibaba Inc.
+ *
+ *  Author: D. Wythe <alibuda@linux.alibaba.com>
+ */
+#ifndef __SMC_BPF
+#define __SMC_BPF
+
+#include <linux/types.h>
+#include <net/sock.h>
+#include <net/tcp.h>
+
+#if IS_ENABLED(CONFIG_SMC_BPF)
+
+/* Initialize struct_ops registration. It will automatically unload
+ * when module is unloaded.
+ * @return 0 on success
+ */
+int smc_bpf_struct_ops_init(void);
+
+void bpf_smc_set_tcp_option(struct tcp_sock *sk);
+void bpf_smc_set_tcp_option_cond(const struct tcp_sock *tp, struct inet_request_sock *ireq);
+
+#else
+static inline int smc_bpf_struct_ops_init(void) { return 0; }
+#endif /* CONFIG_SMC_BPF */
+
+#endif /* __SMC_BPF */
-- 
1.8.3.1


