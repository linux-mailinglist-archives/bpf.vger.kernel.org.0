Return-Path: <bpf+bounces-45596-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D82E19D8E86
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 23:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C7911694CF
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 22:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C591CEE8C;
	Mon, 25 Nov 2024 22:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JRm6ZWNI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB52C1CEAD1;
	Mon, 25 Nov 2024 22:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732573825; cv=none; b=nboIKe498VRaHS12savH/PqRmjvHf5f64mIqUtpenZ1BeNE5wdWK0j8fYwQn5RPUPtPPav58g+kw9+oV6uVzDz7AMAICiNrZk3EIdVEC4R1N5NIm36g8DW+4Rh9Dmbc+yDwPyREFlXWD2XZc6g+2Yk3/3jbljF21xiqAN6Wu4eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732573825; c=relaxed/simple;
	bh=AI77Y2EXMZWTFlS4ewWlo7CTJrXexBZvmZusVl8+0hM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FWNVGRbe+3mVGUPv/VOjVfAQqfXsQvtwYbRqcBS8bpgD+7g4odsxeNu3FTKYSuX5HFaWiXit3uCaE7188WVX4U6iCLBH36S0sGT91TMhFwjaxPGC3Q4AdIaglfpaC/hN77pRdPrGQKtaOewzvlljDTD1Bwru4kaL/yqvStk5Pz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JRm6ZWNI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 801E1C4CED3;
	Mon, 25 Nov 2024 22:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732573824;
	bh=AI77Y2EXMZWTFlS4ewWlo7CTJrXexBZvmZusVl8+0hM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JRm6ZWNIqj3rOy/gHd6mI/39N+l969qkYXvPWvkouSKDYhhIysUDvtLDIPUY8+wDP
	 62WBtGUzUVvF00y4OlMULGUgzOehLTljF8u3buRgEZ38gFrCu6qza62FWyUAEJXe5k
	 2B8dzuwsOLUvA9RcyrWm3E3v5d8jao0QWAy8zVQJqFWie1SCQo2JKN+Eo6qhy/RjhQ
	 gt7RxUXk8OrLlASWMKtSyvXJqrqp3bAnq4vjgIh6DEeBYWKjYZ4x0Zhku39MVD7PQD
	 44zbzrXLMSsKBc9O6vLLLOW5Tfl/TDdTdrQtK8bd3IFtNfcNLHelYZd7OY84hpb37K
	 +2fZWoRX7/Bfg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710F03809A00;
	Mon, 25 Nov 2024 22:30:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf 0/2] bpf: fix OOB accesses in map_delete_elem callbacks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173257383699.4058254.11460936929624006361.git-patchwork-notify@kernel.org>
Date: Mon, 25 Nov 2024 22:30:36 +0000
References: <20241122121030.716788-1-maciej.fijalkowski@intel.com>
In-Reply-To: <20241122121030.716788-1-maciej.fijalkowski@intel.com>
To: Fijalkowski@codeaurora.org, Maciej <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, netdev@vger.kernel.org, magnus.karlsson@intel.com,
 bjorn@kernel.org, jordyzomer@google.com, security@kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 22 Nov 2024 13:10:28 +0100 you wrote:
> v1->v2:
> - CC stable and collect tags from Toke & John
> 
> Hi,
> 
> Jordy reported that for big enough XSKMAPs and DEVMAPs, when deleting
> elements, OOB writes occur.
> 
> [...]

Here is the summary with links:
  - [v2,bpf,1/2] xsk: fix OOB map writes when deleting elements
    https://git.kernel.org/bpf/bpf/c/32cd3db7de97
  - [v2,bpf,2/2] bpf: fix OOB devmap writes when deleting elements
    https://git.kernel.org/bpf/bpf/c/ab244dd7cf4c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



