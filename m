Return-Path: <bpf+bounces-69961-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B27ABA986F
	for <lists+bpf@lfdr.de>; Mon, 29 Sep 2025 16:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DAD63C3661
	for <lists+bpf@lfdr.de>; Mon, 29 Sep 2025 14:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D913093CA;
	Mon, 29 Sep 2025 14:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="OWTjUzq0"
X-Original-To: bpf@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459C11E8329;
	Mon, 29 Sep 2025 14:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759155703; cv=none; b=cAR2gC3vHBrdGsrfl23AhE7d8loLBLWdDAbpdMEv6McqwNYCLEbhcrUll+chARuEksjAjrncC1rTWzstkk87JUJaNbHE2TJZwhxYyljiIfCNb/0uDq8bVZMXeUifA2CLornqjQ53x3tjazkmgrWhM0uAOyRzX+JJuVmghB6vk84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759155703; c=relaxed/simple;
	bh=bsiZWK+t8jHf9WvX8LalU0yGIyJxcJM68PRbIZFr2D4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZgJaEAV16hpGpCUH1HTsHW94NQBjvYh5s2lmPybfhwdjB47qu6VdnVreXf3MeVpZmrl8R108KDRZUOg/p8aFe9eUTC9AP7asoAkaDgmSfIG63WDjLcUv2ZVDC2zxgbHlVklg+1mXOmycH1S6A/yvqodaNxywuz1MLYTXbFV9Pmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=OWTjUzq0; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1759155690; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=FkcnFCtQ0f2lI113k/WzyZSzFaNtmxgsUVeEjQdhJIg=;
	b=OWTjUzq01F2p1EO45F3dumyoOv2hEgtaCSigayuy5rUGpjF6cCsjnE85G/OrXCTCidZcIuv4DVgetPP6GWHI09Qzgu5rwTknH2Jwfct7ynz7QpKyqyjIe6uUfCV252EEDzoE9yYzATN3/7tdD3FHLwrK2CGNDvu3beOZRzR+K/g=
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0Wp5sGqR_1759155687 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 29 Sep 2025 22:21:27 +0800
Date: Mon, 29 Sep 2025 22:21:27 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: "D. Wythe" <alibuda@linux.alibaba.com>, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	pabeni@redhat.com, song@kernel.org, sdf@google.com,
	haoluo@google.com, yhs@fb.com, edumazet@google.com,
	john.fastabend@gmail.com, kpsingh@kernel.org, jolsa@kernel.org,
	mjambigi@linux.ibm.com, wenjia@linux.ibm.com, wintera@linux.ibm.com,
	tonylu@linux.alibaba.com, guwen@linux.alibaba.com
Cc: bpf@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	netdev@vger.kernel.org, sidraya@linux.ibm.com, jaka@linux.ibm.com
Subject: Re: [PATCH bpf-next v3 2/3] net/smc: bpf: Introduce generic hook for
 handshake flow
Message-ID: <aNqV5zmFbLk0MmlM@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20250929063400.37939-1-alibuda@linux.alibaba.com>
 <20250929063400.37939-3-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929063400.37939-3-alibuda@linux.alibaba.com>

On 2025-09-29 14:33:59, D. Wythe wrote:
>The introduction of IPPROTO_SMC enables eBPF programs to determine
>whether to use SMC based on the context of socket creation, such as
>network namespaces, PID and comm name, etc.
>
>As a subsequent enhancement, to introduce a new generic hook that
>allows decisions on whether to use SMC or not at runtime, including
>but not limited to local/remote IP address or ports.
>
>User can write their own implememtion via bpf_struct_ops now to choose
>whether to use SMC or not before TCP 3rd handshake to be comleted.
>
>Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>

Looks good to me, thanks for continuing to work on this!

Reviewed-by: Dust Li <dust.li@linux.alibaba.com>

Best regards,
Dust


>---
> include/net/netns/smc.h |   3 +
> include/net/smc.h       |  53 ++++++++++++++++
> net/ipv4/tcp_output.c   |  36 +++++++----
> net/smc/Kconfig         |  10 +++
> net/smc/Makefile        |   1 +
> net/smc/af_smc.c        |  10 +++
> net/smc/smc_hs_bpf.c    | 137 ++++++++++++++++++++++++++++++++++++++++
> net/smc/smc_hs_bpf.h    |  31 +++++++++
> net/smc/smc_sysctl.c    |  91 ++++++++++++++++++++++++++
> 9 files changed, 358 insertions(+), 14 deletions(-)
> create mode 100644 net/smc/smc_hs_bpf.c
> create mode 100644 net/smc/smc_hs_bpf.h
>
>diff --git a/include/net/netns/smc.h b/include/net/netns/smc.h
>index fc752a50f91b..d66bfd392254 100644
>--- a/include/net/netns/smc.h
>+++ b/include/net/netns/smc.h
>@@ -17,6 +17,9 @@ struct netns_smc {
> #ifdef CONFIG_SYSCTL
> 	struct ctl_table_header		*smc_hdr;
> #endif
>+#if IS_ENABLED(CONFIG_SMC_HS_CTRL_BPF)
>+	struct smc_hs_ctrl __rcu	*hs_ctrl;
>+#endif /* CONFIG_SMC_HS_CTRL_BPF */
> 	unsigned int			sysctl_autocorking_size;
> 	unsigned int			sysctl_smcr_buf_type;
> 	int				sysctl_smcr_testlink_time;
>diff --git a/include/net/smc.h b/include/net/smc.h
>index db84e4e35080..d599f8a74043 100644
>--- a/include/net/smc.h
>+++ b/include/net/smc.h
>@@ -18,6 +18,8 @@
> #include "linux/ism.h"
> 
> struct sock;
>+struct tcp_sock;
>+struct inet_request_sock;
> 
> #define SMC_MAX_PNETID_LEN	16	/* Max. length of PNET id */
> 
>@@ -97,4 +99,55 @@ struct smcd_dev {
> 	u8 going_away : 1;
> };
> 
>+#define SMC_HS_CTRL_NAME_MAX 16
>+
>+enum {
>+	/* ops can be inherit from init_net */
>+	SMC_HS_CTRL_FLAG_INHERITABLE = 0x1,
>+
>+	SMC_HS_CTRL_ALL_FLAGS = SMC_HS_CTRL_FLAG_INHERITABLE,
>+};
>+
>+struct smc_hs_ctrl {
>+	/* private */
>+
>+	struct list_head list;
>+	struct module *owner;
>+
>+	/* public */
>+
>+	/* unique name */
>+	char name[SMC_HS_CTRL_NAME_MAX];
>+	int flags;
>+
>+	/* Invoked before computing SMC option for SYN packets.
>+	 * We can control whether to set SMC options by returning various value.
>+	 * Return 0 to disable SMC, or return any other value to enable it.
>+	 */
>+	int (*syn_option)(struct tcp_sock *tp);
>+
>+	/* Invoked before Set up SMC options for SYN-ACK packets
>+	 * We can control whether to respond SMC options by returning various
>+	 * value. Return 0 to disable SMC, or return any other value to enable
>+	 * it.
>+	 */
>+	int (*synack_option)(const struct tcp_sock *tp,
>+			     struct inet_request_sock *ireq);
>+};
>+
>+#if IS_ENABLED(CONFIG_SMC_HS_CTRL_BPF)
>+#define smc_call_hsbpf(init_val, sk, func, ...) ({		\
>+	typeof(init_val) __ret = (init_val);			\
>+	struct smc_hs_ctrl *ctrl;				\
>+	rcu_read_lock();					\
>+	ctrl = rcu_dereference(sock_net(sk)->smc.hs_ctrl);	\
>+	if (ctrl && ctrl->func)					\
>+		__ret = ctrl->func(__VA_ARGS__);		\
>+	rcu_read_unlock();					\
>+	__ret;							\
>+})
>+#else
>+#define smc_call_hsbpf(init_val, sk, ...)  ({ (void)(sk); (init_val); })
>+#endif /* CONFIG_SMC_HS_CTRL_BPF */
>+
> #endif	/* _SMC_H */
>diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
>index caf11920a878..e4ee138044d3 100644
>--- a/net/ipv4/tcp_output.c
>+++ b/net/ipv4/tcp_output.c
>@@ -39,6 +39,7 @@
> 
> #include <net/tcp.h>
> #include <net/mptcp.h>
>+#include <net/smc.h>
> #include <net/proto_memory.h>
> 
> #include <linux/compiler.h>
>@@ -764,34 +765,41 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
> 	mptcp_options_write(th, ptr, tp, opts);
> }
> 
>-static void smc_set_option(const struct tcp_sock *tp,
>+static void smc_set_option(struct tcp_sock *tp,
> 			   struct tcp_out_options *opts,
> 			   unsigned int *remaining)
> {
> #if IS_ENABLED(CONFIG_SMC)
>-	if (static_branch_unlikely(&tcp_have_smc)) {
>-		if (tp->syn_smc) {
>-			if (*remaining >= TCPOLEN_EXP_SMC_BASE_ALIGNED) {
>-				opts->options |= OPTION_SMC;
>-				*remaining -= TCPOLEN_EXP_SMC_BASE_ALIGNED;
>-			}
>+	struct sock *sk = &tp->inet_conn.icsk_inet.sk;
>+
>+	if (static_branch_unlikely(&tcp_have_smc) && tp->syn_smc) {
>+		tp->syn_smc = !!smc_call_hsbpf(1, sk, syn_option, tp);
>+		/* re-check syn_smc */
>+		if (tp->syn_smc &&
>+		    *remaining >= TCPOLEN_EXP_SMC_BASE_ALIGNED) {
>+			opts->options |= OPTION_SMC;
>+			*remaining -= TCPOLEN_EXP_SMC_BASE_ALIGNED;
> 		}
> 	}
> #endif
> }
> 
> static void smc_set_option_cond(const struct tcp_sock *tp,
>-				const struct inet_request_sock *ireq,
>+				struct inet_request_sock *ireq,
> 				struct tcp_out_options *opts,
> 				unsigned int *remaining)
> {
> #if IS_ENABLED(CONFIG_SMC)
>-	if (static_branch_unlikely(&tcp_have_smc)) {
>-		if (tp->syn_smc && ireq->smc_ok) {
>-			if (*remaining >= TCPOLEN_EXP_SMC_BASE_ALIGNED) {
>-				opts->options |= OPTION_SMC;
>-				*remaining -= TCPOLEN_EXP_SMC_BASE_ALIGNED;
>-			}
>+	const struct sock *sk = &tp->inet_conn.icsk_inet.sk;
>+
>+	if (static_branch_unlikely(&tcp_have_smc) && tp->syn_smc && ireq->smc_ok) {
>+		ireq->smc_ok = !!smc_call_hsbpf(1, sk, synack_option,
>+						tp, ireq);
>+		/* re-check smc_ok */
>+		if (ireq->smc_ok &&
>+		    *remaining >= TCPOLEN_EXP_SMC_BASE_ALIGNED) {
>+			opts->options |= OPTION_SMC;
>+			*remaining -= TCPOLEN_EXP_SMC_BASE_ALIGNED;
> 		}
> 	}
> #endif
>diff --git a/net/smc/Kconfig b/net/smc/Kconfig
>index ba5e6a2dd2fd..67edeb927e19 100644
>--- a/net/smc/Kconfig
>+++ b/net/smc/Kconfig
>@@ -33,3 +33,13 @@ config SMC_LO
> 	  of architecture or hardware.
> 
> 	  if unsure, say N.
>+
>+config SMC_HS_CTRL_BPF
>+	bool "Generic eBPF hook for SMC handshake flow"
>+	depends on SMC && BPF_SYSCALL
>+	default y
>+	help
>+	  SMC_HS_CTRL_BPF enables support to register generic eBPF hook for SMC
>+	  handshake flow, which offer much greater flexibility in modifying the behavior
>+	  of the SMC protocol stack compared to a complete kernel-based approach. Select
>+	  this option if you want filtring the handshake process via eBPF programs.
>diff --git a/net/smc/Makefile b/net/smc/Makefile
>index 60f1c87d5212..57b919434df4 100644
>--- a/net/smc/Makefile
>+++ b/net/smc/Makefile
>@@ -7,3 +7,4 @@ smc-y += smc_cdc.o smc_tx.o smc_rx.o smc_close.o smc_ism.o smc_netlink.o smc_sta
> smc-y += smc_tracepoint.o smc_inet.o
> smc-$(CONFIG_SYSCTL) += smc_sysctl.o
> smc-$(CONFIG_SMC_LO) += smc_loopback.o
>+smc-$(CONFIG_SMC_HS_CTRL_BPF) += smc_hs_bpf.o
>diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
>index e0e48f24cd61..ecc6499b05fa 100644
>--- a/net/smc/af_smc.c
>+++ b/net/smc/af_smc.c
>@@ -59,6 +59,7 @@
> #include "smc_sysctl.h"
> #include "smc_loopback.h"
> #include "smc_inet.h"
>+#include "smc_hs_bpf.h"
> 
> static DEFINE_MUTEX(smc_server_lgr_pending);	/* serialize link group
> 						 * creation on server
>@@ -3609,8 +3610,17 @@ static int __init smc_init(void)
> 		pr_err("%s: smc_inet_init fails with %d\n", __func__, rc);
> 		goto out_ulp;
> 	}
>+	rc = bpf_smc_hs_ctrl_init();
>+	if (rc) {
>+		pr_err("%s: bpf_smc_hs_ctrl_init fails with %d\n", __func__,
>+		       rc);
>+		goto out_inet;
>+	}
>+
> 	static_branch_enable(&tcp_have_smc);
> 	return 0;
>+out_inet:
>+	smc_inet_exit();
> out_ulp:
> 	tcp_unregister_ulp(&smc_ulp_ops);
> out_lo:
>diff --git a/net/smc/smc_hs_bpf.c b/net/smc/smc_hs_bpf.c
>new file mode 100644
>index 000000000000..4aa6d38da122
>--- /dev/null
>+++ b/net/smc/smc_hs_bpf.c
>@@ -0,0 +1,137 @@
>+// SPDX-License-Identifier: GPL-2.0-only
>+/*
>+ *  Shared Memory Communications over RDMA (SMC-R) and RoCE
>+ *
>+ *  Generic hook for SMC handshake flow.
>+ *
>+ *  Copyright IBM Corp. 2016
>+ *  Copyright (c) 2025, Alibaba Inc.
>+ *
>+ *  Author: D. Wythe <alibuda@linux.alibaba.com>
>+ */
>+
>+#include <linux/bpf_verifier.h>
>+#include <linux/bpf.h>
>+#include <linux/btf.h>
>+#include <linux/rculist.h>
>+
>+#include "smc_hs_bpf.h"
>+
>+static DEFINE_SPINLOCK(smc_hs_ctrl_list_lock);
>+static LIST_HEAD(smc_hs_ctrl_list);
>+
>+static int smc_hs_ctrl_reg(struct smc_hs_ctrl *ctrl)
>+{
>+	int ret = 0;
>+
>+	spin_lock(&smc_hs_ctrl_list_lock);
>+	/* already exist or duplicate name */
>+	if (smc_hs_ctrl_find_by_name(ctrl->name))
>+		ret = -EEXIST;
>+	else
>+		list_add_tail_rcu(&ctrl->list, &smc_hs_ctrl_list);
>+	spin_unlock(&smc_hs_ctrl_list_lock);
>+	return ret;
>+}
>+
>+static void smc_hs_ctrl_unreg(struct smc_hs_ctrl *ctrl)
>+{
>+	spin_lock(&smc_hs_ctrl_list_lock);
>+	list_del_rcu(&ctrl->list);
>+	spin_unlock(&smc_hs_ctrl_list_lock);
>+
>+	/* Ensure that all readers to complete */
>+	synchronize_rcu();
>+}
>+
>+struct smc_hs_ctrl *smc_hs_ctrl_find_by_name(const char *name)
>+{
>+	struct smc_hs_ctrl *ctrl;
>+
>+	list_for_each_entry_rcu(ctrl, &smc_hs_ctrl_list, list) {
>+		if (strcmp(ctrl->name, name) == 0)
>+			return ctrl;
>+	}
>+	return NULL;
>+}
>+
>+static int __smc_bpf_stub_set_tcp_option(struct tcp_sock *tp) { return 1; }
>+static int __smc_bpf_stub_set_tcp_option_cond(const struct tcp_sock *tp,
>+					      struct inet_request_sock *ireq)
>+{
>+	return 1;
>+}
>+
>+static struct smc_hs_ctrl __smc_bpf_hs_ctrl = {
>+	.syn_option	= __smc_bpf_stub_set_tcp_option,
>+	.synack_option	= __smc_bpf_stub_set_tcp_option_cond,
>+};
>+
>+static int smc_bpf_hs_ctrl_init(struct btf *btf) { return 0; }
>+
>+static int smc_bpf_hs_ctrl_reg(void *kdata, struct bpf_link *link)
>+{
>+	return smc_hs_ctrl_reg(kdata);
>+}
>+
>+static void smc_bpf_hs_ctrl_unreg(void *kdata, struct bpf_link *link)
>+{
>+	smc_hs_ctrl_unreg(kdata);
>+}
>+
>+static int smc_bpf_hs_ctrl_init_member(const struct btf_type *t,
>+				       const struct btf_member *member,
>+				       void *kdata, const void *udata)
>+{
>+	const struct smc_hs_ctrl *u_ctrl;
>+	struct smc_hs_ctrl *k_ctrl;
>+	u32 moff;
>+
>+	u_ctrl = (const struct smc_hs_ctrl *)udata;
>+	k_ctrl = (struct smc_hs_ctrl *)kdata;
>+
>+	moff = __btf_member_bit_offset(t, member) / 8;
>+	switch (moff) {
>+	case offsetof(struct smc_hs_ctrl, name):
>+		if (bpf_obj_name_cpy(k_ctrl->name, u_ctrl->name,
>+				     sizeof(u_ctrl->name)) <= 0)
>+			return -EINVAL;
>+		return 1;
>+	case offsetof(struct smc_hs_ctrl, flags):
>+		if (u_ctrl->flags & ~SMC_HS_CTRL_ALL_FLAGS)
>+			return -EINVAL;
>+		k_ctrl->flags = u_ctrl->flags;
>+		return 1;
>+	default:
>+		break;
>+	}
>+
>+	return 0;
>+}
>+
>+static const struct bpf_func_proto *
>+bpf_smc_hs_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>+{
>+	return bpf_base_func_proto(func_id, prog);
>+}
>+
>+static const struct bpf_verifier_ops smc_bpf_verifier_ops = {
>+	.get_func_proto		= bpf_smc_hs_func_proto,
>+	.is_valid_access	= bpf_tracing_btf_ctx_access,
>+};
>+
>+static struct bpf_struct_ops bpf_smc_hs_ctrl_ops = {
>+	.name		= "smc_hs_ctrl",
>+	.init		= smc_bpf_hs_ctrl_init,
>+	.reg		= smc_bpf_hs_ctrl_reg,
>+	.unreg		= smc_bpf_hs_ctrl_unreg,
>+	.cfi_stubs	= &__smc_bpf_hs_ctrl,
>+	.verifier_ops	= &smc_bpf_verifier_ops,
>+	.init_member	= smc_bpf_hs_ctrl_init_member,
>+	.owner		= THIS_MODULE,
>+};
>+
>+int bpf_smc_hs_ctrl_init(void)
>+{
>+	return register_bpf_struct_ops(&bpf_smc_hs_ctrl_ops, smc_hs_ctrl);
>+}
>diff --git a/net/smc/smc_hs_bpf.h b/net/smc/smc_hs_bpf.h
>new file mode 100644
>index 000000000000..f5f1807c079e
>--- /dev/null
>+++ b/net/smc/smc_hs_bpf.h
>@@ -0,0 +1,31 @@
>+/* SPDX-License-Identifier: GPL-2.0 */
>+/*
>+ *  Shared Memory Communications over RDMA (SMC-R) and RoCE
>+ *
>+ *  Generic hook for SMC handshake flow.
>+ *
>+ *  Copyright IBM Corp. 2016
>+ *  Copyright (c) 2025, Alibaba Inc.
>+ *
>+ *  Author: D. Wythe <alibuda@linux.alibaba.com>
>+ */
>+
>+#ifndef __SMC_HS_CTRL
>+#define __SMC_HS_CTRL
>+
>+#include <net/smc.h>
>+
>+/* Find hs_ctrl by the target name, which required to be a c-string.
>+ * Return NULL if no such ctrl was found,otherwise, return a valid ctrl.
>+ *
>+ * Note: Caller MUST ensure it's was invoked under rcu_read_lock.
>+ */
>+struct smc_hs_ctrl *smc_hs_ctrl_find_by_name(const char *name);
>+
>+#if IS_ENABLED(CONFIG_SMC_HS_CTRL_BPF)
>+int bpf_smc_hs_ctrl_init(void);
>+#else
>+static inline int bpf_smc_hs_ctrl_init(void) { return 0; }
>+#endif /* CONFIG_SMC_HS_CTRL_BPF */
>+
>+#endif /* __SMC_HS_CTRL */
>diff --git a/net/smc/smc_sysctl.c b/net/smc/smc_sysctl.c
>index 2fab6456f765..918516734468 100644
>--- a/net/smc/smc_sysctl.c
>+++ b/net/smc/smc_sysctl.c
>@@ -12,12 +12,14 @@
> 
> #include <linux/init.h>
> #include <linux/sysctl.h>
>+#include <linux/bpf.h>
> #include <net/net_namespace.h>
> 
> #include "smc.h"
> #include "smc_core.h"
> #include "smc_llc.h"
> #include "smc_sysctl.h"
>+#include "smc_hs_bpf.h"
> 
> static int min_sndbuf = SMC_BUF_MIN_SIZE;
> static int min_rcvbuf = SMC_BUF_MIN_SIZE;
>@@ -30,6 +32,69 @@ static int links_per_lgr_max = SMC_LINKS_ADD_LNK_MAX;
> static int conns_per_lgr_min = SMC_CONN_PER_LGR_MIN;
> static int conns_per_lgr_max = SMC_CONN_PER_LGR_MAX;
> 
>+#if IS_ENABLED(CONFIG_SMC_HS_CTRL_BPF)
>+static int smc_net_replace_smc_hs_ctrl(struct net *net, const char *name)
>+{
>+	struct smc_hs_ctrl *ctrl = NULL;
>+
>+	rcu_read_lock();
>+	/* null or empty name ask to clear current ctrl */
>+	if (name && name[0]) {
>+		ctrl = smc_hs_ctrl_find_by_name(name);
>+		if (!ctrl) {
>+			rcu_read_unlock();
>+			return -EINVAL;
>+		}
>+		/* no change, just return */
>+		if (ctrl == rcu_dereference(net->smc.hs_ctrl)) {
>+			rcu_read_unlock();
>+			return 0;
>+		}
>+		if (!bpf_try_module_get(ctrl, ctrl->owner)) {
>+			rcu_read_unlock();
>+			return -EBUSY;
>+		}
>+	}
>+	/* xhcg old ctrl with the new one atomically */
>+	ctrl = unrcu_pointer(xchg(&net->smc.hs_ctrl, RCU_INITIALIZER(ctrl)));
>+	/* release old ctrl */
>+	if (ctrl)
>+		bpf_module_put(ctrl, ctrl->owner);
>+
>+	rcu_read_unlock();
>+	return 0;
>+}
>+
>+static int proc_smc_hs_ctrl(const struct ctl_table *ctl, int write,
>+			    void *buffer, size_t *lenp, loff_t *ppos)
>+{
>+	struct net *net = container_of(ctl->data, struct net, smc.hs_ctrl);
>+	char val[SMC_HS_CTRL_NAME_MAX];
>+	const struct ctl_table tbl = {
>+		.data = val,
>+		.maxlen = SMC_HS_CTRL_NAME_MAX,
>+	};
>+	struct smc_hs_ctrl *ctrl;
>+	int ret;
>+
>+	rcu_read_lock();
>+	ctrl = rcu_dereference(net->smc.hs_ctrl);
>+	if (ctrl)
>+		memcpy(val, ctrl->name, sizeof(ctrl->name));
>+	else
>+		val[0] = '\0';
>+	rcu_read_unlock();
>+
>+	ret = proc_dostring(&tbl, write, buffer, lenp, ppos);
>+	if (ret)
>+		return ret;
>+
>+	if (write)
>+		ret = smc_net_replace_smc_hs_ctrl(net, val);
>+	return ret;
>+}
>+#endif /* CONFIG_SMC_HS_CTRL_BPF */
>+
> static struct ctl_table smc_table[] = {
> 	{
> 		.procname       = "autocorking_size",
>@@ -99,6 +164,15 @@ static struct ctl_table smc_table[] = {
> 		.extra1		= SYSCTL_ZERO,
> 		.extra2		= SYSCTL_ONE,
> 	},
>+#if IS_ENABLED(CONFIG_SMC_HS_CTRL_BPF)
>+	{
>+		.procname	= "hs_ctrl",
>+		.data		= &init_net.smc.hs_ctrl,
>+		.mode		= 0644,
>+		.maxlen		= SMC_HS_CTRL_NAME_MAX,
>+		.proc_handler	= proc_smc_hs_ctrl,
>+	},
>+#endif /* CONFIG_SMC_HS_CTRL_BPF */
> };
> 
> int __net_init smc_sysctl_net_init(struct net *net)
>@@ -109,6 +183,16 @@ int __net_init smc_sysctl_net_init(struct net *net)
> 	table = smc_table;
> 	if (!net_eq(net, &init_net)) {
> 		int i;
>+#if IS_ENABLED(CONFIG_SMC_HS_CTRL_BPF)
>+		struct smc_hs_ctrl *ctrl;
>+
>+		rcu_read_lock();
>+		ctrl = rcu_dereference(init_net.smc.hs_ctrl);
>+		if (ctrl && ctrl->flags & SMC_HS_CTRL_FLAG_INHERITABLE &&
>+		    bpf_try_module_get(ctrl, ctrl->owner))
>+			rcu_assign_pointer(net->smc.hs_ctrl, ctrl);
>+		rcu_read_unlock();
>+#endif /* CONFIG_SMC_HS_CTRL_BPF */
> 
> 		table = kmemdup(table, sizeof(smc_table), GFP_KERNEL);
> 		if (!table)
>@@ -139,6 +223,9 @@ int __net_init smc_sysctl_net_init(struct net *net)
> 	if (!net_eq(net, &init_net))
> 		kfree(table);
> err_alloc:
>+#if IS_ENABLED(CONFIG_SMC_HS_CTRL_BPF)
>+	smc_net_replace_smc_hs_ctrl(net, NULL);
>+#endif /* CONFIG_SMC_HS_CTRL_BPF */
> 	return -ENOMEM;
> }
> 
>@@ -148,6 +235,10 @@ void __net_exit smc_sysctl_net_exit(struct net *net)
> 
> 	table = net->smc.smc_hdr->ctl_table_arg;
> 	unregister_net_sysctl_table(net->smc.smc_hdr);
>+#if IS_ENABLED(CONFIG_SMC_HS_CTRL_BPF)
>+	smc_net_replace_smc_hs_ctrl(net, NULL);
>+#endif /* CONFIG_SMC_HS_CTRL_BPF */
>+
> 	if (!net_eq(net, &init_net))
> 		kfree(table);
> }
>-- 
>2.45.0

