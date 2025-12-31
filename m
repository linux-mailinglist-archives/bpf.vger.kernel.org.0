Return-Path: <bpf+bounces-77610-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8D1CEC587
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 18:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B2703009F96
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 17:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53755281369;
	Wed, 31 Dec 2025 17:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R1amAKDv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA902877D6
	for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 17:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767201208; cv=none; b=jb7MSIemhPkd+1BM3QIiIpx6Bh3UBngfkAM1OuZyn0ykaCRlUGKSmS+3VMxh3Qz1+k5EZWyy5SECwxcwh84QoEoxXmgfbRzl+1pKyx9mv/N3E83qUYG907lBlURMKlqUPo9xykMRTZGoIXaQmvmenvqKH3vwkSVOErLGle2FIIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767201208; c=relaxed/simple;
	bh=50yp/1IucWeAbwoiC4R2WlYNCAxT7BijkEusNO7Z7eE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uCdFWEtjdkGufxqDXqg764/bPS6C4PRdYUj+rK4sHdu+EFDpqc+3TWsJfa3Nkkq5AXgAkUHEOKafKElwk+Fyl5FVO0XZvpKmqw1+3mjP7VMapveSNDzauJghgkOtht9goNa4LGBjy3/DRGgvxvq/cynE3/fmt4WHVu/Xo4tpOR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R1amAKDv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A87CFC113D0;
	Wed, 31 Dec 2025 17:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767201208;
	bh=50yp/1IucWeAbwoiC4R2WlYNCAxT7BijkEusNO7Z7eE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=R1amAKDv/JH3MZosjWn4WdILGSSabjnFaEB0nOh57I01ol0yyqD3eWFC63EbA/6jE
	 5DEdGYc6I85yVbNEhBNnKoGA9EVP193Qpi9qDdgqFe/6qcEFnth0SdwRlKczfL6cbM
	 g/ViuAaDEkN5ayXDz6p/j/AoMyaB0jAOshe+AwvhKA4xE/5GNAdN5mbwKmPNELE1MM
	 nTVNTd5ot80SwieGFYjCVasWe9Ex0RoXdkRLWD7ZFGxSLCvYMGOcuHVjc69ONDfqPe
	 wEbWClHcIRuoBzPgcHlTikOvayu1QQMMrx4rokxanCcCSydnwzPIsgTJa/e66g8id9
	 kgdCYbY62KV7Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B88E3809A83;
	Wed, 31 Dec 2025 17:10:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/2] bpf: unify state pruning handling of
 invalid/misc stack slots
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176720101000.3562703.10505763825074318061.git-patchwork-notify@kernel.org>
Date: Wed, 31 Dec 2025 17:10:10 +0000
References: <20251230-loop-stack-misc-pruning-v1-0-585cfd6cec51@gmail.com>
In-Reply-To: <20251230-loop-stack-misc-pruning-v1-0-585cfd6cec51@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 30 Dec 2025 21:36:02 -0800 you wrote:
> This change unifies states pruning handling of NOT_INIT registers,
> STACK_INVALID/STACK_MISC stack slots for regular and iterator/callback
> based loop cases.
> 
> The change results in a modest verifier performance improvement:
> 
> ========= selftests: master vs loop-stack-misc-pruning =========
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpf: allow states pruning for misc/invalid slots in iterator loops
    https://git.kernel.org/bpf/bpf-next/c/840692326e92
  - [bpf-next,2/2] selftests/bpf: iterator based loop and STACK_MISC states pruning
    https://git.kernel.org/bpf/bpf-next/c/4fd99103eef3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



