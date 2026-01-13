Return-Path: <bpf+bounces-78745-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1035CD1AD28
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 19:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94128306CD89
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 18:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D401E30F555;
	Tue, 13 Jan 2026 18:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MlJyVjyA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D78834C123
	for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 18:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768328461; cv=none; b=uX012Lu45e5LJoWb8Irl8l2l/qEMelVsGC19ab3oLx5eF04/wQRzNoMjaU7tJ3KGvYn5LfD+wTZP3YHiRahaVxLAkhmUL0TdtnqD4/L4KbnECEvXAS6vYQ+p+zXYkFP5hrorM3a2HGCuxbrcPoM3P/b4BGIR0ySOoL/KcV97D6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768328461; c=relaxed/simple;
	bh=eC/5VFUag6JiTn5692sdLEbHFkuEkkdKuQxxg+vphaw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=L/ebdd0hTCeWp7DUvRlLp015gAudX8woUTVYhY9UBI47q6jxyNVkWywnv8XFaWgeNwpGGZmkin3nk/O6vpGpsCg/o0wmvxJdS+GTd7WyH96J3Jsx2gK6tEMjpQLxWx1/872oFKgmIHMOZ5VCRFH3P9nwCRkEsnec9qqN8Nk5bYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MlJyVjyA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC202C116C6;
	Tue, 13 Jan 2026 18:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768328460;
	bh=eC/5VFUag6JiTn5692sdLEbHFkuEkkdKuQxxg+vphaw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MlJyVjyA6RQ8w8Zs7BrRVZc5PHopJzPnaS5F0ZnbMrcyZsh5cxFq9/nbo9Yx2qAeU
	 cgzumcxar/qI+bYFsiSfxpSHStW9nCbHCdcSnaj6eSzxEtpRBx21TvDAZPylQS6OIr
	 7koqTyICnaUffHQdDUbZTuXaskVlYXcGRhJysBJpUpDZZ9kHD6P3viaNmHsnDCUKAL
	 Cs7IswR6XIN1kbUN5KXamVwwPHHfxtp+kedl7p4omx1tJqzi2yQlJqPUNTB9KHpY1X
	 viJUbBOqiAEd+VmglY8NVe2MyXUNTn/NYlxv8y4OKdMe/PGqm37vZq1lAVEW+lI6fS
	 efNaRYI4wSbtQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 789413808200;
	Tue, 13 Jan 2026 18:17:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/3] Fix a few selftest failure due to 64K page
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176832825427.2345780.2450685924903687097.git-patchwork-notify@kernel.org>
Date: Tue, 13 Jan 2026 18:17:34 +0000
References: <20260113061018.3797051-1-yonghong.song@linux.dev>
In-Reply-To: <20260113061018.3797051-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 12 Jan 2026 22:10:18 -0800 you wrote:
> Fix a few arm64 selftest failures due to 64K page. Please see each
> indvidual patch for why the test failed and how the test gets fixed.
> 
> Yonghong Song (3):
>   selftests/bpf: Fix dmabuf_iter/lots_of_buffers failure with 64K page
>   selftests/bpf: Fix sk_bypass_prot_mem failure with 64K page
>   selftests/bpf: Fix verifier_arena_globals1 failure with 64K page
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/3] selftests/bpf: Fix dmabuf_iter/lots_of_buffers failure with 64K page
    https://git.kernel.org/bpf/bpf-next/c/2465a08d433d
  - [bpf-next,2/3] selftests/bpf: Fix sk_bypass_prot_mem failure with 64K page
    https://git.kernel.org/bpf/bpf-next/c/d2f7cd20a7c7
  - [bpf-next,3/3] selftests/bpf: Fix verifier_arena_globals1 failure with 64K page
    https://git.kernel.org/bpf/bpf-next/c/951d79017e8a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



