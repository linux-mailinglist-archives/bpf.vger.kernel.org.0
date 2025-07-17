Return-Path: <bpf+bounces-63665-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F9CB0952F
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 21:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34C8B7A21A4
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 19:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E47521A420;
	Thu, 17 Jul 2025 19:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kk11qW6/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21835194A60;
	Thu, 17 Jul 2025 19:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752781787; cv=none; b=twWNBaCxAPWkgeeZXKdAIvOShEJVzFgwW80upuBa3h0kaJvlLeTm5U/Tci9ODuTDDqgD3uEolsGsKcvXke0KoRda2oaWmZ9cRLjkuu+Pgd4qcq8rPCayqSLdlXXMr9Bb54tUYu1uya+A+iMlW50+yRQ3SbTqhSZWknCjU7taWNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752781787; c=relaxed/simple;
	bh=1R9zfgnqlqBLKpx/A7r6wfwk5oqpycKcHBIww1LzM/Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=n0gBzdBJAtrMB7HV7BDSfKS3Ev1jrxnwauYD+bk0XePnodoG4XKmGn2Ya2tmWBTG7mAW7XihmIr8R9zAFzXWDmOlK4xGsVUxQsZl5vCFmC8nxUUYms7z4OyrYvjrXPIAYyZKWcps4M/e8YhSQbBwxik/3LAD31rBs+uN1K5TYMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kk11qW6/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81164C4CEE3;
	Thu, 17 Jul 2025 19:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752781786;
	bh=1R9zfgnqlqBLKpx/A7r6wfwk5oqpycKcHBIww1LzM/Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kk11qW6/VfXSao1aX395jqf28p610lBRPzJFPhvEh9g88aeRjK2RqNq//qKLRXmNC
	 bctbw+BoDyuCNON29USqz/FGzfoTEH3svM88oPHlDV3o2NZ0aZbW33ayxmB7iNbkRb
	 O8Xsh8JidCDOwnRUsqhMeR+mbDVbVVr5ugj6eRAYieV5nknikTseMe7zmrDI/sffp1
	 /7jHIbYm7bznXGHTeEaglnbpYw8r/28FqSlY3k6GpMHcbPjY06xFkKTLgLkcckjmN0
	 mfjTEIINFSpSorE876saAM6Xj4Y2yWLVCq521E/5vx/XDfPxkyEkdR5WMxqQHcWoC3
	 XzOhaJFPstwqA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADBE2383BAC1;
	Thu, 17 Jul 2025 19:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] btf: fix virt_to_phys warning on arm64 when mmapping
 vmlinux
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175278180651.2055348.12385131153368330090.git-patchwork-notify@kernel.org>
Date: Thu, 17 Jul 2025 19:50:06 +0000
References: <20250717-vmlinux-mmap-pa-symbol-v1-1-970be6681158@isovalent.com>
In-Reply-To: <20250717-vmlinux-mmap-pa-symbol-v1-1-970be6681158@isovalent.com>
To: Lorenz Bauer <lmb@isovalent.com>
Cc: leitao@debian.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shakeel.butt@linux.dev,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 17 Jul 2025 17:49:49 +0100 you wrote:
> Breno Leitao reports that arm64 emits the following warning:
> 
>     [   58.896157] virt_to_phys used for non-linear address: 000000009fea9737
>       (__start_BTF+0x0/0x685530)
>     [   23.988669] WARNING: CPU: 25 PID: 1442 at arch/arm64/mm/physaddr.c:15
>       __virt_to_phys (arch/arm64/mm/physaddr.c:?)
> 
> [...]

Here is the summary with links:
  - [bpf] btf: fix virt_to_phys warning on arm64 when mmapping vmlinux
    https://git.kernel.org/bpf/bpf/c/2e2713ae1a05

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



