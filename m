Return-Path: <bpf+bounces-35232-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F00909390CA
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 16:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 295F61C2133E
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 14:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DE016D9D7;
	Mon, 22 Jul 2024 14:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GPkZ6pzS"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE228C1A;
	Mon, 22 Jul 2024 14:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721659232; cv=none; b=K80RIzxQT9bYH4tk9vxUDgRpb1zXJ9SH4nkV0cKH+Cxla86CA/MaGFIcCwQ+N3/BwftqTt4BNT1YdUMEXxQrA9cpHdBq6gCpvyillkwVHaXMlGIrnMszWX7Zo298yuEavcJL1fUyEuAPCm5cnbW5b4/dA5uDQG9kFAVxK6zgi3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721659232; c=relaxed/simple;
	bh=Z8R3MZocWehGF27RwOiV3by/zfxI9eFnzqNFtAtK56A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rwsQ501cHWkeiM1/5qIMDa3e/AGXHOPX47ToCn6LmdaavVrwbSkM68Cg/CZEg58UvCJ0aPQd5kuKtCs7wMV+1h+mGm4wFqTLulwZpyhH/ixdTneZAuo9ErmC+EyQThACoOys0Bpom6fgUzRl9E0Hyd2RRH+5K9WyfMF8gQ2DjJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GPkZ6pzS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E5116C4AF0D;
	Mon, 22 Jul 2024 14:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721659232;
	bh=Z8R3MZocWehGF27RwOiV3by/zfxI9eFnzqNFtAtK56A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GPkZ6pzSFZ0jZF/f2HZXCduhxm8oSfhmbTUg8my5uzQYcq6KqcRvVOS6aNGPXoExq
	 KOI/eNow3e4jM+ZVOHJdbG+XJS4lle0nbXk3H+oCRST8NjcBtNElZMr+7pEPoyePB2
	 C9297cXlPeYzI4ueYsXtqjmVVhc7RA7g3oD23nkIqfD7Phrp+hnAQaO9WOPXcvkcX/
	 cpj3PUedW1O/tnEw8Q1G/Jz1M0KIVi/7AHmwTI4oe2ZyxoTAte3OwiIvtSTdzA9UIw
	 6acMwvNsVnbBlX2cIk2p1XdQuJ0Ww1r8zW0clqJxWF6anFO/c309r0pr0blF0tdH+K
	 nRlmKVYABMQsw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D230DC43445;
	Mon, 22 Jul 2024 14:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] tools/resolve_btfids: fix comparison of distinct pointer
 types warning in resolve_btfids
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172165923185.11692.3731891172987239291.git-patchwork-notify@kernel.org>
Date: Mon, 22 Jul 2024 14:40:31 +0000
References: <20240722083305.4009723-1-liwei.song.lsong@gmail.com>
In-Reply-To: <20240722083305.4009723-1-liwei.song.lsong@gmail.com>
To: Liwei Song <liwei.song.lsong@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, vmalik@redhat.com,
 alan.maguire@oracle.com, friedrich.vock@gmx.de, dxu@dxuuu.xyz,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon, 22 Jul 2024 16:32:59 +0800 you wrote:
> Add a type cast for set8->pairs to fix below compile warning:
> 
> main.c: In function 'sets_patch':
> main.c:699:50: warning: comparison of distinct pointer types lacks a cast
>   699 |        BUILD_BUG_ON(set8->pairs != &set8->pairs[0].id);
>       |                                 ^~
> 
> [...]

Here is the summary with links:
  - tools/resolve_btfids: fix comparison of distinct pointer types warning in resolve_btfids
    https://git.kernel.org/bpf/bpf/c/13c9b702e6cb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



