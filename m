Return-Path: <bpf+bounces-49048-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7D4A139E0
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 13:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74668188AE9B
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 12:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E3D1DE88A;
	Thu, 16 Jan 2025 12:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="aBbdOx0G"
X-Original-To: bpf@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0DB1DE4D4;
	Thu, 16 Jan 2025 12:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737030193; cv=none; b=XxzFmYw8kXskbEVsZfAp4StUD62X6nDl/kmg7Y0MgIR+oKzw6TKlFfuq2EOwcxQBilqQxdlNppzdHM/AXCEMdIlIUTWQRrQ080HlVyKflMYBjn4WbG1d5Wf2PgQfM3ovz4tmzh4uvInbJlC5RoI6l0t9Z4zKcKJT+eLL/Dwq8Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737030193; c=relaxed/simple;
	bh=DHqEvLwf3HDkS2JVIwmCrqfeDQIkB8B3EbXIvh3PJ8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jTUmeOX+Q3Oe4YoQ+5+XASb2HUZ8DgjecY/CkLe3lb4S2SQYYl4MfLj5rd6LNa/piutsA70HQVXOEltrylRFhWom21PbLzW6QZ5GWRMmtiAuHXbSmywFREIfPRcKMrsZVtd4HtaaVAZ5zdiJljdEj5DCMviuv0Dk3r7tsVxoDOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=aBbdOx0G; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1737030181; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=z/2X4QCJz0+PjyBqoo8pjyWfSn+lHxhP2Hw0xitx+xw=;
	b=aBbdOx0GBWv0xqNbiQwOCdBdCoX7wngQbPTG8guLWzkYLFE0NLORM3BXK6GJE2Zu7UCdzw6OMMpw7YXoOOIdRlCYHicTQVcl9yqM50YBkq0oyxE8ucKfOMiVXE1MYjrbR0xf09kbLtrUK0ZCwXymIr9qy87SZ9e3OLAYyX99j3s=
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0WNlhgBZ_1737030179 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 16 Jan 2025 20:23:00 +0800
Date: Thu, 16 Jan 2025 20:22:59 +0800
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
Subject: Re: [PATCH bpf-next v6 2/5] net/smc: Introduce generic hook smc_ops
Message-ID: <20250116122259.GE89233@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20250116074442.79304-1-alibuda@linux.alibaba.com>
 <20250116074442.79304-3-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116074442.79304-3-alibuda@linux.alibaba.com>

On 2025-01-16 15:44:39, D. Wythe wrote:
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
> include/net/smc.h       | 53 +++++++++++++++++++++++
> net/ipv4/tcp_output.c   | 18 ++++++--
> net/smc/Kconfig         | 12 ++++++
> net/smc/Makefile        |  1 +
> net/smc/smc_ops.c       | 53 +++++++++++++++++++++++
> net/smc/smc_ops.h       | 28 ++++++++++++
> net/smc/smc_sysctl.c    | 94 +++++++++++++++++++++++++++++++++++++++++
> 8 files changed, 258 insertions(+), 4 deletions(-)
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
>index db84e4e35080..271838591b63 100644
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
>+	!!__ret;					\
>+})

Here you force the return value to be bool by !!ret, what if the
future caller expects the return value to be an integer or other types ?

Best regards,
Dust


