Return-Path: <bpf+bounces-72526-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 091B9C1491D
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 13:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2167A1AA4DB5
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 12:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0910A32B9A5;
	Tue, 28 Oct 2025 12:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="S1JVJxV/"
X-Original-To: bpf@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A8E3090F1;
	Tue, 28 Oct 2025 12:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761653744; cv=none; b=tbi9kc1HD6+iTUTkJ6cNv+JY/p/68JFtRjhwrS/0j7k1zNwonu5JcFeYP/+AdxuVeFV6NudM9v8eCSu/Qx0MbgZU2xdnG+JLHr7rxI8OsMZd5IPsYXpqQPpJyT4B1EN/yaUAi+zub9LH1ke/umrSGfbH9Nxodf3Kx0F6JhjovaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761653744; c=relaxed/simple;
	bh=ZGANUuUM1Ta5jSsaWQ1AP4sTctgoxZB4uBLp2dgy3Nk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oB5hoTT0mo/jNK+wfG+0aYfjIhrAn4/Tb393ARaOMOgMwvr8hbgQn7xTGIQvA0z1wDfoxNKyOyQSi53qoriaCo255pez86AjX7ltukKoSI6rzfZaCyaj2xntam+h4fRzF7rVEuMgt/HZODM+7wx1ny3ZOn0vPk2Fs9XXp76X9Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=S1JVJxV/; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761653733; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=5+s5aiR2bzoPUL8wi4Dwm6Sd2km5LFKo9GoEvip3NMs=;
	b=S1JVJxV/+/QwQg8fsKfuVELjlR+sssL4wFTU9o4rKg+Q7kIqeuN6EQiCVMuNzZpKq1934pQybNlXF6Xzjt2ZAvYC/n1eJPtzE8R+UERfcI0Lx1yjEiD43kxK+gEnYNQENvUNzjb126/QPl/Ue/NyjtMP2dqKwYqsvFc5W+CF02w=
Received: from localhost(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WrBwBVw_1761653731 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 28 Oct 2025 20:15:31 +0800
Date: Tue, 28 Oct 2025 20:15:31 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com    >
To: "D. Wythe" <alibuda@linux.alibaba.com>, martin.lau@linux.de,
	ast@kernel.org, andrii.nakryiko@gmail.com
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, pabeni@redhat.com, song@kernel.org,
	sdf@google.com, haoluo@google.com, yhs@fb.com, edumazet@google.com,
	john.fastabend@gmail.com, kpsingh@kernel.org, jolsa@kernel.org,
	mjambigi@linux.ibm.com, wenjia@linux.ibm.com, wintera@linux.ibm.com,
	dust.li@linux.alibaba.com, tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com, bpf@vger.kernel.org, davem@davemloft.net,
	kuba@kernel.org, netdev@vger.kernel.org, sidraya@linux.ibm.com,
	jaka@linux.ibm.com
Subject: Re: [PATCH bpf-next v3 0/3] net/smc: Introduce smc_hs_ctrl
Message-ID: <20251028121531.GA51645@j66a10360.sqa.eu95>
References: <20250929063400.37939-1-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929063400.37939-1-alibuda@linux.alibaba.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Sep 29, 2025 at 02:33:57PM +0800, D. Wythe wrote:
> This patch aims to introduce BPF injection capabilities for SMC and
> includes a self-test to ensure code stability.
> 
> Since the SMC protocol isn't ideal for every situation, especially
> short-lived ones, most applications can't guarantee the absence of
> such scenarios. Consequently, applications may need specific strategies
> to decide whether to use SMC. For example, an application might limit SMC
> usage to certain IP addresses or ports.
> 
> To maintain the principle of transparent replacement, we want applications
> to remain unaffected even if they need specific SMC strategies. In other
> words, they should not require recompilation of their code.
> 
> Additionally, we need to ensure the scalability of strategy implementation.
> While using socket options or sysctl might be straightforward, it could
> complicate future expansions.
> 
> Fortunately, BPF addresses these concerns effectively. Users can write
> their own strategies in eBPF to determine whether to use SMC, and they can
> easily modify those strategies in the future.
> 
> This is a rework of the series from [1]. Changes since [1] are limited to
> the SMC parts:
> 
> 1. Rename smc_ops to smc_hs_ctrl and change interface name.
> 2. Squash SMC patches, removing standalone non-BPF hook capability.
> 3. Fix typos


Hi bpf folks,

I've noticed this patch has been pending for a while, and I wanted to
gently check in. Is there any specific concerns or feedback regarding
it from the BPF side? I'm keen to address any issues and move it
forward.

Also, I'd appreciate your guidance on whether this patch should be
targeted for net-next.

Thanks for your time and consideration.

Best regards,
D. Wythe

