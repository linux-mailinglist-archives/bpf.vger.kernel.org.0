Return-Path: <bpf+bounces-51922-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8EBA3BDAD
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 13:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6764B3AB1DF
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 12:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBDC1DFE14;
	Wed, 19 Feb 2025 12:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rgospYIl"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74601DFE0F;
	Wed, 19 Feb 2025 12:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739966410; cv=none; b=D2CcOr3ZIXEc2eU4iclw49jLI0FZSgl9KXIR9wCmQfR9dXzHnLcKAN2j6B+IkDP5kGHKSZW8mBNRqKrsKEY/nyPvvRuXHWSl6pXlrYE0PeGpKe20HF4e6OXEyxNBs4LF7YKBWhWxfWGys4Dt+KldSqiLralE8WrosvHgVajTaOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739966410; c=relaxed/simple;
	bh=aE9HcyCajEVazPonKG1AgVf+pWUFmjDMzHCSFMYcyfI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=l/knugZPOSsscgtp0eXCaNYTdN66t02IvflzV1TRa9rZg/MPinQ5djNSupAAQr1HFvLJQoXBoRpa/mFMGab5iuZC6c0hTQ7fV9LppKR2T3Op//aaScrEqRCrPdyzcor/RSB6Ds/0PuoDuI0rsKoFtDckTonmEVo/JI2tdDK719E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rgospYIl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48CC8C4CED1;
	Wed, 19 Feb 2025 12:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739966409;
	bh=aE9HcyCajEVazPonKG1AgVf+pWUFmjDMzHCSFMYcyfI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rgospYIlvA1eSB9k8RYiFMU16h8uommpo2RvbUGoGdny06TzZ+fNJ4CGyeW0kq6tt
	 z6WjQtoG25Pdsc+6iwPWi7MZupz6OIztBpicHzep6kqcLukAsVbD79MABn/INTLeAW
	 nvnL4Xwb7IC23NkVwsIBk7u4QyrVUYhZOXAHmNsB9Uct4LZ8m4+bhyY6ziQ4NvI1ZO
	 xyCovxaG4paRwXK2aRzdDU9BrAFTQlNr5cJumkZFyUPQRH3ZhHff9yo8GBcu8O8iUQ
	 iKhO7HEzvyPJiQezAuJIQWQ9svJfShrvK5zEHvKmjskqgw1ZWLxqoXXGrQyd9qvbu1
	 0c3d1Gu7Q8d9w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB2A8380AAE9;
	Wed, 19 Feb 2025 12:00:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] net: ethernet: ti: am65-cpsw: drop multiple
 functions and code cleanup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173996643977.565726.11256296514242997941.git-patchwork-notify@kernel.org>
Date: Wed, 19 Feb 2025 12:00:39 +0000
References: <20250217-am65-cpsw-zc-prep-v1-0-ce450a62d64f@kernel.org>
In-Reply-To: <20250217-am65-cpsw-zc-prep-v1-0-ce450a62d64f@kernel.org>
To: Roger Quadros <rogerq@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, s-vadapalli@ti.com,
 danishanwar@ti.com, srk@ti.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 17 Feb 2025 09:31:45 +0200 you wrote:
> We have 2 tx completion functions to handle single-port vs multi-port
> variants. Merge them into one function to make maintenance easier.
> 
> We also have 2 functions to handle TX completion for SKB vs XDP.
> Get rid of them too.
> 
> Also do some minor cleanups.
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] net: ethernet: ti: am65-cpsw: remove am65_cpsw_nuss_tx_compl_packets_2g()
    https://git.kernel.org/netdev/net-next/c/9a369ae3d143
  - [net-next,2/5] net: ethernet: ti: am65_cpsw: remove cpu argument am65_cpsw_run_xdp
    https://git.kernel.org/netdev/net-next/c/1ae26bf61517
  - [net-next,3/5] net: ethernet: ti: am65-cpsw: use return instead of goto in am65_cpsw_run_xdp()
    https://git.kernel.org/netdev/net-next/c/09057ce3774e
  - [net-next,4/5] net: ethernet: ti: am65_cpsw: move am65_cpsw_put_page() out of am65_cpsw_run_xdp()
    https://git.kernel.org/netdev/net-next/c/6d6c7933cea6
  - [net-next,5/5] net: ethernet: ti am65_cpsw: Drop separate TX completion functions
    https://git.kernel.org/netdev/net-next/c/ce643fa62a70

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



