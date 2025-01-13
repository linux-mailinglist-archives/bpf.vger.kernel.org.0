Return-Path: <bpf+bounces-48678-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49276A0B60E
	for <lists+bpf@lfdr.de>; Mon, 13 Jan 2025 12:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAAEA7A244A
	for <lists+bpf@lfdr.de>; Mon, 13 Jan 2025 11:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42111FDA6B;
	Mon, 13 Jan 2025 11:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fkrzWApx"
X-Original-To: bpf@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9854B1B4154;
	Mon, 13 Jan 2025 11:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736768993; cv=none; b=eAsFCNvc1QFAzmFSQGWj91RBO7VOSluSz2zpxRx13e5n/FCOxImpa8HyMQj1iOxsuICAxQsMhLfNrIrNBwJRzirGTuLKAVqBZmINcsiFKIGpoxJFnyItjZyOUxNJ1mSHucxFr3AFgyM42wojHLIkrBqvEfoSJRseqOp2BQfEWEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736768993; c=relaxed/simple;
	bh=u/3TiRKpp8tpJXx8+txBRBPg+Fjpk1lHw0jz/n8kUag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TDeUGNMHoFoszz/Dg86qHkxsO2mUO5Akvn3cXB39XtFB7mvWdrkjm7zRxK88SMNpnhyvJxZp6l6xAvuCDQ1GgnHlXrX73wqyy+pn3sdiHh1BP3HHA837fFp+ehquz5GDGFR+aMhBlh8hfzuAvphk/MiVqugyzgG1ZzAqlZQlqzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fkrzWApx; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1736768987; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=Oi4ACboGMGTa1BXAPOx4mOpHd0ImIOeMSXF78X60dq4=;
	b=fkrzWApxJG2o3AqkMTK+3tTOcTBfE2dqGPKrAhTEXwq7QN+9hoRhu17gmaECAVGdtySJ2HoiJ5WzVe6QphbE/WEdfDYRnusatFCOn0WqO+FQw/ALbP+EarrZH49k81De/idXa6aqKO0/D1ilduGIOo+dhOoU3eOru8RWmiN2me8=
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0WNY6mku_1736768984 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 13 Jan 2025 19:49:45 +0800
Date: Mon, 13 Jan 2025 19:49:44 +0800
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
Subject: Re: [PATCH bpf-next v5 2/5] net/smc: Introduce generic hook smc_ops
Message-ID: <20250113114944.GB89233@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20250107041715.98342-1-alibuda@linux.alibaba.com>
 <20250107041715.98342-3-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107041715.98342-3-alibuda@linux.alibaba.com>

On 2025-01-07 12:17:12, D. Wythe wrote:
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
> include/net/smc.h       | 51 ++++++++++++++++++++++
> net/ipv4/tcp_output.c   | 15 +++++--
> net/smc/Kconfig         | 12 ++++++
> net/smc/Makefile        |  1 +
> net/smc/smc_ops.c       | 51 ++++++++++++++++++++++
> net/smc/smc_ops.h       | 25 +++++++++++
> net/smc/smc_sysctl.c    | 95 +++++++++++++++++++++++++++++++++++++++++
> 8 files changed, 249 insertions(+), 4 deletions(-)
> create mode 100644 net/smc/smc_ops.c
> create mode 100644 net/smc/smc_ops.h
>
>diff --git a/include/net/netns/smc.h b/include/net/netns/smc.h
>index fc752a50f91b..59d069f56b2d 100644
>--- a/include/net/netns/smc.h
>+++ b/include/net/netns/smc.h
>@@ -17,6 +17,9 @@ struct netns_smc {
> #ifdef CONFIG_SYSCTL
> 	struct ctl_table_header		*smc_hdr;
> #endif
>+#if IS_ENABLED(CONFIG_SMC_OPS)
>+	struct smc_ops __rcu *ops;
>+#endif /* CONFIG_SMC_OPS */
> 	unsigned int			sysctl_autocorking_size;
> 	unsigned int			sysctl_smcr_buf_type;
> 	int				sysctl_smcr_testlink_time;
>diff --git a/include/net/smc.h b/include/net/smc.h
>index db84e4e35080..326a217001d4 100644
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
>@@ -97,4 +99,53 @@ struct smcd_dev {
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

One more thing.
Can we call it smc_bpf_ops ? I think smc_ops is a bit ambiguous.
Same for smc_ops.h/c source file.

Best regards,
Dust

