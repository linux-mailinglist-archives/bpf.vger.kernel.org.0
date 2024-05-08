Return-Path: <bpf+bounces-29028-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C9C8BF667
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 08:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1EF71F23C4D
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 06:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BFD2375B;
	Wed,  8 May 2024 06:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="kg4kuT87"
X-Original-To: bpf@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D447C147;
	Wed,  8 May 2024 06:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715150365; cv=none; b=laHQPdpNZQv8IzpSrN4ZYv9PQbwMf8cx2HK0kbaP4XoT41IzRJipTpNu7yTRCNFKuqQp8DPvmceNQ7UkaPTZGx/5+qzm1/MYMrGViqisXU5pUx2wW4TMBE+TWrTPYgDTQjEW2dZRz0yNaiAdly34rVGgaTRCdjR38WMGjawJdQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715150365; c=relaxed/simple;
	bh=5apkTWojmcE3k+MggFfi2u73Otl721UvupdTwYEon8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CVw1EZjixswHtcCfyKBynInB75jaoqwOMj4kWXRGG7HzNXv48cOGXOSEkBg5EB1Y8ZXQtRCja2nwp/NJiQ1kz8Pv1KlhJa1cewwQBmUFBLGiBc8SHIAtq8llTLWaltJDnCCZQmMEKKKB5WV8eV7AfRrOkUWYip0W4Ck9L9EyTGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=kg4kuT87; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715150354; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=yizkrXLhU+dxzuGFufkGGyPhK2B9HqR+hbP/CMmLM4w=;
	b=kg4kuT87a7eljIbhflDzfjvNrhFGkeyvJwz/qF1cdLDaAgFzZXb1bhodXu18UlMxH7kWbmbNGHstKqZgHSyhJawuPmcWi1FLVG6OcbtLy2ZYgcAEJj63vGsmpYiSpzxYBRzwdOzvJF9fMUKukV/EUXaADi2LRAiQgJANEsfv24M=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=tonylu@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0W62UDX-_1715150352;
Received: from localhost(mailfrom:tonylu@linux.alibaba.com fp:SMTPD_---0W62UDX-_1715150352)
          by smtp.aliyun-inc.com;
          Wed, 08 May 2024 14:39:13 +0800
Date: Wed, 8 May 2024 14:39:10 +0800
From: Tony Lu <tonylu@linux.alibaba.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Wen Gu <guwen@linux.alibaba.com>, wintera@linux.ibm.com,
	twinkler@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
	agordeev@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, wenjia@linux.ibm.com,
	jaka@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
	alibuda@linux.alibaba.com, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net-next v7 00/11] net/smc: SMC intra-OS shortcut with
 loopback-ism
Message-ID: <ZjseDobo5XqUQcUE@TONYMAC-ALIBABA.local>
Reply-To: Tony Lu <tonylu@linux.alibaba.com>
References: <20240428060738.60843-1-guwen@linux.alibaba.com>
 <Zi5wIrf3nAeJh1u5@pop-os.localdomain>
 <2e34e4ea-b198-487e-be5b-ba854965dbeb@linux.alibaba.com>
 <ZjpSgWyHaNC/ikNP@pop-os.localdomain>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjpSgWyHaNC/ikNP@pop-os.localdomain>

On Tue, May 07, 2024 at 09:10:41AM -0700, Cong Wang wrote:
> On Tue, May 07, 2024 at 10:34:09PM +0800, Wen Gu wrote:
> > 
> > 
> > On 2024/4/28 23:49, Cong Wang wrote:
> > > On Sun, Apr 28, 2024 at 02:07:27PM +0800, Wen Gu wrote:
> > > > This patch set acts as the second part of the new version of [1] (The first
> > > > part can be referred from [2]), the updated things of this version are listed
> > > > at the end.
> > > > 
> > > > - Background
> > > > 
> > > > SMC-D is now used in IBM z with ISM function to optimize network interconnect
> > > > for intra-CPC communications. Inspired by this, we try to make SMC-D available
> > > > on the non-s390 architecture through a software-implemented Emulated-ISM device,
> > > > that is the loopback-ism device here, to accelerate inter-process or
> > > > inter-containers communication within the same OS instance.
> > > 
> > > Just FYI:
> > > 
> > > Cilium has implemented this kind of shortcut with sockmap and sockops.
> > > In fact, for intra-OS case, it is _very_ simple. The core code is less
> > > than 50 lines. Please take a look here:
> > > https://github.com/cilium/cilium/blob/v1.11.4/bpf/sockops/bpf_sockops.c
> > > 
> > > Like I mentioned in my LSF/MM/BPF proposal, we plan to implement
> > > similiar eBPF things for inter-OS (aka VM) case.
> > > 
> > > More importantly, even LD_PRELOAD is not needed for this eBPF approach.
> > > :)
> > > 
> > > Thanks.
> > 
> > Hi, Cong. Thank you very much for the information. I learned about sockmap
> > before and from my perspective smcd loopback and sockmap each have their own
> > pros and cons.
> > 
> > The pros of smcd loopback is that it uses a standard process that defined
> > by RFC-7609 for negotiation, this CLC handshake helps smc correctly determine
> > whether the tcp connection should be upgraded no matter what middleware the
> > connection passes, e.g. through NAT. So we don't need to pay extra effort to
> > check whether the connection should be shortcut, unlike checking various policy
> > by bpf_sock_ops_ipv4() in sockmap. And since the handshake automatically select
> > different underlay devices for different scenarios (loopback-ism in intra-OS,
> > ISM in inter-VM of IBM z and RDMA in inter-VM of different hosts), various
> > scenarios can be covered through one smc protocol stack.
> > 
> > The cons of smcd loopback is also related to the CLC handshake, one more round
> > handshake may cause smc to perform worse than TCP in short-lived connection
> > scenarios. So we basically use smc upgrade in long-lived connection scenarios
> > and are exploring IPPROTO_SMC[1] to provide lossless fallback under adverse cases.
> 
> You don't have to bother RFC's, since you could define your own TCP
> options. And, the eBPF approach could also use TCP options whenver
> needed. Cilium probably does not use them only because for intra-OS case
> it is too simple to bother TCP options, as everything can be shared via a
> shared socketmap.

You can define and use any private TCP options but that is not the right
way for a inter-host network protocol, especially for different subnet,
arch or OS (Linux, z/OS and so on). As the essence of communication
between any two parties, everyone need to abide by the same standards. I
also have to admit that SMC is a standard protocol and we need to extend
the protocol spec through standard and appropriate methods, such as IETF
RFC and protocol white paper. If it is only a temporary acceleration
solution used on a small scale, this restriction are not required.

> 
> In reality, the setup is not that complex. In many cases we already know
> whether we have VM or container (or mixed) setup before we develop (as
> a part of requirement gathering). And they rarely change.

To running SMC in nowadays cloud infra, TCP handshake is not the most
efficient but the most practical way, for we can't touch the infra
under VM, even don't know what kind of environment.

> 
> Taking one step back, the discovery of VM or container or loopback cases
> could be done via TCP options too, to deal with complex cases like
> KataContainer. There is no reason to bother RFC's, maybe except the RDMA
> case.
> 
> In fact, this is an advantage to me. We don't need to argue with anyone
> on our own TCP option or eBPF code, we don't even have to share our own
> eBPF code here.

Actually I am looking forward to learn about the whole way of eBPF. Both
SMC and eBPF are trying to solve this issue in their own view. I don't
think one must be replaced by another one for now. To define these
inter/intra-OS/host scene and captivate interest are more important, I
think, than seeking a one-size-fits-all solution for the present time.

> 
> > 
> > And we are also working on other upgrade ways than LD_PRELOAD, e.g. using eBPF
> > hook[2] with IPPROTO_SMC, to enhance the usability.
> 
> That is wrong IMHO, because basically it just overwrites kernel modules
> with eBPF, not how eBPF is supposed to be used. IOW, you could not use
> it at all without SMC/MPTCP modules.

The eBPF hookers are considering as a part of SMC modules. It should not
be used out of SMC module for now at least.

> 
> BTW, this approach does not work for kernel sockets, because you only
> hook __sys_socket().

Yep, SMC should not replace kernel socket for now. In our scenario,
almost all applications suitable for SMC only run in user space.

Thanks,
Tony Lu

> 
> Of course, for sockmap or sockops, they could be used independently for
> any other purposes. I hope now you could see the flexiblities of eBPF
> over kernel modules.
> 
> Thanks.

