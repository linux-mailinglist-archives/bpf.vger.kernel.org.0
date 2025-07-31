Return-Path: <bpf+bounces-64779-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7D1B16DD4
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 10:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B1A05843BC
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 08:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695D32BD5A7;
	Thu, 31 Jul 2025 08:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="pKCxRBrW"
X-Original-To: bpf@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BA329DB86;
	Thu, 31 Jul 2025 08:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753951383; cv=none; b=Qy0OjD6U8n2KCoctEBiuPkkkkn2FQuQfkOKBo/T8E3gZlR5r1GuliSnYhjX/ijWkcVFJJkuHQpmEDWvYJ9810a2RHUFfnneLrAwfGn3YXORlbXDvcCVnWh3xojwBChaLXNqmDFulP+hQ6EZi0IJHzKfIE+WwCyUfl+rZcVXkCEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753951383; c=relaxed/simple;
	bh=NHerNppnhC+t4desSGxW+zTR14//daCV58vcZkn7KdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g0q4SQVOwPVerDtOiBMAfadv4yBQh125R6IhIhzFS27oEaEXURftwVyFWGIppHF6b2xzEnIKzomp0LgaNBjpJgz0WeCRgdiTaFfvl7CxuwoHQLrmJUfy1idbyYUDpKCgf2/O4ZMVY+ubqQtYGJvMJUa206parucLAGEv45gq6Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=pKCxRBrW; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753951371; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=cHNEAR8H6hUEl3zVU2RSSk3lm+PzNXW7NYcdWPYYO3s=;
	b=pKCxRBrWfTf35zLX6dztyr5pVivA6cYVAkQtDlWhFVwpVNCC90Wt+byf2/e27dp/Sw3H/8CmnWLF5/Cp1BBhtn79iFQsIUCI2e2zzOti3sZMGJx3SDYlsDhvKumpQ9c+/tOfoDuZ2Y3jfdT8mjezc9XTiG0JPYPX1WYcennOR6s=
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WkXYUm8_1753951369 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 31 Jul 2025 16:42:49 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com>
To: ast@kernel.org,
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
	Mahanta.Jambigi@ibm.com,
	Sidraya.Jayagond@ibm.com,
	wenjia@linux.ibm.com,
	wintera@linux.ibm.com,
	dust.li@linux.alibaba.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com
Cc: bpf@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	jaka@linux.ibm.com
Subject: [PATCH bpf-next 3/5] net/smc: bpf: Introduce generic hook for handshake flow
Date: Thu, 31 Jul 2025 16:42:38 +0800
Message-ID: <20250731084240.86550-4-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250731084240.86550-1-alibuda@linux.alibaba.com>
References: <20250731084240.86550-1-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The introduction of IPPROTO_SMC enables eBPF programs to determine
whether to use SMC based on the context of socket creation, such as
network namespaces, PID and comm name, etc.

As a subsequent enhancement, to introduce a new generic hook that
allows decisions on whether to use SMC or not at runtime, including
but not limited to local/remote IP address or ports.

User can write their own implememtion via bpf_struct_ops now to choose
whether to use SMC or not before TCP 3rd handshake to be comleted.

Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
---
 include/net/netns/smc.h |   3 +
 include/net/smc.h       |  53 ++++++++++++++++
 net/ipv4/tcp_output.c   |  18 ++++--
 net/smc/Kconfig         |  12 ++++
 net/smc/Makefile        |   1 +
 net/smc/af_smc.c        |  11 ++++
 net/smc/smc_hs_bpf.c    | 131 ++++++++++++++++++++++++++++++++++++++++
 net/smc/smc_hs_bpf.h    |  31 ++++++++++
 net/smc/smc_sysctl.c    |  90 +++++++++++++++++++++++++++
 9 files changed, 346 insertions(+), 4 deletions(-)
 create mode 100644 net/smc/smc_hs_bpf.c
 create mode 100644 net/smc/smc_hs_bpf.h

diff --git a/include/net/netns/smc.h b/include/net/netns/smc.h
index fc752a50f91b..2af1a2f0035e 100644
--- a/include/net/netns/smc.h
+++ b/include/net/netns/smc.h
@@ -17,6 +17,9 @@ struct netns_smc {
 #ifdef CONFIG_SYSCTL
 	struct ctl_table_header		*smc_hdr;
 #endif
+#if IS_ENABLED(CONFIG_SMC_HS_CTRL_BPF)
+	struct smc_hs_ctrl __rcu		*hs_ctrl;
+#endif /* CONFIG_SMC_HS_CTRL_BPF */
 	unsigned int			sysctl_autocorking_size;
 	unsigned int			sysctl_smcr_buf_type;
 	int				sysctl_smcr_testlink_time;
diff --git a/include/net/smc.h b/include/net/smc.h
index db84e4e35080..c808d5df3006 100644
--- a/include/net/smc.h
+++ b/include/net/smc.h
@@ -18,6 +18,8 @@
 #include "linux/ism.h"
 
 struct sock;
+struct tcp_sock;
+struct inet_request_sock;
 
 #define SMC_MAX_PNETID_LEN	16	/* Max. length of PNET id */
 
@@ -97,4 +99,55 @@ struct smcd_dev {
 	u8 going_away : 1;
 };
 
+#define SMC_HS_CTRL_NAME_MAX 16
+
+enum {
+	/* ops can be inherit from init_net */
+	SMC_HS_CTRL_FLAG_INHERITABLE = 0x1,
+
+	SMC_HS_CTRL_ALL_FLAGS = SMC_HS_CTRL_FLAG_INHERITABLE,
+};
+
+struct smc_hs_ctrl {
+	/* private */
+
+	struct list_head list;
+	struct module *owner;
+
+	/* public */
+
+	/* unique name */
+	char name[SMC_HS_CTRL_NAME_MAX];
+	int flags;
+
+	/* Invoked before computing SMC option for SYN packets.
+	 * We can control whether to set SMC options by returning various value.
+	 * Return 0 to disable SMC, or return any other value to enable it.
+	 */
+	int (*syn_option)(struct tcp_sock *tp);
+
+	/* Invoked before Set up SMC options for SYN-ACK packets
+	 * We can control whether to respond SMC options by returning various
+	 * value. Return 0 to disable SMC, or return any other value to enable
+	 * it.
+	 */
+	int (*synack_option)(const struct tcp_sock *tp,
+			     struct inet_request_sock *ireq);
+};
+
+#if IS_ENABLED(CONFIG_SMC_HS_CTRL_BPF)
+#define smc_call_hsbpf(init_val, sk, func, ...) ({	\
+	typeof(init_val) __ret = (init_val);		\
+	struct smc_hs_ctrl *ctrl;			\
+	rcu_read_lock();				\
+	ctrl = READ_ONCE(sock_net(sk)->smc.hs_ctrl);	\
+	if (ctrl && ctrl->func)				\
+		__ret = ctrl->func(__VA_ARGS__);	\
+	rcu_read_unlock();				\
+	__ret;						\
+})
+#else
+#define smc_call_hsbpf(init_val, ...) (init_val)
+#endif /* CONFIG_SMC_HS_CTRL_BPF */
+
 #endif	/* _SMC_H */
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 3ac8d2d17e1f..d3c2bdc725df 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -40,6 +40,7 @@
 #include <net/tcp.h>
 #include <net/mptcp.h>
 #include <net/proto_memory.h>
+#include <net/smc.h>
 
 #include <linux/compiler.h>
 #include <linux/gfp.h>
@@ -764,14 +765,18 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
 	mptcp_options_write(th, ptr, tp, opts);
 }
 
-static void smc_set_option(const struct tcp_sock *tp,
+static void smc_set_option(struct tcp_sock *tp,
 			   struct tcp_out_options *opts,
 			   unsigned int *remaining)
 {
 #if IS_ENABLED(CONFIG_SMC)
+	struct sock *sk = &tp->inet_conn.icsk_inet.sk;
 	if (static_branch_unlikely(&tcp_have_smc)) {
 		if (tp->syn_smc) {
-			if (*remaining >= TCPOLEN_EXP_SMC_BASE_ALIGNED) {
+			tp->syn_smc = !!smc_call_hsbpf(1, sk, syn_option, tp);
+			/* re-check syn_smc */
+			if (tp->syn_smc &&
+			    *remaining >= TCPOLEN_EXP_SMC_BASE_ALIGNED) {
 				opts->options |= OPTION_SMC;
 				*remaining -= TCPOLEN_EXP_SMC_BASE_ALIGNED;
 			}
@@ -781,14 +786,19 @@ static void smc_set_option(const struct tcp_sock *tp,
 }
 
 static void smc_set_option_cond(const struct tcp_sock *tp,
-				const struct inet_request_sock *ireq,
+				struct inet_request_sock *ireq,
 				struct tcp_out_options *opts,
 				unsigned int *remaining)
 {
 #if IS_ENABLED(CONFIG_SMC)
+	const struct sock *sk = &tp->inet_conn.icsk_inet.sk;
 	if (static_branch_unlikely(&tcp_have_smc)) {
 		if (tp->syn_smc && ireq->smc_ok) {
-			if (*remaining >= TCPOLEN_EXP_SMC_BASE_ALIGNED) {
+			ireq->smc_ok = !!smc_call_hsbpf(1, sk, synack_option,
+							 tp, ireq);
+			/* re-check smc_ok */
+			if (ireq->smc_ok &&
+			    *remaining >= TCPOLEN_EXP_SMC_BASE_ALIGNED) {
 				opts->options |= OPTION_SMC;
 				*remaining -= TCPOLEN_EXP_SMC_BASE_ALIGNED;
 			}
diff --git a/net/smc/Kconfig b/net/smc/Kconfig
index ba5e6a2dd2fd..90408afa6119 100644
--- a/net/smc/Kconfig
+++ b/net/smc/Kconfig
@@ -33,3 +33,15 @@ config SMC_LO
 	  of architecture or hardware.
 
 	  if unsure, say N.
+
+config SMC_HS_CTRL_BPF
+	bool "Generic eBPF hook for SMC handshake flow"
+	depends on SMC && BPF_SYSCALL
+	default n
+	help
+	  SMC_HS_CTRL_BPF enables support to register generic eBPF hook for SMC
+	  handshake flow, which offer much greater flexibility in modifying the behavior
+	  of the SMC protocol stack compared to a complete kernel-based approach. Select
+	  this option if you want filtring the handshake process via eBPF programs.
+
+	  if unsure, say N.
\ No newline at end of file
diff --git a/net/smc/Makefile b/net/smc/Makefile
index 60f1c87d5212..a3ac276cdd39 100644
--- a/net/smc/Makefile
+++ b/net/smc/Makefile
@@ -7,3 +7,4 @@ smc-y += smc_cdc.o smc_tx.o smc_rx.o smc_close.o smc_ism.o smc_netlink.o smc_sta
 smc-y += smc_tracepoint.o smc_inet.o
 smc-$(CONFIG_SYSCTL) += smc_sysctl.o
 smc-$(CONFIG_SMC_LO) += smc_loopback.o
+smc-$(CONFIG_SMC_HS_CTRL_BPF) += smc_hs_bpf.o
\ No newline at end of file
diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index dc72ff353813..4973c408b80c 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -59,6 +59,7 @@
 #include "smc_sysctl.h"
 #include "smc_loopback.h"
 #include "smc_inet.h"
+#include "smc_hs_bpf.h"
 
 static DEFINE_MUTEX(smc_server_lgr_pending);	/* serialize link group
 						 * creation on server
@@ -3610,8 +3611,18 @@ static int __init smc_init(void)
 		pr_err("%s: smc_inet_init fails with %d\n", __func__, rc);
 		goto out_ulp;
 	}
+
+	rc = bpf_smc_hs_ctrl_init();
+	if (rc) {
+		pr_err("%s: bpf_smc_hs_ctrl_init fails with %d\n", __func__,
+		       rc);
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
diff --git a/net/smc/smc_hs_bpf.c b/net/smc/smc_hs_bpf.c
new file mode 100644
index 000000000000..d5a07532cf78
--- /dev/null
+++ b/net/smc/smc_hs_bpf.c
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  Shared Memory Communications over RDMA (SMC-R) and RoCE
+ *
+ *  Generic hook for SMC subsystem.
+ *
+ *  Copyright IBM Corp. 2016
+ *  Copyright (c) 2024, Alibaba Inc.
+ *
+ *  Author: D. Wythe <alibuda@linux.alibaba.com>
+ */
+
+#include <linux/bpf_verifier.h>
+#include <linux/bpf.h>
+#include <linux/btf.h>
+#include <linux/rculist.h>
+
+#include "smc_hs_bpf.h"
+
+static DEFINE_SPINLOCK(smc_hs_ctrl_list_lock);
+static LIST_HEAD(smc_hs_ctrl_list);
+
+static int smc_hs_ctrl_reg(struct smc_hs_ctrl *ctrl)
+{
+	int ret = 0;
+
+	spin_lock(&smc_hs_ctrl_list_lock);
+	/* already exist or duplicate name */
+	if (smc_hs_ctrl_find_by_name(ctrl->name))
+		ret = -EEXIST;
+	else
+		list_add_tail_rcu(&ctrl->list, &smc_hs_ctrl_list);
+	spin_unlock(&smc_hs_ctrl_list_lock);
+	return ret;
+}
+
+static void smc_hs_ctrl_unreg(struct smc_hs_ctrl *ctrl)
+{
+	spin_lock(&smc_hs_ctrl_list_lock);
+	list_del_rcu(&ctrl->list);
+	spin_unlock(&smc_hs_ctrl_list_lock);
+
+	/* Ensure that all readers to complete */
+	synchronize_rcu();
+}
+
+struct smc_hs_ctrl *smc_hs_ctrl_find_by_name(const char *name)
+{
+	struct smc_hs_ctrl *ctrl;
+
+	list_for_each_entry_rcu(ctrl, &smc_hs_ctrl_list, list) {
+		if (strcmp(ctrl->name, name) == 0)
+			return ctrl;
+	}
+	return NULL;
+}
+
+static int __bpf_smc_stub_set_tcp_option(struct tcp_sock *tp) { return 1; }
+static int __bpf_smc_stub_set_tcp_option_cond(const struct tcp_sock *tp,
+					      struct inet_request_sock *ireq)
+{
+	return 1;
+}
+
+static struct smc_hs_ctrl __bpf_smc_hs_ctrl = {
+	.syn_option	= __bpf_smc_stub_set_tcp_option,
+	.synack_option	= __bpf_smc_stub_set_tcp_option_cond,
+};
+
+static int smc_bpf_hs_ctrl_init(struct btf *btf) { return 0; }
+
+static int smc_bpf_hs_ctrl_reg(void *kdata, struct bpf_link *link)
+{
+	return smc_hs_ctrl_reg(kdata);
+}
+
+static void smc_bpf_hs_ctrl_unreg(void *kdata, struct bpf_link *link)
+{
+	smc_hs_ctrl_unreg(kdata);
+}
+
+static int smc_bpf_hs_ctrl_init_member(const struct btf_type *t,
+				       const struct btf_member *member,
+				       void *kdata, const void *udata)
+{
+	const struct smc_hs_ctrl *u_ctrl;
+	struct smc_hs_ctrl *k_ctrl;
+	u32 moff;
+
+	u_ctrl = (const struct smc_hs_ctrl *)udata;
+	k_ctrl = (struct smc_hs_ctrl *)kdata;
+
+	moff = __btf_member_bit_offset(t, member) / 8;
+	switch (moff) {
+	case offsetof(struct smc_hs_ctrl, name):
+		if (bpf_obj_name_cpy(k_ctrl->name, u_ctrl->name,
+				     sizeof(u_ctrl->name)) <= 0)
+			return -EINVAL;
+		return 1;
+	case offsetof(struct smc_hs_ctrl, flags):
+		if (u_ctrl->flags & ~SMC_HS_CTRL_ALL_FLAGS)
+			return -EINVAL;
+		k_ctrl->flags = u_ctrl->flags;
+		return 1;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static const struct bpf_verifier_ops smc_bpf_verifier_ops = {
+	.get_func_proto		= bpf_base_func_proto,
+	.is_valid_access	= bpf_tracing_btf_ctx_access,
+};
+
+static struct bpf_struct_ops bpf_smc_hs_ctrl_ops = {
+	.name		= "smc_hs_ctrl",
+	.init		= smc_bpf_hs_ctrl_init,
+	.reg		= smc_bpf_hs_ctrl_reg,
+	.unreg		= smc_bpf_hs_ctrl_unreg,
+	.cfi_stubs	= &__bpf_smc_hs_ctrl,
+	.verifier_ops	= &smc_bpf_verifier_ops,
+	.init_member	= smc_bpf_hs_ctrl_init_member,
+	.owner		= THIS_MODULE,
+};
+
+int bpf_smc_hs_ctrl_init(void)
+{
+	return register_bpf_struct_ops(&bpf_smc_hs_ctrl_ops, smc_hs_ctrl);
+}
diff --git a/net/smc/smc_hs_bpf.h b/net/smc/smc_hs_bpf.h
new file mode 100644
index 000000000000..d6ca3377f682
--- /dev/null
+++ b/net/smc/smc_hs_bpf.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *  Shared Memory Communications over RDMA (SMC-R) and RoCE
+ *
+ *  Generic hook for SMC subsystem.
+ *
+ *  Copyright IBM Corp. 2016
+ *  Copyright (c) 2024, Alibaba Inc.
+ *
+ *  Author: D. Wythe <alibuda@linux.alibaba.com>
+ */
+
+#ifndef __SMC_HS_CTRL
+#define __SMC_HS_CTRL
+
+#include <net/smc.h>
+
+/* Find hs_ctrl by the target name, which required to be a c-string.
+ * Return NULL if no such ctrl was found,otherwise, return a valid ctrl.
+ *
+ * Note: Caller MUST ensure it's was invoked under rcu_read_lock.
+ */
+struct smc_hs_ctrl *smc_hs_ctrl_find_by_name(const char *name);
+
+#if IS_ENABLED(CONFIG_SMC_HS_CTRL_BPF)
+int bpf_smc_hs_ctrl_init(void);
+#else
+static inline int bpf_smc_hs_ctrl_init(void) { return 0; }
+#endif /* CONFIG_SMC_HS_CTRL_BPF */
+
+#endif /* __SMC_HS_CTRL */
diff --git a/net/smc/smc_sysctl.c b/net/smc/smc_sysctl.c
index 2fab6456f765..9b15f5f49039 100644
--- a/net/smc/smc_sysctl.c
+++ b/net/smc/smc_sysctl.c
@@ -18,6 +18,7 @@
 #include "smc_core.h"
 #include "smc_llc.h"
 #include "smc_sysctl.h"
+#include "smc_hs_bpf.h"
 
 static int min_sndbuf = SMC_BUF_MIN_SIZE;
 static int min_rcvbuf = SMC_BUF_MIN_SIZE;
@@ -30,6 +31,69 @@ static int links_per_lgr_max = SMC_LINKS_ADD_LNK_MAX;
 static int conns_per_lgr_min = SMC_CONN_PER_LGR_MIN;
 static int conns_per_lgr_max = SMC_CONN_PER_LGR_MAX;
 
+#if IS_ENABLED(CONFIG_SMC_HS_CTRL_BPF)
+static int smc_net_replace_smc_hs_ctrl(struct net *net, const char *name)
+{
+	struct smc_hs_ctrl *ctrl = NULL;
+
+	rcu_read_lock();
+	/* null or empty name ask to clear current ctrl */
+	if (name && name[0]) {
+		ctrl = smc_hs_ctrl_find_by_name(name);
+		if (!ctrl) {
+			rcu_read_unlock();
+			return -EINVAL;
+		}
+		/* no change, just return */
+		if (ctrl == rcu_dereference(net->smc.hs_ctrl)) {
+			rcu_read_unlock();
+			return 0;
+		}
+		if (!bpf_try_module_get(ctrl, ctrl->owner)) {
+			rcu_read_unlock();
+			return -EBUSY;
+		}
+	}
+	/* xhcg old ctrl with the new one atomically */
+	ctrl = xchg(&net->smc.hs_ctrl, ctrl);
+	/* release old ctrl */
+	if (ctrl)
+		bpf_module_put(ctrl, ctrl->owner);
+
+	rcu_read_unlock();
+	return 0;
+}
+
+static int proc_smc_hs_ctrl(const struct ctl_table *ctl, int write,
+			    void *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct net *net = container_of(ctl->data, struct net, smc.hs_ctrl);
+	char val[SMC_HS_CTRL_NAME_MAX];
+	const struct ctl_table tbl = {
+		.data = val,
+		.maxlen = SMC_HS_CTRL_NAME_MAX,
+	};
+	struct smc_hs_ctrl *ctrl;
+	int ret;
+
+	rcu_read_lock();
+	ctrl = rcu_dereference(net->smc.hs_ctrl);
+	if (ctrl)
+		memcpy(val, ctrl->name, sizeof(ctrl->name));
+	else
+		val[0] = '\0';
+	rcu_read_unlock();
+
+	ret = proc_dostring(&tbl, write, buffer, lenp, ppos);
+	if (ret)
+		return ret;
+
+	if (write)
+		ret = smc_net_replace_smc_hs_ctrl(net, val);
+	return ret;
+}
+#endif /* CONFIG_SMC_HS_CTRL_BPF */
+
 static struct ctl_table smc_table[] = {
 	{
 		.procname       = "autocorking_size",
@@ -99,6 +163,15 @@ static struct ctl_table smc_table[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
 	},
+#if IS_ENABLED(CONFIG_SMC_HS_CTRL_BPF)
+	{
+		.procname	= "hs_ctrl",
+		.data		= &init_net.smc.hs_ctrl,
+		.mode		= 0644,
+		.maxlen		= SMC_HS_CTRL_NAME_MAX,
+		.proc_handler	= proc_smc_hs_ctrl,
+	},
+#endif /* CONFIG_SMC_HS_CTRL_BPF */
 };
 
 int __net_init smc_sysctl_net_init(struct net *net)
@@ -109,6 +182,16 @@ int __net_init smc_sysctl_net_init(struct net *net)
 	table = smc_table;
 	if (!net_eq(net, &init_net)) {
 		int i;
+#if IS_ENABLED(CONFIG_SMC_HS_CTRL_BPF)
+		struct smc_hs_ctrl *ctrl;
+
+		rcu_read_lock();
+		ctrl = rcu_dereference(init_net.smc.hs_ctrl);
+		if (ctrl && ctrl->flags & SMC_HS_CTRL_FLAG_INHERITABLE &&
+		    bpf_try_module_get(ctrl, ctrl->owner))
+			rcu_assign_pointer(net->smc.hs_ctrl, ctrl);
+		rcu_read_unlock();
+#endif /* CONFIG_SMC_HS_CTRL_BPF */
 
 		table = kmemdup(table, sizeof(smc_table), GFP_KERNEL);
 		if (!table)
@@ -139,6 +222,9 @@ int __net_init smc_sysctl_net_init(struct net *net)
 	if (!net_eq(net, &init_net))
 		kfree(table);
 err_alloc:
+#if IS_ENABLED(CONFIG_SMC_HS_CTRL_BPF)
+	smc_net_replace_smc_hs_ctrl(net, NULL);
+#endif /* CONFIG_SMC_HS_CTRL_BPF */
 	return -ENOMEM;
 }
 
@@ -148,6 +234,10 @@ void __net_exit smc_sysctl_net_exit(struct net *net)
 
 	table = net->smc.smc_hdr->ctl_table_arg;
 	unregister_net_sysctl_table(net->smc.smc_hdr);
+#if IS_ENABLED(CONFIG_SMC_HS_CTRL_BPF)
+	smc_net_replace_smc_hs_ctrl(net, NULL);
+#endif /* CONFIG_SMC_HS_CTRL_BPF */
+
 	if (!net_eq(net, &init_net))
 		kfree(table);
 }
-- 
2.45.0


