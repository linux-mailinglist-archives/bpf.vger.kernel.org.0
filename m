Return-Path: <bpf+bounces-76693-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 272C1CC131D
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 07:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4963302A104
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 06:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649BC3358C5;
	Tue, 16 Dec 2025 06:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="I20jWGmy"
X-Original-To: bpf@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E1E33507E;
	Tue, 16 Dec 2025 06:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765867762; cv=none; b=G343QtTCJoKfB8SI5YaAEBfVrU0kw0B6Afo+sw8vk/rNTgjU5pkUPeEn5jmt6HYYJjPm9zIBAwLZ4qqekYZR013QRWExaZEcHUfyzOP+g5cGpITuc4PD7WimNwUPUys5mcgIldFmFhQQx/9FZnSsMOxJyjUfsbPrpd83uTYp15w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765867762; c=relaxed/simple;
	bh=y3LZTdWeXaDwOT7B5oB/IVXIdk2Wl/xRuoBAyExP6sQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MzdxnP/MeuhmdG+wgj3P6zfQJqO4BhsKvVreOkVoCxLl2g71R/EaNB/6PBFNjtCz4O1NaFOzg9TMA9smW+c9w1xXrhc0POX3/Ww8QMGOiXo4B8dL3eKhfMa8s0bSCLSiOnrhnYnOnmyD2JLybJxOvwXbGRjpGDPXvIFvVYDDBGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=I20jWGmy; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1765867746; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=eXww2wokBNIXVWI9Au+GOjuDg060gzlswGgY9Uw/cEM=;
	b=I20jWGmy79tozHEROVu3YdZdpKB27mRnWc522lpd2LY0ToW/1kSYU2SBeowI/2pt3JtuYhF5TEjaIzgfX1Dgac194TmsgfMKvYi4AvsT0VqpYVtsI2MAiD/OQlj/x4FeNNYeGv3Uc4zXq2/BEaX4S3HdylNHyxVJRtbzTxvY+ac=
Received: from localhost(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WuyA09c_1765867423 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 16 Dec 2025 14:43:43 +0800
Date: Tue, 16 Dec 2025 14:43:43 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com    >
To: Guenter Roeck <linux@roeck-us.net>
Cc: "D. Wythe" <alibuda@linux.alibaba.com>, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	pabeni@redhat.com, song@kernel.org, sdf@google.com,
	haoluo@google.com, yhs@fb.com, edumazet@google.com,
	john.fastabend@gmail.com, kpsingh@kernel.org, jolsa@kernel.org,
	mjambigi@linux.ibm.com, wenjia@linux.ibm.com, wintera@linux.ibm.com,
	dust.li@linux.alibaba.com, tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com, bpf@vger.kernel.org, davem@davemloft.net,
	kuba@kernel.org, netdev@vger.kernel.org, sidraya@linux.ibm.com,
	jaka@linux.ibm.com
Subject: Re: [PATCH bpf-next v5 2/3] net/smc: bpf: Introduce generic hook for
 handshake flow
Message-ID: <20251216064343.GA12661@j66a10360.sqa.eu95>
References: <20251107035632.115950-1-alibuda@linux.alibaba.com>
 <20251107035632.115950-3-alibuda@linux.alibaba.com>
 <3a0d2f44-6f1c-4f79-b8cb-f57387933a5a@roeck-us.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a0d2f44-6f1c-4f79-b8cb-f57387933a5a@roeck-us.net>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Thu, Dec 04, 2025 at 08:16:46PM -0800, Guenter Roeck wrote:
> On Fri, Nov 07, 2025 at 11:56:31AM +0800, D. Wythe wrote:
> > The introduction of IPPROTO_SMC enables eBPF programs to determine
> > whether to use SMC based on the context of socket creation, such as
> > network namespaces, PID and comm name, etc.
> > 
> > As a subsequent enhancement, to introduce a new generic hook that
> > allows decisions on whether to use SMC or not at runtime, including
> > but not limited to local/remote IP address or ports.
> > 
> > User can write their own implememtion via bpf_struct_ops now to choose
> > whether to use SMC or not before TCP 3rd handshake to be comleted.
> 
> Building csky:allmodconfig ... failed
> --------------
> Error log:
> In file included from include/linux/bpf_verifier.h:7,
>                  from net/smc/smc_hs_bpf.c:13:
> net/smc/smc_hs_bpf.c: In function 'bpf_smc_hs_ctrl_init':
> include/linux/bpf.h:2068:50: error: statement with no effect [-Werror=unused-value]
>  2068 | #define register_bpf_struct_ops(st_ops, type) ({ (void *)(st_ops); 0; })
>       |                                                  ^~~~~~~~~~~~~~~~
> net/smc/smc_hs_bpf.c:139:16: note: in expansion of macro 'register_bpf_struct_ops'
>   139 |         return register_bpf_struct_ops(&bpf_smc_hs_ctrl_ops, smc_hs_ctrl);
> 
> Should this have been
> 
> 	return register_bpf_struct_ops(&bpf_smc_hs_ctrl_ops, smc_hs_ctrl_ops);
> 									^^^^
> ?
> 
> Guenter

Hi Guenter,

This looks like a known build failure with -Werror=unused-value caused by register_bpf_struct_ops()
on some configs.

It should be fixed by Geert's patch:
https://lore.kernel.org/netdev/ead27aa92275c71c1fcd148f88ca6926a524f322.1764843951.git.geert@linux-m68k.org/


