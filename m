Return-Path: <bpf+bounces-64836-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B93B17666
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 21:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDB5258034E
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 19:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2A424635E;
	Thu, 31 Jul 2025 19:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fIhdJhA2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDAE245019
	for <bpf@vger.kernel.org>; Thu, 31 Jul 2025 19:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753988653; cv=none; b=ZgDFNrX+xqsfkFqSwIWcCXe0zytzDBXqcioch0ynWkrCMj0oqwvdQxmXxxVZAmVjRk6nCzeFNW1KwhiVsRK9qLfdRDFxOwGWWWSVG1ea/ayBp1aUUebLtNi3nQKc2enRIGM6f8s8M32oH+zEfS1LZ84ehLBVpEB6dsCfyfzkxS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753988653; c=relaxed/simple;
	bh=9iKFp4m7VKMJlqmDBL1Mybh5nH4rQeF/jlgCHpVMc1Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QRiNKat8eYqjilgChOdgIly6cWZVSQxTMnBPPpXKd0Grt0HeEYhXu0e8f8Y9JZc/xiQg+o0tekwEuO4bTbadGDhNA53ayKXDHPgeIxeZcnSLMQAyIEs0zjbdNFl6ZiMz7xVPADKn8CGpBsXnIQ82Y90mPhPvYYhjVJX4H5PMbqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fIhdJhA2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F31CC4CEF6;
	Thu, 31 Jul 2025 19:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753988653;
	bh=9iKFp4m7VKMJlqmDBL1Mybh5nH4rQeF/jlgCHpVMc1Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fIhdJhA2whGee5vCEUOugywDK6Gx+gXm+8AdjPhMpxFke5HX+02RxU2uIhPIwwlTm
	 0sgF1KHYVuoiPgoVR4s0xcUh2ayVh1M/WszWLRonYwfximUQCy8GEG3pBzYyLONQ8U
	 EbwPLMq0X+1ooWrLNOoVm7Lvo08T10QBkS1/KHl7jCmuNpbF+EsTyMLdn3vbnlCU/E
	 x3tig3+gIVv5kANoOyz8Wv63//GiZZtTbh6psMAX4HMhBTafYno1MZ/FrM7ttZIuH8
	 CxDNVeHyxLjM5erwvmIwRAYZx9lfzg6Iq1JntuxXAY5VJVqzETpCfhC7G2CT3ZKyjT
	 6VzQYTvekC7mw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB5C7383BF51;
	Thu, 31 Jul 2025 19:04:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2 1/4] bpf: Add cookie object to bpf maps
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175398866876.3245442.4453254948006628986.git-patchwork-notify@kernel.org>
Date: Thu, 31 Jul 2025 19:04:28 +0000
References: <20250730234733.530041-1-daniel@iogearbox.net>
In-Reply-To: <20250730234733.530041-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: ast@kernel.org, andrii@kernel.org, bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 31 Jul 2025 01:47:30 +0200 you wrote:
> Add a cookie to BPF maps to uniquely identify BPF maps for the timespan
> when the node is up. This is different to comparing a pointer or BPF map
> id which could get rolled over and reused.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  include/linux/bpf.h  | 1 +
>  kernel/bpf/syscall.c | 6 ++++++
>  2 files changed, 7 insertions(+)

Here is the summary with links:
  - [bpf,v2,1/4] bpf: Add cookie object to bpf maps
    https://git.kernel.org/bpf/bpf/c/12df58ad2942
  - [bpf,v2,2/4] bpf: Move bpf map owner out of common struct
    https://git.kernel.org/bpf/bpf/c/fd1c98f0ef5c
  - [bpf,v2,3/4] bpf: Move cgroup iterator helpers to bpf.h
    https://git.kernel.org/bpf/bpf/c/9621e60f59ea
  - [bpf,v2,4/4] bpf: Fix oob access in cgroup local storage
    https://git.kernel.org/bpf/bpf/c/abad3d0bad72

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



