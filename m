Return-Path: <bpf+bounces-77720-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4CECEF715
	for <lists+bpf@lfdr.de>; Fri, 02 Jan 2026 23:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85020300FFBB
	for <lists+bpf@lfdr.de>; Fri,  2 Jan 2026 22:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37652FDC20;
	Fri,  2 Jan 2026 22:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NCMIdufe"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4172D7DDD
	for <bpf@vger.kernel.org>; Fri,  2 Jan 2026 22:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767393810; cv=none; b=huEC0n9XpFibcBjGA8G0By7pZNVeLnUVpOQdiESwHk++XIH87DVNw8y9jVD4wgulouMAyGQb79J5X2PF4xszSaTUxaDVUQ8tmXMeEEryUEkRHpeIKpVGLWUidpg1BaWUOS27+IVXuwnO9DB4wv4yrrgRzuvtVQCaUS3te2QUWVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767393810; c=relaxed/simple;
	bh=482RQ9svoJchkioCy58IjLIqwkUsWRuWy3f5d3Jbtqc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WAEzyn0vzbT5rsMYvRrMv+ErQHQ+RXFDq1cy4L1gRzv1jyHI5BT2kL0x1jpCcfOXeZtqQPK1uxcbF55LkqzPRz34nehDOqOgwABM2lxn/W2oPIlGmpauXUsuYvetEAYMTv2aM6BZVLuN0TYfe7cVPqKwftguT44MNJuNySAUMgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NCMIdufe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11A6AC116B1;
	Fri,  2 Jan 2026 22:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767393810;
	bh=482RQ9svoJchkioCy58IjLIqwkUsWRuWy3f5d3Jbtqc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NCMIdufe1kXXYo7OnZCmyWhaZubkPNB7JRLG4Zx0IkOAHHjrfCHdx/VW+Sie0Nch4
	 hKYSElyMwM7kM9T10P9gmUSRjADmhg3+Y5vC1274IlkBgAFuUaYz3rlIdlUaxPxlXW
	 m84OcyuSYETE6LZrDJFshc2PJZuNgeT/AJvhmPgWNYX9NRlaAkSWkGVQpOsS0OUPE9
	 0fkkKUaayyeApzWUhYoJSmYQtOGRQddEnU8aeUMOWiohQBw9jQqxOLmgvF+fIqOwS9
	 6FtSVNEuIxTStlLZ+CINsvlRLj5gL9qo+YGqrOOndpFAJHWS0DEQVdokQ/m5QOdWrQ
	 Lr/yJ+mDK3RnA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3BAE0380A962;
	Fri,  2 Jan 2026 22:40:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v5 0/2] memcg accounting for BPF arena
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176739361003.4022808.6370687418641185135.git-patchwork-notify@kernel.org>
Date: Fri, 02 Jan 2026 22:40:10 +0000
References: <20260102200230.25168-1-puranjay@kernel.org>
In-Reply-To: <20260102200230.25168-1-puranjay@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, puranjay12@gmail.com, ast@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri,  2 Jan 2026 12:02:26 -0800 you wrote:
> v4: https://lore.kernel.org/all/20260102181333.3033679-1-puranjay@kernel.org/
> Changes in v4->v5:
> - Remove unused variables from bpf_map_alloc_pages() (CI)
> 
> v3: https://lore.kernel.org/all/20260102151852.570285-1-puranjay@kernel.org/
> Changes in v3->v4:
> - Do memcg set/recover in arena_reserve_pages() rather than
>   bpf_arena_reserve_pages() for symmetry with other kfuncs (Alexei)
> 
> [...]

Here is the summary with links:
  - [bpf-next,v5,1/2] bpf: syscall: Introduce memcg enter/exit helpers
    https://git.kernel.org/bpf/bpf-next/c/817593af7b9b
  - [bpf-next,v5,2/2] bpf: arena: Reintroduce memcg accounting
    https://git.kernel.org/bpf/bpf-next/c/e66fe1bc6d25

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



