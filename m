Return-Path: <bpf+bounces-41871-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 306ED99D317
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 17:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA98E1F250DD
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 15:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F063A1C8306;
	Mon, 14 Oct 2024 15:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uWOsX9VG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7596C1CAB8;
	Mon, 14 Oct 2024 15:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728919824; cv=none; b=RBvyPCezjy6OeoabwXPkNmyivcorEdwP4tof1V8zze+YQa1vJgJaAM9gh+Qj5oJqkxUyB6qfylVj1P024v1pdQq6UYMqRoVdGH9Ut7kylig8XqKG13lTCSYUzUV72j1FYIDJyr9dWHCjuq3KLdhix7SIfVJZWwVmfFeQg07jgGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728919824; c=relaxed/simple;
	bh=IFh152OzkNNwBp2V666FvTPbVLmElo7Ra8vfg4hP9ak=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jfoBEhTTE1GWKPT2MSwcZf6HqYxGAwRXqZ9qjQQOi0vD/Njd5J2MMerTNEPrUU05tJYOyMrPRbNkwp17p9BRU53YS4PTvJso+nvGUlnpuMtGbe0JHD85DFWynY2s/gTAjnikpq6ED5A/tBTVGje+iNe3jrUNKKeu5I6i/4FF72A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uWOsX9VG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA1CC4CEC3;
	Mon, 14 Oct 2024 15:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728919824;
	bh=IFh152OzkNNwBp2V666FvTPbVLmElo7Ra8vfg4hP9ak=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uWOsX9VGmdQK86EEKryFp2zRFdllIQRmfv+M63mlVAEZm3Ita7Quwklw13Dk4tp68
	 ZgK1pHq4WyhkvSxRbZthX9RrBMmuezze5EOLb3mVURgaVIG0XF0cnZFepIkmG9Q8Cp
	 FVgZR7mHvAT6EiMmFnY3bGg/xKU1nNv1YNJT9nmoeGvqANAJ8U8EGLbJO/57dLTxcB
	 XBa3ZRfuibfu5/MLV5rg0Q2fZTqiXVvlIHXqFblSTlF/6Rt9e3ZLXMwXcpDfWB6lmo
	 WX9g9L/Tv0+5NkOd5uuvx+iywixP1Vw1Z6fd63z7bdMb++TcRJC30Flh9MWbO1DqfT
	 l4LS/OgYBfzvA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 711993822E4C;
	Mon, 14 Oct 2024 15:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next 0/6] xsk: struct diet and cleanups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172891982926.552239.13770014212967008223.git-patchwork-notify@kernel.org>
Date: Mon, 14 Oct 2024 15:30:29 +0000
References: <20241007122458.282590-1-maciej.fijalkowski@intel.com>
In-Reply-To: <20241007122458.282590-1-maciej.fijalkowski@intel.com>
To: Fijalkowski@codeaurora.org, Maciej <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, netdev@vger.kernel.org, magnus.karlsson@intel.com,
 bjorn@kernel.org, vadfed@meta.com

Hello:

This series was applied to bpf/bpf-next.git (net)
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon,  7 Oct 2024 14:24:52 +0200 you wrote:
> Hi all,
> 
> this modest work brings back size of xdp_buff_xsk back to two cache
> lines which in turn improves performance. Interestingly I was able to
> observe on ice with HW rings sized to 512 around 12% better performance
> when running xdpsock in l2fwd scenario. First three patches are behind
> this. Other setups were not that impressive, I believe results may vary
> based on the underlying CPU. Bottom line is that shrinking this struct
> takes off a bit of work from CPU's shoulders.
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next,1/6] xsk: get rid of xdp_buff_xsk::xskb_list_node
    https://git.kernel.org/bpf/bpf-next/c/b692bf9a7543
  - [v2,bpf-next,2/6] xsk: s/free_list_node/list_node
    https://git.kernel.org/bpf/bpf-next/c/30ec2c1baaea
  - [v2,bpf-next,3/6] xsk: get rid of xdp_buff_xsk::orig_addr
    https://git.kernel.org/bpf/bpf-next/c/bea14124bacb
  - [v2,bpf-next,4/6] xsk: carry a copy of xdp_zc_max_segs within xsk_buff_pool
    https://git.kernel.org/bpf/bpf-next/c/6e126872191d
  - [v2,bpf-next,5/6] xsk: wrap duplicated code to function
    https://git.kernel.org/bpf/bpf-next/c/1d10b2bed2d4
  - [v2,bpf-next,6/6] xsk: use xsk_buff_pool directly for cq functions
    https://git.kernel.org/bpf/bpf-next/c/e6c4047f5122

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



