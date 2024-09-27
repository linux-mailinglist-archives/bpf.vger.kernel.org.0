Return-Path: <bpf+bounces-40450-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2BE988CB2
	for <lists+bpf@lfdr.de>; Sat, 28 Sep 2024 01:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8D6B282A78
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 23:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC161B7903;
	Fri, 27 Sep 2024 23:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gX76rm0b"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C9A19341F
	for <bpf@vger.kernel.org>; Fri, 27 Sep 2024 23:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727478030; cv=none; b=GfwtadGCO8C5HayXEMDw1lP4wx1xns1zwcxcV6mhFvhVzPQ6iPSm54XBCeV90J7Vo2WNGmz/KflZjdpmzmJFJ+XFPjb4FfywUoX82ML1Yhlsx2+aygBuyp0WJKEuoA0U/ZjEELVbkzmDhlI0s+kTVpbX0WFo9sohsI4IRUshLnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727478030; c=relaxed/simple;
	bh=J9rOAANjds3GxzzV8iJikXTQkebvQBFHN+mRaFQTz58=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HUabBXGYfoetXquDOQW9hnZc8bsupxbiGAkbo8uhVqRXjyyfhCrxARGHgK11zWvB+jnsBaUiz02Ev1ioZdWjyP6+84KwsYdgZsjlJB+UnDA5129nmKj5fdWLMuvaMNl+UpWAQUajatK42NLK8MjKCuQfHRo64oaxQeROzNPiyFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gX76rm0b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16650C4CEC4;
	Fri, 27 Sep 2024 23:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727478030;
	bh=J9rOAANjds3GxzzV8iJikXTQkebvQBFHN+mRaFQTz58=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gX76rm0bgZJmpFxV7VT9MTb0G8vmtoTMwupyDdWtRCmcVTAgqc4ZPmdSPb3cainz0
	 w16SrcGGfIBBgpoyqfTGQAp2hq071ujunkC6444p06sIKPZwrlQtf/maq+mm8ylkgP
	 kkxM5wPF7qn1j22v5SJsgfbZfsrgUvFwvHCLEItLpRg9w/7ieFlQZOmG3ffo2cQgSw
	 IL28LXoawlH4nkdaQfD9VAj0JNYd4AjQmkc3N09+ao7LfJhry+zMi+3FN5Db0M0SZZ
	 ymSJh3ykga0j0DQY5AuZYvlbCEK1Pe8d1bJ4rx/80tY/ETCDruy3ijd2w+hckBpo+6
	 kT/lUmMeg2qig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB4263809A80;
	Fri, 27 Sep 2024 23:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v1 1/2] bpf: sync_linked_regs() must preserve subreg_def
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172747803277.2107802.3943933559920979953.git-patchwork-notify@kernel.org>
Date: Fri, 27 Sep 2024 23:00:32 +0000
References: <20240924210844.1758441-1-eddyz87@gmail.com>
In-Reply-To: <20240924210844.1758441-1-eddyz87@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, kongln9170@gmail.com

Hello:

This series was applied to bpf/bpf.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 24 Sep 2024 14:08:43 -0700 you wrote:
> Range propagation must not affect subreg_def marks, otherwise the
> following example is rewritten by verifier incorrectly when
> BPF_F_TEST_RND_HI32 flag is set:
> 
>   0: call bpf_ktime_get_ns                   call bpf_ktime_get_ns
>   1: r0 &= 0x7fffffff       after verifier   r0 &= 0x7fffffff
>   2: w1 = w0                rewrites         w1 = w0
>   3: if w0 < 10 goto +0     -------------->  r11 = 0x2f5674a6     (r)
>   4: r1 >>= 32                               r11 <<= 32           (r)
>   5: r0 = r1                                 r1 |= r11            (r)
>   6: exit;                                   if w0 < 0xa goto pc+0
>                                              r1 >>= 32
>                                              r0 = r1
>                                              exit
> 
> [...]

Here is the summary with links:
  - [bpf,v1,1/2] bpf: sync_linked_regs() must preserve subreg_def
    https://git.kernel.org/bpf/bpf/c/27cda47e7819
  - [bpf,v1,2/2] selftests/bpf: verify that sync_linked_regs preserves subreg_def
    https://git.kernel.org/bpf/bpf/c/99a648c951ba

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



