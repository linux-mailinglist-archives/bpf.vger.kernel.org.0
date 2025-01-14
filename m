Return-Path: <bpf+bounces-48745-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 675E3A10334
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 10:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 835C0169AA3
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 09:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE365284A70;
	Tue, 14 Jan 2025 09:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="LVs3hZSt"
X-Original-To: bpf@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C816222DC5D;
	Tue, 14 Jan 2025 09:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736847771; cv=none; b=ICQF2rc1sug5Ngaj1hIWX9JeMsm8KdB4GuRD11N7So04WM++6ttg3m81ZJBWC5DOPmZiOpSobJejieEHaVWgUnOFigrx8dqSpd5GeUMXocISbq8VAM1FlxCmOgWdeFJ88miGfMO7NYD6mNcwxBZ1M8XyZgXQd9fJhN2CX5Nsv3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736847771; c=relaxed/simple;
	bh=e0AeRqcZC6UTkXSXB+7J3el6G/TWf/N1r1efmp5N3Ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WNr1dVf4oLmMiCtC+eq3BlQv/fm4qsLPBLS/HK+FE1xfLjgSFS27z/O7C65VF0nTggmYRiDmkgeK0Jr1urCaHhezpYRqm1B6pYeX+inLMW/U15iBvL2c40fM+PFbouof1x0uKKPhf8SWDyNBARxvqtKrvvBSF9BTziYTgDOYunI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=LVs3hZSt; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1736847759; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=e2z48qYUWaAsXb8lvSCZWYYp4FEVgaH7KLyqNgEE7L8=;
	b=LVs3hZStvdgXY1aEcj0PmThcLI0srnDXtVMCaUpyjYduqQR4lSXBNWJE+c94CgnNp/VlP+/uw6qB9ugCaUPAGCphq0RXZkBXnYx2HmgfJsl5ZY6Rk5ChC9qSII00XLcFMHm6c5dVnPI2E+9m2mjIgGCqtNhtGFX5ftmIdv/+wfI=
Received: from localhost(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WNeswtl_1736847756 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 14 Jan 2025 17:42:37 +0800
Date: Tue, 14 Jan 2025 17:42:36 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com    >
To: Dust Li <dust.li@linux.alibaba.com>
Cc: "D. Wythe" <alibuda@linux.alibaba.com>, kgraul@linux.ibm.com,
	wenjia@linux.ibm.com, jaka@linux.ibm.com, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	pabeni@redhat.com, song@kernel.org, sdf@google.com,
	haoluo@google.com, yhs@fb.com, edumazet@google.com,
	john.fastabend@gmail.com, kpsingh@kernel.org, jolsa@kernel.org,
	guwen@linux.alibaba.com, kuba@kernel.org, davem@davemloft.net,
	netdev@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v5 2/5] net/smc: Introduce generic hook smc_ops
Message-ID: <20250114094236.GA16797@j66a10360.sqa.eu95>
References: <20250107041715.98342-1-alibuda@linux.alibaba.com>
 <20250107041715.98342-3-alibuda@linux.alibaba.com>
 <20250113114012.GA89233@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113114012.GA89233@linux.alibaba.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Jan 13, 2025 at 07:40:12PM +0800, Dust Li wrote:
> On 2025-01-07 12:17:12, D. Wythe wrote:
> >The introduction of IPPROTO_SMC enables eBPF programs to determine
> >whether to use SMC based on the context of socket creation, such as
> >network namespaces, PID and comm name, etc.
> >
> >As a subsequent enhancement, to introduce a new generic hook that
> >allows decisions on whether to use SMC or not at runtime, including
> >but not limited to local/remote IP address or ports.
> >
> >Moreover, in the future, we can achieve more complex extensions to the
> >protocol stack by extending this ops.
> >
> >Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
> >---
> > include/net/netns/smc.h |  3 ++
> > include/net/smc.h       | 51 ++++++++++++++++++++++
> > net/ipv4/tcp_output.c   | 15 +++++--
> > net/smc/Kconfig         | 12 ++++++
> > net/smc/Makefile        |  1 +
> > net/smc/smc_ops.c       | 51 ++++++++++++++++++++++
> > net/smc/smc_ops.h       | 25 +++++++++++
> > net/smc/smc_sysctl.c    | 95 +++++++++++++++++++++++++++++++++++++++++
> > 8 files changed, 249 insertions(+), 4 deletions(-)
> > create mode 100644 net/smc/smc_ops.c
> > create mode 100644 net/smc/smc_ops.h
> >
> >diff --git a/include/net/netns/smc.h b/include/net/netns/smc.h
> >index fc752a50f91b..59d069f56b2d 100644
> >--- a/include/net/netns/smc.h
> >+++ b/include/net/netns/smc.h
> >@@ -17,6 +17,9 @@ struct netns_smc {
> > #ifdef CONFIG_SYSCTL
> > 	struct ctl_table_header		*smc_hdr;
> > #endif
> >+#if IS_ENABLED(CONFIG_SMC_OPS)
> >+	struct smc_ops __rcu *ops;
>                               ^^^
> Align with other fields
> 
Oops, nice catch.
> >+#endif /* CONFIG_SMC_OPS */
> > 	unsigned int			sysctl_autocorking_size;
> > 	unsigned int			sysctl_smcr_buf_type;
> > 	int				sysctl_smcr_testlink_time;
> >diff --git a/include/net/smc.h b/include/net/smc.h
> >index db84e4e35080..326a217001d4 100644
> >--- a/include/net/smc.h
> >+++ b/include/net/smc.h
> >+#include <net/smc.h>
> 
> Put this include right after #include <net/proto_memory.h> ?
> I notice all the includes here are well classified.
> 
> 
Done, I didn't notice this detail before.
> > 
> > /* Refresh clocks of a TCP socket,
> >  * ensuring monotically increasing values.
> >@@ -759,14 +760,17 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
> > 	mptcp_options_write(th, ptr, tp, opts);
> > }
> > 
> >-static void smc_set_option(const struct tcp_sock *tp,
> >+static void smc_set_option(struct tcp_sock *tp,
> > 			   struct tcp_out_options *opts,
> > 			   unsigned int *remaining)
> > {
> >+	  SMC_OPS enables support to register genericfor hook via eBPF programs
> 
> genericfor ?
> 
generic.. I will fix it in next version. 
> >+	  for SMC subsystem. eBPF programs offer much greater flexibility
> >+	  in modifying the behavior of the SMC protocol stack compared
> >+	  to a complete kernel-based approach.
> >+
> >+	  if unsure, say N.
> >diff --git a/net/smc/Makefile b/net/smc/Makefile
> >index 60f1c87d5212..5dd706b2927a 100644
> >--- a/net/smc/Makefile
> >+++ b/net/smc/Makefile
> >+	struct net *net = container_of(ctl->data, struct net,
> >+				       smc.ops);
> 
> This line won't exceed 80 characters, no need to split into 2 lines.
> 
Take it. Thanks for all the advices.

Best wishes,
D. Wythe

> 
> Best regards,
> Dust

