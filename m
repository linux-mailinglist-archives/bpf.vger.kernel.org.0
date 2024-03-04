Return-Path: <bpf+bounces-23285-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C1286FE34
	for <lists+bpf@lfdr.de>; Mon,  4 Mar 2024 11:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 097E01F21DF3
	for <lists+bpf@lfdr.de>; Mon,  4 Mar 2024 10:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E5F22331;
	Mon,  4 Mar 2024 10:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qpYqK3pV"
X-Original-To: bpf@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9306819BA6
	for <bpf@vger.kernel.org>; Mon,  4 Mar 2024 09:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709546399; cv=none; b=T5lB3lmRGE+Dfup2lZ5a+0gHT7Kfe94Md4hIKJHF0kFBoYna+5ZfXHJvqjaM/FBAp+gx8YmB5Y2WCk5b96qQhrcO0qB0qJCFtpNWHpps5y0dCb8vw8LNImzqMadi98WRLhmHUBy48SIbNHK23MP010EZBe2e6dm4YrVQfraMNBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709546399; c=relaxed/simple;
	bh=jrb7GoyzDhGPvE0IQ31uOGs4AjzNa1kzFLZs937xyJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tOxC8AxFBzKGv7q680Kw8jNt5ZzoP27pIkzjF9b16mu/6dwPbfNjinEETMEk5IAdHG9HisNIY92fwe+px+nyAnvPGkN9lz/m/2fC2ZNKZhs3DUGPN4ceofSJQ/PgTQmSYLsntvW04TbV6FqTSFDaYmYdPv5RSRODeK4JGCNfJ5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qpYqK3pV; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709546388; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=jrb7GoyzDhGPvE0IQ31uOGs4AjzNa1kzFLZs937xyJs=;
	b=qpYqK3pVA7sYBBJPiKAeMA0tGpmdN2nZ5pEDAlUKB9m/tk1QwLUInYO0g4jnCYmgQ8h87fhk7zqNFkspAi1oXHnNbRu8xyxqcACHk+WbxUVQrY4QZ+vksih9SGHY7EljUOoZT7/0J3tGDBzuhum9Jd+cnHXCLdO6TTK1a/F7i3A=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W1nQWjE_1709546387;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0W1nQWjE_1709546387)
          by smtp.aliyun-inc.com;
          Mon, 04 Mar 2024 17:59:48 +0800
Date: Mon, 4 Mar 2024 17:59:47 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: Cong Wang <xiyou.wangcong@gmail.com>, lsf-pc@lists.linux-foundation.org
Cc: bpf <bpf@vger.kernel.org>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"a.mehrab@bytedance.com" <a.mehrab@bytedance.com>
Subject: Re: [LSF/MM/BPF TOPIC] Inter-VM Shared Memory Communications with
 eBPF
Message-ID: <20240304095947.GB123222@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <CAM_iQpXzAYFES62Cbj8PoGqr_OW=R+Y-ac=6s3kmp5373R7RzQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM_iQpXzAYFES62Cbj8PoGqr_OW=R+Y-ac=6s3kmp5373R7RzQ@mail.gmail.com>

On Fri, Feb 23, 2024 at 03:05:59PM -0800, Cong Wang wrote:

Hi Cong,

This is a good topic !
We have proposed another solution to accelerate Inter-VM tcp/ip communication
transparently within the same host based on SMC-D + virtio-ism
https://lists.oasis-open.org/archives/virtio-comment/202212/msg00030.html

I don't know, can we do better with your proposal ?

Best regards,
Dust


>Hi, all
>
>We would like to discuss our inter-VM shared memory communications
>proposal with the BPF community.
>
>First, VMM (virtual machine monitor) offers significant advantages
>over native machines when VMs co-resident on the same physical host
>are non-competing in terms of network and computing resources.
>However, the performance of VMs is significantly degraded compared to
>that of native machines when co-resident VMs are competing for
>resources under high workload demands due to high overheads of
>switches and events in host/guest domain and VMM. Second, the
>communication overhead between co-resident VMs can be as high as the
>communication cost between VMs located on separate physical machines.
>This is because the abstraction of VMs supported by VMM technology
>does not differentiate whether the data request is coming from
>co-resident VMs or not. More importantly, when using TCP/IP as the
>communication method, the overhead of the Linux networking stack
>itself is also significant.
>
>Although vsock already offers an optimized alternative of inter-VM
>communications, we argue that lack of transparency to applications is
>the reason why vsock is not yet widely adopted. Instead of introducing
>more socket families, we propose a novel solution using shared memory
>with eBPF to bypass the TCP/IP stack completely and transparently to
>bring co-resident VM communications to optimal.
>
>We would like to discuss:
>- How to design a new eBPF map based on IVSHMEM (Inter-VM Shared Memory)?
>- How to reuse the existing eBPF ring buffer?
>- How to leverage the socket map to replace tcp_sendmsg() and
>tcp_recvmsg() with shared memory logic?
>
>
>Thanks.
>Cong

