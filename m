Return-Path: <bpf+bounces-15407-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A067F1E77
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 22:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63FD5B218D5
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 21:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0753328DF;
	Mon, 20 Nov 2023 21:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ozg/VLcp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFF9249FC
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 21:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CD2D0C433C9;
	Mon, 20 Nov 2023 21:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700514023;
	bh=Hkhny/Sd4YvbzObA3ElFvnAtIRSaIFn8iME91Jab5hQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ozg/VLcptWszfcIVcLLpuQmiTymzcrAxku6JPj0RtYUblxyxTwyfkHRlC9Awfv8u1
	 6nIja9hj8V6wb7HYKoDRAIwm1wp8ci4sqhT40rPZl4X7cNQn4y7v7CsgU2N+PMAbMG
	 SazriQRl6ZVALnwRwdoaW5lomPwlyp65STZ3duJsJsXVyuzrlmPqOdzx4uKWCwz4a6
	 pFNHuhju6zOp/JixPe4SExfInaP18CNAL07bh3WRNSpp8HxlwHvg3g2s6simSq8aGz
	 CUENBCBlk1eySTxjn7l0iXIjH4m4CDbWw5y6h3C1KXiR+CygdpxJxWTgADGr2QARxU
	 X+04IbRu3AFWQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B1AA1EAA95B;
	Mon, 20 Nov 2023 21:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: reduce verboseness of reg_bounds
 selftest logs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170051402372.13726.6490873027895269871.git-patchwork-notify@kernel.org>
Date: Mon, 20 Nov 2023 21:00:23 +0000
References: <20231120180452.145849-1-andrii@kernel.org>
In-Reply-To: <20231120180452.145849-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 20 Nov 2023 10:04:52 -0800 you wrote:
> Reduce verboseness of test_progs' output in reg_bounds set of tests with
> two changes.
> 
> First, instead of each different operator (<, <=, >, ...) being it's own
> subtest, combine all different ops for the same (x, y, init_t, cond_t)
> values into single subtest. Instead of getting 6 subtests, we get one
> generic one, e.g.:
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: reduce verboseness of reg_bounds selftest logs
    https://git.kernel.org/bpf/bpf-next/c/57b97ecb40ca

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



