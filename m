Return-Path: <bpf+bounces-20283-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81FBC83B627
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 01:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23CB1B223F2
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 00:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE8A10E6;
	Thu, 25 Jan 2024 00:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nBo54KHe"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EA07FB;
	Thu, 25 Jan 2024 00:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706143228; cv=none; b=K3TifDYdfEO5p1Acbq2fC5aROicSRTyJ2lFaf4wX/Wjokpm2GR99kaqbQa8KgLB4/xCtMPKdnDMMeVWAA0HAlyYX7wFbl7UPE0Dc47Lf9v2cusFNH80VKrlxMIP2Aec5LApS04BIg5xr8MEv+S0kZokl7UJdprKmLcHD7X+1DsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706143228; c=relaxed/simple;
	bh=J8OrFbZ6p2Es2PNzFeewNd0/aA/PXopYkzTYOJFEy+o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hbCCwiHKk8PSXQ5UfLsubv2z9mMapc31HIROsEQiPtIRR18ZGHsg1kDH4aPrPf+jme2DVmyQQPhChk/uhTGRJr/c4fpYcGvAF00S8NA3tPpFz5PuI8q0l0DFJWn62Wxxv085K5ARxPhBxJbWKli7+7gJrc3I02gJ4xTJ3BmyCj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nBo54KHe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A5386C43390;
	Thu, 25 Jan 2024 00:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706143227;
	bh=J8OrFbZ6p2Es2PNzFeewNd0/aA/PXopYkzTYOJFEy+o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nBo54KHeJnUG/98Ev7Z/PP2MLOjXSNp8uhMwH/uv2aHLdLjuzWS29kyKRSI67or7X
	 2MI314yQzk2gktsy04rqYi9s5g+2L5Ri7lkYVzxvXcAR7YwapFO3zK8RK/Ton39eC2
	 mx2Zqfq3tCHrZ7WSN7KpdYdAEhHCjKO88Uvkt9f7qLfw3PAVEn3BGWvU9/2db6EUrt
	 nDxN8XdJbzaeWR3KeXHDNBxw8LAsHsUaafl4EeKN7Qy4ucCcm3MVrB90FXSjjEzyw6
	 RzYkv3MljkNaPPIbajkjtmntOwM5kPMI1sOwt973Kr5XOoTrqmgKraHvwU3bBxRYMt
	 YP5LXn6pKSYxg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8C6D4D8C966;
	Thu, 25 Jan 2024 00:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 bpf 00/11] net: bpf_xdp_adjust_tail() and Intel mbuf fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170614322757.2287.16460177244589273549.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jan 2024 00:40:27 +0000
References: <20240124191602.566724-1-maciej.fijalkowski@intel.com>
In-Reply-To: <20240124191602.566724-1-maciej.fijalkowski@intel.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, netdev@vger.kernel.org, magnus.karlsson@intel.com,
 bjorn@kernel.org, echaudro@redhat.com, lorenzo@kernel.org,
 martin.lau@linux.dev, tirthendu.sarkar@intel.com, john.fastabend@gmail.com,
 horms@kernel.org, kuba@kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 24 Jan 2024 20:15:51 +0100 you wrote:
> Hey,
> 
> after a break followed by dealing with sickness, here is a v6 that makes
> bpf_xdp_adjust_tail() actually usable for ZC drivers that support XDP
> multi-buffer. Since v4 I tried also using bpf_xdp_adjust_tail() with
> positive offset which exposed yet another issues, which can be observed
> by increased commit count when compared to v3.
> 
> [...]

Here is the summary with links:
  - [v6,bpf,01/11] xsk: recycle buffer in case Rx queue was full
    https://git.kernel.org/bpf/bpf/c/269009893146
  - [v6,bpf,02/11] xsk: make xsk_buff_pool responsible for clearing xdp_buff::flags
    https://git.kernel.org/bpf/bpf/c/f7f6aa8e2438
  - [v6,bpf,03/11] xsk: fix usage of multi-buffer BPF helpers for ZC XDP
    https://git.kernel.org/bpf/bpf/c/c5114710c8ce
  - [v6,bpf,04/11] ice: work on pre-XDP prog frag count
    https://git.kernel.org/bpf/bpf/c/ad2047cf5d93
  - [v6,bpf,05/11] i40e: handle multi-buffer packets that are shrunk by xdp prog
    https://git.kernel.org/bpf/bpf/c/83014323c642
  - [v6,bpf,06/11] ice: remove redundant xdp_rxq_info registration
    https://git.kernel.org/bpf/bpf/c/2ee788c06493
  - [v6,bpf,07/11] intel: xsk: initialize skb_frag_t::bv_offset in ZC drivers
    https://git.kernel.org/bpf/bpf/c/290779905d09
  - [v6,bpf,08/11] ice: update xdp_rxq_info::frag_size for ZC enabled Rx queue
    https://git.kernel.org/bpf/bpf/c/3de38c871742
  - [v6,bpf,09/11] xdp: reflect tail increase for MEM_TYPE_XSK_BUFF_POOL
    https://git.kernel.org/bpf/bpf/c/fbadd83a612c
  - [v6,bpf,10/11] i40e: set xdp_rxq_info::frag_size
    https://git.kernel.org/bpf/bpf/c/a045d2f2d03d
  - [v6,bpf,11/11] i40e: update xdp_rxq_info::frag_size for ZC enabled Rx queue
    https://git.kernel.org/bpf/bpf/c/0cbb08707c93

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



