Return-Path: <bpf+bounces-69872-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E6017BA54FA
	for <lists+bpf@lfdr.de>; Sat, 27 Sep 2025 00:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CFC444E1BF8
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 22:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A73E29A307;
	Fri, 26 Sep 2025 22:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AI05CVt7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA542848A2;
	Fri, 26 Sep 2025 22:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758925227; cv=none; b=CiyZXT8nQX3OReu9plarvW8SdOMQlH2oz4V229se9ZqzhpuWev/lxzUXBQGXPB3KntyY/kHoB5+1DeHO+s1xnlZ/U/fxMRDUz9mkopH12BFp5mnPOLVIK6soVt4UgqF37hfQ8VaikLKcU78dCGw8haycLJxFv4hP4BuACHQvmn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758925227; c=relaxed/simple;
	bh=ni0jaNTxjzQ5iV15IwrDN+UTPw7OdPLj8fWrz3N34DI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ILiEUVSHqEBKJwI4Lwttoxxq+MG6ERlWBqOPz2xKum9ZeOYKLRwKQXZ0x4AEMvttjjHPcaV5TOe9JpGa78pc1FXnrVNa2l9OuQQuyHEO3chxcuhutfLYk+uiJB7ZNdC1erymMEi8CfMqJUAcvnFhw++PUTTsiSapCBmwv87Kw38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AI05CVt7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81701C4CEF4;
	Fri, 26 Sep 2025 22:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758925226;
	bh=ni0jaNTxjzQ5iV15IwrDN+UTPw7OdPLj8fWrz3N34DI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AI05CVt7sHRkylsE/Et4vba3SgNCyr24xHt/I0fnQ2+JfEdxmQniwMvFH/bth4m45
	 9ubE6HSB0UDuAB8uh2BF8PMPvj7QzIL/g6Dvt8BfgkKQPSLW7PNdiuLWrqm+GoIFzt
	 SBvixLB5+nAuciANxticJ5+Mw6hvnpQ6onCsu5yBO7Y5HdGEK8vWtkUIm0NoKXKy1o
	 D5qWtr735ZYS5qTEnma9RzNWhO9uTUKa7jL+IMbGggOB8UrbHXcx5qZOINOeP/jb6z
	 VKJvUVKcMFLUsjOO2adlmGqIqz10S46DfCkMIrZx1iQrKGaHo55HvN3ZJZK77CKxth
	 ANCHW6+7Dh9Tg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADEA39D0C3F;
	Fri, 26 Sep 2025 22:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5][pull request] idpf: add XSk support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175892522173.77570.9707782331084725672.git-patchwork-notify@kernel.org>
Date: Fri, 26 Sep 2025 22:20:21 +0000
References: <20250924175230.1290529-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20250924175230.1290529-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 aleksander.lobakin@intel.com, michal.kubiak@intel.com,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
 przemyslaw.kitszel@intel.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, horms@kernel.org, sdf@fomichev.me,
 nxne.cnse.osdt.itp.upstreaming@intel.com, bpf@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Wed, 24 Sep 2025 10:52:23 -0700 you wrote:
> Alexander Lobakin says:
> 
> Add support for XSk xmit and receive using libeth_xdp.
> 
> This includes adding interfaces to reconfigure/enable/disable only
> a particular set of queues and support for checksum offload XSk Tx
> metadata.
> libeth_xdp's implementation mostly matches the one of ice: batched
> allocations and sending, unrolled descriptor writes etc. But unlike
> other Intel drivers, XSk wakeup is implemented using CSD/IPI instead
> of HW "software interrupt". In lots of different tests, this yielded
> way better perf than SW interrupts, but also, this gives better
> control over which CPU will handle the NAPI loop (SW interrupts are
> a subject to irqbalance and stuff, while CSDs are strictly pinned
> 1:1 to the core of the same index).
> Note that the header split is always disabled for XSk queues, as
> for now we see no reasons to have it there.
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] idpf: add virtchnl functions to manage selected queues
    https://git.kernel.org/netdev/net-next/c/6b8e30b64065
  - [net-next,2/5] idpf: add XSk pool initialization
    https://git.kernel.org/netdev/net-next/c/3d57b2c00f09
  - [net-next,3/5] idpf: implement XSk xmit
    https://git.kernel.org/netdev/net-next/c/8ff6d62261a3
  - [net-next,4/5] idpf: implement Rx path for AF_XDP
    https://git.kernel.org/netdev/net-next/c/9705d6552f58
  - [net-next,5/5] idpf: enable XSk features and ndo_xsk_wakeup
    https://git.kernel.org/netdev/net-next/c/96da9d67da78

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



