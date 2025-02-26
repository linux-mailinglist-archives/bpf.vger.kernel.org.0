Return-Path: <bpf+bounces-52683-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B7FA46A25
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 19:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0631D16CCCC
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 18:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37974236425;
	Wed, 26 Feb 2025 18:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bWbccPZX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B083E22B8C2
	for <bpf@vger.kernel.org>; Wed, 26 Feb 2025 18:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740595799; cv=none; b=bqSjF01h+TOVcwtdJ2KLZjJ9Q/KQgiSFrVx+bWnbR/vcfZdC4h1oqbgS+QgvgJTbb56mC8PBxgBDa9dHLgV0dOrSXE2WWXcOjlpHBaIxuP+at0yNYT0wlExyjw6h1LjggI2FBmeladOoAMmugQH1ssDfbi7YEOugcYpaXKfNf6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740595799; c=relaxed/simple;
	bh=xMQDGGY3BkM3SWdC0WenXnT2urcwBfyYp+E8zSksba4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=svaN0dAjkoCckjeaY/KHdlK/YnGmOlCN3wJHGCuuiD1OLmHqGq7pJffHe3zXB5lPAUIR+ZCeMVRT+FbcZIz6cjEtSsVLlZuYPQv+wDICZdXqF/6wBjjmhdcxhToaSaKXCZdLWooTANVFLCtYdNlDT4BuQCUrgTYIG4ipGkVwznY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bWbccPZX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F954C4CED6;
	Wed, 26 Feb 2025 18:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740595799;
	bh=xMQDGGY3BkM3SWdC0WenXnT2urcwBfyYp+E8zSksba4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bWbccPZXex03mDwuKY8KI0MfmNJ+cnLFvcwftin0GkW9HJqL87LJe729lsiRuXr0W
	 3W2859rSDoBFiiTnknqSsKCNA3PI49j4QnQWwE/H7oUpSir3gs55VCTuBnBudQx+ad
	 XreX/gW1pajNkeEYW7hdtSnDBuBcnNGnLNHGrAL8uMVYaM2m8dESazQa8ixUVvrnLC
	 y9CqqFvdCfA4h5J7ynncTR5BS8SyqYSFZSwCivZklkazmIzrcu5oKD1Q/ctnSxnEmB
	 tgbvl9dLOWetLgbLVzxLz6SqjJ8aoM0qZrnrsYXFcFqENVy2MK3NvPJzNVrxVo+4dA
	 3nZbuD6zWFVyw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C78380CFE5;
	Wed, 26 Feb 2025 18:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v5 0/2] selftests/bpf: implement setting global
 variables in veristat
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174059583101.808966.411903542330887067.git-patchwork-notify@kernel.org>
Date: Wed, 26 Feb 2025 18:50:31 +0000
References: <20250225163101.121043-1-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250225163101.121043-1-mykyta.yatsenko5@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 eddyz87@gmail.com, yatsenko@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 25 Feb 2025 16:30:59 +0000 you wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
> 
> To better verify some complex BPF programs by veristat, it would be useful
> to preset global variables. This patch set implements this functionality
> and introduces tests for veristat.
> 
> v4->v5
>   * Rework parsing to use sscanf for integers
>   * Addressing nits
> 
> [...]

Here is the summary with links:
  - [bpf-next,v5,1/2] selftests/bpf: implement setting global variables in veristat
    https://git.kernel.org/bpf/bpf-next/c/e3c9abd0d14b
  - [bpf-next,v5,2/2] selftests/bpf: introduce veristat test
    https://git.kernel.org/bpf/bpf-next/c/3d1033caf056

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



