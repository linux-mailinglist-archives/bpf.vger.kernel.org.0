Return-Path: <bpf+bounces-38946-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7664196CC82
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 04:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEC57B2371F
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 02:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734FA28684;
	Thu,  5 Sep 2024 02:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQ9Z8RAj"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAB12564;
	Thu,  5 Sep 2024 02:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725502232; cv=none; b=l1InQA4ugiHFF4gZb1C6G0Zj0TGgisS/m8NZSE49wxpHgWBTTpmwaEdC5ozvJ0B7kTMMRnyrGFekxzv09izmnhRxiN0EoI5MHJLZL7gZ4v19qrpDTHlnACOnG+AGYcBPktUwyDllrEpIotVv67xhCfdVmYDy5oYfsbfT6Bdo/0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725502232; c=relaxed/simple;
	bh=qhnvU5LS8dpPbJlPDpc2qvEpy/600H1YHQKZhTyjSG0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HxT44SzUHghA7LUvSXNDQzf6HsmAAr6/5haUZOZBjBaE6bxVXXNgPDvfLJ2CufQ+2E3ujotrf1ezzaFdOSis4SGXkyjx8oS8Y0pqY37/N2J/Qe9DA62ubtpa8yC8Z5QWNto1Ov2njiewU+VaVzRrCeYpwMIpW/OYa4Y3KOHs0TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQ9Z8RAj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75B92C4CEC2;
	Thu,  5 Sep 2024 02:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725502230;
	bh=qhnvU5LS8dpPbJlPDpc2qvEpy/600H1YHQKZhTyjSG0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aQ9Z8RAjlz504faobgVyDfOOB7ZHV3o3rpna500UBcRbwTBAFS7KgbN65jdEH8yJP
	 pIWAWlNCiNtB+S38eIxWYETPk45IgogfOpicWqwOpE4dGdAJYGs6fwNpjays8c2GM9
	 tQEeZS1nUpKxzT4VH80BlM7g7+TEhqLssGps7qADlMt9Mnw38oYetxonlzVrf7Ecbd
	 TapW99wjvVFJhHtxEPizScI1hqKywQbeIcjywzlbCvlon9xJ3sRKmnJuF6qcQuJJHh
	 T7/qc5swgUh7ryvOME/WUEoGtfIh3bc7jP4Q0x6gHzzWUZbzL0ilCUkkgwbgSfWfB0
	 KfFHBsF7QkMIw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F6B3822D30;
	Thu,  5 Sep 2024 02:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/6][pull request] ice: fix synchronization between
 .ndo_bpf() and reset
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172550223126.1227714.3911146774586738228.git-patchwork-notify@kernel.org>
Date: Thu, 05 Sep 2024 02:10:31 +0000
References: <20240903183034.3530411-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20240903183034.3530411-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, larysa.zaremba@intel.com,
 wojciech.drewek@intel.com, michal.kubiak@intel.com, jacob.e.keller@intel.com,
 amritha.nambiar@intel.com, przemyslaw.kitszel@intel.com,
 sridhar.samudrala@intel.com, maciej.fijalkowski@intel.com,
 magnus.karlsson@intel.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, bpf@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Tue,  3 Sep 2024 11:30:26 -0700 you wrote:
> Larysa Zaremba says:
> 
> PF reset can be triggered asynchronously, by tx_timeout or by a user. With some
> unfortunate timings both ice_vsi_rebuild() and .ndo_bpf will try to access and
> modify XDP rings at the same time, causing system crash.
> 
> The first patch factors out rtnl-locked code from VSI rebuild code to avoid
> deadlock. The following changes lock rebuild and .ndo_bpf() critical sections
> with an internal mutex as well and provide complementary fixes.
> 
> [...]

Here is the summary with links:
  - [net,1/6] ice: move netif_queue_set_napi to rtnl-protected sections
    https://git.kernel.org/netdev/net/c/2a5dc090b92c
  - [net,2/6] ice: protect XDP configuration with a mutex
    https://git.kernel.org/netdev/net/c/2504b8405768
  - [net,3/6] ice: check for XDP rings instead of bpf program when unconfiguring
    https://git.kernel.org/netdev/net/c/f50c68763436
  - [net,4/6] ice: check ICE_VSI_DOWN under rtnl_lock when preparing for reset
    https://git.kernel.org/netdev/net/c/d8c40b9d3a6c
  - [net,5/6] ice: remove ICE_CFG_BUSY locking from AF_XDP code
    https://git.kernel.org/netdev/net/c/7e3b407ccbea
  - [net,6/6] ice: do not bring the VSI up, if it was down before the XDP setup
    https://git.kernel.org/netdev/net/c/04c7e14e5b0b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



