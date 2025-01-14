Return-Path: <bpf+bounces-48747-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D196A10377
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 10:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 201D518896DC
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 09:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBEE1ADC94;
	Tue, 14 Jan 2025 09:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="o3f9nXid"
X-Original-To: bpf@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9AF1ADC73;
	Tue, 14 Jan 2025 09:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736848633; cv=none; b=nOsC4lO0T7bV4PneOLiAgWnPe4HrxKU/5TbnZKMsmvMDObmroUF6OhrMza0/5xzUPwczqTApNW4wHk1C1kOOaAQEZ8Hszz3rEoq1hRrwgGNuSzHU9vR72E6DlE1AKrpjoqmtFSXPPZkyiybmMV7Ev7XfvcC2r7ncAAcnrzUlyPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736848633; c=relaxed/simple;
	bh=p2S7cQjHwtKfXhux3t3TqEpA73IACmKf3QU7Jnt5v3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=geZ6N6Lr75BcPDCkm7aTPcK4JQfq89cbmpY2+x1HhOWHdmtYlkakvWeFucBe4DYBnLe/4IG5FsSZ1ohgaxODp5joV3Md149mOwq8ifhstQV/mQwVxFcbFza9X4hoHLfKMqUkXHZ+fpfOyTaC5BdEMy+WdLcWy+66Mau9BGDSQyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=o3f9nXid; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1736848621; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=iNcP2KCOX9JtWeJDFiPz7AMgXEFC4KxUVa/PMlGFmbs=;
	b=o3f9nXidq61dcOlOV5YzbkcyWvSKvPj0w4pLh7wVZ6mVLbP89n57IVFcd5nT4dt/kkAh7oWL9qxDEboCPsr75DxqzP4Dch/Rdnd71cGS+uDS8Wf86DXpHjrjvFVZNBAxCf2ZptEfFj9eLXO9pCIeodejMUXeQGQkb+NsnhrFkVM=
Received: from localhost(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WNevIV4_1736848295 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 14 Jan 2025 17:51:36 +0800
Date: Tue, 14 Jan 2025 17:51:35 +0800
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
Message-ID: <20250114095135.GB16797@j66a10360.sqa.eu95>
References: <20250107041715.98342-1-alibuda@linux.alibaba.com>
 <20250107041715.98342-3-alibuda@linux.alibaba.com>
 <20250113114944.GB89233@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113114944.GB89233@linux.alibaba.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Jan 13, 2025 at 07:49:44PM +0800, Dust Li wrote:
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
> >+
> >+struct smc_ops {
> 
> One more thing.
> Can we call it smc_bpf_ops ? I think smc_ops is a bit ambiguous.
> Same for smc_ops.h/c source file.

I don't think smc_bpf_ops is a good idea. BPF is just a way to implement
smc_ops. Similarly, we can also implement this ops within the kernel module,
just like tcp_congestion_ops dose. If you think this is ambiguous, perhaps
we can call it as smc_handshake_ops ? This should eliminate the ambiguity.

Best wishes,
D. Wythe
> 
> Best regards,
> Dust

