Return-Path: <bpf+bounces-69316-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33BC5B9400C
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 04:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E78D03A5EEA
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 02:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCCD526290;
	Tue, 23 Sep 2025 02:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E4rh6Eza"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60572111A8;
	Tue, 23 Sep 2025 02:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758594615; cv=none; b=nWJ5ZAAmHwhR72OMB9vuCaCS7CVrCymxdBMi50ryzvTUQTOGvnhed+ZhHEcZbJ31nBFe10hvBJN8iLC1fOu/dYib5ekMK2COXiDhF1K6eBUgVcg5K8XfvTqp/iwVUNeduuzmCOImlEfR+f3oue3MK+SFc3f0SbHzyoiABVEabwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758594615; c=relaxed/simple;
	bh=9zO77vAq+fFMaXqM0hmbhn8zZtJmWHVWGqFgHp/gj48=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jAZz5ZO0NAAtCD9iyPFG4/WJjpsCLbClOCUmHZxdTLY6Gxjqm4cpTUW4sRoXBvQuCPUomzogmQSin6DqUdG3EliAX5UnrzkjiNWaY3bx7Wbv2ZodbuKpA3H+mnp4J+fsLHVsQV/pK1XpyNG3qlUVe/lzjzTVKuh4Iwk8CmbfNrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E4rh6Eza; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7573C4CEF0;
	Tue, 23 Sep 2025 02:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758594614;
	bh=9zO77vAq+fFMaXqM0hmbhn8zZtJmWHVWGqFgHp/gj48=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=E4rh6EzaILpY7kkUOdMuXFutC1EN6MYy3atgyRUTjGEnMFzXqA4qwFA7FKyBowQ6o
	 rPPTtDkK+HfMlAWQEBR2zu2GVc/vQ5s8N/xzmfc0VTF2ECB7DLmroBMsNYKfRMErDE
	 UyxoEmD2DzeiGK3DeyzE/EA7++Sq/pPjsEqQfJ2h/qtocGmkqCjAbUMZR1PuDmnIUD
	 Ujp05S3p2ig5fcajXBnCyFrGnREkiPO8fLYiB45U5RxpcV1uehwcX+XmIlrMiUN7KQ
	 znfPufAfQfbwNk1tAQ7LyxpaLrIOrjSZkYeHC7TYMmjbSdv3Gd/82I/zgKJYFZzr5Q
	 ntEH1icZwulyA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CF339D0C20;
	Tue, 23 Sep 2025 02:30:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v7 0/5] Signed BPF programs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175859461225.1236852.4239631219709272102.git-patchwork-notify@kernel.org>
Date: Tue, 23 Sep 2025 02:30:12 +0000
References: <20250921160120.9711-1-kpsingh@kernel.org>
In-Reply-To: <20250921160120.9711-1-kpsingh@kernel.org>
To: KP Singh <kpsingh@kernel.org>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
 bboscaccy@linux.microsoft.com, paul@paul-moore.com, kys@microsoft.com,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sun, 21 Sep 2025 18:01:15 +0200 you wrote:
> # v6 -> v7
> 
> * list header mess up in Patch subject
> 
> # v5 -> v6
> 
> * Rebase again removing the first 7 patches as they are merged already.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v7,1/5] bpf: Implement signature verification for BPF programs
    https://git.kernel.org/bpf/bpf-next/c/349271568303
  - [bpf-next,v7,2/5] libbpf: Update light skeleton for signing
    (no matching commit)
  - [bpf-next,v7,3/5] libbpf: Embed and verify the metadata hash in the loader
    https://git.kernel.org/bpf/bpf-next/c/ea923080c145
  - [bpf-next,v7,4/5] bpftool: Add support for signing BPF programs
    https://git.kernel.org/bpf/bpf-next/c/40863f4d6ef2
  - [bpf-next,v7,5/5] selftests/bpf: Enable signature verification for some lskel tests
    https://git.kernel.org/bpf/bpf-next/c/b720903e2b14

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



