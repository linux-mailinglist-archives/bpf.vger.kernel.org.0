Return-Path: <bpf+bounces-32322-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF9390B874
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 19:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B4BA2834DA
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 17:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2E618EFF7;
	Mon, 17 Jun 2024 17:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LDXPTw6Z"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E2618EFEF
	for <bpf@vger.kernel.org>; Mon, 17 Jun 2024 17:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718646630; cv=none; b=UQaVTF0Zi/f8hnW8fG/guhbcg1G776dsgtEeKPm6g/LsRHk0LdUkn6MTPou0cLwYOOjnG1AJM7NyxDe1uuCRpntIbKNwmogSS8NGJHk3JekA2bRAqqVuX8ByABoT343TBiaX6LlrV/bdMNGzzkO7bLJbWt0WgZGTiJDYjmdwaDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718646630; c=relaxed/simple;
	bh=XZg9pwZY3eW4ah89FyTk0aHH/hwYiyfdyH+NdviW3MI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hL3y6rRLj5BiRPqg/eZR+BNzyJp6y2zBHZMMOnoctGBe2tqfASvZl8d954IZkO2J6ZEULRJkI9MzaT4GpPwW7XZ93oIDK7gfrOcp6+KXpIoW22GAF/KynmLWfp+rlDCTyey9wYlKD4qQ76ujTKNgH8J85hIdPGiuJHrAhY8Av74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LDXPTw6Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D12ADC4AF1C;
	Mon, 17 Jun 2024 17:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718646629;
	bh=XZg9pwZY3eW4ah89FyTk0aHH/hwYiyfdyH+NdviW3MI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LDXPTw6ZoMLykOXsrFZ0tL5WavwiFbefbAnFe12HkJtkTS+b3Vj8VvmGmuh6BHZxa
	 fEf8kBBQbVd/LHqMBF+ARfZDGLwRXPXU85cgH5eW3XcicmPYw1tUvG3B45wvL/OX/m
	 BeaBa0cBRNESSnR1TygjWn1iJvsPfZotsNtx0IZtdiRjmF3tNxPfG6O2tanoA/mn0O
	 q4w98nzKKo+5CFQieAw9tr5ZyzhsKzbABtjFb3vcs+rQ4RwSXhln2DcU8xAiQtvJ4z
	 Qt6dnESL8Pf/jBY9vcS37hNt23z1KVS59ompXL47el6oGTbGzun3OuT8n5yzeq/sIF
	 Ozuc71pkf4TzA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BA7FEC4936D;
	Mon, 17 Jun 2024 17:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf 0/3] bpf: Fix missed var_off related to movsx in verifier
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171864662975.16109.1401227268177136624.git-patchwork-notify@kernel.org>
Date: Mon, 17 Jun 2024 17:50:29 +0000
References: <20240615174621.3994321-1-yonghong.song@linux.dev>
In-Reply-To: <20240615174621.3994321-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 15 Jun 2024 10:46:21 -0700 you wrote:
> Zac reported a verification issue ([1]) where verification unexpectedly succeeded.
> This is due to missing proper var_off setting in verifier related to
> movsx insn. I found another similar issue as well. This patch set fixed
> both problems and added three inline asm tests to test these fixes.
> 
>   [1] https://lore.kernel.org/bpf/CAADnVQLPU0Shz7dWV4bn2BgtGdxN3uFHPeobGBA72tpg5Xoykw@mail.gmail.com/
> 
> [...]

Here is the summary with links:
  - [bpf,1/3] bpf: Add missed var_off setting in set_sext32_default_val()
    https://git.kernel.org/bpf/bpf/c/380d5f89a481
  - [bpf,2/3] bpf: Add missed var_off setting in coerce_subreg_to_size_sx()
    https://git.kernel.org/bpf/bpf/c/44b7f7151dfc
  - [bpf,3/3] selftests/bpf: Add a few tests to cover
    https://git.kernel.org/bpf/bpf/c/a62293c33b05

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



