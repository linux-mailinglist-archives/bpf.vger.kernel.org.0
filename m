Return-Path: <bpf+bounces-78746-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE00D1AD1F
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 19:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A68BE3038CF6
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 18:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C023F34DCF9;
	Tue, 13 Jan 2026 18:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DmjhAUnc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA2C34AB1D
	for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 18:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768328464; cv=none; b=ZH1xgp/inMH0zauWoiogCY+H4c4xHOfvfoIPGIQmy48rNvm80CkTVewdHthZCpbwIn65tKcY5UUqzsbDBIclXt/NH8v+nqASVPnY0lchDPSIh1wOYdywHNI30258ZBhg4FDqej4eqwlKav+gJMoZxipJHlxVKyuAKwuNAO4jgvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768328464; c=relaxed/simple;
	bh=bNR7MQjDig0SSlRFjPRKkZuOUHeeHRg8sC8Kqkz0FG0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pl1rP0GI3RPlJMG53IC92P8O+0XPP0/m74S3F1DVB5wL2Nj0dsZmnQZXo6jKjdrubd6LzW6wCUGEK4zFpZaoBeI2SM47o6IN23bhUS3TVplTeXWloVwDqpUnkolAOlYPpVEE3F3puI6ECjyxUJK4G93ASaK8urWwnrV0fHhxFFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DmjhAUnc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 639CDC116C6;
	Tue, 13 Jan 2026 18:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768328462;
	bh=bNR7MQjDig0SSlRFjPRKkZuOUHeeHRg8sC8Kqkz0FG0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DmjhAUncB1xhjUOtTEKYNLtjW4IpQvYIwwe9eEYlhdkITww+Be49iXfZ55/YWtBY0
	 G7PMBVJ91Mvxl273xpXNRnBS5VfLlpDuUuMKQ7TPFg0y+Xg0wyGqWzLX1uLd4b0v90
	 tqDjAzYlCc/T+5pkXke9IYzbPUlq+I1d/0K8suraT5tWhEcI6vGKkqmKUhSXl4dn+3
	 NBR172TZSO73XcYajoRWFJFFtor9hrUi3xxHc3SUjFBDPOgG89+yY/G+FUzs+HO3jp
	 SOydZgGETjLEVwbyK6kXvh2SRW4kSSXDQ8PMLX1WqCkZJ4TFw+CN3QvG/Q5rgdbqQ6
	 q0IPhNvTufyFg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F29CC3808200;
	Tue, 13 Jan 2026 18:17:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] bpf: Use reg_state() for register access in
 verifier
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176832825552.2345780.3486489104510186170.git-patchwork-notify@kernel.org>
Date: Tue, 13 Jan 2026 18:17:35 +0000
References: <20260113134826.2214860-1-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260113134826.2214860-1-mykyta.yatsenko5@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, yatsenko@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 13 Jan 2026 13:48:26 +0000 you wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
> 
> Replace the pattern of declaring a local regs array from cur_regs()
> and then indexing into it with the more concise reg_state() helper.
> This simplifies the code by eliminating intermediate variables and
> makes register access more consistent throughout the verifier.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] bpf: Use reg_state() for register access in verifier
    https://git.kernel.org/bpf/bpf-next/c/7af333994860

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



