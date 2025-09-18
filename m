Return-Path: <bpf+bounces-68872-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2691AB87458
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 00:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8524558256B
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 22:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348972F7ACA;
	Thu, 18 Sep 2025 22:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pz832gEi"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE07F2288D5
	for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 22:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758235209; cv=none; b=BjR620L31OjGrA98BpVPqGxCwDLEjbdU3FXCO6ixISMmN0f4LBTCeNuS4gNo0fnXlAsREit0uvkBPYOkmXiQo6T53m9ssUgKqRFMlYtMapIBw5knT1H1RO/2QuwxFkICAQWjUDNhtu43K1vZEa8/TZTKlc6hhXwcf5qH1dsr/U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758235209; c=relaxed/simple;
	bh=ZJX+HnEBvDNEqpmtG9H3b7QgUO6zFa9ogNYkofUql58=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=O35y94Pi11SsjHn2VNkVLemAcv+iefbW0DVl2Whvy9hIxh5xEgEynueEs7twcRbotRBESdCCP+uZRKVVaimiw+a71qoWLa8t4sdB7/uQ0IOxvshZ1cFkpBjbU8kvSrAdzGIzereClzMCqqenP1kcoET+7GYhBmHUJrGPThEiKpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pz832gEi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F842C4CEE7;
	Thu, 18 Sep 2025 22:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758235209;
	bh=ZJX+HnEBvDNEqpmtG9H3b7QgUO6zFa9ogNYkofUql58=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Pz832gEisUnLsQuazKv9igQDdC79iq+vYKKf4Sd/JOSzmicbfpkQaF3hNnXLIfysp
	 M3lG1/2AFhmZAAuaSyTK+0X0+5tRYLeLNEI2qgZuKQCpGbB5cVBf3GvYL9ByLhMp16
	 d7gFzHXn/LuYKFmzAbk9EYrsWxSK8aGwxG0v5X2K7uNbosbO822Dxn6t67BA5tNROc
	 BGxg2UAx3pWLp/DPQi2Vk3x1pNuwkSL1gAEN0nafVFO/IE+5cWVKpQEnfS04Cuz3K+
	 tu8tR0xtZ12bIJFT3aeUy0ONA25DXfdv48EYuBosl8snkiw7O1pAlRiaIsITPM3vMy
	 XS9AzUoX6jdyw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4794539D0C20;
	Thu, 18 Sep 2025 22:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/2] Update KF_RCU_PROTECTED
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175823520925.2974709.5913309884000579325.git-patchwork-notify@kernel.org>
Date: Thu, 18 Sep 2025 22:40:09 +0000
References: <20250917032755.4068726-1-memxor@gmail.com>
In-Reply-To: <20250917032755.4068726-1-memxor@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
 tj@kernel.org, arighi@nvidia.com, kkd@meta.com, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 17 Sep 2025 03:27:53 +0000 you wrote:
> Currently, KF_RCU_PROTECTED only applies to iterator APIs and that too
> in a convoluted fashion: the presence of this flag on the kfunc is used
> to set MEM_RCU in iterator type, and the lack of RCU protection results
> in an error only later, once next() or destroy() methods are invoked on
> the iterator. While there is no bug, this is certainly a bit unintuitive,
> and makes the enforcement of the flag iterator specific.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/2] bpf: Enforce RCU protection for KF_RCU_PROTECTED
    https://git.kernel.org/bpf/bpf-next/c/1512231b6cc8
  - [bpf-next,v3,2/2] selftests/bpf: Add tests for KF_RCU_PROTECTED
    https://git.kernel.org/bpf/bpf-next/c/8b788d663861

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



