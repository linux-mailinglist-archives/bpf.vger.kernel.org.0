Return-Path: <bpf+bounces-45595-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E81079D8E84
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 23:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD0F5285126
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 22:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEBF1CDFC2;
	Mon, 25 Nov 2024 22:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ugVDIVrt"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1751CDA1E;
	Mon, 25 Nov 2024 22:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732573823; cv=none; b=i9t0BrDqgVgmeOI1GTu/Pw8+GpnFKD/rKFubMwmXP+6UfbvtIfkik2N/tPv8SdCDLRN93WXgLwjnJS7e8zTHKEOa/GeaIlMBzfF3OiILYmTANhTNsSE7awMSMTqt8hxRijoNusRC3e8IZn0BbnYv2mtmTY636K8jROBOfxLs3n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732573823; c=relaxed/simple;
	bh=fHvnGdZ50/nq2t1zezbGmwAW7qZpIAi7AAjhKDn3FUo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=l+zkkMsrEioeWKTgmM2fiXOXasPa5gUIZhpzyEJrWHSKiXmjkSoQVf0ZLfTEmjPUqBHDFJUoxfVyi+souWrVXfSGnKvRdXzmGlSCknL1HE6dsrrRNhwBvyCwp/RZ9YdSFBB9vYffOYAxi93YaKO63+yBpiRJyqZ5K2w9DdbpL2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ugVDIVrt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0240AC4CECE;
	Mon, 25 Nov 2024 22:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732573823;
	bh=fHvnGdZ50/nq2t1zezbGmwAW7qZpIAi7AAjhKDn3FUo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ugVDIVrtAzyUmYxUy+qBQWrC+rtnv8uZnqZUDidRAqhXGryg/1dfgTU6wiQQEBzDD
	 Ll+eZp0NcGFE7XoTBrs22vqDefpYgyEYWNLhiTfPi8SJ/1oTOTYDEKWk27bXPFegtb
	 3zSDbtbq5CqynZheg20pvse87O/H3DzSAtNhKBt6goagVit0nOGUmyeFqeagqRcuUB
	 iWjF84+L2HK6yV7hP9cLQccwuOkdifG+h37nFjbJ1WBbulvEhyNzmESPmYpcySP/G3
	 nyGZcCnG5XTV6q31yBfG3AH/F2Rrs9leC+W2KF6ocA9EnUiUDP+Tmur0Do9gue2wcr
	 yjkaamL/chHaQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADCD3809A00;
	Mon, 25 Nov 2024 22:30:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] xsk: always clear DMA mapping information when unmapping
 the pool
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173257383550.4058254.12806548531670345328.git-patchwork-notify@kernel.org>
Date: Mon, 25 Nov 2024 22:30:35 +0000
References: <20241122112912.89881-1-larysa.zaremba@intel.com>
In-Reply-To: <20241122112912.89881-1-larysa.zaremba@intel.com>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: bpf@vger.kernel.org, bjorn@kernel.org, magnus.karlsson@intel.com,
 maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 horms@kernel.org, przemyslaw.kitszel@intel.com, jacob.e.keller@intel.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 alasdair.mcwilliam@outlook.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 22 Nov 2024 12:29:09 +0100 you wrote:
> When the umem is shared, the DMA mapping is also shared between the xsk
> pools, therefore it should stay valid as long as at least 1 user remains.
> However, the pool also keeps the copies of DMA-related information that are
> initialized in the same way in xp_init_dma_info(), but cleared by
> xp_dma_unmap() only for the last remaining pool, this causes the problems
> below.
> 
> [...]

Here is the summary with links:
  - [bpf] xsk: always clear DMA mapping information when unmapping the pool
    https://git.kernel.org/bpf/bpf/c/ac9a48a6f161

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



