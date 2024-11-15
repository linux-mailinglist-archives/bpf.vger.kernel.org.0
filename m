Return-Path: <bpf+bounces-44979-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFECD9CF436
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 19:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7ABCFB3C58C
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 18:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385FB1E1023;
	Fri, 15 Nov 2024 18:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkBLvfHg"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6009157A5C
	for <bpf@vger.kernel.org>; Fri, 15 Nov 2024 18:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731695417; cv=none; b=kldZyg/8Aa5jiTc/RWFH5nacYZxzTsCRMXl0fIhcPc6PWCq5FO618DsOdRTdNbpp5EKXm+zjUrBzBJOELVQ4JPBcEA3XmzMigjzvcwpQwgtz6uznrwIR/0pZHHyJrxnKjZBYiXbBQSU9VrL3Lzpz05Ic0fAGBGgoUHNcHR/OwZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731695417; c=relaxed/simple;
	bh=zYQCn7yRkKhp+cOwgc/njMVz3QWB7y6zYAwgVO6c+HQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hqeAZoHKyM6Eo2K6bg40ixeHa0SVXNiXa499UIxMZWMlUTGSyCS8Fwm++hsAvk7/0T3qkUtygV3qe9dzPV1/pq65jgEFgvvs2+HPNjAn637mnX+GxsFPy+33g0G5areXpUwu4rz+oTx5EB/a9uDJ5R5vChue7ES/ftOIk9dvPvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nkBLvfHg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B55FC4CECF;
	Fri, 15 Nov 2024 18:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731695417;
	bh=zYQCn7yRkKhp+cOwgc/njMVz3QWB7y6zYAwgVO6c+HQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nkBLvfHgEjLmixv/VichXGl3Yh+2xmAv3G+pIY9ND7Drpxu/SMjzWLD0d7/SVjzhA
	 29LhBOf/evYzx/S1aN6EpQnXYLjGLXT57r55rx1dg0L72E8I7ooiQlp0DsdYbirrdZ
	 yKb5l66H2DnonmzmQKu11pmWUWjwkPwOtZWyPmaEuu99WyDkvar26IUuO1zIt/ZmS/
	 zW3S4bZ6X7996+0nWwbAjQ8LsJkPyt3wR4R4UXnB/rgIOJwaeUb1usg6L/3bJef+1m
	 v7gOo7hYvhpnpWvuQNOt4HoJO0N8Om9UbURTKNnU9gxDhN0J60t37cTA8zCWM4AhWo
	 96xLRWrO4q0vA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D9C3809A80;
	Fri, 15 Nov 2024 18:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 bpf-next] bpf: use common instruction history across all
 states
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173169542803.2677360.15146978034997887831.git-patchwork-notify@kernel.org>
Date: Fri, 15 Nov 2024 18:30:28 +0000
References: <20241115001303.277272-1-andrii@kernel.org>
In-Reply-To: <20241115001303.277272-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com, eddyz87@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 14 Nov 2024 16:13:03 -0800 you wrote:
> Instead of allocating and copying instruction history each time we
> enqueue child verifier state, switch to a model where we use one common
> dynamically sized array of instruction history entries across all states.
> 
> The key observation for proving this is correct is that instruction
> history is only relevant while state is active, which means it either is
> a current state (and thus we are actively modifying instruction history
> and no other state can interfere with us) or we are checkpointed state
> with some children still active (either enqueued or being current).
> 
> [...]

Here is the summary with links:
  - [v3,bpf-next] bpf: use common instruction history across all states
    https://git.kernel.org/bpf/bpf-next/c/96a30e469ca1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



