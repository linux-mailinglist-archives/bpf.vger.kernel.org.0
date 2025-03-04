Return-Path: <bpf+bounces-53239-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24153A4EF2B
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 22:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7592C3A40F3
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 21:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E54B264F8C;
	Tue,  4 Mar 2025 21:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RebnjQx5"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C081C84DB
	for <bpf@vger.kernel.org>; Tue,  4 Mar 2025 21:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741122602; cv=none; b=fdOPGQQVzKY9cT77fafoIGMTjz27ZZcCBsR/lzX10zRx0At8yCNXonYxiAVChOZJaqTm2xWLSxJTAgZq2V73AXDVolDMsOmxCp8euZgqFOs89V0g0XAqo628uHlJVGitP1rapZ/hItIkzgvcMSWCzmBEc9AwXRg9tGc4HMN7mfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741122602; c=relaxed/simple;
	bh=EgTTnoX9r9PHA4XzOdIPHudWoDUhST+djSOQEhJvFNQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Niw90g/c+AKPualsis+w3u1+AfDVPknoc4KjHO2fBasElNfbSkpdiGTIk1axxRkKDJYTA1mML7kBULKkZ8laRU0yziSBonjDK3LtNF4yso2Rj9t/iW9TfhtO8GAzeIj0I7G8fzMQ7m/afi52CDCFP9eN/YvQ0+BrbU/Ea40vP3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RebnjQx5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89128C4CEE5;
	Tue,  4 Mar 2025 21:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741122601;
	bh=EgTTnoX9r9PHA4XzOdIPHudWoDUhST+djSOQEhJvFNQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RebnjQx5b8/+RgBZ3Ioz4B4UnJWIpe52gTbP9PzAwYxLOupkvynkFbwzHU3tmFnqz
	 tu/CCvFcaQtLgrUEL2IDZtKnsSwOF5RSsRwcv9507q4sK/M6hztuVTeOhW7ibEXrbY
	 Vk0XKnl5kUBVhaF+R5hTK98LDvoswTMneG6SIiJgkb3kl8q1Bzr8A06V1C6XO6BEMX
	 z4KNhN8zXEpBRwQPnlckq/vM3Ql/IKEcuA8odJx6FvDAGG8l7J0sE9eQliwo0HzLpq
	 eRyz7nvGuYVKRlrAgpcC9ghs5VjlFouRDVnGvOv4s3hS878fOInkaob4AQY7cJhy8q
	 esZXSvwUZZIUA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF7A380CEF6;
	Tue,  4 Mar 2025 21:10:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/5] bpf: simple DFA-based live registers analysis
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174112263451.294592.2291982366290755107.git-patchwork-notify@kernel.org>
Date: Tue, 04 Mar 2025 21:10:34 +0000
References: <20250304195024.2478889-1-eddyz87@gmail.com>
In-Reply-To: <20250304195024.2478889-1-eddyz87@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, tj@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue,  4 Mar 2025 11:50:19 -0800 you wrote:
> This patch-set introduces a simple live registers DFA analysis.
> Analysis is done as a separate step before main verification pass.
> Results are stored in the env->insn_aux_data for each instruction.
> 
> The change helps with iterator/callback based loops handling,
> as regular register liveness marks are not finalized while
> loops are processed. See veristat results in patch #2.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/5] bpf: jmp_offset() and verbose_insn() utility functions
    https://git.kernel.org/bpf/bpf-next/c/1c152572be59
  - [bpf-next,v3,2/5] bpf: get_call_summary() utility function
    https://git.kernel.org/bpf/bpf-next/c/0ae958eca164
  - [bpf-next,v3,3/5] bpf: simple DFA-based live registers analysis
    https://git.kernel.org/bpf/bpf-next/c/7dad03653567
  - [bpf-next,v3,4/5] bpf: use register liveness information for func_states_equal
    https://git.kernel.org/bpf/bpf-next/c/994a876a076a
  - [bpf-next,v3,5/5] selftests/bpf: test cases for compute_live_registers()
    https://git.kernel.org/bpf/bpf-next/c/8a3fc22ddec7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



