Return-Path: <bpf+bounces-33502-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C63C91E374
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 17:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF3BA283137
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 15:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7474C16CD2D;
	Mon,  1 Jul 2024 15:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lV9r7hAJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E385384DE9;
	Mon,  1 Jul 2024 15:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719846629; cv=none; b=o+El8hNUQE1kCrrs/iZIF7q4WPMsfeAVEcuRf3nSPtiIVyht7M/NIQeqiFQyupzPe7evgK9Ek1zkscdKYY5IZsXWktjrINxJSvHkQBQdgsPcB2ajOKhTTVx0Sc9kxoyFmoiRM2sdxcvws+Dk1A5zjd3pOCx9HZ2wcJ/mO5mDeQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719846629; c=relaxed/simple;
	bh=MMhmd+2OqCPynT3QO2s+IyuhlXayN0mUXmdQP4pBhXc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jB02WDMI1qGOgzO+aneD8610dbW4BhuWk7w39vzerBlWYQzrgyOSzleJbLErB0ByNCgtYUF05f65bIiOPAOrGXm3/dgX7i6UZ6OqYAz2w5ry6kw81QTKg/nCFM5KUUj9xrZUGjNnWUJqM0sJ86PObN102yEKSlWEJFcxJ5ZSrg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lV9r7hAJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 919A0C4AF12;
	Mon,  1 Jul 2024 15:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719846628;
	bh=MMhmd+2OqCPynT3QO2s+IyuhlXayN0mUXmdQP4pBhXc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lV9r7hAJjQEcxvhXproilhEBUcPjUx6bscl+ZuG+DZjXKTsnVdGye8PpjE0zlE2Do
	 sf+WDe1YmIijeVQe3eQQJW6AuHquUHvr+p8C7WLyGggZ2UbSARQWYORUTkTJfT/Z6R
	 zM7N850/CWtDFl6UWRF10IjXrLa0ryyowk5hRDeFuN1pEqPRobXiQDMt71k2B2TdeS
	 EnFbPIRoWKBF2aA9Jl5ft+JRNA0T7qyTMDNmVv0N01epugVUh/aZzYGGowZSrjjE1t
	 cSVX/PN6nqoD1A1f/7PITzqWdS+ra4st5VC4r3WXbDan51F5rTW4+LamsL1BriIdnD
	 bM5C4wcSCa5+A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7D276C43468;
	Mon,  1 Jul 2024 15:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 bpf-next 0/3] netfilter: Add the capability to offload
 flowtable in XDP layer
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171984662850.25774.11398044687534883438.git-patchwork-notify@kernel.org>
Date: Mon, 01 Jul 2024 15:10:28 +0000
References: <cover.1719698275.git.lorenzo@kernel.org>
In-Reply-To: <cover.1719698275.git.lorenzo@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: bpf@vger.kernel.org, pablo@netfilter.org, kadlec@netfilter.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netfilter-devel@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, lorenzo.bianconi@redhat.com, toke@redhat.com,
 fw@strlen.de, hawk@kernel.org, horms@kernel.org, donhunte@redhat.com,
 memxor@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Sun, 30 Jun 2024 00:26:47 +0200 you wrote:
> Introduce bpf_xdp_flow_lookup kfunc in order to perform the lookup of
> a given flowtable entry based on the fib tuple of incoming traffic.
> bpf_xdp_flow_lookup can be used as building block to offload in XDP
> the sw flowtable processing when the hw support is not available.
> 
> This series has been tested running the xdp_flowtable_offload eBPF program
> on an ixgbe 10Gbps NIC (eno2) in order to XDP_REDIRECT the TCP traffic to
> a veth pair (veth0-veth1) based on the content of the nf_flowtable as soon
> as the TCP connection is in the established state:
> 
> [...]

Here is the summary with links:
  - [v6,bpf-next,1/3] netfilter: nf_tables: add flowtable map for xdp offload
    https://git.kernel.org/bpf/bpf-next/c/89cc8f1c5f22
  - [v6,bpf-next,2/3] netfilter: add bpf_xdp_flow_lookup kfunc
    https://git.kernel.org/bpf/bpf-next/c/391bb6594fd3
  - [v6,bpf-next,3/3] selftests/bpf: Add selftest for bpf_xdp_flow_lookup kfunc
    https://git.kernel.org/bpf/bpf-next/c/c77e572d3a8c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



