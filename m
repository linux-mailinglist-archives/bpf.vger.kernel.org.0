Return-Path: <bpf+bounces-49202-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5858A15220
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 15:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15C827A18D1
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 14:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD616183CA9;
	Fri, 17 Jan 2025 14:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DnOAmPYe"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5254B13CA81;
	Fri, 17 Jan 2025 14:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737125408; cv=none; b=Wi78Q2bVHrvLW9SNJeh9pe1d8lz+rEcdQCv/mbMIko6Rau/nCmd9dLd0viy7zfYFmtIj8jIFDAlr01XLByZ1K/rTiyoojU9ooyklLB7LeTpWvXCDewip9+AZ1y5/3UN9t/yDrVTHHwBL2+uETalWst+exUuElcgc72prY3WEeE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737125408; c=relaxed/simple;
	bh=QuOwvl5pfYaEp+myY0/QNRAPY4YxB9yhVOpmIoqf/TI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tukYE0NLMNMWpJsu2U87TaBVQmIK2QmZI2WsogCdTNUSLoepCcI9OKdZJLNzL6Qh0z7E5gczDikXa9Kl2u/AR7PvAHcPDya7Rb4Ip4PIEWdI/G8rWcaQ4Gdr6FmuueNiBJ/bbk1wJJwIR9sggUlPrF0iyDXMTSHgH2hyV5ar40U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DnOAmPYe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDC7BC4CEDD;
	Fri, 17 Jan 2025 14:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737125406;
	bh=QuOwvl5pfYaEp+myY0/QNRAPY4YxB9yhVOpmIoqf/TI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DnOAmPYeGRgwICwzYj//eyT1Ujvy6kH/AVEhJjSebHVkp3EuuBAke+P3cIQ8e9ojT
	 tTueDkU+PIkipn2RMcJ8IOH+JnHCGU82k3u6wXwKGAGUpMJxPJcyWIJ6ZG6lurXtPu
	 8TVP5fzqSic+/UwDf55VqDelRlUrRt2388t4voDvsn6lgNFR+QbMnFLx7XDfqdGcNv
	 1+J3WJ7riCb3fRFP9xO3IHFDnFdTQbgt1BoFqA09BJp6mkVhPjcXowiEnfojKOH57Y
	 FvCycO/aDXHAue7CTpFx5r5GU2K2iV0ndRGT3W4eLMIrRS47wGBF6GOVv1QyELqr5i
	 5+fsp9AkFV+ow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 35576380AA62;
	Fri, 17 Jan 2025 14:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/1] tools: Sync if_xdp.h uapi tooling header
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173712543002.2150446.16563970234271982689.git-patchwork-notify@kernel.org>
Date: Fri, 17 Jan 2025 14:50:30 +0000
References: <20250115032248.125742-1-yoong.siang.song@intel.com>
In-Reply-To: <20250115032248.125742-1-yoong.siang.song@intel.com>
To: Song Yoong Siang <yoong.siang.song@intel.com>
Cc: sdf@fomichev.me, vishalc@linux.ibm.com, ast@kernel.org,
 daniel@iogearbox.net, davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
 john.fastabend@gmail.com, maciej.fijalkowski@intel.com,
 stable@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed, 15 Jan 2025 11:22:48 +0800 you wrote:
> From: Vishal Chourasia <vishalc@linux.ibm.com>
> 
> Sync if_xdp.h uapi header to remove following warning:
> 
> Warning: Kernel ABI header at 'tools/include/uapi/linux/if_xdp.h' differs
> from latest version at 'include/uapi/linux/if_xdp.h'
> 
> [...]

Here is the summary with links:
  - [net,1/1] tools: Sync if_xdp.h uapi tooling header
    https://git.kernel.org/bpf/bpf-next/c/e055a46dd3cf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



