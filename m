Return-Path: <bpf+bounces-68095-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E6EB52E0A
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 12:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EF4A161F0E
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 10:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5819531283E;
	Thu, 11 Sep 2025 10:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KcPTRITn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C476A31281C;
	Thu, 11 Sep 2025 10:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757585406; cv=none; b=drzSsKU1d1SRzQ6ar78KN2SL27YqHoNqxnzKuiyQeXiWIIHk4lIRNIigBeUT7KEXMRNnXiCEwaabPLCoq6aC4Znrq6W5Vg7Gy2b58FHbe5RNGcks4mNjHYzUYoe1YjXGF7OZxqF7zIqBexGgwsn9309BNDh3EuQIraCnqbColmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757585406; c=relaxed/simple;
	bh=eN0nJzuR7cYj/BqQgbUnT7er/x4zP8Te2SGMwzGgFXM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OiTp+4nTOAG33lY9ti+8KsswSCrzIiVb4CBBoOE9XYIMjx7IZb6QDXC0uQ7qtuYx5BKXSH5gOb+hU3d7ynnhaHWQN3bOcRgLClVsNJiHy7RDuTU8QkLs0L8BuuQ3KYjcAShhdB2jjQTVmshb2Qx1+XE+iaxVpXwbTnSzpHp2di0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KcPTRITn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FA69C4CEF0;
	Thu, 11 Sep 2025 10:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757585406;
	bh=eN0nJzuR7cYj/BqQgbUnT7er/x4zP8Te2SGMwzGgFXM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KcPTRITnkVVcTl9bJYhhKTrbCIwAmB/w0+sPxaQWRk/bGiAkNMO1P7kuLaIym774K
	 Ijau9pSriGMhr4nRPysLx9h6K6L/izZxLrkjmd5OuNInTUa3l0H2+NnSmeIXIQkrym
	 DwGmdCXycl/fpoFOvJ+MnjTv4kBy+qDIDW9zmihCGwZ+MlfD3V2Y0QtSD2YrwHtSFZ
	 X47O1gcC+m0ssSqXv1kvFZcPU0CDk2jBTdfktjKrV/PtB7Bdj+dBt/9HzVokv6kXO8
	 aWcTR0ZtzStEEOV1neATswVuqQ/Y1hniP8esLEG1JaJu2KpmPs66snlKPRocnXmgM1
	 KNJxyxa4BWS/g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34017383BF69;
	Thu, 11 Sep 2025 10:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] net: xdp: handle frags with unreadable
 memory
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175758540901.2113906.14410248093757782465.git-patchwork-notify@kernel.org>
Date: Thu, 11 Sep 2025 10:10:09 +0000
References: <20250905221539.2930285-1-kuba@kernel.org>
In-Reply-To: <20250905221539.2930285-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, michael.chan@broadcom.com, anthony.l.nguyen@intel.com,
 marcin.s.wojtas@gmail.com, tariqt@nvidia.com, mbloch@nvidia.com,
 jasowang@redhat.com, bpf@vger.kernel.org, aleksander.lobakin@intel.com,
 pavan.chebbi@broadcom.com, przemyslaw.kitszel@intel.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  5 Sep 2025 15:15:37 -0700 you wrote:
> Make XDP helpers compatible with unreadable memory. This is very
> similar to how we handle pfmemalloc frags today. Record the info
> in xdp_buf flags as frags get added and then update the skb once
> allocated.
> 
> This series adds the unreadable memory metadata tracking to drivers
> using xdp_build_skb_from*() with no changes on the driver side - hence
> the only driver changes here are refactoring. Obviously, unreadable memory
> is incompatible with XDP today, but thanks to xdp_build_skb_from_buf()
> increasing number of drivers have a unified datapath, whether XDP is
> enabled or not.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net: xdp: pass full flags to xdp_update_skb_shared_info()
    https://git.kernel.org/netdev/net-next/c/1827f773e416
  - [net-next,2/2] net: xdp: handle frags with unreadable memory
    https://git.kernel.org/netdev/net-next/c/6bffdc0f88f8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



