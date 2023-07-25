Return-Path: <bpf+bounces-5878-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C299762441
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 23:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB59B281A89
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 21:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BF726B93;
	Tue, 25 Jul 2023 21:20:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714FC1F188;
	Tue, 25 Jul 2023 21:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EEE98C433C7;
	Tue, 25 Jul 2023 21:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690320022;
	bh=qynhg+B0dn5o76K6T3oIuZMcKx5pVy2asQYuqzlGuyQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gCc7QImp09jJfavitxZgJt34IpmKMQzkADhSErxsL7nbem5+0qMhP43x4woJBaHzU
	 frp6O7WO+vI7bMjzd3KS1fvW91I46Rb9NWge+tppAfcxLHRlHHz2di/xluXr/vTuvw
	 BlhzxE105J73e7XXjYzHAfcekxo2qjJKlEeu8uWjVAPo4q20oEn3KOwBifV+Rffee9
	 9UMc458QQIrfWw/xyxz+VU0vWfoKg1iJSU8BkP/E66I5XncRjGsdrkBa30F/SnKOOD
	 P1J6JlIJV32CvsYbb91hRre94nOncy9KiaXFZeQJQ0Ey9/hUp/cbrvL5CnQPXucnRA
	 arhxWRLP5QzYw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C8225C73FE4;
	Tue, 25 Jul 2023 21:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v6 0/8] Add SO_REUSEPORT support for TC
 bpf_sk_assign
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169032002180.5361.5393311754104928741.git-patchwork-notify@kernel.org>
Date: Tue, 25 Jul 2023 21:20:21 +0000
References: <20230720-so-reuseport-v6-0-7021b683cdae@isovalent.com>
In-Reply-To: <20230720-so-reuseport-v6-0-7021b683cdae@isovalent.com>
To: Lorenz Bauer <lmb@isovalent.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 joe@wand.net.nz, mykolal@fb.com, shuah@kernel.org, kuniyu@amazon.com,
 hemanthmalla@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, joe@cilium.io

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Thu, 20 Jul 2023 17:30:04 +0200 you wrote:
> We want to replace iptables TPROXY with a BPF program at TC ingress.
> To make this work in all cases we need to assign a SO_REUSEPORT socket
> to an skb, which is currently prohibited. This series adds support for
> such sockets to bpf_sk_assing.
> 
> I did some refactoring to cut down on the amount of duplicate code. The
> key to this is to use INDIRECT_CALL in the reuseport helpers. To show
> that this approach is not just beneficial to TC sk_assign I removed
> duplicate code for bpf_sk_lookup as well.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v6,1/8] udp: re-score reuseport groups when connected sockets are present
    https://git.kernel.org/bpf/bpf-next/c/f0ea27e7bfe1
  - [bpf-next,v6,2/8] bpf: reject unhashed sockets in bpf_sk_assign
    https://git.kernel.org/bpf/bpf-next/c/67312adc96b5
  - [bpf-next,v6,3/8] net: export inet_lookup_reuseport and inet6_lookup_reuseport
    https://git.kernel.org/bpf/bpf-next/c/ce796e60b3b1
  - [bpf-next,v6,4/8] net: remove duplicate reuseport_lookup functions
    https://git.kernel.org/bpf/bpf-next/c/0f495f761722
  - [bpf-next,v6,5/8] net: document inet[6]_lookup_reuseport sk_state requirements
    https://git.kernel.org/bpf/bpf-next/c/2a61776366bd
  - [bpf-next,v6,6/8] net: remove duplicate sk_lookup helpers
    https://git.kernel.org/bpf/bpf-next/c/6c886db2e78c
  - [bpf-next,v6,7/8] bpf, net: Support SO_REUSEPORT sockets with bpf_sk_assign
    (no matching commit)
  - [bpf-next,v6,8/8] selftests/bpf: Test that SO_REUSEPORT can be used with sk_assign helper
    https://git.kernel.org/bpf/bpf-next/c/22408d58a42c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



