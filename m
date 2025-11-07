Return-Path: <bpf+bounces-73917-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C31C3E109
	for <lists+bpf@lfdr.de>; Fri, 07 Nov 2025 02:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6E421887E82
	for <lists+bpf@lfdr.de>; Fri,  7 Nov 2025 01:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401242E6CBF;
	Fri,  7 Nov 2025 01:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aC5LCa9U"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E1113DDAE;
	Fri,  7 Nov 2025 01:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762477235; cv=none; b=mVjCZQC5R1Ifx5b5Qn2OVqbctQVj21LS7GB/MMS3WqwH1MAVEdoSCk2Gi5t8GA5/6bd1TR1v2IEWrRGv/MVddZ6sV/Ct+vxnDU7AL64arNNAdspnySOiqeMpvaMJh9Sk8bUfIeu/EOUuKdDRrX/1Mv4AgHTXjPVlxQjOLwbpz6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762477235; c=relaxed/simple;
	bh=fiaJcDHy26t8h/Wgv/2c5GS1hWMi8i5RvIqS2k/JJoU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FSHZVtC4vdFduWogZErOGsAAKnceodbx5CItNt3qRNKeEl1g8rzt9pVlT/K2KPtju6EWIcN6/oIkZo1DWPePvb9574rNPf1Q/Qp93v+XOmngT7a63AO+MGcAb5CMMmAE+NspOzDWaJujtq6Tm8PjMKP897Wuh4XImAAum42Pwds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aC5LCa9U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F1E9C4CEFB;
	Fri,  7 Nov 2025 01:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762477235;
	bh=fiaJcDHy26t8h/Wgv/2c5GS1hWMi8i5RvIqS2k/JJoU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aC5LCa9USbYcNePnewtIR+hcEl6V4b37mHpxEr6MubTdOemX/EQmYLmVdc6Wx3tZe
	 oc7qoPrhwPZqYs56nePgIf5zpnYBzmIXQpbjCtIqiaTbwfU3iC61BmtHJ8Lj6vWRkY
	 GLcgbDCfxXtvrxS6qmpZ28D8E7VapGr/s/URaz4tGpASRTkLU+RxCYcAIg+9EOECPJ
	 HP7Rxca/cmtSVZ/fll5EWOMW9OTykxc4ctCTB1Zc6aow9w8lW13zdrBOB7V2tVp9xo
	 xh2kiey1vgqTcEyCuz8hEvkjnD+VMr5PK4Gnil0QilU9vPVhuFtNqJC8/wYjBCnytn
	 YZb8vVgwGzR1g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C3739EF974;
	Fri,  7 Nov 2025 01:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 00/14] netkit: Support for io_uring zero-copy
 and
 AF_XDP
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176247720805.439165.4093423538146996768.git-patchwork-notify@kernel.org>
Date: Fri, 07 Nov 2025 01:00:08 +0000
References: <20251031212103.310683-1-daniel@iogearbox.net>
In-Reply-To: <20251031212103.310683-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, kuba@kernel.org,
 davem@davemloft.net, razor@blackwall.org, pabeni@redhat.com,
 willemb@google.com, sdf@fomichev.me, john.fastabend@gmail.com,
 martin.lau@kernel.org, jordan@jrife.io, maciej.fijalkowski@intel.com,
 magnus.karlsson@intel.com, dw@davidwei.uk, toke@redhat.com,
 yangzhenze@bytedance.com, wangdongdong.6@bytedance.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 31 Oct 2025 22:20:49 +0100 you wrote:
> Containers use virtual netdevs to route traffic from a physical netdev
> in the host namespace. They do not have access to the physical netdev
> in the host and thus can't use memory providers or AF_XDP that require
> reconfiguring/restarting queues in the physical netdev.
> 
> This patchset adds the concept of queue peering to virtual netdevs that
> allow containers to use memory providers and AF_XDP at native speed.
> These mapped queues are bound to a real queue in a physical netdev and
> act as a proxy.
> 
> [...]

Here is the summary with links:
  - [net-next,v4,01/14] net: Add bind-queue operation
    (no matching commit)
  - [net-next,v4,02/14] net: Implement netdev_nl_bind_queue_doit
    (no matching commit)
  - [net-next,v4,03/14] net: Add peer info to queue-get response
    (no matching commit)
  - [net-next,v4,04/14] net, ethtool: Disallow peered real rxqs to be resized
    (no matching commit)
  - [net-next,v4,05/14] net: Proxy net_mp_{open,close}_rxq for mapped queues
    (no matching commit)
  - [net-next,v4,06/14] xsk: Move NETDEV_XDP_ACT_ZC into generic header
    https://git.kernel.org/netdev/net-next/c/24ab8efb9aea
  - [net-next,v4,07/14] xsk: Extend xsk_rcv_check validation
    (no matching commit)
  - [net-next,v4,08/14] xsk: Proxy pool management for mapped queues
    (no matching commit)
  - [net-next,v4,09/14] netkit: Add single device mode for netkit
    (no matching commit)
  - [net-next,v4,10/14] netkit: Document fast vs slowpath members via macros
    https://git.kernel.org/netdev/net-next/c/25e63e559c41
  - [net-next,v4,11/14] netkit: Implement rtnl_link_ops->alloc and ndo_queue_create
    (no matching commit)
  - [net-next,v4,12/14] netkit: Add netkit notifier to check for unregistering devices
    (no matching commit)
  - [net-next,v4,13/14] netkit: Add io_uring zero-copy support for TCP
    (no matching commit)
  - [net-next,v4,14/14] netkit: Add xsk support for af_xdp applications
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



