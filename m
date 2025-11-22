Return-Path: <bpf+bounces-75292-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C288C7C454
	for <lists+bpf@lfdr.de>; Sat, 22 Nov 2025 04:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D41A53A697C
	for <lists+bpf@lfdr.de>; Sat, 22 Nov 2025 03:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEAAA13AD26;
	Sat, 22 Nov 2025 03:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nR9ZiUA6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C64E35975
	for <bpf@vger.kernel.org>; Sat, 22 Nov 2025 03:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763781646; cv=none; b=lvOtKq+7AUj5fZKsb/LslrkG5WLYnAzreIRINky4LZ9JDST7jCi2Bb+kzMmwemthVvDt2b688WijNyFf2qHbYHNGgmlKD9Ku2JTN6drM5PSz3MmIZsU4wbxnv8ILJzR8P3C/Bfmntv1VQsWgFFPqbdCDuBHgN2dpd0K1vCb8GoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763781646; c=relaxed/simple;
	bh=rOrAoOgtuyFJjrpY2/bPlLSzd2APJqNqBPcO0nlggzw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YWMiud2TOW3jdNnweWSo6/FFu5LNbG5Ao55Y00KlwWpiacy0fDTnLf6x9z/yOwpLiDQaS+jGXcbGe4wwXzQGg6wc+VIOYTGR5y27EPD43ldC8RVh8bCbDWH4SRSgt6SPvea+Y3eEe6jbgYNZd5xGghs+aUfG/2Fb5osHTEjoHK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nR9ZiUA6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 904EFC4CEF1;
	Sat, 22 Nov 2025 03:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763781645;
	bh=rOrAoOgtuyFJjrpY2/bPlLSzd2APJqNqBPcO0nlggzw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nR9ZiUA6fitGwhn0Un+NQK2S+SK3LrL3aepCU0eZiJ2vPW8VHA1yGMlGnlitqvgUx
	 3TOCXavHcgzBD+nDc8yy58jeKzB3xLqeZlTdae1cmrhGySxEUHSKo0qhrZsrj7+LTR
	 du5KKOJ6BbwWS6HVq6+1WDxaLT4BCVW1gQYjDvZbxzkB3ucu1dSrQ0KdgXE3+K4y6M
	 ApP0QMyTUG1Uuusna0olgs4TiZfKqJbIK4zgEI11VdPqqL3s1kpxAnoFen4736ZSPJ
	 yb3topgHv1vmKwGQd+O3WUsYzvSg88QZuLu9/55u95JXhQI+0jA6DmtuuykxlCHaGp
	 Cwf4BzH3zi7fg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BFE3A78B25;
	Sat, 22 Nov 2025 03:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/2] bpf: Nested rcu critical sections
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176378161001.2671115.14700810886503055578.git-patchwork-notify@kernel.org>
Date: Sat, 22 Nov 2025 03:20:10 +0000
References: <20251117200411.25563-1-puranjay@kernel.org>
In-Reply-To: <20251117200411.25563-1-puranjay@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, kkd@meta.com, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
 puranjay12@gmail.com, kernel-team@fb.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 17 Nov 2025 20:04:08 +0000 you wrote:
> v1: https://lore.kernel.org/bpf/20250916113622.19540-1-puranjay@kernel.org/
> Changes in v1->v2:
> - Move the addition of new tests to a separate patch (Alexei)
> - Avoid incrementing active_rcu_locks at two places (Eduard)
> 
> Support nested rcu critical sections by making the boolean flag
> active_rcu_lock a counter and use it to manage rcu critical section
> state. bpf_rcu_read_lock() increments this counter and
> bpf_rcu_read_unlock() decrements it, MEM_RCU -> PTR_UNTRUSTED transition
> happens when active_rcu_locks drops to 0.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] bpf: support nested rcu critical sections
    https://git.kernel.org/bpf/bpf-next/c/4167096cb964
  - [bpf-next,v2,2/2] selftests: bpf: Add tests for unbalanced rcu_read_lock
    https://git.kernel.org/bpf/bpf-next/c/cf49ec5705a6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



