Return-Path: <bpf+bounces-17333-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C176C80B8FD
	for <lists+bpf@lfdr.de>; Sun, 10 Dec 2023 06:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 593F9B20AD4
	for <lists+bpf@lfdr.de>; Sun, 10 Dec 2023 05:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2141FAA;
	Sun, 10 Dec 2023 05:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ocvynBAd"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFA917F3
	for <bpf@vger.kernel.org>; Sun, 10 Dec 2023 05:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 54083C433C9;
	Sun, 10 Dec 2023 05:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702186223;
	bh=1UoYqhVsIOO+xKsV2z9mjZ0OK6SVw+LuzpHTU5ab7mE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ocvynBAdIestMiZv+RQ2esNxDPqf1zXZxNDJBN5MaOJMgYr/6NcntNfmuBnha9PqR
	 zbgxF+3KLQz/Ms/FB+loNgkLP7ohx+rGwigX3vH0DbkP7ZEw6RsNsaXnxNkFFVMAXt
	 bhkQXqt4GOlzn7oaUOyjpifgxcAUZCf8S+bn2isFNuBP4z/UcDilCvNnCsGEl1yO99
	 tKSw9EvBfe4+0qzb+kICm0cYqv67r9hAv/s+f2urJ/qcgebHAWQVa33yGj9KxZlsiS
	 xVXBSTDqBHtBZBA9oxuscly+bryhJojpf2X/TFrhVBr2ZFGJ8K9DQIDgbw3l+oa5pB
	 6zYMOeGPBXhTg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 39B0FDD4F1D;
	Sun, 10 Dec 2023 05:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESEND bpf-next v1] test_bpf: Rename second ALU64_SMOD_X to
 ALU64_SMOD_K
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170218622323.12725.6922514276385110557.git-patchwork-notify@kernel.org>
Date: Sun, 10 Dec 2023 05:30:23 +0000
References: <20231207040851.19730-1-yangtiezhu@loongson.cn>
In-Reply-To: <20231207040851.19730-1-yangtiezhu@loongson.cn>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 puranjay12@gmail.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu,  7 Dec 2023 12:08:51 +0800 you wrote:
> Currently, there are two test cases with same name
> "ALU64_SMOD_X: -7 % 2 = -1", the first one is right,
> the second one should be ALU64_SMOD_K because its
> code is BPF_ALU64 | BPF_MOD | BPF_K.
> 
> Before:
> test_bpf: #170 ALU64_SMOD_X: -7 % 2 = -1 jited:1 4 PASS
> test_bpf: #171 ALU64_SMOD_X: -7 % 2 = -1 jited:1 4 PASS
> 
> [...]

Here is the summary with links:
  - [RESEND,bpf-next,v1] test_bpf: Rename second ALU64_SMOD_X to ALU64_SMOD_K
    https://git.kernel.org/bpf/bpf-next/c/5181dc08f795

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



