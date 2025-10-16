Return-Path: <bpf+bounces-71082-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86992BE1CF2
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 08:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 593253A68B6
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 06:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3B02EF65C;
	Thu, 16 Oct 2025 06:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P8yMnM5E"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6AC239E63;
	Thu, 16 Oct 2025 06:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760597429; cv=none; b=tX5gFL9q1Z+S4Krpj5355hK0x4i9Mlj2vKgTsA4Op4P51fPPK/5p+PcU55z9X+6SzjQA7b/qXC2e+6vrsExwJlwiogCwyl2KO1+nAi40n6XpSTGHPhFgsgtDv2Q1Hz4FVxVqZZ+LEbzOQ5o/wZJaidCsD6ftv7tLyvlfn4MkAFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760597429; c=relaxed/simple;
	bh=5nAl/JapwFNY3OyQHlzk+hzxps0TpN4jCMXVZiiK2hg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=taNIU07/OHlYeDISvcjf1cx/2r+hSojx6ODNgrKO2Xd9X3/W34CdDYz5MIJhyUo27WE7axLh0vwxD/kV9jUHTulD9H60iZvDKDkKxlrSx7YUUGCY7YOWZIpUwgwlb1FMTcE+XRwsyDEJAYJEqO38m93/solFxcUfgtRUt7y9tqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P8yMnM5E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5521C4CEF1;
	Thu, 16 Oct 2025 06:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760597428;
	bh=5nAl/JapwFNY3OyQHlzk+hzxps0TpN4jCMXVZiiK2hg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=P8yMnM5EAoAsDgEHOM9S8eJ3SeCAoFGEum+vS0rKYeqXBBwPUQNeTFJZZ3R+nVepb
	 B94nwKqrcmwoUR3md3StGUsQat6okBKa5re2gwXe/aU0LUAndmNJUpQqfYMWUPt4Pp
	 csE5DqKKitFgE7RPYOBwAVek7uFMRvOINhF432nZN9v56CYyjFpDaTlEFN3/HJ/YqK
	 1qUR4eD+fljqjAn50lPFHUbwCDmfYExBGqZWVX0DFCds4GdmDzV3X8hsQaKP6FwTAO
	 HIAKMpKIWdno7OnxLUD4P9CjUdJUzCCu+ULJsnKZQQz00wdqI/UP9J8BgFSFZyQtlC
	 Vhb0RdFxnSULg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DCE38111E3;
	Thu, 16 Oct 2025 06:50:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next/net 0/6] bpf: Allow opt-out from
 sk->sk_prot->memory_allocated.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176059741325.1205767.12458760043676255932.git-patchwork-notify@kernel.org>
Date: Thu, 16 Oct 2025 06:50:13 +0000
References: <20251014235604.3057003-1-kuniyu@google.com>
In-Reply-To: <20251014235604.3057003-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, john.fastabend@gmail.com, sdf@fomichev.me,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ncardwell@google.com, willemb@google.com, almasrymina@google.com,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, kuni1840@gmail.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (net)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Tue, 14 Oct 2025 23:54:53 +0000 you wrote:
> This series allows opting out of the global per-protocol memory
> accounting if socket is configured as such by sysctl or BPF prog.
> 
> This series is the successor of the series below [0], but the changes
> now fall in net and bpf subsystems only.
> 
> I discussed with Roman Gushchin offlist, and he suggested not mixing
> two independent subsystems and it would be cleaner not to depend on
> memcg.
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next/net,1/6] tcp: Save lock_sock() for memcg in inet_csk_accept().
    https://git.kernel.org/bpf/bpf-next/c/8c52ab2e9b34
  - [v2,bpf-next/net,2/6] net: Allow opt-out from global protocol memory accounting.
    https://git.kernel.org/bpf/bpf-next/c/d5728fed86f6
  - [v2,bpf-next/net,3/6] net: Introduce net.core.bypass_prot_mem sysctl.
    https://git.kernel.org/bpf/bpf-next/c/543cf9b90ce5
  - [v2,bpf-next/net,4/6] bpf: Support bpf_setsockopt() for BPF_CGROUP_INET_SOCK_CREATE.
    https://git.kernel.org/bpf/bpf-next/c/13b77b283f2b
  - [v2,bpf-next/net,5/6] bpf: Introduce SK_BPF_BYPASS_PROT_MEM.
    https://git.kernel.org/bpf/bpf-next/c/58e1d04e5e34
  - [v2,bpf-next/net,6/6] selftest: bpf: Add test for sk->sk_bypass_prot_mem.
    https://git.kernel.org/bpf/bpf-next/c/71295ac94281

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



