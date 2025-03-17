Return-Path: <bpf+bounces-54209-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C16A6568E
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 16:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F40F2189C290
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 15:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B32519992C;
	Mon, 17 Mar 2025 15:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p5qBC26t"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F31192B81;
	Mon, 17 Mar 2025 15:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742226606; cv=none; b=LXummjgYFSXjFvJLXMEzHDKIgOxLRh7cgdehrHXCZLrfZ8pzECP/PnJwei6nI8PDDoZztDGbWKmcXXxdtYlkMXyRoKTBM9LazlLZQPtChoZN2114iaQMS1hmC/M2ZpvRqDKpxUAMP/T80fF/J+wWBbJ/KeJ2EizjjMW11qabm3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742226606; c=relaxed/simple;
	bh=nMH0RzohJoZBT5RceZ8BBKm/q1nNIbRA2dK3YQi/RDo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rijBwn5GBY5LI7aofcH3toX8fKdSyhau2VIjAzE2gMwr4x2B1yrI8gLMnVXox0WdyAx4knIiCm3bA1WbIuo7d/eLhN5YgtXL4wwPQPUw9sSU8mNw0YHuYH5d/3Ql9cK5Md+sv2eoqd5pvcXLVncyfj69p3INN3TFQIxrAc7RJCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p5qBC26t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A0B9C4CEE3;
	Mon, 17 Mar 2025 15:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742226605;
	bh=nMH0RzohJoZBT5RceZ8BBKm/q1nNIbRA2dK3YQi/RDo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=p5qBC26t1VXdd7vTO8m0/a6n/R8f+BPfqE/NJwnP6iKdhhD1jYkbqLsfRwayShSSA
	 aYPBUnZHGesLAc3U6++tLMwKw6YuT5L+/vo7+raymIeTdG3+y3sJcNzit4ZzsZUg8d
	 oc9faAwsr7pKJ6rvnKWSNyrf0YitKm4o8puiMkjlhhoDGzkVbKBg9pjwAn1ymugYKL
	 SubbZ2mu2pXVQoPhgnCawLRcamWlFV45ogb9NRCJV5iUWssU4UqWqPOtpCB4kaulgF
	 gSmf6J5bPFp44ED6EOUsoxWyefHekEhEzEQYAt0p8N04fkto45FlBjAY9M4Y5C+71w
	 r9VL70wLdTwoA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB6B3380CFF7;
	Mon, 17 Mar 2025 15:50:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v7 net-next 00/12] AccECN protocol preparation patch series
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174222664074.3797981.10286790754550014794.git-patchwork-notify@kernel.org>
Date: Mon, 17 Mar 2025 15:50:40 +0000
References: <20250305223852.85839-1-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20250305223852.85839-1-chia-yu.chang@nokia-bell-labs.com>
To: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>
Cc: netdev@vger.kernel.org, dsahern@gmail.com, davem@davemloft.net,
 edumazet@google.com, dsahern@kernel.org, pabeni@redhat.com,
 joel.granados@kernel.org, kuba@kernel.org, andrew+netdev@lunn.ch,
 horms@kernel.org, pablo@netfilter.org, kadlec@netfilter.org,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 kory.maincent@bootlin.com, bpf@vger.kernel.org, kuniyu@amazon.com,
 andrew@lunn.ch, ij@kernel.org, ncardwell@google.com,
 koen.de_schepper@nokia-bell-labs.com, g.white@CableLabs.com,
 ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
 cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
 vidhi_goel@apple.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed,  5 Mar 2025 23:38:40 +0100 you wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> Hello,
> 
> Please find the v7
> 
> v7 (03-Mar-2025)
> - Move 2 new patches added in v6 to the next AccECN patch series
> 
> [...]

Here is the summary with links:
  - [v7,net-next,01/12] tcp: reorganize tcp_in_ack_event() and tcp_count_delivered()
    https://git.kernel.org/netdev/net-next/c/149dfb31615e
  - [v7,net-next,02/12] tcp: create FLAG_TS_PROGRESS
    https://git.kernel.org/netdev/net-next/c/da610e18313b
  - [v7,net-next,03/12] tcp: use BIT() macro in include/net/tcp.h
    https://git.kernel.org/netdev/net-next/c/0114a91da672
  - [v7,net-next,04/12] tcp: extend TCP flags to allow AE bit/ACE field
    https://git.kernel.org/netdev/net-next/c/2c2f08d31d2f
  - [v7,net-next,05/12] tcp: reorganize SYN ECN code
    (no matching commit)
  - [v7,net-next,06/12] tcp: rework {__,}tcp_ecn_check_ce() -> tcp_data_ecn_check()
    https://git.kernel.org/netdev/net-next/c/f0db2bca0cf9
  - [v7,net-next,07/12] tcp: helpers for ECN mode handling
    (no matching commit)
  - [v7,net-next,08/12] gso: AccECN support
    https://git.kernel.org/netdev/net-next/c/023af5a72ab1
  - [v7,net-next,09/12] gro: prevent ACE field corruption & better AccECN handling
    https://git.kernel.org/netdev/net-next/c/4e4f7cefb130
  - [v7,net-next,10/12] tcp: AccECN support to tcp_add_backlog
    https://git.kernel.org/netdev/net-next/c/d722762c4eaa
  - [v7,net-next,11/12] tcp: add new TCP_TW_ACK_OOW state and allow ECN bits in TOS
    https://git.kernel.org/netdev/net-next/c/4618e195f925
  - [v7,net-next,12/12] tcp: Pass flags to __tcp_send_ack
    https://git.kernel.org/netdev/net-next/c/9866884ce8ef

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



