Return-Path: <bpf+bounces-71288-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB66BEDDC2
	for <lists+bpf@lfdr.de>; Sun, 19 Oct 2025 04:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B6FAA4E20B8
	for <lists+bpf@lfdr.de>; Sun, 19 Oct 2025 02:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A4813774D;
	Sun, 19 Oct 2025 02:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KwR86TUV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCB1354AE8
	for <bpf@vger.kernel.org>; Sun, 19 Oct 2025 02:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760841031; cv=none; b=KzDe75ijz3AL2oP1nvJlA/KyvH9WLdzfRhwl8Yf3tIRxWkY+nNX1Pcffgrq2JnaOjF6v4oX2qkqlpOMnX1DNZFfVbu6bP5m13azajMllIh5BdGv717HHZK32uE394+1AxfNqFTk7Ny22FMHU2MgH/lWrSjnMq2DXPnSGBfs+hF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760841031; c=relaxed/simple;
	bh=0qVFoHQo2yjBLNpYoXs4/kA5nVD1EKKdm52aSMvUiGw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AEh+XDKflV7RzqKgmTDIX2mVzk+eP8/Qf860kMaLn8G3MzIKYsxORuHAL3+G8insLWbpIj31t3iezlSgTZw0U6fyb+qUtM9TDzWMHH8N5i8zjiAXr09Og9hsZXorIb7hNQaiJXnK5cKbvOORxoxcUvnsNmgg10Ewo9N/u6BycsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KwR86TUV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14F57C4CEF8;
	Sun, 19 Oct 2025 02:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760841031;
	bh=0qVFoHQo2yjBLNpYoXs4/kA5nVD1EKKdm52aSMvUiGw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KwR86TUV9EGFVS2J473hRYlIJMOvn96/YOO0mcFHQ4ldU4bV7a65lkSDi4f5Q01EY
	 XCZf2f+Jb5qXbWH+Jhu9JfzoPYryR+p7p+jzGCEJaGh3axR5UFgm/bwmtQO6lAXqIq
	 RmtwD7wa61ma5g/PelQOfa2eBCZNhlDM4aZ8dTWkRjnBu4jjFmvU7Zt7xNUbeT9HbE
	 XH33YqyOKxD/q3dpTC2Nl7aHCKMI217LTFBr/Y0ID3MR2YhfCgsPZsiA7ep78r/kMP
	 Sa8YSG5amA9m8m0STdH8AbOUYd3vpSfmJh8+uUNIXdfWv8KGD0mfLesu3JoE3sfM8T
	 bru1ifl4z+KUw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3644139EFBBF;
	Sun, 19 Oct 2025 02:30:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/2] bpf: MM related minor changes 
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176084101401.3155740.15408477033569481420.git-patchwork-notify@kernel.org>
Date: Sun, 19 Oct 2025 02:30:14 +0000
References: <20251016063929.13830-1-laoar.shao@gmail.com>
In-Reply-To: <20251016063929.13830-1-laoar.shao@gmail.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-mm@kvack.org, root@localhost.localdomain

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 16 Oct 2025 14:39:27 +0800 you wrote:
> From: root <root@localhost.localdomain>
> 
> These two minor patches were developed during the implementation of
> BPF-THP:
> 
>   https://lwn.net/Articles/1042138/
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpf: mark mm->owner as __safe_rcu_or_null
    https://git.kernel.org/bpf/bpf-next/c/ec8e3e27a140
  - [bpf-next,2/2] bpf: mark vma->{vm_mm,vm_file} as __safe_trusted_or_null
    https://git.kernel.org/bpf/bpf-next/c/7484e7cd8ab1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



