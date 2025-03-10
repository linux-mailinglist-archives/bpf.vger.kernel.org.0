Return-Path: <bpf+bounces-53768-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8A4A5A6FB
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 23:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9C1816A18D
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 22:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12031E5B6E;
	Mon, 10 Mar 2025 22:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OvGX0RXP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9BA36B
	for <bpf@vger.kernel.org>; Mon, 10 Mar 2025 22:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741645199; cv=none; b=smpqr4pLsJwzYh1nkA1uCGXtO/esHod/sBtQwF8sMIDbVl2xukWpOmAq6abLx915bo8li7BzWZJkNzlp44fKf3d1sXulG0kadbtNwqlJRl2uAd+/YWLqQC0bd6Bp9qKKvqZGnpZ667KvvFquP0gZjyU4PNygxgf8nYWLdIgy3xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741645199; c=relaxed/simple;
	bh=BcciyUtNk9oqQJfgscav6X5TptmR8rR0Dpa1dqvmC9Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=K6/uc3D6qH0tfzeh2WVzTJyKB+2PsvZ6q1sIXC605HEG9ofYWc+pJfAxFIxbx6Pbu0g+jn9edst2U6oxvwBFdqnlbT0G+Uv5qd5kGBS6eHvL1Omwz69FhB3lw+7WK1ahGsq2FhNI7FL4g/45E/yj37bEuKUs3fQdVgeEz6VUrNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OvGX0RXP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A62E5C4CEE5;
	Mon, 10 Mar 2025 22:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741645198;
	bh=BcciyUtNk9oqQJfgscav6X5TptmR8rR0Dpa1dqvmC9Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OvGX0RXPlbstL18dgeKOEYrsph2tKOsLHZlLaFIlrJmnAXMB41Siywkbz4LztO8Km
	 URBz6UYx6e1w8DV1LiIoAQr4ze7Yh9H+S3RHd8lRhLCd7GNpnQjs6s7dMLcAcDxjQG
	 u93cCsJAicQrbulp9hau/4FTI+YTNpSpNydaJ3NdPt42+Y4h2JReO8CO90PpxJMgV/
	 Q6MhtAPg81wFmVOe4fsjdm7/w+BOBLiEeqJhba38EsJeVVF1rAaFM1hvB5odx4izyO
	 HmLUcKS/aqjfJHRxG8J4yHxUfHLPEQSCqVRcRy74IV9pLFMvmvFOhWrISb9SRsnFch
	 BabYSoD4mmffw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB2CF380AACB;
	Mon, 10 Mar 2025 22:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: fix selection of static vs.  dynamic
 LLVM
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174164523277.3715574.15222910291013459510.git-patchwork-notify@kernel.org>
Date: Mon, 10 Mar 2025 22:20:32 +0000
References: <20250310145112.1261241-1-aspsk@isovalent.com>
In-Reply-To: <20250310145112.1261241-1-aspsk@isovalent.com>
To: Anton Protopopov <aspsk@isovalent.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, dxu@dxuuu.xyz,
 bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 10 Mar 2025 14:51:12 +0000 you wrote:
> The Makefile uses the exit code of the `llvm-config --link-static --libs`
> command to choose between statically-linked and dynamically-linked LLVMs.
> The stdout and stderr of that command are redirected to /dev/null.
> To redirect the output the "&>" construction is used, which might not be
> supported by /bin/sh, which is executed by make for $(shell ...) commands.
> On such systems the test will fail even if static LLVM is actually
> supported. Replace "&>" by ">/dev/null 2>&1" to fix this.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: fix selection of static vs. dynamic LLVM
    https://git.kernel.org/bpf/bpf-next/c/74f36a97e5e5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



