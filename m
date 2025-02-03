Return-Path: <bpf+bounces-50317-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57436A25A66
	for <lists+bpf@lfdr.de>; Mon,  3 Feb 2025 14:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D05A1888578
	for <lists+bpf@lfdr.de>; Mon,  3 Feb 2025 13:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9139E204F82;
	Mon,  3 Feb 2025 13:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AGFTALrh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C63204F67;
	Mon,  3 Feb 2025 13:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738588208; cv=none; b=HjLr6NAPmGvQbj1id8bs+qJruOBqaK3M6qFlJClrKRRUcdZkP8ioO/Lh3QnWrlQX4fixt4zi96pcEtyql2wbABakqle577mF88h59K6MkDrbNE0ksW7oIVBXtw34HK/XqHEOZhxuc3E2YT/4hqF06mPEcyGi7VZSjHl/a0ebRr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738588208; c=relaxed/simple;
	bh=ZRKpRfTI8aYwEKFGS5ayvIhMOlp8nuCwNYhmFDz09QQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GxXgkDjJuUTGgZUdSb4+lOqJDRXJydjyUAYbZFS4/5NSGzkNc42H96cLPxszoO9MfielVenzMzQzaGdaVe0GJIRmWdADw6kRbk982NJk0VysZDsndInA2DdrtyAfEsefITyZSA9pktZLtnp78SyO2bZOHfVs1tAs02MneiC02uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AGFTALrh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F9A3C4CEE4;
	Mon,  3 Feb 2025 13:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738588207;
	bh=ZRKpRfTI8aYwEKFGS5ayvIhMOlp8nuCwNYhmFDz09QQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AGFTALrhCfnWJ2GVu/RzGBL9IiwtCYn/jSFenfe+ABSVs9Rlryb0+VvwFFmgrTe7G
	 2AgxH/9PKnpTnx70y+4uqLA2JPLNP0j7jOeX5+vzgA0rpjdA+7JbEUrjjPIN5zvskY
	 /3HbJv1MipTnzkeH+C37af6QhWtPG/83Cc0D4olkkvY/PUMJtZdQ+5K4jBdFOjVyl8
	 A077NjzjXqTLwpG8EWCrbb8H7qbexLgOu9972dnDonytjAkOVmhiL+WXf9eTk8JMxy
	 iI9LwnppwmG4yaFqvO/vdzvYe1jX+aupF/VzD0T4nbDWcyx3ufg3FAhrAC4o35jI7w
	 qj8yuXMnqFwoQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE70A380AA7F;
	Mon,  3 Feb 2025 13:10:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf] net: Add rx_skb of kfree_skb to raw_tp_null_args[].
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173858823421.3242491.5873739358513954554.git-patchwork-notify@kernel.org>
Date: Mon, 03 Feb 2025 13:10:34 +0000
References: <20250201030142.62703-1-kuniyu@amazon.com>
In-Reply-To: <20250201030142.62703-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, memxor@gmail.com, kuni1840@gmail.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, yan@cloudflare.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 31 Jan 2025 19:01:42 -0800 you wrote:
> Yan Zhai reported a BPF prog could trigger a null-ptr-deref [0]
> in trace_kfree_skb if the prog does not check if rx_sk is NULL.
> 
> Commit c53795d48ee8 ("net: add rx_sk to trace_kfree_skb") added
> rx_sk to trace_kfree_skb, but rx_sk is optional and could be NULL.
> 
> Let's add kfree_skb to raw_tp_null_args[] to let the BPF verifier
> validate such a prog and prevent the issue.
> 
> [...]

Here is the summary with links:
  - [v2,bpf] net: Add rx_skb of kfree_skb to raw_tp_null_args[].
    https://git.kernel.org/bpf/bpf/c/fc610c8c586c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



