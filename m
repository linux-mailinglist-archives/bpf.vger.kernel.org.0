Return-Path: <bpf+bounces-60416-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D675AAD63AD
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 01:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A8257A9AC6
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 23:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725772505CB;
	Wed, 11 Jun 2025 23:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2gMLPxA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E805B24EAAF
	for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 23:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749683414; cv=none; b=T9Q7P5H3ydRd73a2wvAnt560Mrc7WCMKdgTCks8fSCUZQp2c/1R41d6ZmlX275s6HKWOfPo/CiDqjYXeHuRnXidH16GgoKDAsy6ZXqV1TVWJTwTf2ro3q+ka/i4eEUPjZ91KgXd/8DTjMsglRWb3z+/cRZ1ZsDu1YTbB4Y+WwOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749683414; c=relaxed/simple;
	bh=0ohRqrwkF7nose7c550XgQX7gEtSowg8VJQPhejwJTw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gDnJMgyKzB414jB+/hPnMSp3uS+6xRUz8XPmQMkg0N64WSuJfOulOIAXVIaMaayRfSQfdJm1IeShZACierJ2pFQ/DDZ5RV/lxqnhvKnMhNQ69sYzzy7lxF8KueRKp87zF3uXQuqdwTu/P0Dt+EXNWBbCHyBMiENljCocUFl3518=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2gMLPxA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72FD9C4CEE3;
	Wed, 11 Jun 2025 23:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749683413;
	bh=0ohRqrwkF7nose7c550XgQX7gEtSowg8VJQPhejwJTw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=F2gMLPxAC5Pq82obJYkeVRn/ICAqSgmTADN5f+6LBFEtEJ2lJ8nl7utanO5fHdzPv
	 n3CCk6aEcqbdgA6xvu3gPl0q3y8S+aKWAHwY/anCxi//5wQkDUXWSs62F7Vh/Rf6PC
	 K7K5k/Vnh1kJwHHIyyY9IQnQmXLamiSqZhiYj2zvyKrsrQfjDxKW5c4ENej1lfKqFn
	 Y9z6po6Kfep4sipFVq8Uv4dbKdsRGjkjIOYVq5/14i80ask1/bZDrOi9isiosoNvo2
	 60Mi0JlCsaNThwdp9B0SR4bySBdq2bksvHnFq1q6njVc/Kkex2J2NUJXIkMRpwNMFA
	 aohu7dyas5niQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE0F380DBE9;
	Wed, 11 Jun 2025 23:10:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 00/11] bpf: propagate read/precision marks
 over
 state graph backedges
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174968344350.3524559.14906547029551737094.git-patchwork-notify@kernel.org>
Date: Wed, 11 Jun 2025 23:10:43 +0000
References: <20250611200546.4120963-1-eddyz87@gmail.com>
In-Reply-To: <20250611200546.4120963-1-eddyz87@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 11 Jun 2025 13:05:35 -0700 you wrote:
> Current loop_entry-based states comparison logic does not handle the
> following case:
> 
>  .-> A --.  Assume the states are visited in the order A, B, C.
>  |   |   |  Assume that state B reaches a state equivalent to state A.
>  |   v   v  At this point, state C is not processed yet, so state A
>  '-- B   C  has not received any read or precision marks from C.
>             As a result, these marks won't be propagated to B.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,01/11] Revert "bpf: use common instruction history across all states"
    (no matching commit)
  - [bpf-next,v3,02/11] bpf: compute SCCs in program control flow graph
    https://git.kernel.org/bpf/bpf-next/c/de270addb499
  - [bpf-next,v3,03/11] bpf: frame_insn_idx() utility function
    https://git.kernel.org/bpf/bpf-next/c/2ca9f34850d6
  - [bpf-next,v3,04/11] bpf: starting_state parameter for __mark_chain_precision()
    https://git.kernel.org/bpf/bpf-next/c/8e1acf430049
  - [bpf-next,v3,05/11] bpf: set 'changed' status if propagate_precision() did any updates
    https://git.kernel.org/bpf/bpf-next/c/a8b96f6950d5
  - [bpf-next,v3,06/11] bpf: set 'changed' status if propagate_liveness() did any updates
    https://git.kernel.org/bpf/bpf-next/c/6b3f95cd99f8
  - [bpf-next,v3,07/11] bpf: move REG_LIVE_DONE check to clean_live_states()
    https://git.kernel.org/bpf/bpf-next/c/d297ccb27e04
  - [bpf-next,v3,08/11] bpf: propagate read/precision marks over state graph backedges
    (no matching commit)
  - [bpf-next,v3,09/11] bpf: remove {update,get}_loop_entry functions
    https://git.kernel.org/bpf/bpf-next/c/49af1fa94a93
  - [bpf-next,v3,10/11] bpf: include backedges in peak_states stat
    https://git.kernel.org/bpf/bpf-next/c/346757cf121d
  - [bpf-next,v3,11/11] selftests/bpf: tests with a loop state missing read/precision mark
    https://git.kernel.org/bpf/bpf-next/c/69afa150dfa2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



