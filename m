Return-Path: <bpf+bounces-38765-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC2296981B
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 11:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D8F3B25FC7
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 09:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BAEA1C769A;
	Tue,  3 Sep 2024 09:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YDozzlLi"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45B41C7660;
	Tue,  3 Sep 2024 09:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725354030; cv=none; b=l4OB2n1cXvaaeMESllLx4rjk145GolY7eEdLu+9936V32+bnxief4L99F8OpREKhiiyTVGVvYGSqmjDG+WYfevwY+IL23L40FoTs+CLZYV75t24G665/DvOPIwCu7VgMCM1qtm8ExRY/GUNbY0W/8uMWfU/fH+jwwf5N/ugC2Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725354030; c=relaxed/simple;
	bh=nSvH7njmPuveEhUVDO40rfe4HWyxx/nctaf+U0qJWBM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KDe1+JCHb9R8r2Cgw6Ic9CdXF7Axd6+l1+xNGv4CnSUI771xWdgkLkuwQnq+lZo4fehXpj5DZn4M4jzMl7tFaoEbpozTn9CKdCAwTyEIoDYy320fw9xThyC/0adFdbfX8Fn582Ve+OLfbRFFzLWws90bChw13GNCNqefz0GFzGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YDozzlLi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A59FC4CEC4;
	Tue,  3 Sep 2024 09:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725354030;
	bh=nSvH7njmPuveEhUVDO40rfe4HWyxx/nctaf+U0qJWBM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YDozzlLi3E7w7YXzwmP+3Z3wGQF5tRyTh9oeq/y0bOuGjpg79FEi/KYB8YrwRhPLT
	 j27C0gt5oU2VRCg1RPt/QvPqiJcAMcWelGlA9BgZwDjTDFSEKo3c/f5/hhm10X0UH3
	 mC2QrVxnScWkyX8sCZunjtmlT3w/DBzoCMW0e8cbr1VniL6LN0bX1PF/zEoTTOMmmj
	 6XwtOdIWgUe0Q9VGoG6FZpeqkV6B3pSYWQICgjyVZuOv5mYmdWDFYWoJGl2I4xnVQB
	 9QdDKuIKbqHd3U3WvOk8vudNSQFbPEGN9ml9nxifJk25q66bBzZT6Ozq77mYG9053Y
	 /JAfsfwWpuJEQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 344D33805D82;
	Tue,  3 Sep 2024 09:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3] net: ethernet: ti: am65-cpsw: Fix XDP
 implementation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172535403101.219489.11960916524185779932.git-patchwork-notify@kernel.org>
Date: Tue, 03 Sep 2024 09:00:31 +0000
References: <20240829-am65-cpsw-xdp-v1-0-ff3c81054a5e@kernel.org>
In-Reply-To: <20240829-am65-cpsw-xdp-v1-0-ff3c81054a5e@kernel.org>
To: Roger Quadros <rogerq@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, jpanis@baylibre.com, jacob.e.keller@intel.com,
 s-vadapalli@ti.com, danishanwar@ti.com, vigneshr@ti.com, srk@ti.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 29 Aug 2024 15:03:18 +0300 you wrote:
> The XDP implementation on am65-cpsw driver is broken in many ways
> and this series fixes it.
> 
> Below are the current issues that are being fixed:
> 
> 1)  The following XDP_DROP test from [1] stalls the interface after
>     250 packets.
>     ~# xdb-bench drop -m native eth0
>     This is because new RX requests are never queued. Fix that.
> 
> [...]

Here is the summary with links:
  - [net,1/3] net: ethernet: ti: am65-cpsw: fix XDP_DROP, XDP_TX and XDP_REDIRECT
    https://git.kernel.org/netdev/net/c/5e24db550bd6
  - [net,2/3] net: ethernet: ti: am65-cpsw: Fix NULL dereference on XDP_TX
    https://git.kernel.org/netdev/net/c/0a50c35277f9
  - [net,3/3] net: ethernet: ti: am65-cpsw: Fix RX statistics for XDP_TX and XDP_REDIRECT
    https://git.kernel.org/netdev/net/c/624d3291484f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



