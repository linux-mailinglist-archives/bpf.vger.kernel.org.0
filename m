Return-Path: <bpf+bounces-64233-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50056B0FEED
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 04:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51B7C1C28569
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 02:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971C81A08B8;
	Thu, 24 Jul 2025 02:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YGD0rksi"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F1722097
	for <bpf@vger.kernel.org>; Thu, 24 Jul 2025 02:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753325390; cv=none; b=PByYGmkGu2POe2Y461j/POZaQ7lAs+mqj79qUNsmSzIqKCNdSH/32tI9bVchKc6EGnRUw+MtAgVqrfiOCLpAOpnyrns+zyn1EhLbxgU4nVIMvFxDkA6kLnRpHuaCpssgWCNxPwvqVgGER4vg3YFz6E5kFuHLQC35Ro9ltjFzKr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753325390; c=relaxed/simple;
	bh=ietMRy8k1B1lPWI0Kl+5KntCrsZvgyQWIzMv7OI1Xbs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=e90+RvYpvHOiF7TQopQ7yjAjJRlpgI/IKiP+RAy0SXQcZpl4DlXIrqbwiY9pGjU8kJw/UfTOfznHkiU6Zhe92/Q8J7Lhhziwo+tLclPtMvEGCbufuVFlJkij09S6aAL2vyzy+3t4saSyMSAncGcYZsFja0xce0R+MnJfysyM608=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YGD0rksi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E83FCC4CEE7;
	Thu, 24 Jul 2025 02:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753325389;
	bh=ietMRy8k1B1lPWI0Kl+5KntCrsZvgyQWIzMv7OI1Xbs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YGD0rksiMoy3Y7SduiVRvPICoGSMcw6tzd/Y4EZKOZKwDL5hlMGX409ZQeW8chM3S
	 QtPL4yejzJF9rrpPcijLbGIq9MZqVzu8eZtqQ/D3wy8ShydRVf2ZnpzICz90S3Ng4S
	 YgFL9NtvfuyOIDEfURu5ZYttypSw45LWQE8QNjHqv9F8vcA95LdwzbVpexAR6Agt2j
	 VBX++K33sl0u7rhTr6bEmh4Js7rTDhYDY7hjeX8BBF40bGck+QDf4pP/pZI/nIgISi
	 uAPV1/49jNOlTIZEBoE/rU+KvkpE9UoE0sJ00v+n4OIQCkt2nj6VGWpa+1jxCo8RSW
	 FXh4Pu3LU3oqw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B05383BF4E;
	Thu, 24 Jul 2025 02:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Reject narrower access to pointer
 ctx
 fields
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175332540780.1856668.12807197332073126174.git-patchwork-notify@kernel.org>
Date: Thu, 24 Jul 2025 02:50:07 +0000
References: 
 <3b8dcee67ff4296903351a974ddd9c4dca768b64.1753194596.git.paul.chaignon@gmail.com>
In-Reply-To: 
 <3b8dcee67ff4296903351a974ddd9c4dca768b64.1753194596.git.paul.chaignon@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, john.fastabend@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (net)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Tue, 22 Jul 2025 16:32:32 +0200 you wrote:
> The following BPF program, simplified from a syzkaller repro, causes a
> kernel warning:
> 
>     r0 = *(u8 *)(r1 + 169);
>     exit;
> 
> With pointer field sk being at offset 168 in __sk_buff. This access is
> detected as a narrower read in bpf_skb_is_valid_access because it
> doesn't match offsetof(struct __sk_buff, sk). It is therefore allowed
> and later proceeds to bpf_convert_ctx_access. At that point,
> target_size is null and the verifier errors with a kernel warning and:
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] bpf: Reject narrower access to pointer ctx fields
    https://git.kernel.org/bpf/bpf-next/c/e09299225d5b
  - [bpf-next,v2,2/2] selftests/bpf: Test invalid narrower ctx load
    https://git.kernel.org/bpf/bpf-next/c/ba578b87fe2b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



