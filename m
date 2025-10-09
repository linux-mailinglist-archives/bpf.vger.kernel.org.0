Return-Path: <bpf+bounces-70648-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C48BC8428
	for <lists+bpf@lfdr.de>; Thu, 09 Oct 2025 11:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85F993A7442
	for <lists+bpf@lfdr.de>; Thu,  9 Oct 2025 09:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B6534BA47;
	Thu,  9 Oct 2025 09:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0vv3qCm"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90726212568;
	Thu,  9 Oct 2025 09:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760001628; cv=none; b=OwkxuWHj11jEC/SBVYSn0Mhg7YlLR14MPeiq9q3hF5gTr16GS058rHecD5PvgzqjlvNeZyUhs6r0W/8//jW4dHwzI/tnv5CLON8YDRuma1pc8Tx38a7yRctRR6Rx+r1aCk/dEpDlu59RWlEO14xqD4jLBmoe/BPpEB4+OhXZX6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760001628; c=relaxed/simple;
	bh=JoFBUJhn1oPLkeLJI1ZhygBJxrj9Lun7twPwWoIfsSM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nXhoR53uFUTGOytzCNWuZX71SRUUqb+On61bqj62DulWrMXPX4gUjYLFBvT7jx/2qCwxmuTG2NOZtkw1mpFkU3K6bbVzg8CBxyYTTzbzO2ZlfncRY71wYknODCKun8mWREwyfkn9k2NLi7So78o6kVZRcmsC++iNWDGt5r3ECxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g0vv3qCm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CB56C4CEE7;
	Thu,  9 Oct 2025 09:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760001628;
	bh=JoFBUJhn1oPLkeLJI1ZhygBJxrj9Lun7twPwWoIfsSM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=g0vv3qCmd+KPNo9LQB9YQ8DjWvUI3yk4rhNRmbO06pZxQ0KBo9JE1y4oIurIAhO3R
	 p2MDy9+EbdEd8TLLlTODUXFfZA3Do2VmDFIovFDMeUiu/5Pw8B6S49r5dEw5/7yQhx
	 h1rpvyqAjTg+B48RirTaj62pvM4Oza8rOKnNNQKhP/mAtRbSpyxriXeWY30sXQDDDI
	 yYulTD1C2ai9W9Lu/lt/gCTTeGQ43YaRmHoNqXpzN/utRGpPafw8EGjrWpLzXifgy0
	 NVh4Y7m39kFzzGuFhb7RYSy/O2ece5dEqHerlBsjglpOw0Zsb0DZ6zMJGFXvWaCuDK
	 HEpGiaKPFIa+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F0B3A549AA;
	Thu,  9 Oct 2025 09:20:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/9] eth: fbnic: fix XDP_TX and XDP vs qstats
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176000161625.3846982.7993344693854909404.git-patchwork-notify@kernel.org>
Date: Thu, 09 Oct 2025 09:20:16 +0000
References: <20251007232653.2099376-1-kuba@kernel.org>
In-Reply-To: <20251007232653.2099376-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 bpf@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  7 Oct 2025 16:26:44 -0700 you wrote:
> Fix XDP_TX hangs and adjust the XDP statistics to match the definition
> of qstats. The three problems are somewhat distinct.
> 
> XDP_TX hangs is a simple coding bug (patch 1).
> 
> The accounting of XDP packets is all over the place. Fix it to obey
> qstat rules (packets seen by XDP always counted as Rx packets).
> Patch 2 fixes the basic accounting, patch 3 touches up saving
> the stats when rings are freed.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/9] eth: fbnic: fix missing programming of the default descriptor
    https://git.kernel.org/netdev/net/c/7e617d57f2a2
  - [net,v2,2/9] eth: fbnic: fix accounting of XDP packets
    https://git.kernel.org/netdev/net/c/613e9e8dcb7e
  - [net,v2,3/9] eth: fbnic: fix saving stats from XDP_TX rings on close
    https://git.kernel.org/netdev/net/c/858b78b24af2
  - [net,v2,4/9] selftests: drv-net: xdp: rename netnl to ethnl
    https://git.kernel.org/netdev/net/c/1ad3f62089af
  - [net,v2,5/9] selftests: drv-net: xdp: add test for interface level qstats
    https://git.kernel.org/netdev/net/c/27ba92560bcc
  - [net,v2,6/9] eth: fbnic: fix reporting of alloc_failed qstats
    https://git.kernel.org/netdev/net/c/2eecd3a41e67
  - [net,v2,7/9] selftests: drv-net: fix linter warnings in pp_alloc_fail
    https://git.kernel.org/netdev/net/c/0be740fb22da
  - [net,v2,8/9] selftests: drv-net: pp_alloc_fail: lower traffic expectations
    https://git.kernel.org/netdev/net/c/fbb467f0ed95
  - [net,v2,9/9] selftests: drv-net: pp_alloc_fail: add necessary optoins to config
    https://git.kernel.org/netdev/net/c/5d683e550540

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



