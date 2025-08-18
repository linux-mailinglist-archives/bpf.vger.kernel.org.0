Return-Path: <bpf+bounces-65925-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A68B2B29C
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 22:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD046626FF4
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 20:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E15B259CA7;
	Mon, 18 Aug 2025 20:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ob5R/DIo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CF43451B8;
	Mon, 18 Aug 2025 20:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755549639; cv=none; b=dQD7YKLTqqBM7mEp3KjopygBuLRojIF5zGKSif5ogH6hQKuldKXEVTTA/ZjKaB1Hh7Rg2wHHAzRN56zx3llrHw77lgBuHitiLJlEgg5mNlKChNyW/5cNkavafcGkdy5cLhYk8rr5/n7QjkChuyiouatIXNnCI1KVEGev8VEzOxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755549639; c=relaxed/simple;
	bh=SLGzkMWb782QPOKXdJcGw4zS6aXjo42Av30yuVLNs8c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AOHo2eVdjZP3Hkv5T0YvucHxGVn1oRU1fKqSUQPAmFrTab5NA6oek6rOKCImxfNOyPdZbXmcJl5jdoE+SaTxawT8wSyShZo/pvtNF5buD2Gdk0C1T5GhyD5nPwsX5ZTm2keD5w7ppgreepuS3sU39hArFPHqmLEUHkvUU9rik18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ob5R/DIo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A0A2C4CEEB;
	Mon, 18 Aug 2025 20:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755549639;
	bh=SLGzkMWb782QPOKXdJcGw4zS6aXjo42Av30yuVLNs8c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ob5R/DIo0SS1ijjporX/AId4430MV/EnT9psgjVHQma0chjz9iV91fXrFU9xpGEun
	 Oo1Kd15fOcDTPRzz0geVAREEolvKXn54EtVFNM5TGhSC9WCWaRDjl9kntwqXsvnFdE
	 AMrevbUOXpVJC+j1Hlsl9R/P+1V4NDpOpAwzXoJEKuewBKB5vVQ0Vkuqj1OTaS26sJ
	 RSAQ2wqnZeCs3E2rxBroZTeWEFM+kD2xamWjIrixKZReIt3xky2MaxGKTp9l+hBVkX
	 SEMCEXVd2x/BgwQj1c6aif7nq3ZZvQP3rWHwnDcrrxi2WOaQNAyTACjwxfytbpgv/s
	 yDPfi5azox8oQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DD7383BF4E;
	Mon, 18 Aug 2025 20:40:50 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v7 0/9] Add a dynptr type for skb metadata for TC
 BPF
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175554964898.2904664.15930245053733821413.git-patchwork-notify@kernel.org>
Date: Mon, 18 Aug 2025 20:40:48 +0000
References: 
 <20250814-skb-metadata-thru-dynptr-v7-0-8a39e636e0fb@cloudflare.com>
In-Reply-To: 
 <20250814-skb-metadata-thru-dynptr-v7-0-8a39e636e0fb@cloudflare.com>
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 arthur@arthurfabre.com, daniel@iogearbox.net, eddyz87@gmail.com,
 edumazet@google.com, kuba@kernel.org, hawk@kernel.org,
 jbrandeburg@cloudflare.com, joannelkoong@gmail.com, lorenzo@kernel.org,
 martin.lau@linux.dev, thoiland@redhat.com, yan@cloudflare.com,
 kernel-team@cloudflare.com, netdev@vger.kernel.org, sdf@fomichev.me

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Thu, 14 Aug 2025 11:59:26 +0200 you wrote:
> TL;DR
> -----
> 
> This is the first step in an effort which aims to enable skb metadata
> access for all BPF programs which operate on an skb context.
> 
> By skb metadata we mean the custom metadata area which can be allocated
> from an XDP program with the bpf_xdp_adjust_meta helper [1]. Network stack
> code accesses it using the skb_metadata_* helpers.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v7,1/9] bpf: Add dynptr type for skb metadata
    https://git.kernel.org/bpf/bpf-next/c/89d912e494f7
  - [bpf-next,v7,2/9] bpf: Enable read/write access to skb metadata through a dynptr
    https://git.kernel.org/bpf/bpf-next/c/6877cd392bae
  - [bpf-next,v7,3/9] selftests/bpf: Cover verifier checks for skb_meta dynptr type
    https://git.kernel.org/bpf/bpf-next/c/0e74eb4d57f0
  - [bpf-next,v7,4/9] selftests/bpf: Pass just bpf_map to xdp_context_test helper
    https://git.kernel.org/bpf/bpf-next/c/6dfd5e01e1a7
  - [bpf-next,v7,5/9] selftests/bpf: Parametrize test_xdp_context_tuntap
    https://git.kernel.org/bpf/bpf-next/c/dd9f6cfb4ef4
  - [bpf-next,v7,6/9] selftests/bpf: Cover read access to skb metadata via dynptr
    https://git.kernel.org/bpf/bpf-next/c/153f6bfd4890
  - [bpf-next,v7,7/9] selftests/bpf: Cover write access to skb metadata via dynptr
    https://git.kernel.org/bpf/bpf-next/c/ed9336080780
  - [bpf-next,v7,8/9] selftests/bpf: Cover read/write to skb metadata at an offset
    https://git.kernel.org/bpf/bpf-next/c/bd1b51b31978
  - [bpf-next,v7,9/9] selftests/bpf: Cover metadata access from a modified skb clone
    https://git.kernel.org/bpf/bpf-next/c/403fae59781f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



