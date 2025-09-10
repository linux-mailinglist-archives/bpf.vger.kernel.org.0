Return-Path: <bpf+bounces-68056-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4D1B52142
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 21:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 376163A507F
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 19:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FA52D8791;
	Wed, 10 Sep 2025 19:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bT8Ms3zA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BDC1A3178
	for <bpf@vger.kernel.org>; Wed, 10 Sep 2025 19:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757533206; cv=none; b=MUU4mhYMRQN62dUdKS/b9PogtUwlPNTtnD3sZ4oxJW4Ubzt/o2DGOReNuYdiQgfqZyZr84RLWrqMrOllt4DFvMhFPJss1vSaRymfv8CTyrX44wy4DiracXkPT8OUX5ARlQiRd7sKAybK+Ek67hIFgJ32bzfiihuiFwJKZJDk1EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757533206; c=relaxed/simple;
	bh=8T7e6OzPCx/1TDmovX7YjRIVfXSfxQlXLEfT76uRgxI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Rk+RCtpr5qWOjx1vlKuhACStQHQAYSTVhkytHdlQFVUIF3rL0ZvboCL+CYPXmkkf4G1pPBDZM24PepdwyYwgYff1W+SO4vBgoFe/GCV6Z51m7jgxiMFxetWUPnZIVmzwDpZr4x7sgsttS5FRhf9eQML2Li8rZ33wzltPqeSjPN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bT8Ms3zA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87A60C4CEEB;
	Wed, 10 Sep 2025 19:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757533205;
	bh=8T7e6OzPCx/1TDmovX7YjRIVfXSfxQlXLEfT76uRgxI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bT8Ms3zAVPVENqkDtAlW74Y3ZTyXvsZnWP8JIhOzP/O2aLFsVc1p9+fU9TYayWh/B
	 5EdH4uiZiyuPBuoR8QDNr700nnVE24AivE297/Pq5XsgtEJybtBy5jP/yHxVTOJu9d
	 4BhQpVbLdZ8paymjPCBBNUqtPrkkWKAnI/L5rswG4QtbHIqSYIdceFqygF4M3FVkir
	 eRwc9ps2YNtqed93whCCHont3n8tBs0oQmZYc1GFxd8KlAYPBzUItrz8tU4BZqqlI1
	 AyRtxIOkBUORiIz3HlcpS+VcOpbUr+kIChjd60KmSwrO2UiDxu1IaDWxe0B1vkzdvh
	 +cGIo4YjqjZGg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE42B383BF69;
	Wed, 10 Sep 2025 19:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v3 0/2] bpf: Reject bpf_timer for PREEMPT_RT
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175753320852.1544970.3158513977352960891.git-patchwork-notify@kernel.org>
Date: Wed, 10 Sep 2025 19:40:08 +0000
References: <20250910125740.52172-1-leon.hwang@linux.dev>
In-Reply-To: <20250910125740.52172-1-leon.hwang@linux.dev>
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, yepeilin@google.com, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 kernel-patches-bot@fb.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 10 Sep 2025 20:57:38 +0800 you wrote:
> While running './test_progs -t timer' to validate the test case from
> "selftests/bpf: Introduce experimental bpf_in_interrupt()"[0] for
> PREEMPT_RT, I encountered a kernel warning:
> 
> BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
> 
> To address this, reject bpf_timer usage in the verifier when
> PREEMPT_RT is enabled, and skip the corresponding timer selftests.
> 
> [...]

Here is the summary with links:
  - [bpf,v3,1/2] bpf: Reject bpf_timer for PREEMPT_RT
    https://git.kernel.org/bpf/bpf/c/e25ddfb388c8
  - [bpf,v3,2/2] selftests/bpf: Skip timer cases when bpf_timer is not supported
    https://git.kernel.org/bpf/bpf/c/fbdd61c94bcb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



