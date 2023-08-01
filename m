Return-Path: <bpf+bounces-6499-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA8A76A5DD
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 03:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE84B1C20AB0
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 01:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7CA653;
	Tue,  1 Aug 2023 01:00:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772657E;
	Tue,  1 Aug 2023 01:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E7D47C433C7;
	Tue,  1 Aug 2023 01:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690851623;
	bh=OCmwlOTWPHIWCp3t7K6WyhLnDrlRp67gVDfyE58MgA4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=C1s7XZIaFGtCx05pfwIXuVobCjVzEJah4/EUH5Zl7dg6LYMcq96sM0cOlXdrYUW5h
	 ZAssyXvQFxHreP84eKIZY1zFIkz525HYTFobNatSAGMSZybYrR2Xdj4oy/z0yfgvW2
	 KtYaaUyQ2gM+KfdYaGGJpBK6kK/tReaEguFOauVxOY0U+1DxEn5s7xycKolW2ddkwp
	 Th/kFvcs+gi6jC3MEi+RlS4c3u9Yfdw2ixI7/Q+pU7kSTtrEeSoj2EyhU/bTkq0f8e
	 OCL94u1jlli4hgDI0osRwat0VOagow+7/BxZFVgsJOsM/hhK1IimvJ7+AM3Zfu11vR
	 gJ9ySvoPRPsQA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CBBB5E96ABF;
	Tue,  1 Aug 2023 01:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] netfilter: bpf: Only define get_proto_defrag_hook() if
 necessary
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169085162282.11842.12642212227256267164.git-patchwork-notify@kernel.org>
Date: Tue, 01 Aug 2023 01:00:22 +0000
References: <b128b6489f0066db32c4772ae4aaee1480495929.1690840454.git.dxu@dxuuu.xyz>
In-Reply-To: <b128b6489f0066db32c4772ae4aaee1480495929.1690840454.git.dxu@dxuuu.xyz>
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: kadlec@netfilter.org, davem@davemloft.net, pabeni@redhat.com,
 ast@kernel.org, edumazet@google.com, pablo@netfilter.org, kuba@kernel.org,
 fw@strlen.de, netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 lkp@intel.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 31 Jul 2023 15:55:00 -0600 you wrote:
> Before, we were getting this warning:
> 
>   net/netfilter/nf_bpf_link.c:32:1: warning: 'get_proto_defrag_hook' defined but not used [-Wunused-function]
> 
> Guard the definition with CONFIG_NF_DEFRAG_IPV[4|6].
> 
> Fixes: 91721c2d02d3 ("netfilter: bpf: Support BPF_F_NETFILTER_IP_DEFRAG in netfilter link")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202307291213.fZ0zDmoG-lkp@intel.com/
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> 
> [...]

Here is the summary with links:
  - netfilter: bpf: Only define get_proto_defrag_hook() if necessary
    https://git.kernel.org/bpf/bpf-next/c/81584c23f249

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



