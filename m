Return-Path: <bpf+bounces-64460-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 036A6B130EB
	for <lists+bpf@lfdr.de>; Sun, 27 Jul 2025 19:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 658E13B851B
	for <lists+bpf@lfdr.de>; Sun, 27 Jul 2025 17:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8327221D3EC;
	Sun, 27 Jul 2025 17:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XY2vGfGW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFE92045B7
	for <bpf@vger.kernel.org>; Sun, 27 Jul 2025 17:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753637389; cv=none; b=TWnNlk0BxuBzp2pPOHIYPd4KD3XiGI/PzFyqZ1b957uJf7f1i5CNVYPc7pUe6AeFMZt6neeF3QBu3dGBCQkI0IFl1Jnb3KsRahavlD54BTDg2YuH2PfhMq6FT/DH5SqmikHze1lbq0bm4epoLGg++L005Vp4Hhldh9tc/Yj5hNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753637389; c=relaxed/simple;
	bh=9tVwppI2+LwRAXn6LJuFx41/S0dTdLD5N6yd15s7Rcc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hKVnbr/XNHBUzwgw6zWYMy70I43HArNKpuFcryH9q+CPgCcHcospXh+AlA1xKnD2FegK0fYlmAVgYZhZkeF0nNOouOxAwpPVud/+81Y+epIjerYqmjkWBNNxW8Io6w5WqDmqQlhoKWDrlYK1nRodhhPe9w37pfB3MZbu1awBh10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XY2vGfGW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C5AFC4CEEB;
	Sun, 27 Jul 2025 17:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753637388;
	bh=9tVwppI2+LwRAXn6LJuFx41/S0dTdLD5N6yd15s7Rcc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XY2vGfGWQVARd3t+oMp2OHjndkx3TyCjoN56Tc1CH3I6rBHVKHkNEsV+nE/ms+KRd
	 woeJQYDR5nEn4QhiJZibS2TSkUxeZkdbGfrYV0jMnbbU02W1OQj9Wd1Se8h4/p2tzY
	 hQkxQ9V2NYDxtI2upCoXf6T/87rdH6NmOgYpA9tEPnmZMlbnU9YR+tIOCjKfAo4Ode
	 aXdILvEXwSEY2kpgKXRxRjgh1HojH1krbr9TdQcEPiAMFJEpuPDQVe2Vz1Bayysf+Y
	 Gc5NXxvKYf+T4nKSdsgpQWFKX+puwTfX84rFxTKhHeL4YB1/4NnNbAPdQPNgAm6x1N
	 Tvy06UY/x7M+g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE7D383BF4E;
	Sun, 27 Jul 2025 17:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Simplify bounds refinement from s32
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175363740552.3914338.8842497376005706320.git-patchwork-notify@kernel.org>
Date: Sun, 27 Jul 2025 17:30:05 +0000
References: <aIJwnFnFyUjNsCNa@mail.gmail.com>
In-Reply-To: <aIJwnFnFyUjNsCNa@mail.gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, shung-hsi.yu@suse.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu, 24 Jul 2025 19:42:52 +0200 you wrote:
> During the bounds refinement, we improve the precision of various ranges
> by looking at other ranges. Among others, we improve the following in
> this order (other things happen between 1 and 2):
> 
>   1. Improve u32 from s32 in __reg32_deduce_bounds.
>   2. Improve s/u64 from u32 in __reg_deduce_mixed_bounds.
>   3. Improve s/u64 from s32 in __reg_deduce_mixed_bounds.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Simplify bounds refinement from s32
    https://git.kernel.org/bpf/bpf-next/c/5345e64760d3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



