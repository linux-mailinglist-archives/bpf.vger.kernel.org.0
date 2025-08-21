Return-Path: <bpf+bounces-66250-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EAF7B30247
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 20:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB3CFAA5254
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 18:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE9F2EAB80;
	Thu, 21 Aug 2025 18:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hnOCrFyw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365831EB5C2
	for <bpf@vger.kernel.org>; Thu, 21 Aug 2025 18:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755802197; cv=none; b=QHIpBr57v0VPN1QYXezzRr+zsq6XV0aZp/W3Td0AS2hk+PQrzB/adDxUH4fXRVEdkVFVbuS87BPGG7a5ulSLB4wOmLXl1uS8x5uGYfpm0Wixem/QkxexZTOXO7u1fHEQc6lJuPVqR85OUkQoQ1bbRaptR9z4Zk/SJkkZ9BFhJV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755802197; c=relaxed/simple;
	bh=4dTYYKRSHAeNZpKYpaIF1fG6/nWW0i745fdFlR80Ab8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DrqsHkfVuDqLfh15G4jIExxcQ4oihwP6C1CVagAAwJ64IhFE1JyWQeM4hM8Ir08p6UuvKJvYHEG0TeMrUxAHzhA0ihZZhL+TNR2Pvnyt9aCeO74kRiPqGeyJvCSoNnej6b0ymoOUFLGWJc/DaMzcQZNTiOt5iPeR7FY855uCMfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hnOCrFyw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8B5DC4CEEB;
	Thu, 21 Aug 2025 18:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755802196;
	bh=4dTYYKRSHAeNZpKYpaIF1fG6/nWW0i745fdFlR80Ab8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hnOCrFywOv5Jfl9Gozspj/GD5jeX1A2C33AaRkm5+2zLjJZq6VKQbuh1FAhQHuuY6
	 1+QNcZqIHdw8HXtgBNw0ffmXT61727x9RrSLaxxRlTHZl+pyay6RLDA/DMW2kWkIaQ
	 7K8EeBIF5T0EI3I3E9VIN0H4/cG0g86WLFZa2Zkd0XTDZaodBXtFK1XF12VvvrkL/2
	 9aKYN2z2OR4O7WTLr0BgTKOoLkUzpQG/cwoOA78GpJGbOjBkuX6FxUgjoUcERjNSGx
	 MKVVDEJr2iyDn6tBJeLwGaym8EeyeHQZxzqgxCPfMoZoRskx/8KfJW7CpWe714V0HM
	 8JqX49yAGGuog==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CD8383BF5B;
	Thu, 21 Aug 2025 18:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3] selftests/bpf: Use vmlinux.h for BPF programs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175580220600.1148464.7863821287864768578.git-patchwork-notify@kernel.org>
Date: Thu, 21 Aug 2025 18:50:06 +0000
References: <20250821030254.398826-1-hengqi.chen@gmail.com>
In-Reply-To: <20250821030254.398826-1-hengqi.chen@gmail.com>
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 21 Aug 2025 03:02:54 +0000 you wrote:
> Some of the bpf test progs still use linux/libc headers.
> Let's use vmlinux.h instead like the rest of test progs.
> This will also ease cross compiling.
> 
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---
>  tools/testing/selftests/bpf/progs/loop1.c     |  7 +------
>  tools/testing/selftests/bpf/progs/loop2.c     |  7 +------
>  tools/testing/selftests/bpf/progs/loop3.c     |  7 +------
>  tools/testing/selftests/bpf/progs/loop6.c     | 21 +++++++------------
>  .../selftests/bpf/progs/test_overhead.c       |  5 +----
>  5 files changed, 11 insertions(+), 36 deletions(-)

Here is the summary with links:
  - [bpf-next,v3] selftests/bpf: Use vmlinux.h for BPF programs
    https://git.kernel.org/bpf/bpf-next/c/21aeabb68258

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



