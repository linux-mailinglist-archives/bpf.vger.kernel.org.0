Return-Path: <bpf+bounces-10175-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1047A255A
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 20:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA59E281CF2
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 18:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3EB171C3;
	Fri, 15 Sep 2023 18:10:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C58A30D16;
	Fri, 15 Sep 2023 18:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DB543C433C8;
	Fri, 15 Sep 2023 18:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694801424;
	bh=E1T4tSO3mmZZENX032anl81oElEsBXkI6sMMOcyYg3k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dilk96oi5ZBpMOvaBAjx+EieZOfD0r21sDJnu8XwxhzMpLaHAb1PBmqAxQ+036Fuk
	 UxOZHyrihlGGR/t64s0zppbi+e21IlSlihk0eiKhtiU0rPpZQntxAIjbSl4v6K/utT
	 ViElzfXlnSOaPW/hiI8gq3XqVmjqoJ2fZslqP9VcCIpSvt4txFFseBNL8cpKGO74g/
	 3fNaFZKkeNtK+vl9nWm4I5LLRnX8b6yOGpm69di/7KEDkuspFpkCwZTk1KPodcl9WG
	 xTbRrycsZQRuNENrQ2ghEeOX2RiIyueGpEuopCrR6uTXDKmfFYBoxTH6fXwdGM5ksj
	 k6E4bXzS0XL0w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BEAD4C04DD9;
	Fri, 15 Sep 2023 18:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] xsk: add multi-buffer support for sockets sharing
 umem
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169480142477.30383.2749395103301171333.git-patchwork-notify@kernel.org>
Date: Fri, 15 Sep 2023 18:10:24 +0000
References: <20230907035032.2627879-1-tirthendu.sarkar@intel.com>
In-Reply-To: <20230907035032.2627879-1-tirthendu.sarkar@intel.com>
To: Sarkar@codeaurora.org, Tirthendu <tirthendu.sarkar@intel.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, bjorn@kernel.org,
 magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 jonathan.lemon@gmail.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu,  7 Sep 2023 09:20:32 +0530 you wrote:
> Userspace applications indicate their multi-buffer capability to xsk
> using XSK_USE_SG socket bind flag. For sockets using shared umem the
> bind flag may contain XSK_USE_SG only for the first socket. For any
> subsequent socket the only option supported is XDP_SHARED_UMEM.
> 
> Add option XDP_UMEM_SG_FLAG in umem config flags to store the
> multi-buffer handling capability when indicated by XSK_USE_SG option in
> bing flag by the first socket. Use this to derive multi-buffer capability
> for subsequent sockets in xsk core.
> 
> [...]

Here is the summary with links:
  - [bpf-next] xsk: add multi-buffer support for sockets sharing umem
    https://git.kernel.org/bpf/bpf-next/c/d609f3d228a8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



