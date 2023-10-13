Return-Path: <bpf+bounces-12129-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6E47C81D5
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 11:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBF252825D7
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 09:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66E711195;
	Fri, 13 Oct 2023 09:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gd8Tb2MX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BD210A0B;
	Fri, 13 Oct 2023 09:20:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9C80DC433CB;
	Fri, 13 Oct 2023 09:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697188827;
	bh=y9jDUO5xD/h+ai60uaWtxxXBe+UBTx8FQS8ef0NQ1CQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Gd8Tb2MXQKv6DGxUg8FsrdZKl2dCaM7voXeaoiMPw1XT/l8feYLlF8hObsMl+giqX
	 FIgDIuUeKTHLowxNfOK+JeCPucUl57d49MRWT91CmksF2l96zO4xzGSWhr5/G5xeLR
	 ImpqY7K5mNHUPjxq3HsBSq19Ob3pYIXPBowbKPJRDNGkBRvfcvzWPP6jZG02E5Cftl
	 ram5MyckjFF8NiT+EPo8EuWD3QG75eUxCR4TvCddcOYTJ88alDgvlkKySzQDCq75Wa
	 mU3Q14WiEEqD8VV05rxDVPyDr2vhjdsQUAbjrJ2QK3GmytuWFlQuQDYSxBu2j98P9y
	 lrCPDkaVweQwA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 821DAC691EF;
	Fri, 13 Oct 2023 09:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: fec: replace deprecated strncpy with ethtool_sprintf
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169718882752.6212.16802837129949088436.git-patchwork-notify@kernel.org>
Date: Fri, 13 Oct 2023 09:20:27 +0000
References: <20231009-strncpy-drivers-net-ethernet-freescale-fec_main-c-v1-1-4166833f1431@google.com>
In-Reply-To: <20231009-strncpy-drivers-net-ethernet-freescale-fec_main-c-v1-1-4166833f1431@google.com>
To: Justin Stitt <justinstitt@google.com>
Cc: wei.fang@nxp.com, shenwei.wang@nxp.com, xiaoning.wang@nxp.com,
 linux-imx@nxp.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 09 Oct 2023 23:05:41 +0000 you wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> ethtool_sprintf() is designed specifically for get_strings() usage.
> Let's replace strncpy in favor of this more robust and easier to
> understand interface.
> 
> [...]

Here is the summary with links:
  - net: fec: replace deprecated strncpy with ethtool_sprintf
    https://git.kernel.org/netdev/net-next/c/659ce55fddd2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



