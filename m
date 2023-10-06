Return-Path: <bpf+bounces-11579-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2ED7BC197
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 23:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2507282243
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 21:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11801450CB;
	Fri,  6 Oct 2023 21:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQTyIrAS"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690AD42C13;
	Fri,  6 Oct 2023 21:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B6ED1C433C8;
	Fri,  6 Oct 2023 21:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696629023;
	bh=vnr8MJ3nuUJWlcG4ceW7CQzIfkNNw5ZuI20tJRihHdw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JQTyIrASFRYxq407PUwx88KTmlsAvpayXUorRGz7K25UhnD5fO1pmNlBPvdRg1hRw
	 87zlUdgSA0/6AXhRO7c/T3NFZ5cbGllQXcSdxyv2B3TpDJwQJtmkMb1RqQxrWnkf3W
	 earHVFX3UEl/n5gIPAmH9pPirufTDLN3PLVyH3J3ue73oFjyHZsngeVfjAuB2oyZYY
	 TkklQ/LFWtRWLDM+u4qe3hVL2zFNB9+NJaQX/TeUR7u95w//HPy+E2PrgonTDrE1XE
	 +XT6ChB25dS4r6ok9fsxy6Utz3m/ElwejQErSZxx9gTczTmC5PhQAZjFJwieLkPhRM
	 hPF20BM6Dmylw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9A5FFE632D2;
	Fri,  6 Oct 2023 21:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf: Annotate struct bpf_stack_map with __counted_by
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169662902362.27188.6560654759744459728.git-patchwork-notify@kernel.org>
Date: Fri, 06 Oct 2023 21:50:23 +0000
References: <20231006201657.work.531-kees@kernel.org>
In-Reply-To: <20231006201657.work.531-kees@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: song@kernel.org, jolsa@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, gustavoars@kernel.org, bpf@vger.kernel.org,
 linux-hardening@vger.kernel.org, nathan@kernel.org, ndesaulniers@google.com,
 trix@redhat.com, linux-kernel@vger.kernel.org, llvm@lists.linux.dev

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Fri,  6 Oct 2023 13:17:00 -0700 you wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct bpf_stack_map.
> 
> [...]

Here is the summary with links:
  - bpf: Annotate struct bpf_stack_map with __counted_by
    https://git.kernel.org/bpf/bpf-next/c/84cb9cbd911a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



