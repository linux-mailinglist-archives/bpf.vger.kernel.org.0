Return-Path: <bpf+bounces-75745-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BDFC9349B
	for <lists+bpf@lfdr.de>; Sat, 29 Nov 2025 00:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 76D4734BD7E
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 23:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419AF2EAD0B;
	Fri, 28 Nov 2025 23:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nAWfXvwh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF93827F75F
	for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 23:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764372193; cv=none; b=GqZi5z9O2284C5sM6fLvTewnGLxazNpPEsCeC/Ym5aN86p9HilpXAMRl+9sVWezNzd63+PndgFI5m9gzJELIWkesEW+CL757y+I11bG/iO2C2bejaLnjYnr7b7hjLPcmGCCJDfpIhY46VRaMf3EJnxs8yjkCW5nKx+LkjLj/aMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764372193; c=relaxed/simple;
	bh=CEDs/m4YjNxWJT3PSep01LwRgCB/pw+8tyI8NUWxYxw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CCmiL9pOW77Wee6t1mWUqP39Jzudns5ECEQnI4J49FIJRF2BnhpITGRp0Np6RJkaANkNfFHrcWdYX34FhaURQ9SyV7BjOaWng/CgW3n1FYjOC1PMi4hjV7rJKnPI4Mg8sgti0hhoYsm1c9I80NPFA5f/CO7vkHzE0IXTz5vwbaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nAWfXvwh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ADF5C4CEF1;
	Fri, 28 Nov 2025 23:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764372193;
	bh=CEDs/m4YjNxWJT3PSep01LwRgCB/pw+8tyI8NUWxYxw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nAWfXvwhqUgoxBmIUnrRbcbJiojAXi0Ipd1XwRIOSxyUEjbUPHOidowgQgswg5n2t
	 WWBTHN3fBW6wp18LdiWFiz4P98bK8pKdy8ZI9C6SCOo1kWr47goySrE+9KK0knHBxt
	 +jp3f9blFKXZzu7Yt0TwbiYCrgKEEgA2q0ShBAz+ceZyW8dF52KO5KZUdZTH5syuPi
	 H3wpM56Rp9jjf+s1U3x2ge0aEmYCEGnbJeKBnO9eQM0lsBX9ZGRRGqf7av7fM+QrwX
	 OK03ub16HlIBqFWCMKxEAplapBxjYDmSzkCZBA/zDvfldRN5IthdAQLB9uN8mQlJTG
	 L8X0rl9XIjbrg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B834380692B;
	Fri, 28 Nov 2025 23:20:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Disable file_alloc_security hook
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176437201504.828244.12198051182889256649.git-patchwork-notify@kernel.org>
Date: Fri, 28 Nov 2025 23:20:15 +0000
References: <20251126202927.2584874-1-ameryhung@gmail.com>
In-Reply-To: <20251126202927.2584874-1-ameryhung@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 daniel@iogearbox.net, kaiyanm@hust.edu.cn, dddddd@hust.edu.cn,
 dzm91@hust.edu.cn, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 26 Nov 2025 12:29:26 -0800 you wrote:
> A use-after-free bug may be triggered by calling bpf_inode_storage_get()
> in a BPF LSM program hooked to file_alloc_security. Disable the hook to
> prevent this from happening.
> 
> The cause of the bug is shown in the trace below. In alloc_file(), a
> file struct is first allocated through kmem_cache_alloc(). Then,
> file_alloc_security hook is invoked. Since the zero initialization or
> assignment of f->f_inode happen after this LSM hook, a BPF program may
> get a dangeld inode pointer by walking the file struct.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v1,1/2] bpf: Disable file_alloc_security hook
    https://git.kernel.org/bpf/bpf-next/c/b4bf1d23dc1d
  - [bpf-next,v1,2/2] selftests/bpf: Remove usage of lsm/file_alloc_security in selftest
    https://git.kernel.org/bpf/bpf-next/c/a3a60cc120d6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



