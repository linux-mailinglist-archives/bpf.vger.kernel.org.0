Return-Path: <bpf+bounces-49562-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0577A19EF9
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 08:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D0423ADB57
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 07:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E248020B7EF;
	Thu, 23 Jan 2025 07:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="hTKXjDao"
X-Original-To: bpf@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3BD179A7;
	Thu, 23 Jan 2025 07:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737617444; cv=none; b=CDWAB6qHXOYWbHg3P8DnGQw1WwbOQ+VbGsayyh8rf9x0GatxpqBf9xSG5b2tO9ju18EnEFSAcra1RNQDQt5d8Zq0jq9tbYUZlzDT+RQJeAX8XU3lw4z6DJxSzm33HRLDN2/17lQ6uk9jFjs+V1+WqUrMoYVyvy1qOPvRJy8X5U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737617444; c=relaxed/simple;
	bh=4ROXU4dEmh4RWYEx61AVGXA3fTQl3Te7sC7Nvi9QyjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nPYrMHAySYSraqdsDKLV06jimDnNPtK4TfxCDKAGQcyVyJS2sasjrPBndKhbqazUgqSJTQwDWA4vu16kqIwx225CVtQZLflgRd7WY6OVEurxc1jGvjHRN8sQwxxo1tw+VBg4RU40J+dnezKsy5RPVa/kzPjQcNktLY2WKXye2gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=hTKXjDao; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1737617437; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=5xdXtIDyunNbrMxr9UPFYnb5dTDyDfY6SdpFGFKJ/88=;
	b=hTKXjDaoI+NDi1O61RQCZkOSI/eQuMZdjO5EKUq3FFcwoD8DTquU3d5pdWsuQIw/s5g+TEcF+jPNf6cQoAytVa6BLlAwsZmbCM5ucC2R1KsdmInc7pB9bLul2X8AWtinj/pvfsQHLMuu9cpKDa5QBLVYCPSXNWYJVhuCvSCvb68=
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0WOB-.T3_1737617434 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 23 Jan 2025 15:30:35 +0800
Date: Thu, 23 Jan 2025 15:30:34 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: "D. Wythe" <alibuda@linux.alibaba.com>, kgraul@linux.ibm.com,
	wenjia@linux.ibm.com, jaka@linux.ibm.com, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	pabeni@redhat.com, song@kernel.org, sdf@google.com,
	haoluo@google.com, yhs@fb.com, edumazet@google.com,
	john.fastabend@gmail.com, kpsingh@kernel.org, jolsa@kernel.org,
	guwen@linux.alibaba.com
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v7 3/6] net/smc: Introduce generic hook smc_ops
Message-ID: <20250123073034.GQ89233@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20250123015942.94810-1-alibuda@linux.alibaba.com>
 <20250123015942.94810-4-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250123015942.94810-4-alibuda@linux.alibaba.com>

On 2025-01-23 09:59:39, D. Wythe wrote:
>The introduction of IPPROTO_SMC enables eBPF programs to determine
>whether to use SMC based on the context of socket creation, such as
>network namespaces, PID and comm name, etc.
>
>As a subsequent enhancement, to introduce a new generic hook that
>allows decisions on whether to use SMC or not at runtime, including
>but not limited to local/remote IP address or ports.
>
>Moreover, in the future, we can achieve more complex extensions to the
>protocol stack by extending this ops.
>
>Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
>---
> include/net/netns/smc.h |  3 ++
> include/net/smc.h       | 53 ++++++++++++++++++++++++
> net/ipv4/tcp_output.c   | 18 +++++++--
> net/smc/Kconfig         | 12 ++++++
> net/smc/Makefile        |  1 +
> net/smc/smc_ops.c       | 53 ++++++++++++++++++++++++
> net/smc/smc_ops.h       | 28 +++++++++++++
> net/smc/smc_sysctl.c    | 90 +++++++++++++++++++++++++++++++++++++++++
> 8 files changed, 254 insertions(+), 4 deletions(-)
> create mode 100644 net/smc/smc_ops.c
> create mode 100644 net/smc/smc_ops.h
>
>diff --git a/include/net/netns/smc.h b/include/net/netns/smc.h
>index fc752a50f91b..81b3fdb39cd2 100644
>--- a/include/net/netns/smc.h
>+++ b/include/net/netns/smc.h
>@@ -17,6 +17,9 @@ struct netns_smc {
> #ifdef CONFIG_SYSCTL
> 	struct ctl_table_header		*smc_hdr;
> #endif
>+#if IS_ENABLED(CONFIG_SMC_OPS)
>+	struct smc_ops __rcu		*ops;
>+#endif /* CONFIG_SMC_OPS */
> 	unsigned int			sysctl_autocorking_size;
> 	unsigned int			sysctl_smcr_buf_type;
> 	int				sysctl_smcr_testlink_time;
>diff --git a/include/net/smc.h b/include/net/smc.h
>index db84e4e35080..844f98a6296a 100644
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
>+#define  SMC_OPS_NAME_MAX 16
>+
>+enum {
>+	/* ops can be inherit from init_net */
>+	SMC_OPS_FLAG_INHERITABLE = 0x1,
>+
>+	SMC_OPS_ALL_FLAGS = SMC_OPS_FLAG_INHERITABLE,
>+};
>+
>+struct smc_ops {
>+	/* priavte */
>+
>+	struct list_head list;
>+	struct module *owner;
>+
>+	/* public */
>+
>+	/* unique name */
>+	char name[SMC_OPS_NAME_MAX];
>+	int flags;
>+
>+	/* Invoked before computing SMC option for SYN packets.
>+	 * We can control whether to set SMC options by returning varios value.
>+	 * Return 0 to disable SMC, or return any other value to enable it.
>+	 */
>+	int (*set_option)(struct tcp_sock *tp);
>+
>+	/* Invoked before Set up SMC options for SYN-ACK packets
>+	 * We can control whether to respond SMC options by returning varios
>+	 * value. Return 0 to disable SMC, or return any other value to enable
>+	 * it.
>+	 */
>+	int (*set_option_cond)(const struct tcp_sock *tp,
>+			       struct inet_request_sock *ireq);
>+};
>+
>+#if IS_ENABLED(CONFIG_SMC_OPS)
>+#define smc_call_retops(init_val, sk, func, ...) ({	\
>+	typeof(init_val) __ret = (init_val);		\
>+	struct smc_ops *ops;				\
>+	rcu_read_lock();				\
>+	ops = READ_ONCE(sock_net(sk)->smc.ops);		\
>+	if (ops && ops->func)				\
>+		__ret = ops->func(__VA_ARGS__);		\
>+	rcu_read_unlock();				\
>+	__ret;						\
>+})
>+#else
>+#define smc_call_retops(init_val, ...) (init_val)
>+#endif /* CONFIG_SMC_OPS */
>+
> #endif	/* _SMC_H */
>diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
>index 0e5b9a654254..f62e30b4ffc8 100644
>--- a/net/ipv4/tcp_output.c
>+++ b/net/ipv4/tcp_output.c
>@@ -40,6 +40,7 @@
> #include <net/tcp.h>
> #include <net/mptcp.h>
> #include <net/proto_memory.h>
>+#include <net/smc.h>
> 
> #include <linux/compiler.h>
> #include <linux/gfp.h>
>@@ -759,14 +760,18 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
> 	mptcp_options_write(th, ptr, tp, opts);
> }
> 
>-static void smc_set_option(const struct tcp_sock *tp,
>+static void smc_set_option(struct tcp_sock *tp,
> 			   struct tcp_out_options *opts,
> 			   unsigned int *remaining)
> {
> #if IS_ENABLED(CONFIG_SMC)
>+	struct sock *sk = &tp->inet_conn.icsk_inet.sk;
> 	if (static_branch_unlikely(&tcp_have_smc)) {
> 		if (tp->syn_smc) {
>-			if (*remaining >= TCPOLEN_EXP_SMC_BASE_ALIGNED) {
>+			tp->syn_smc = !!smc_call_retops(1, sk, set_option, tp);
>+			/* re-check syn_smc */
>+			if (tp->syn_smc &&
>+			    *remaining >= TCPOLEN_EXP_SMC_BASE_ALIGNED) {
> 				opts->options |= OPTION_SMC;
> 				*remaining -= TCPOLEN_EXP_SMC_BASE_ALIGNED;
> 			}
>@@ -776,14 +781,19 @@ static void smc_set_option(const struct tcp_sock *tp,
> }
> 
> static void smc_set_option_cond(const struct tcp_sock *tp,
>-				const struct inet_request_sock *ireq,
>+				struct inet_request_sock *ireq,
> 				struct tcp_out_options *opts,
> 				unsigned int *remaining)
> {
> #if IS_ENABLED(CONFIG_SMC)
>+	const struct sock *sk = &tp->inet_conn.icsk_inet.sk;
> 	if (static_branch_unlikely(&tcp_have_smc)) {
> 		if (tp->syn_smc && ireq->smc_ok) {
>-			if (*remaining >= TCPOLEN_EXP_SMC_BASE_ALIGNED) {
>+			ireq->smc_ok = !!smc_call_retops(1, sk, set_option_cond,
>+							 tp, ireq);
>+			/* re-check smc_ok */
>+			if (ireq->smc_ok &&
>+			    *remaining >= TCPOLEN_EXP_SMC_BASE_ALIGNED) {
> 				opts->options |= OPTION_SMC;
> 				*remaining -= TCPOLEN_EXP_SMC_BASE_ALIGNED;
> 			}
>diff --git a/net/smc/Kconfig b/net/smc/Kconfig
>index ba5e6a2dd2fd..27f35064d04c 100644
>--- a/net/smc/Kconfig
>+++ b/net/smc/Kconfig
>@@ -33,3 +33,15 @@ config SMC_LO
> 	  of architecture or hardware.
> 
> 	  if unsure, say N.
>+
>+config SMC_OPS
>+	bool "Generic hook for SMC subsystem"
>+	depends on SMC && BPF_SYSCALL
>+	default n
>+	help
>+	  SMC_OPS enables support to register generic hook via eBPF programs
>+	  for SMC subsystem. eBPF programs offer much greater flexibility
>+	  in modifying the behavior of the SMC protocol stack compared
>+	  to a complete kernel-based approach.
>+
>+	  if unsure, say N.

I'm still not completely satisfied with the name smc_ops. Since this
will be the API for our users, we need to be carefull on the name.

It seems like you're aiming to define a common set of operations, but
the implementation appears to be intertwined with BPF. If this is
intended to be a common interface, and if we are using another operation,
there shouldn’t be a need to hold a BPF reference.

As your 'help' sugguest, What about smc_hook ?

Best regards,
Dust


