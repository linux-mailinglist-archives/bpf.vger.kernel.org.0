Return-Path: <bpf+bounces-74574-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB3EC5F5EC
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 22:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D16044E16E3
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 21:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E8D35971D;
	Fri, 14 Nov 2025 21:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZFhu7JJE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB7F35971E
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 21:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763155841; cv=none; b=eTTG8gRGjA4jG3JFQqt/xsf4k/nuAC2ObYVNM842YNqqumwkxOa2vAI16d2Dnz0xBMgFfyfQks0lmt2fNOi2K2JFjGk71o5eAreihMel2PHF7NByO8rvqv2T3OCVv7d/WadQfG4HMSw+tbrBl9nxbZ1QXZHPg2V+jgjClc5O5vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763155841; c=relaxed/simple;
	bh=4DovQABtTkEUNwjRpfOTD02k45LOc6jQwXCpVedikjA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NGt5Jn6Pz8uFs6VZPzp9JMjjnVk1rUKcdRep9AwNgtGjTg0Y2BM554DrPbVdVj0XZCpUZkEDXjgRYWr3cCj0rZh5SKgwllrCKd/EJgCDii1oPCZpcXaXCU8Jy1INcZ+nG697jJlCV2agNoTum4ho31FraLwvAVyhF6XWTrqtROM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZFhu7JJE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CFEBC4CEF5;
	Fri, 14 Nov 2025 21:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763155841;
	bh=4DovQABtTkEUNwjRpfOTD02k45LOc6jQwXCpVedikjA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZFhu7JJE35ehTQ6xw7g5w5UTTFn/K5Leru9Y2yXY5wE923YHUUU6maOTKJBpvIjHJ
	 yNHf11DZ0WQZGyYb5u6V6Z1t12zrml308qN6HNkEj2cA8c5Vc6PbeSDuTzdW5YG5x9
	 r8+E3II9jKd70G20S8ElIK/xTNUW6IkObFYXHMr3ZjRujXC+WuePIyvM4975fV1stZ
	 q+C4dvmanjsMJp8YuNfMLejhgdSdmrboSYR9ZT8l484MGnrFaZY3aU0aPhU4YO3Mp+
	 ee1jYfNHkZHNgeoi/wRdrZljBh58dAjJRPXb39AvG81orUu+c3nGiBt5KbCBf39rQu
	 n4na7PSldB/nQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DC03A78A5E;
	Fri, 14 Nov 2025 21:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v1] bpf: a few missing checks to avoid verbose
 verifier log
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176315581000.1841661.3597462964016117495.git-patchwork-notify@kernel.org>
Date: Fri, 14 Nov 2025 21:30:10 +0000
References: <20251114200542.912386-1-eddyz87@gmail.com>
In-Reply-To: <20251114200542.912386-1-eddyz87@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, emil@etsalapatis.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 14 Nov 2025 12:05:42 -0800 you wrote:
> There are a few places where log level is not checked before calling
> "verbose()". This forces programs working only at
> BPF_LOG_LEVEL_STATS (e.g. veristat) to allocate unnecessarily large
> log buffers.
> 
> Reported-by: Emil Tsalapatis <emil@etsalapatis.com>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next,v1] bpf: a few missing checks to avoid verbose verifier log
    https://git.kernel.org/bpf/bpf-next/c/e5d2e34e726b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



