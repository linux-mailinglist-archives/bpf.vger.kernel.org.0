Return-Path: <bpf+bounces-15802-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6767F7077
	for <lists+bpf@lfdr.de>; Fri, 24 Nov 2023 10:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E975B21331
	for <lists+bpf@lfdr.de>; Fri, 24 Nov 2023 09:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C60179A4;
	Fri, 24 Nov 2023 09:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZpmKDVv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C108BFA
	for <bpf@vger.kernel.org>; Fri, 24 Nov 2023 09:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C5583C433CA;
	Fri, 24 Nov 2023 09:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700819425;
	bh=2aslCvoRCbGHirVmnLlmqAn9jCCQvo5n59ZYxBMWRqg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IZpmKDVvHqpjgqeBJd8lrLWFrAm+NENVw3/T2PnnZfxUUUTWCsPK9o74T0ixkT51u
	 qJwYzaP/nYYiG8Bf9ZMYkr4BExSwBwxThoMb+WVVQKtQT0kn0ZZunebqRnnXeAszlF
	 A29HLgqRkrszm9FhmwcqzvsqWferB4QZypReGG8SBg3+9b2tCTrw6eha9xegOwwG4h
	 K3kcyi8ZEQ7Tdkwrv9uUfdpX8eTBqkq5UKXWUoWpVWQa1ahiCqq77L/bJ43HsqDY/f
	 nozOTiSvAaL/4K1Mgh0k+J+ZoQ5KKTMyszkZV3PNQTM+RjaHi8oJ6Yo7ceIiCadZ57
	 eTVgRLXCnzrSA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AB33EC395FD;
	Fri, 24 Nov 2023 09:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next 0/3] Verify global subprogs lazily
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170081942569.7798.3155849492052675870.git-patchwork-notify@kernel.org>
Date: Fri, 24 Nov 2023 09:50:25 +0000
References: <20231124035937.403208-1-andrii@kernel.org>
In-Reply-To: <20231124035937.403208-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu, 23 Nov 2023 19:59:34 -0800 you wrote:
> See patch #2 for justification. In few words, current eager verification of
> global func prevents BPF CO-RE approaches to be applied to global functions.
> 
> Patch #1 is just a nicety to emit global subprog names in verifier logs.
> 
> Patch #3 adds selftests validating new lazy semantics.
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next,1/3] bpf: emit global subprog name in verifier logs
    https://git.kernel.org/bpf/bpf-next/c/491dd8edecbc
  - [v2,bpf-next,2/3] bpf: validate global subprogs lazily
    https://git.kernel.org/bpf/bpf-next/c/2afae08c9dcb
  - [v2,bpf-next,3/3] selftests/bpf: add lazy global subprog validation tests
    https://git.kernel.org/bpf/bpf-next/c/e8a339b5235e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



