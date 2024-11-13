Return-Path: <bpf+bounces-44704-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A98439C66A1
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 02:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA5D8B28975
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 01:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29386762EF;
	Wed, 13 Nov 2024 01:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="izVMnSWE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B5E1304B0
	for <bpf@vger.kernel.org>; Wed, 13 Nov 2024 01:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731460822; cv=none; b=ssZ9nTe6c5DK6u5qPsMovtrqYP1lpXOCQj9HlI1M8xwzslr7J2n6Pphg/c/6h+7WZsMgnTseS88m2NdAoZEQf5aEoND9qrdbGzX0h36tlK1YtOU7T9OZrtU1OvWKG1zyzbPHrSSLngpsbtfutqPOGi6vSmvYDclkTn+J/Gz7EcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731460822; c=relaxed/simple;
	bh=Vsa4sDdsAC1gj7GAekRMO2ofIe35EKLaPCCwFQIFT5o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QBxtOP9nApOrUlIThfhIcwyfGN2MqGBGPTTYmk6nRKiAsTN3HKFv1l8yBN8Yo65X7qHy/PKgQVthqMtMrL86QsVuI4Hvmy4kZkeUihPMB3qwXgveadFPCE53K2qR0uVbkmNxSj5HEqdhmviAZyB5gbOyrrCChmxb+RYXLhxI9j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=izVMnSWE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B474C4CED6;
	Wed, 13 Nov 2024 01:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731460822;
	bh=Vsa4sDdsAC1gj7GAekRMO2ofIe35EKLaPCCwFQIFT5o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=izVMnSWEIO/TKtcKO+KZjPbmu7I2GMMrX40Tw27hJvb6Z98gNxzCQxBw4Qcnp4DRU
	 BbBN1LdJ8mpVJh+8vpWAsJLzFJ53bu6PivpEp9U5xXAuKUgBanEy/Ft3Rs+lxt3yet
	 L6crg0UmcFLu3JN3ocWCN/akvSMT4mkiyxPRDu1go76FeuawypIQLlXhsFqvZiQkQo
	 davtGwYqSm+LDfe6vvTG5IPcr5OPCoqIW+hXJiXsodBA9dbM2YHHoCz7pUYhied2I7
	 uGhsmzxbG/RhLJJslCJwvs859BZRW8S8/ph74hifd4KJdii6KuPxUBk94AKIacatd8
	 2802qF5vwnBqQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD463809A80;
	Wed, 13 Nov 2024 01:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v12 0/7] bpf: Support private stack for bpf progs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173146083249.741480.16435519636826517152.git-patchwork-notify@kernel.org>
Date: Wed, 13 Nov 2024 01:20:32 +0000
References: <20241112163902.2223011-1-yonghong.song@linux.dev>
In-Reply-To: <20241112163902.2223011-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org,
 tj@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 12 Nov 2024 08:39:02 -0800 you wrote:
> The main motivation for private stack comes from nested scheduler in
> sched-ext from Tejun. The basic idea is that
>  - each cgroup will its own associated bpf program,
>  - bpf program with parent cgroup will call bpf programs
>    in immediate child cgroups.
> 
> Let us say we have the following cgroup hierarchy:
>   root_cg (prog0):
>     cg1 (prog1):
>       cg11 (prog11):
>         cg111 (prog111)
>         cg112 (prog112)
>       cg12 (prog12):
>         cg121 (prog121)
>         cg122 (prog122)
>     cg2 (prog2):
>       cg21 (prog21)
>       cg22 (prog22)
>       cg23 (prog23)
> 
> [...]

Here is the summary with links:
  - [bpf-next,v12,1/7] bpf: Find eligible subprogs for private stack support
    https://git.kernel.org/bpf/bpf-next/c/a76ab5731e32
  - [bpf-next,v12,2/7] bpf: Enable private stack for eligible subprogs
    https://git.kernel.org/bpf/bpf-next/c/e00931c02568
  - [bpf-next,v12,3/7] bpf, x86: Avoid repeated usage of bpf_prog->aux->stack_depth
    https://git.kernel.org/bpf/bpf-next/c/f4b21ed0b9d6
  - [bpf-next,v12,4/7] bpf, x86: Support private stack in jit
    https://git.kernel.org/bpf/bpf-next/c/7d1cd70d4b16
  - [bpf-next,v12,5/7] selftests/bpf: Add tracing prog private stack tests
    https://git.kernel.org/bpf/bpf-next/c/f4b295ab6598
  - [bpf-next,v12,6/7] bpf: Support private stack for struct_ops progs
    https://git.kernel.org/bpf/bpf-next/c/5bd36da1e37e
  - [bpf-next,v12,7/7] selftests/bpf: Add struct_ops prog private stack tests
    https://git.kernel.org/bpf/bpf-next/c/becfe32b57c7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



