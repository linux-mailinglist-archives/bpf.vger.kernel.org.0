Return-Path: <bpf+bounces-56656-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A937A9BBE9
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 02:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A528E1BA38C8
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 00:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3124F1C36;
	Fri, 25 Apr 2025 00:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ND9v1EXs"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99FE10FD
	for <bpf@vger.kernel.org>; Fri, 25 Apr 2025 00:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745541594; cv=none; b=UbeczVx9UDbqvzh8Mc3RVV7UA2MqJNCc8RGAI17eGTbKV9EPlAsFnKiUJe3Dos4GGEdYLrc64eHWw42WrB57K1h3Nlk6owWKRo36xttKtqNHToCpeiVGwzKKYOilPGlRLdWMHEFmEQBVOHjb9Nj59/1diHIv04anpsXOC7fkwQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745541594; c=relaxed/simple;
	bh=hrPBou/dQU5mAqGP0ke6ZQy3qCEhD+nuxcTDGggj0hM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Udsz7CI0JtkOvv3CYC9tUy3XrqAQ4VvGEI602gBDg9hY4mP9gbPs0zJv5vSxpxc7O6vNf6/ZAr+eE2ttUVboB/Nmvk+TFEFZP38M67qaRwKazeVgV97WSXr8irYiPXfXqoHBfQO4AJGpvSjG+43ht8RjOh59yi5at2q3hrzZZZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ND9v1EXs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29E25C4CEE3;
	Fri, 25 Apr 2025 00:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745541594;
	bh=hrPBou/dQU5mAqGP0ke6ZQy3qCEhD+nuxcTDGggj0hM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ND9v1EXs3/CSXJERi3xCQPpcOZvW7+7VCKKLFh2Z+Anc2M9bP5CouFAnO6xAvqRZF
	 Gk5effARh1Zf7cEvml8dnLiNtfw/3vPYs6knz4AJC+ddvcsB/VNz09JhUAfQfzNXR/
	 TQEpNFLNv5A5iVh814cL4ci7BtnGePMFMAUIv7LWC3glDfRg+tNV9DfI5Gqv8P4UYU
	 olebiNUwgaQHB4XNE6m6JaKL1VFVTeLwGL5szCzKuJGkulID8XFIjoW9vrYEoOQn4J
	 Hu+QP5cGmc/FWuVjrluwwhxXppn9ghIPxxp6mMkluCA25JmLzJxbKDHQxFoQNGWgst
	 9iZVSvpSCT6aA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF01380CFD9;
	Fri, 25 Apr 2025 00:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/3] selftests/bpf: Fix a few issues in arena_spin_lock
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174554163275.3532237.3982010492009484651.git-patchwork-notify@kernel.org>
Date: Fri, 25 Apr 2025 00:40:32 +0000
References: <20250424165525.154403-1-iii@linux.ibm.com>
In-Reply-To: <20250424165525.154403-1-iii@linux.ibm.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 bpf@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 24 Apr 2025 18:41:24 +0200 you wrote:
> Hi,
> 
> I tried running the arena_spin_lock test on s390x and ran into the
> following issues:
> 
> * Changing the header file does not lead to rebuilding the test.
> * The checked for number of CPUs and the actually required number of
>   CPUs are different.
> * Endianness issue in spinlock definition.
> 
> [...]

Here is the summary with links:
  - [1/3] selftests/bpf: Fix arena_spin_lock.c build dependency
    https://git.kernel.org/bpf/bpf-next/c/ddfd1f30b5ba
  - [2/3] selftests/bpf: Fix arena_spin_lock on systems with less than 16 CPUs
    https://git.kernel.org/bpf/bpf-next/c/0240e5a9431c
  - [3/3] selftests/bpf: Fix endianness issue in __qspinlock declaration
    https://git.kernel.org/bpf/bpf-next/c/be5521991506

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



