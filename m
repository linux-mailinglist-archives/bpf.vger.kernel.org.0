Return-Path: <bpf+bounces-27146-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 404D98A9FAD
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 18:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED7E52815C5
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 16:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E3816C6BD;
	Thu, 18 Apr 2024 16:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gqidILYF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15CD15E20F
	for <bpf@vger.kernel.org>; Thu, 18 Apr 2024 16:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713456628; cv=none; b=iQLsJZ9dxf8MTrKA2bTqUiABrMBjgbwEQhIY0t/CWdy0vgufHcHIXHyERoszh7yxyw6hrPcFgwFrw/4hUanZ8EKJinQzMXEwABp04LAUW58DFzCFIbKtK20EI6FL8QOpvX/W7hTDql1RAcq1INHRMyR9OZSJBa/vlOkP0RnAG+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713456628; c=relaxed/simple;
	bh=xdVod3ocIcDqz2Mlxa5Te0MdrICigSjFcOsBEarH+bk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AfrcxxDh2+EEnoFIPnuNdyDWh9iFKaeim2fT3mRH3e5W9DCgSdJgSOh/TIeec+yKuFtEvR2HVlM9w+eSfHtUSDojnMWG1by12mytCVtZm0XQp7NMBHw9cTHxWh6EoN3tm8mIULK728qimhWLMCtgAIy4vry1YaHuAtUWFOtLG7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gqidILYF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 449A1C116B1;
	Thu, 18 Apr 2024 16:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713456628;
	bh=xdVod3ocIcDqz2Mlxa5Te0MdrICigSjFcOsBEarH+bk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gqidILYFOw0z/EaZ5t44jVw2j0eBk7qMayPAR+znjW/HMsPHJzJIILHGE9M1x0HvZ
	 zsklOnmE/JBujSe1Lg1pRp3T9hxlUADoOu0wCfxhC7g+OTKBhHfu+wIo3D6WoRQlAE
	 6Nobw0aPdO50UvgbzXp64U4TjfNWkzZkUCIG95CL2FPhJtuXG6mc4uEAeS4d1h4hNt
	 /r1FsCvAiZuAx3RW7TAEPxUl3nKo9XYuzVP+YQqvVgXasgbJRwlRgsqT97ZacOlHMO
	 VTOLIjL7Z5XdNog5aF6OVIqsiduo1MHqyGwnAEsc0PYvcdj2tMYpve6gs1H7nsQCc1
	 duiZuX5ikwEGw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 30C9AC395C5;
	Thu, 18 Apr 2024 16:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Fix JIT of is_mov_percpu_addr instruction.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171345662819.481.13885920460862679199.git-patchwork-notify@kernel.org>
Date: Thu, 18 Apr 2024 16:10:28 +0000
References: <20240417214406.15788-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20240417214406.15788-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@kernel.org, eddyz87@gmail.com, kernel-team@fb.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 17 Apr 2024 14:44:06 -0700 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> The codegen for is_mov_percpu_addr instruction works for rax/r8 registers
> only. Fix it to generate proper x86 byte code for other registers.
> 
> Fixes: 7bdbf7446305 ("bpf: add special internal-only MOV instruction to resolve per-CPU addrs")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Fix JIT of is_mov_percpu_addr instruction.
    https://git.kernel.org/bpf/bpf-next/c/462e5e2a5938

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



