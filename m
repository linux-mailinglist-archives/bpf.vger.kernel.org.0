Return-Path: <bpf+bounces-42940-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F08139AD347
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 19:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B0ED1C2127F
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 17:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8AC1CF5C4;
	Wed, 23 Oct 2024 17:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OkNjIN2i"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73191A0AF0
	for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 17:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729705820; cv=none; b=UZG5MB0k8WqX3ps1p/Qw735FcuyFzwRbWKUdZG3hhdLbRHs3e2qsXNepymkJLZMHOdqKHvZoaywCJRPbVOiPs0oWFximKK/bVS69Hyt/vK1izLBbTMN8FlPbqrB1PlPEfkIgDDOtsVC4qSNuADa+mo2Cj12EGhy+O+rUzn+Jm9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729705820; c=relaxed/simple;
	bh=5Mx/hOJMjlEiyx0/JBvuy0y6UeX5IXvZYvMYdktWluo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GICkk5Zj86OlKK70LpqCbUf9o19PSJtA2PrioNk9eQr8jeLYCTUjdeb6Wx88kfxCcK7aW+6ZztVXjeKF/4M0G0rl05Frk4/YQd2/V8b/N1B83fSl2q77bOKybJAGLhU7Sz1RfZ9fmB3qquAbfR+vmU0LUzK9TPYHa1Cs37N1sx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OkNjIN2i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4601DC4CEC6;
	Wed, 23 Oct 2024 17:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729705820;
	bh=5Mx/hOJMjlEiyx0/JBvuy0y6UeX5IXvZYvMYdktWluo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OkNjIN2iadPQSeqdHRNNCvr34X1raCDi5iYnvHqKn7VZNu0944Tb+jbBaZZ3nYEzy
	 T5Y/rFoHAHfojzY1XJq6x/ifW4J/k506lnG9o+9nXi0apvj0/nRmUyG9Vk1UhDZ6a+
	 tElVAR9tV8FLwt3R17k5a12tORUpCh1oeQ4kH7+tmzOzMzXGBInzANd6JTRPlt02ki
	 QsqtEUQfihKdkJS3WHvWy9yz/6XeCCOBZpYKsifFx7wS27YoQ+AdHsQYWmxnxLhQ2t
	 Lz28HkrtHdEXGIT2PVQ/3WpO3HthrtDkXtvPqRWtlgicFaCoebZ4KjuRXxBLb5xrDI
	 mn59PXmE+zyNw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADE83809A8A;
	Wed, 23 Oct 2024 17:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] selftests/bpf: increase verifier log limit in
 veristat
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172970582675.1679208.3228181228742002310.git-patchwork-notify@kernel.org>
Date: Wed, 23 Oct 2024 17:50:26 +0000
References: <20241023155314.126255-1-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20241023155314.126255-1-mykyta.yatsenko5@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, yatsenko@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 23 Oct 2024 16:53:14 +0100 you wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
> 
> The current default buffer size of 16MB allocated by veristat is no
> longer sufficient to hold the verifier logs of some production BPF
> programs. To address this issue, we need to increase the verifier log
> limit.
> Commit 7a9f5c65abcc ("bpf: increase verifier log limit") has already
> increased the supported buffer size by the kernel, but veristat users
> need to explicitly pass a log size argument to use the bigger log.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] selftests/bpf: increase verifier log limit in veristat
    https://git.kernel.org/bpf/bpf-next/c/1f7c33630724

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



