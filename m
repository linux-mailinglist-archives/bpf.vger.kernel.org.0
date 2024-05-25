Return-Path: <bpf+bounces-30596-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C6D8CF094
	for <lists+bpf@lfdr.de>; Sat, 25 May 2024 19:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9D241F21CD1
	for <lists+bpf@lfdr.de>; Sat, 25 May 2024 17:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9DA3126F3D;
	Sat, 25 May 2024 17:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lOiixgcl"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3455358ABC
	for <bpf@vger.kernel.org>; Sat, 25 May 2024 17:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716659432; cv=none; b=oZf7cdpOAlHrroTV5Fw/FzeJV7yyfQSKnyu1s9Eb0+xESZSzIHdkg1MsvbcgRQqMPLmq/8i1IHS18gEucC4B1dO+FkTForHwZu+kC1it/8ysSHUq0uWLEwR8ryMfr0XAwUEG8gvDhCOysO7k1Qlw49311hl6cuOqjgotHBz1qdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716659432; c=relaxed/simple;
	bh=ZWtHjsL45ZyOE3P8Ch2sEExI0FBoGZ9m1rc4/c44+nw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=a2lv3ub3pSV87EQrkbrI+VLrR91l+Lld4PmN1BzmPW+hGH4dud0QBvLKaeLm8/GbT8Jajwmu0LQ+b1exCOiSuB2cr/O/10C5MQ1OwfvWD0Oq30oCOJIIKsDrG/YeUfO3T6wT+iJgPsw/ou1mmMW+4mby3TQ0uBF2N4omsT29DB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lOiixgcl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D6C68C32786;
	Sat, 25 May 2024 17:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716659431;
	bh=ZWtHjsL45ZyOE3P8Ch2sEExI0FBoGZ9m1rc4/c44+nw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lOiixgclrrvYMuqoPwDisp29AxX2vtahEX+31jiVXS4wOHhliRC3cvh201ZXBk4mw
	 p9Vd96ivLdlOddo15cZ05VBuQQVTwaQCbqOWSOnNNX37CSU+Ek17ajl8ImPMQOe6A1
	 FuMhYVexY67LcBtKflrKwgt/649tqPESkiTykTZfv+CWO0MTrnNq9coRZtlbbwyRVr
	 Brfldk9y68HPHHKHILfIzxxXhFnYjIIXQDMT5pthjJ4T5yuydAEiWxp19FJWwz6Kcq
	 1oUIacm3j3HXp1rLH/VHZ2+ZTCNCm/XdS/G3oARh1262N8xkSpjaUlRj9HJLDrIHzP
	 95IUUKWvRPBRg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C2856C43333;
	Sat, 25 May 2024 17:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] ARC,
 bpf: Fix issues reported by the static analyzers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171665943179.11416.15139734893822863704.git-patchwork-notify@kernel.org>
Date: Sat, 25 May 2024 17:50:31 +0000
References: <20240525035628.1026-1-list+bpf@vahedi.org>
In-Reply-To: <20240525035628.1026-1-list+bpf@vahedi.org>
To: Shahab Vahedi <list+bpf@vahedi.org>
Cc: bpf@vger.kernel.org, shahab@synopsys.com, vgupta@kernel.org,
 ast@kernel.org, linux-snps-arc@lists.infradead.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 25 May 2024 05:56:28 +0200 you wrote:
> From: Shahab Vahedi <shahab@synopsys.com>
> 
> Also updated couple of comments along the way.
> 
> One of the issues reported was indeed a bug in the code:
> 
>   memset(ctx, 0, sizeof(ctx))      // original line
>   memset(ctx, 0, sizeof(*ctx))     // fixed line
> 
> [...]

Here is the summary with links:
  - [bpf-next] ARC, bpf: Fix issues reported by the static analyzers
    https://git.kernel.org/bpf/bpf/c/dd6a403795f0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



