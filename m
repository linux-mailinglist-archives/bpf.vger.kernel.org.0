Return-Path: <bpf+bounces-63074-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8FBB0231F
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 19:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5BACA44E4F
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 17:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44C72F1FDE;
	Fri, 11 Jul 2025 17:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EiEw5hfq"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA042EF2AA
	for <bpf@vger.kernel.org>; Fri, 11 Jul 2025 17:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752256191; cv=none; b=gE1ddxzXRRnAwjfhje8iAQuMfT4oVyzwmmLrJHLUmhditL0+P468GanxiXn+aeXDOMRE+HSqOBMNHbuYlQ19LPNbvueIGLlvJ/3LEw28o5v6+TyQFA2++XRd5Rfm52ZD7T1m1hHQEBk6AbTWHWjHKLAKogSZyqqiUXCTvEjqghE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752256191; c=relaxed/simple;
	bh=mmBw444e0Rg94wA0H3JqW7XnbFNNaJrF1mJ5IHEbp90=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tOeWhR6P3Xcr1OyjOilu59xZGsLZinEYfKUEMMCBSijsjtUAzwgOWn7mDbD3y1z43AP2mG3ui/EUf3o0ZUl0WhMtuv8E3XojLTBe3Ch+eyH0hUSKxKBn4aY+AVcn/RdkxQ94YZ0FVqwLBkCJZiHJAWS5DwAqrQE6oO1biBLkoIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EiEw5hfq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C812C4CEED;
	Fri, 11 Jul 2025 17:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752256191;
	bh=mmBw444e0Rg94wA0H3JqW7XnbFNNaJrF1mJ5IHEbp90=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EiEw5hfqA/bF1dPtVztG7cbSWjyyjS3VbRoQYKylj2ihTxzmKAw25tgKQ2YDSlJ5/
	 f8FIsmIRXe/KCGbiHpGwZxnkeBtXxlZkBkKEiTIqntKC/f0l2kInoKH0y0yzozIpTk
	 7+ZR/L9lJuRtfZ+SjR0NlLo/BYrrVR53vq+qi5+6oFZcrnx9vPaZR7tNPG+61KeV1W
	 6iTC9mUXC9utD9uYXSvtP99GBWxg8XKNjVcXRyO2G0ve/wHMDk0QLRrLzUyCwQrM4d
	 Q987nvL2eJpXye/qQBi80dWtiRYs9GwjeMSnst4x/WwPblK869FJ8ur3qCWulRtTZG
	 Y+OO3984Ey9eg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34129383B275;
	Fri, 11 Jul 2025 17:50:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 0/2] bpf/arena: Add kfunc for reserving arena memory
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175225621275.2353625.17022488161752474201.git-patchwork-notify@kernel.org>
Date: Fri, 11 Jul 2025 17:50:12 +0000
References: <20250709191312.29840-1-emil@etsalapatis.com>
In-Reply-To: <20250709191312.29840-1-emil@etsalapatis.com>
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 memxor@gmail.com, yonghong.song@linux.dev, sched-ext@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed,  9 Jul 2025 15:13:10 -0400 you wrote:
> Add a new kfunc for BPF arenas that reserves a region of the mapping
> to prevent it from being mapped. These regions serve as guards against
> out-of-bounds accesses and are useful for debugging arena-related code.
> 
> CHANGELOG
> =========
> 
> [...]

Here is the summary with links:
  - [v4,1/2] bpf/arena: add bpf_arena_reserve_pages kfunc
    https://git.kernel.org/bpf/bpf-next/c/8fc3d2d8b501
  - [v4,2/2] selftests/bpf: add selftests for bpf_arena_reserve_pages
    https://git.kernel.org/bpf/bpf-next/c/9f9559f0acc4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



