Return-Path: <bpf+bounces-30140-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE038CB315
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 19:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7A6A1C21A72
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 17:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76995148FE6;
	Tue, 21 May 2024 17:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sIu2FAwv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9CE14884F;
	Tue, 21 May 2024 17:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716313232; cv=none; b=QHx8/wrPAm0Ah3V2vYnH+sTFBGCjAN6Pi0IYXrFRdT0PbjSXuEv/RAiNralVKRIhl+Xq9KvnXUzCN+w2IoeSrxguC9XuUoFec6Bw4ZajjQUPM7HV6QRHAvaU+931kBduhTOaGi8pLXK8/9iu3yb+5GJ6jUPT5MtnoApF+jK0bTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716313232; c=relaxed/simple;
	bh=qVChz3yTRX5PsAq7ghcr9MG/QydNqv/MMmVizdTxvB4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VTkhY/+2CcOWN3W11iQ6yoYdzcGAWsKhRRJ5hVjuczn2OCG2SxN7d0nD8ZTbU+UKQLbvw2ejN2iSi4NWRUNqzH/WCgLJl+e4Vb6SqoIyDH96DA7oM+i3E7KN3iIjURaXP/SCnilWUla2dAW6ziQ72nGA8Ij04yO8FA5F1dvTNus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sIu2FAwv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 63A71C32786;
	Tue, 21 May 2024 17:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716313231;
	bh=qVChz3yTRX5PsAq7ghcr9MG/QydNqv/MMmVizdTxvB4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sIu2FAwvPmvmAVo4yv/cA54k6lVYQjQu8qYevji7M4bufW/aKH/mbPHvwHsdvdBFE
	 VghMkq4NapK88uDP+0WAGi/5WqznvVAjokRHztad/xdl+Z3P4mhyDPWiQDaJBNMtyw
	 yfxsgy9Hx7ACHkgcADVjpkbVCXC6xKFGoQwJjiC/55McsMUNa+lF30AEOCm0KLGPyT
	 iwB9SDYwwh3dgVDCjBdCRF9BxVWYf2EpJj1trvmt1vKupDQqwJvBJIRVvVYI1UFLJb
	 PvEI3r8i2BlM8Iu76adSPj3jQV7Crbzic6tJU41rBYFv7wRzVPDxazitSQqsOnXWjZ
	 IbYIGeonCCipw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3F873C54BD4;
	Tue, 21 May 2024 17:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpftool: un-const bpf_func_info to fix it for llvm 17 and
 newer
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171631323125.30783.6623831881664329095.git-patchwork-notify@kernel.org>
Date: Tue, 21 May 2024 17:40:31 +0000
References: <20240520225149.5517-1-ivan@cloudflare.com>
In-Reply-To: <20240520225149.5517-1-ivan@cloudflare.com>
To: Ivan Babrou <ivan@cloudflare.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@cloudflare.com, quentin@isovalent.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 nathan@kernel.org, ndesaulniers@google.com, trix@redhat.com, ramasha@fb.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 20 May 2024 15:51:49 -0700 you wrote:
> LLVM 17 started treating const structs as constants:
> 
> * https://github.com/llvm/llvm-project/commit/0b2d5b967d98
> 
> Combined with pointer laundering via ptr_to_u64, which takes a const ptr,
> but in reality treats the underlying memory as mutable, this makes clang
> always pass zero to btf__type_by_id, which breaks full name resolution.
> 
> [...]

Here is the summary with links:
  - bpftool: un-const bpf_func_info to fix it for llvm 17 and newer
    https://git.kernel.org/bpf/bpf-next/c/f4aba3471cfb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



