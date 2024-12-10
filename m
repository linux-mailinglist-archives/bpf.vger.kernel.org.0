Return-Path: <bpf+bounces-46477-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03DA29EA6EB
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 05:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BB52282C12
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 04:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2533225766;
	Tue, 10 Dec 2024 04:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="bVOpOFOS"
X-Original-To: bpf@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1239C1D79A3;
	Tue, 10 Dec 2024 04:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733803457; cv=none; b=CAuZ6/tXfLcaOMQvbIX7VKvyavkkpVOJrjixB7s+CTOYZ0Nfgkg4GRuEAdcWE/YdM3BDK2UlI+gwnj97R286ujisP6O/hhESvPsf3V1MxwVKALboqdLYRSINrrThMdfCP6/vwKyurQZWDvR2gC/3ljboO/6H9VJJbU/+IVayf5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733803457; c=relaxed/simple;
	bh=00MZDtEQc8cudXFab639g8G6jcxKxY4ipxJHDtrbfBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MQYsWqzrnAQc46052RAn0b7bROYMCkHOLkRx0NuIcCQeF7ghK9NOKeF9NLiXb0PDOwsYZAfOb7olzdD2h/jDh6CSKRW/FbBh5NJPMQYEHQeerMqe1bObINH+SsMQxqTgvE0+HC7209t5xJM3J9WnwCmLb5HbXSKsQh2AB4ST6Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=bVOpOFOS; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733803452; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=pj3X3jxKZ7nW5+LEb6ZD7OgevxazCO0NZ28sw3x9NS4=;
	b=bVOpOFOSmbYulQRu2zjpCmJXiJo39jlLvguuwsCTW9qsnDMSAALfWevOESnDps4cnWzBppfxwTSJzTMrOnVsf2bYo65SIeXCN9ZAwQ+7qFUBAR6nKGuue8Wp5MSYR3y7iV+6kLAPGrvyOf1lu4+nagyFXrLGG2qf7/088Fs/qL8=
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WLDSEY5_1733803450 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 10 Dec 2024 12:04:10 +0800
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
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 2/5] net/smc: Introduce generic hook smc_ops
Date: Tue, 10 Dec 2024 12:04:01 +0800
Message-ID: <20241210040404.10606-3-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241210040404.10606-1-alibuda@linux.alibaba.com>
References: <20241210040404.10606-1-alibuda@linux.alibaba.com>
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

Moreover, in the future, we can achieve more complex extensions to the
protocol stack by extending this ops.

Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
---
 include/net/netns/smc.h |  3 ++
 include/net/smc.h       | 51 ++++++++++++++++++++++
 net/ipv4/tcp_output.c   | 15 +++++--
 net/smc/Kconfig         | 12 ++++++
 net/smc/Makefile        |  1 +
 net/smc/smc_ops.c       | 51 ++++++++++++++++++++++
 net/smc/smc_ops.h       | 29 +++++++++++++
 net/smc/smc_sysctl.c    | 95 +++++++++++++++++++++++++++++++++++++++++
 8 files changed, 253 insertions(+), 4 deletions(-)
 create mode 100644 net/smc/smc_ops.c
 create mode 100644 net/smc/smc_ops.h

diff --git a/include/net/netns/smc.h b/include/net/netns/smc.h
index fc752a50f91b..59d069f56b2d 100644
--- a/include/net/netns/smc.h
+++ b/include/net/netns/smc.h
@@ -17,6 +17,9 @@ struct netns_smc {
 #ifdef CONFIG_SYSCTL
 	struct ctl_table_header		*smc_hdr;
 #endif
+#if IS_ENABLED(CONFIG_SMC_OPS)
+	struct smc_ops __rcu *ops;
+#endif /* CONFIG_SMC_OPS */
 	unsigned int			sysctl_autocorking_size;
 	unsigned int			sysctl_smcr_buf_type;
 	int				sysctl_smcr_testlink_time;
diff --git a/include/net/smc.h b/include/net/smc.h
index db84e4e35080..25c762aa96fc 100644
--- a/include/net/smc.h
+++ b/include/net/smc.h
@@ -18,6 +18,8 @@
 #include "linux/ism.h"
 
 struct sock;
+struct tcp_sock;
+struct inet_request_sock;
 
 #define SMC_MAX_PNETID_LEN	16	/* Max. length of PNET id */
 
@@ -97,4 +99,53 @@ struct smcd_dev {
 	u8 going_away : 1;
 };
 
+#define  SMC_OPS_NAME_MAX 16
+
+enum {
+	/* ops can be inherit from init_net */
+	SMC_OPS_FLAG_INHERITABLE = 0x1,
+
+	SMC_OPS_ALL_FLAGS = SMC_OPS_FLAG_INHERITABLE,
+};
+
+struct smc_ops {
+	/* priavte */
+
+	struct list_head list;
+	struct module *owner;
+
+	/* public */
+
+	/* unique name */
+	char name[SMC_OPS_NAME_MAX];
+	int flags;
+
+	/* Invoked before computing SMC option for SYN packets.
+	 * We can control whether to set SMC options by returning varios value.
+	 * Return 0 to disable SMC, or return any other value to enable it.
+	 */
+	int (*set_option)(struct tcp_sock *tp);
+
+	/* Invoked before Set up SMC options for SYN-ACK packets
+	 * We can control whether to respond SMC options by returning varios value.
+	 * Return 0 to disable SMC, or return any other value to enable it.
+	 */
+	int (*set_option_cond)(const struct tcp_sock *tp, struct inet_request_sock *ireq);
+};
+
+#if IS_ENABLED(CONFIG_SMC_OPS)
+#define smc_call_retops(init_val, sk, func, ...) ({	\
+	typeof(init_val) __ret = (init_val);		\
+	struct smc_ops *ops;				\
+	rcu_read_lock();				\
+	ops = READ_ONCE(sock_net(sk)->smc.ops);		\
+	if (ops && ops->func)				\
+		__ret = ops->func(__VA_ARGS__);		\
+	rcu_read_unlock();				\
+	__ret;						\
+})
+#else
+#define smc_call_retops(init_val, ...) (init_val)
+#endif /* CONFIG_SMC_OPS */
+
 #endif	/* _SMC_H */
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 5485a70b5fe5..7b402167fb4d 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -48,6 +48,7 @@
 #include <linux/skbuff_ref.h>
 
 #include <trace/events/tcp.h>
+#include <net/smc.h>
 
 /* Refresh clocks of a TCP socket,
  * ensuring monotically increasing values.
@@ -759,14 +760,17 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
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
+			tp->syn_smc = smc_call_retops(1, &tp->inet_conn.icsk_inet.sk,
+						      set_option, tp);
+			/* re-check syn_smc */
+			if (tp->syn_smc && *remaining >= TCPOLEN_EXP_SMC_BASE_ALIGNED) {
 				opts->options |= OPTION_SMC;
 				*remaining -= TCPOLEN_EXP_SMC_BASE_ALIGNED;
 			}
@@ -776,14 +780,17 @@ static void smc_set_option(const struct tcp_sock *tp,
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
+			ireq->smc_ok = smc_call_retops(1, &tp->inet_conn.icsk_inet.sk,
+						       set_option_cond, tp, ireq);
+			/* re-check smc_ok */
+			if (ireq->smc_ok && *remaining >= TCPOLEN_EXP_SMC_BASE_ALIGNED) {
 				opts->options |= OPTION_SMC;
 				*remaining -= TCPOLEN_EXP_SMC_BASE_ALIGNED;
 			}
diff --git a/net/smc/Kconfig b/net/smc/Kconfig
index ba5e6a2dd2fd..0ee16ec8dceb 100644
--- a/net/smc/Kconfig
+++ b/net/smc/Kconfig
@@ -33,3 +33,15 @@ config SMC_LO
 	  of architecture or hardware.
 
 	  if unsure, say N.
+
+config SMC_OPS
+	bool "Generic hook for SMC subsystem"
+	depends on SMC && BPF_SYSCALL
+	default n
+	help
+	  SMC_OPS enables support to register genericfor hook via eBPF programs
+	  for SMC subsystem. eBPF programs offer much greater flexibility
+	  in modifying the behavior of the SMC protocol stack compared
+	  to a complete kernel-based approach.
+
+	  if unsure, say N.
diff --git a/net/smc/Makefile b/net/smc/Makefile
index 60f1c87d5212..5dd706b2927a 100644
--- a/net/smc/Makefile
+++ b/net/smc/Makefile
@@ -7,3 +7,4 @@ smc-y += smc_cdc.o smc_tx.o smc_rx.o smc_close.o smc_ism.o smc_netlink.o smc_sta
 smc-y += smc_tracepoint.o smc_inet.o
 smc-$(CONFIG_SYSCTL) += smc_sysctl.o
 smc-$(CONFIG_SMC_LO) += smc_loopback.o
+smc-$(CONFIG_SMC_OPS) += smc_ops.o
\ No newline at end of file
diff --git a/net/smc/smc_ops.c b/net/smc/smc_ops.c
new file mode 100644
index 000000000000..0fc19cadd760
--- /dev/null
+++ b/net/smc/smc_ops.c
@@ -0,0 +1,51 @@
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
+#include "smc_ops.h"
+
+static DEFINE_SPINLOCK(smc_ops_list_lock);
+static LIST_HEAD(smc_ops_list);
+
+static int smc_ops_reg(struct smc_ops *ops)
+{
+	int ret = 0;
+
+	spin_lock(&smc_ops_list_lock);
+	/* already exist or duplicate name */
+	if (smc_ops_find_by_name(ops->name))
+		ret = -EEXIST;
+	else
+		list_add_tail_rcu(&ops->list, &smc_ops_list);
+	spin_unlock(&smc_ops_list_lock);
+	return ret;
+}
+
+static void smc_ops_unreg(struct smc_ops *ops)
+{
+	spin_lock(&smc_ops_list_lock);
+	list_del_rcu(&ops->list);
+	spin_unlock(&smc_ops_list_lock);
+
+	/* Ensure that all readers to complete */
+	synchronize_rcu();
+}
+
+struct smc_ops *smc_ops_find_by_name(const char *name)
+{
+	struct smc_ops *ops;
+
+	list_for_each_entry_rcu(ops, &smc_ops_list, list) {
+		if (strcmp(ops->name, name) == 0)
+			return ops;
+	}
+	return NULL;
+}
diff --git a/net/smc/smc_ops.h b/net/smc/smc_ops.h
new file mode 100644
index 000000000000..214f4c99efd4
--- /dev/null
+++ b/net/smc/smc_ops.h
@@ -0,0 +1,29 @@
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
+#ifndef __SMC_OPS
+#define __SMC_OPS
+
+#include <net/smc.h>
+
+#if IS_ENABLED(CONFIG_SMC_OPS)
+/* Find ops by the target name, which required to be a c-string.
+ * Return NULL if no such ops was found,otherwise, return a valid ops.
+ *
+ * Note: Caller MUST ensure it's was invoked under rcu_read_lock.
+ */
+struct smc_ops *smc_ops_find_by_name(const char *name);
+#else
+static inline struct smc_ops *smc_ops_find_by_name(const char *name) { return NULL; }
+#endif /* CONFIG_SMC_OPS*/
+
+#endif /* __SMC_OPS */
diff --git a/net/smc/smc_sysctl.c b/net/smc/smc_sysctl.c
index 2fab6456f765..2aa3f19025f4 100644
--- a/net/smc/smc_sysctl.c
+++ b/net/smc/smc_sysctl.c
@@ -18,6 +18,7 @@
 #include "smc_core.h"
 #include "smc_llc.h"
 #include "smc_sysctl.h"
+#include "smc_ops.h"
 
 static int min_sndbuf = SMC_BUF_MIN_SIZE;
 static int min_rcvbuf = SMC_BUF_MIN_SIZE;
@@ -30,6 +31,70 @@ static int links_per_lgr_max = SMC_LINKS_ADD_LNK_MAX;
 static int conns_per_lgr_min = SMC_CONN_PER_LGR_MIN;
 static int conns_per_lgr_max = SMC_CONN_PER_LGR_MAX;
 
+#if IS_ENABLED(CONFIG_SMC_OPS)
+static int smc_net_replace_smc_ops(struct net *net, const char *name)
+{
+	struct smc_ops *ops = NULL;
+
+	rcu_read_lock();
+	/* null or empty name ask to clear current ops */
+	if (name && name[0]) {
+		ops = smc_ops_find_by_name(name);
+		if (!ops) {
+			rcu_read_unlock();
+			return -EINVAL;
+		}
+		/* no change, just return */
+		if (ops == rcu_dereference(net->smc.ops)) {
+			rcu_read_unlock();
+			return 0;
+		}
+	}
+	if (!ops || bpf_try_module_get(ops, ops->owner)) {
+		/* xhcg */
+		ops = rcu_replace_pointer(net->smc.ops, ops, true);
+		/* release old ops */
+		if (ops)
+			bpf_module_put(ops, ops->owner);
+	} else if (ops) {
+		rcu_read_unlock();
+		return -EBUSY;
+	}
+	rcu_read_unlock();
+	return 0;
+}
+
+static int proc_smc_ops(const struct ctl_table *ctl, int write,
+			void *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct net *net = container_of(ctl->data, struct net,
+				       smc.ops);
+	char val[SMC_OPS_NAME_MAX];
+	struct ctl_table tbl = {
+		.data = val,
+		.maxlen = SMC_OPS_NAME_MAX,
+	};
+	struct smc_ops *ops;
+	int ret;
+
+	rcu_read_lock();
+	ops = rcu_dereference(net->smc.ops);
+	if (ops)
+		memcpy(val, ops->name, sizeof(ops->name));
+	else
+		val[0] = '\0';
+	rcu_read_unlock();
+
+	ret = proc_dostring(&tbl, write, buffer, lenp, ppos);
+	if (ret)
+		return ret;
+
+	if (write)
+		ret = smc_net_replace_smc_ops(net, val);
+	return ret;
+}
+#endif /* CONFIG_SMC_OPS */
+
 static struct ctl_table smc_table[] = {
 	{
 		.procname       = "autocorking_size",
@@ -99,6 +164,15 @@ static struct ctl_table smc_table[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
 	},
+#if IS_ENABLED(CONFIG_SMC_OPS)
+	{
+		.procname	= "ops",
+		.data		= &init_net.smc.ops,
+		.mode		= 0644,
+		.maxlen		= SMC_OPS_NAME_MAX,
+		.proc_handler	= proc_smc_ops,
+	},
+#endif /* CONFIG_SMC_OPS */
 };
 
 int __net_init smc_sysctl_net_init(struct net *net)
@@ -109,6 +183,20 @@ int __net_init smc_sysctl_net_init(struct net *net)
 	table = smc_table;
 	if (!net_eq(net, &init_net)) {
 		int i;
+#if IS_ENABLED(CONFIG_SMC_OPS)
+		struct smc_ops *ops;
+
+		rcu_read_lock();
+		ops = rcu_dereference(init_net.smc.ops);
+		if (ops && ops->flags & SMC_OPS_FLAG_INHERITABLE) {
+			if (!bpf_try_module_get(ops, ops->owner)) {
+				rcu_read_unlock();
+				return -EBUSY;
+			}
+			rcu_assign_pointer(net->smc.ops, ops);
+		}
+		rcu_read_unlock();
+#endif /* CONFIG_SMC_OPS */
 
 		table = kmemdup(table, sizeof(smc_table), GFP_KERNEL);
 		if (!table)
@@ -139,6 +227,9 @@ int __net_init smc_sysctl_net_init(struct net *net)
 	if (!net_eq(net, &init_net))
 		kfree(table);
 err_alloc:
+#if IS_ENABLED(CONFIG_SMC_OPS)
+	smc_net_replace_smc_ops(net, NULL);
+#endif /* CONFIG_SMC_OPS */
 	return -ENOMEM;
 }
 
@@ -148,6 +239,10 @@ void __net_exit smc_sysctl_net_exit(struct net *net)
 
 	table = net->smc.smc_hdr->ctl_table_arg;
 	unregister_net_sysctl_table(net->smc.smc_hdr);
+#if IS_ENABLED(CONFIG_SMC_OPS)
+	smc_net_replace_smc_ops(net, NULL);
+#endif /* CONFIG_SMC_OPS */
+
 	if (!net_eq(net, &init_net))
 		kfree(table);
 }
-- 
2.45.0


