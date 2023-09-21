Return-Path: <bpf+bounces-10601-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 082027AA531
	for <lists+bpf@lfdr.de>; Fri, 22 Sep 2023 00:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id CB4B2286927
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 22:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F3720338;
	Thu, 21 Sep 2023 22:40:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEA1168B3;
	Thu, 21 Sep 2023 22:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 746EFC433C7;
	Thu, 21 Sep 2023 22:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695336024;
	bh=YJWf9LmGERCK01Hcj/TS3IGtBPmay9vgQw9uJoivTtA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gdxniGFlXCI4g5BAA/DqQq4X7YCYXqTO6RWkaeGX1ed0R7T5zY95g+nnA4VS5g/gL
	 puwMa+Za40IDdwr1dNiZKv3+wzCb0/VZ793+w8CI6EPB4nxXNJrHs5CCr01iKXzUVt
	 zRl+5tcNcpuTR2T/3JRY1tr0BJbPMTKDs7tsqpujlSl28Q02ByRSMCzcrKWKlCn8BP
	 wR8DRDeHiDOHaz5c97e5q218kZoz47pqJ4w74ZtXPXyyvMB7JvxM3thDIUP+NAurlV
	 YFPCpKHbMMzAMKpq8lZ6p2kJZrExJd/kZY8yP+RIFRA3C6FYrPYbdXQY/Gc60dxCYd
	 gEv0UKpFwIeyQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5B8C1E11F40;
	Thu, 21 Sep 2023 22:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v1] bpf,
 docs: Add loongarch64 as arch supporting BPF JIT
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169533602435.20538.12738329187307671554.git-patchwork-notify@kernel.org>
Date: Thu, 21 Sep 2023 22:40:24 +0000
References: <1695111937-19697-1-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1695111937-19697-1-git-send-email-yangtiezhu@loongson.cn>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: corbet@lwn.net, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Tue, 19 Sep 2023 16:25:37 +0800 you wrote:
> As BPF JIT support for loongarch64 was added about one year ago
> with commit 5dc615520c4d ("LoongArch: Add BPF JIT support"), it
> is appropriate to add loongarch64 as arch supporting BPF JIT in
> bpf and sysctl docs as well.
> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> 
> [...]

Here is the summary with links:
  - [bpf-next,v1] bpf, docs: Add loongarch64 as arch supporting BPF JIT
    https://git.kernel.org/bpf/bpf-next/c/ac0691c75ab7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



