Return-Path: <bpf+bounces-6289-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B128767941
	for <lists+bpf@lfdr.de>; Sat, 29 Jul 2023 02:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 525E028280B
	for <lists+bpf@lfdr.de>; Sat, 29 Jul 2023 00:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53BF3214F0;
	Sat, 29 Jul 2023 00:00:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F03317ABD;
	Sat, 29 Jul 2023 00:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0FB12C433C7;
	Sat, 29 Jul 2023 00:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690588824;
	bh=K5+XOsV1PmFjr6Y+NoSjlqVr4nBt42EXshVfzdbLfbc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jC4WrhGZHTySo/2DoZaU+HyEhhNvSxyBy0Pn9Hx4eRhJq4lmvDuSEDJIRzBkel3b+
	 aqenqxRRjSZn+o0U8iFp0ypgPEovV+uDlp8mrJwfC85e4mpFEgjo44vJ8kiErt4zmv
	 zfWs4xu49o44xjAgvZj/hHOv3VoVicW7KpS6CXTQS9fMIPhaQBSp69ifTiCSUm6+Vj
	 VWf3IRYDofG9QJ/CG4XpENN9V7VgYvS6XEx7vXx6TzN4nHGypG6plztqUeAT8s4vK9
	 EcLwkPfGsGx8D2BXloNMYrNsaA7UTUdp3o4WR/QRBVJstDciiqnuSx3u85yovKJ5j2
	 btEpM4O9fiZTw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E8408C4166F;
	Sat, 29 Jul 2023 00:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v6 0/5] Support defragmenting IPv(4|6) packets in BPF
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169058882394.20221.4449281517467236117.git-patchwork-notify@kernel.org>
Date: Sat, 29 Jul 2023 00:00:23 +0000
References: <cover.1689970773.git.dxu@dxuuu.xyz>
In-Reply-To: <cover.1689970773.git.dxu@dxuuu.xyz>
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: linux-kernel@vger.kernel.org, coreteam@netfilter.org,
 netfilter-devel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com,
 fw@strlen.de, daniel@iogearbox.net, dsahern@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 21 Jul 2023 14:22:44 -0600 you wrote:
> === Context ===
> 
> In the context of a middlebox, fragmented packets are tricky to handle.
> The full 5-tuple of a packet is often only available in the first
> fragment which makes enforcing consistent policy difficult. There are
> really only two stateless options, neither of which are very nice:
> 
> [...]

Here is the summary with links:
  - [bpf-next,v6,1/5] netfilter: defrag: Add glue hooks for enabling/disabling defrag
    https://git.kernel.org/bpf/bpf-next/c/9abddac583d6
  - [bpf-next,v6,2/5] netfilter: bpf: Support BPF_F_NETFILTER_IP_DEFRAG in netfilter link
    https://git.kernel.org/bpf/bpf-next/c/91721c2d02d3
  - [bpf-next,v6,3/5] bpf: selftests: Support not connecting client socket
    https://git.kernel.org/bpf/bpf-next/c/3495e89cdc3a
  - [bpf-next,v6,4/5] bpf: selftests: Support custom type and proto for client sockets
    https://git.kernel.org/bpf/bpf-next/c/e15a22095608
  - [bpf-next,v6,5/5] bpf: selftests: Add defrag selftests
    https://git.kernel.org/bpf/bpf-next/c/c313eae739b9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



