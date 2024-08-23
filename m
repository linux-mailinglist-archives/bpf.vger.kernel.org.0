Return-Path: <bpf+bounces-37906-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A96C995C20A
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 02:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AC93285334
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 00:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420D9A21;
	Fri, 23 Aug 2024 00:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a/nowcG9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B477C195;
	Fri, 23 Aug 2024 00:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724371853; cv=none; b=aIsdhVGlcM0sZqP/z8G9yQLin7hCGKeKz7c01Y3hmGiQEnXvxGO+F/sYoW1DTseUozlUEiyt6+4q35fu4je2zoYHCl85QMYAmycwVK378enpFgtoMgy5vh1PF908FId646cJNhhof+UaLi4v4zTJvgF9EYkw1luczO0KHhJtYVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724371853; c=relaxed/simple;
	bh=Zig78F1jxYvV1YE2GVzXH2LxBcFyyr9YBg8AGV5nTvk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EAquNUxyIgJQ1eMWIAsfkRLjQhA52pAu2FENLY+8/7SsGHMDiggMVCzzqKtJUDcku0qswyxy7hFk/ckukLlX5XD7aEykkVds/BV4rcQLtbOZwlDUyd6PEtSvHbWELR/L8s1fR9un6QkeBtXeEt6qaOIKSWM272BoodsEzDMN4GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a/nowcG9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ED14C32782;
	Fri, 23 Aug 2024 00:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724371853;
	bh=Zig78F1jxYvV1YE2GVzXH2LxBcFyyr9YBg8AGV5nTvk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=a/nowcG9ERskdDMxErmUu5qIWGjv4rH+kulKaudu6KhvjzmgNKqEDZ56IRzXeXMF3
	 k+eh7XmUrRM36ZoNykiiCCKSnt0Sf+UBi7aGdFEuOXORWLB9MEU9ovdrWoWBPBqCM4
	 N+JJE5yn7LAA1IVaYY6pFRwjMxwpLCH7AaNhCyG1+J3U6R53qHehS1jhCf+2b/gJfY
	 QyNagUH6gmmkPrXcqSQebIwFcwk3Y3K5bNrMaqhFJ3Krjx4T7k0sUmKQLfTDWmod1L
	 yzFFwjRMuZe7AJ1PJf1aCSACbRLGy/UIoO4/6zOlZTfkwZVqfzIZSCJMAW0o60hYkq
	 Ghvn5qjZt8EVg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D123809A81;
	Fri, 23 Aug 2024 00:10:54 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/12] Unmask upper DSCP bits - part 1
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172437185328.2512544.14083176872988992315.git-patchwork-notify@kernel.org>
Date: Fri, 23 Aug 2024 00:10:53 +0000
References: <20240821125251.1571445-1-idosch@nvidia.com>
In-Reply-To: <20240821125251.1571445-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, gnault@redhat.com,
 dsahern@kernel.org, fw@strlen.de, martin.lau@linux.dev, daniel@iogearbox.net,
 john.fastabend@gmail.com, ast@kernel.org, pablo@netfilter.org,
 kadlec@netfilter.org, willemdebruijn.kernel@gmail.com, bpf@vger.kernel.org,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 21 Aug 2024 15:52:39 +0300 you wrote:
> tl;dr - This patchset starts to unmask the upper DSCP bits in the IPv4
> flow key in preparation for allowing IPv4 FIB rules to match on DSCP. No
> functional changes are expected.
> 
> The TOS field in the IPv4 flow key ('flowi4_tos') is used during FIB
> lookup to match against the TOS selector in FIB rules and routes.
> 
> [...]

Here is the summary with links:
  - [net-next,01/12] bpf: Unmask upper DSCP bits in bpf_fib_lookup() helper
    https://git.kernel.org/netdev/net-next/c/ef434fae7228
  - [net-next,02/12] ipv4: Unmask upper DSCP bits in NETLINK_FIB_LOOKUP family
    https://git.kernel.org/netdev/net-next/c/bc52a4eecefd
  - [net-next,03/12] ipv4: Unmask upper DSCP bits when constructing the Record Route option
    https://git.kernel.org/netdev/net-next/c/be2e9089cb34
  - [net-next,04/12] netfilter: rpfilter: Unmask upper DSCP bits
    https://git.kernel.org/netdev/net-next/c/c1ae5ca69b69
  - [net-next,05/12] netfilter: nft_fib: Unmask upper DSCP bits
    https://git.kernel.org/netdev/net-next/c/338385e059c5
  - [net-next,06/12] ipv4: ipmr: Unmask upper DSCP bits in ipmr_rt_fib_lookup()
    https://git.kernel.org/netdev/net-next/c/2bc9778b6696
  - [net-next,07/12] ipv4: Unmask upper DSCP bits in fib_compute_spec_dst()
    https://git.kernel.org/netdev/net-next/c/39d3628f7cea
  - [net-next,08/12] ipv4: Unmask upper DSCP bits in input route lookup
    https://git.kernel.org/netdev/net-next/c/df9131c7fafd
  - [net-next,09/12] ipv4: Unmask upper DSCP bits in RTM_GETROUTE input route lookup
    https://git.kernel.org/netdev/net-next/c/b1251a6f1a9b
  - [net-next,10/12] ipv4: icmp: Pass full DS field to ip_route_input()
    https://git.kernel.org/netdev/net-next/c/1c6f50b37f71
  - [net-next,11/12] ipv4: udp: Unmask upper DSCP bits during early demux
    https://git.kernel.org/netdev/net-next/c/b6791ac5ea49
  - [net-next,12/12] ipv4: Unmask upper DSCP bits when using hints
    https://git.kernel.org/netdev/net-next/c/be8b8ded7799

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



