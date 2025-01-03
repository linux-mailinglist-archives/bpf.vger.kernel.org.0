Return-Path: <bpf+bounces-47826-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D62F8A00492
	for <lists+bpf@lfdr.de>; Fri,  3 Jan 2025 07:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A1311883B31
	for <lists+bpf@lfdr.de>; Fri,  3 Jan 2025 06:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21AF1B3724;
	Fri,  3 Jan 2025 06:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="o3O0hx5z"
X-Original-To: bpf@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11ABF18E3F;
	Fri,  3 Jan 2025 06:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735887263; cv=none; b=Xryejvjr3RM9trfiEkw8WVmOs6S1t2tmmulqo9MR4ORAxWupczr3trvQDt+B+/p6suMJIAhaZug7ppL+TIzDwlETkAmNrlUXL8+h/LATziH5LvnkS3OqVGaY41G9IfM6+X4BgI5nJoUOwMvEWcL5KYNFS2SiSG1oU/hFvomRBjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735887263; c=relaxed/simple;
	bh=PJpgzKeezNgC+5hejlcAZIEUZi3MXPTqwoKcVqJHGak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rqg7EBQ8rRaoIBClH6qyXrRvmY1rg2qmxuXIEcPWiMz87hZMM+aVMdBGafP56dPCUlntZzAk3mkQK76SFQ2bbjecEpvM04a5Vkf9tuvV7vEz4U6IPYorHVdmMjzb0v14QPgUt8nuTEQCOEYjj8L/qhLZKrNqik5O+iVKGVg6RuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=o3O0hx5z; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1735887251; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=Z4LkRbGR3D2V2xL7xVxfuLn4xv2XaiQ/dik6t3ApoyA=;
	b=o3O0hx5z2dGFEA/LeAwT5NWQ8dx2by1r+oqkibQTs3TvO9P4Oh5Qr27TR8JI5W7LjvyxRsSUz5V8ezPioocGvLIAtSWcMZo/BCnb5ax645AiUrnFTGD1evTVhoX0Keh/w9BYBkAjC4Euo6nf4HVSC+E+2q8vtO3whlz1nRnux1s=
Received: from localhost(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WMsLtr9_1735887249 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 03 Jan 2025 14:54:09 +0800
Date: Fri, 3 Jan 2025 14:54:09 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com    >
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: "D. Wythe" <alibuda@linux.alibaba.com>, kgraul@linux.ibm.com,
	wenjia@linux.ibm.com, jaka@linux.ibm.com, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	pabeni@redhat.com, song@kernel.org, sdf@google.com,
	haoluo@google.com, yhs@fb.com, edumazet@google.com,
	john.fastabend@gmail.com, kpsingh@kernel.org, jolsa@kernel.org,
	guwen@linux.alibaba.com, kuba@kernel.org, davem@davemloft.net,
	netdev@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 3/5] net/smc: bpf: register smc_ops info
 struct_ops
Message-ID: <20250103065409.GA70746@j66a10360.sqa.eu95>
References: <20241218024422.23423-1-alibuda@linux.alibaba.com>
 <20241218024422.23423-4-alibuda@linux.alibaba.com>
 <525a2714-f8b0-4fdb-9cfb-d8a913c43c8e@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <525a2714-f8b0-4fdb-9cfb-d8a913c43c8e@linux.dev>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Thu, Dec 26, 2024 at 08:44:20PM +0100, Zhu Yanjun wrote:
> 在 2024/12/18 3:44, D. Wythe 写道:
> >To implement injection capability for smc via struct_ops, so that
> >user can make their own smc_ops to modify the behavior of smc stack.
> >
> >Currently, user can write their own implememtion to choose whether to
> >use SMC or not before TCP 3rd handshake to be comleted. In the future,
> >users can implement more complex functions on smc by expanding it.
> >
> >Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
> >---
> >  net/smc/af_smc.c  | 10 +++++
> >  net/smc/smc_ops.c | 99 +++++++++++++++++++++++++++++++++++++++++++++++
> >  net/smc/smc_ops.h |  2 +
> >  3 files changed, 111 insertions(+)
> >
> >diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> >index 9d76e902fd77..6adedae2986d 100644
> >--- a/net/smc/af_smc.c
> >+++ b/net/smc/af_smc.c
> >@@ -55,6 +55,7 @@
> >  #include "smc_sysctl.h"
> >  #include "smc_loopback.h"
> >  #include "smc_inet.h"
> >+static struct bpf_struct_ops bpf_smc_bpf_ops = {
> >  #else
> >  static inline struct smc_ops *smc_ops_find_by_name(const char *name) { return NULL; }
> >+static inline int smc_bpf_struct_ops_init(void) { return 0; }
> 
> Both smc_ops_find_by_name and smc_bpf_struct_ops_init seem to be
> dead codes. Enabling/Disabling CONFIG_SMC_OPS, the above 2 inline
> functions will not be called. The 2 functions should be removed.
> 
> Zhu Yanjun
> 

Good catch. I will fix this in the next version. 

Thanks,
D. Wythe

> >  #endif /* CONFIG_SMC_OPS*/
> >  #endif /* __SMC_OPS */

