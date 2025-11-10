Return-Path: <bpf+bounces-74098-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F368C49220
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 20:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66F933AF788
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 19:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086F933DEFB;
	Mon, 10 Nov 2025 19:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mdQUJua5"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7247633B6DC;
	Mon, 10 Nov 2025 19:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762804099; cv=none; b=RdqGsYjPUAhXRIFTL96B8Nb1Btwxoq7mCuIsvwtST0+5i5n0jYx1EZp0SrSUGwsEhqs12mmYVu+9rzSB3OMekefRoxNdbA0v9f/6ebe1+rp8q1aUHmBDxva3oOOkTIirkFav6SxD++YRYRTgqatJJbQyKKUoOSQlXA6f9kJVGN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762804099; c=relaxed/simple;
	bh=vECWW1+fzPlhbg3jOchInqlZNeZ+ywTe3ORT2mNy944=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=u/FEJntqXyL2PjUbuHTC7wRAvRS9VeJw/4r/ZzunLnBtlJE0s6JNvMsVAjRye+dNKv8adVGxe6XZlhXBQF2cbumJ4BDcb5dcmHKptbwkLPzccLcKoSc2OWXYExPfxBZNqyvGhjK3P63WBMBcyb4krHPs6iQty/6iJJQt5flXDjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mdQUJua5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBDF7C4AF0B;
	Mon, 10 Nov 2025 19:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762804098;
	bh=vECWW1+fzPlhbg3jOchInqlZNeZ+ywTe3ORT2mNy944=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mdQUJua5xXUHt2bIqF16IADFP1HzoC9GVTg0s5+KnP7TbMQ4fGle9oY1h+/1ZCrE5
	 9+oh9uH7Kyi7Whl7EFnU5+JazyrEaPkyPL0CD42XJcDbVKvwMDkq+i0dWxAzbrOCRd
	 W8mwtBw3J+lLhUak5drTEAAwa7vf6t3DOqgnFp7TgvgFp/dxaaWcjHocMW8Oo4EXiU
	 tm1HSWgI1IoiSRE8PkI/n43k9Z7rNglkt2PobevRKIPALQPSYO6CkvZ0PrhEbPfQxM
	 RBiqwpLAsqRfpBTwFvVHIjnmH3+dy/zLBTtrkyM4eSyvB/uhLl4uElys7C1r6A209W
	 etvHB5ivePXxw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 610A4380CEFB;
	Mon, 10 Nov 2025 19:30:02 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 00/16] Make TC BPF helpers preserve skb
 metadata
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176280300126.2739595.12327410423066489915.git-patchwork-notify@kernel.org>
Date: Mon, 10 Nov 2025 19:30:01 +0000
References: <20251105-skb-meta-rx-path-v4-0-5ceb08a9b37b@cloudflare.com>
In-Reply-To: <20251105-skb-meta-rx-path-v4-0-5ceb08a9b37b@cloudflare.com>
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, martin.lau@linux.dev,
 daniel@iogearbox.net, john.fastabend@gmail.com, sdf@fomichev.me,
 ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, haoluo@google.com,
 jolsa@kernel.org, arthur@arthurfabre.com, hawk@kernel.org,
 netdev@vger.kernel.org, kernel-team@cloudflare.com

Hello:

This series was applied to bpf/bpf-next.git (net)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Wed, 05 Nov 2025 21:19:37 +0100 you wrote:
> Changes in v4:
> - Fix copy-paste bug in check_metadata() test helper (AI review)
> - Add "out of scope" section (at the bottom)
> - Link to v3: https://lore.kernel.org/r/20251026-skb-meta-rx-path-v3-0-37cceebb95d3@cloudflare.com
> 
> Changes in v3:
> - Use the already existing BPF_STREAM_STDERR const in tests (Martin)
> - Unclone skb head on bpf_dynptr_write to skb metadata (patch 3) (Martin)
> - Swap order of patches 1 & 2 to refer to skb_postpush_data_move() in docs
> - Mention in skb_data_move() docs how to move just the metadata
> - Note in pskb_expand_head() docs to move metadata after skb_push() (Jakub)
> - Link to v2: https://lore.kernel.org/r/20251019-skb-meta-rx-path-v2-0-f9a58f3eb6d6@cloudflare.com
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,01/16] net: Helper to move packet data and metadata after skb_push/pull
    https://git.kernel.org/bpf/bpf-next/c/8989d328dfe7
  - [bpf-next,v4,02/16] net: Preserve metadata on pskb_expand_head
    https://git.kernel.org/bpf/bpf-next/c/290fc0be09e2
  - [bpf-next,v4,03/16] bpf: Unclone skb head on bpf_dynptr_write to skb metadata
    https://git.kernel.org/bpf/bpf-next/c/f38499ff45f5
  - [bpf-next,v4,04/16] vlan: Make vlan_remove_tag return nothing
    https://git.kernel.org/bpf/bpf-next/c/b85be58e2f7c
  - [bpf-next,v4,05/16] bpf: Make bpf_skb_vlan_pop helper metadata-safe
    https://git.kernel.org/bpf/bpf-next/c/efd35c26239b
  - [bpf-next,v4,06/16] bpf: Make bpf_skb_vlan_push helper metadata-safe
    https://git.kernel.org/bpf/bpf-next/c/55ffc98b44d2
  - [bpf-next,v4,07/16] bpf: Make bpf_skb_adjust_room metadata-safe
    https://git.kernel.org/bpf/bpf-next/c/be83105d38ab
  - [bpf-next,v4,08/16] bpf: Make bpf_skb_change_proto helper metadata-safe
    https://git.kernel.org/bpf/bpf-next/c/8cfc172ce28e
  - [bpf-next,v4,09/16] bpf: Make bpf_skb_change_head helper metadata-safe
    https://git.kernel.org/bpf/bpf-next/c/fb206fc3129b
  - [bpf-next,v4,10/16] selftests/bpf: Verify skb metadata in BPF instead of userspace
    https://git.kernel.org/bpf/bpf-next/c/967534e57c44
  - [bpf-next,v4,11/16] selftests/bpf: Dump skb metadata on verification failure
    https://git.kernel.org/bpf/bpf-next/c/9ef9ac15a527
  - [bpf-next,v4,12/16] selftests/bpf: Expect unclone to preserve skb metadata
    https://git.kernel.org/bpf/bpf-next/c/1e1357fde808
  - [bpf-next,v4,13/16] selftests/bpf: Cover skb metadata access after vlan push/pop helper
    https://git.kernel.org/bpf/bpf-next/c/354d020c29f7
  - [bpf-next,v4,14/16] selftests/bpf: Cover skb metadata access after bpf_skb_adjust_room
    https://git.kernel.org/bpf/bpf-next/c/29960e635b01
  - [bpf-next,v4,15/16] selftests/bpf: Cover skb metadata access after change_head/tail helper
    https://git.kernel.org/bpf/bpf-next/c/85d454afef61
  - [bpf-next,v4,16/16] selftests/bpf: Cover skb metadata access after bpf_skb_change_proto
    https://git.kernel.org/bpf/bpf-next/c/d2c5cca3fb58

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



