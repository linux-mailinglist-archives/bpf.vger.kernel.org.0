Return-Path: <bpf+bounces-32149-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BB9907F98
	for <lists+bpf@lfdr.de>; Fri, 14 Jun 2024 01:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F02E1C21396
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 23:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3A014D43B;
	Thu, 13 Jun 2024 23:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hbps8wXE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71AA13BACC
	for <bpf@vger.kernel.org>; Thu, 13 Jun 2024 23:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718322032; cv=none; b=Ba4Z8Qd0/2c3Z3p7yTviCVjJPV/cZydjMw21oswULx+ugfVvs/BaZ4CCEZqMVm3stshFyJJhb12JhbfOOCSL6HHMF2bbzdzovVPKmOq92WzRJX4x5ZMUh6knwvgxCug346gBaRAzaPH3a1mI7235ZJrG7zfN+V0zjqwPXsrbNFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718322032; c=relaxed/simple;
	bh=RfyxnGmXKidNeOfzqDPLzqUBlvNBFvxqMVGU0dBSmUw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=b3Qxe3uQEJ70NlVCsHWy9uzJIq/hJBCGg+J+h4zw4oJt9a37VJhzXLh99uo9J379UBldSEX4poNkL5Ma2SyYHBOF28GE0esEdGn/A2XapQYQL4x8MJoijqOC0eyZG7+Cjf6LNCpwYF4R3AQo6OvoaGcBCFGnCMCEdg32JHQdYqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hbps8wXE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6C37DC4AF1A;
	Thu, 13 Jun 2024 23:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718322031;
	bh=RfyxnGmXKidNeOfzqDPLzqUBlvNBFvxqMVGU0dBSmUw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Hbps8wXEuKE4nqR0xm4JSUsxoWNOa6ufVJsaz+i7o7c5ZGv8Yff0RlNznP5efK58E
	 FMdK47ZG22uLNNav/fJyH7Ds2JJJQQczfNnecBvLcZ3YDrxXdF3Ae/PeUOUcXborrI
	 cJWgW6k2aLunnKpZfMNxQdHO52NTDwaEUOcVQqt24aT50L+CJ221F8eKkMylvi5lMD
	 gnW7H069h89kWWNARdHAON9jrs370WAtyAa/BUrmFjHq1ZTVyl+dPc+K0DzJ8M3tIo
	 IDdbenUskutnnL1w5XUSFnLqinO+hm3FQE0LOZ80mOnj9hZvGxgISM27G9QkR7ZYVS
	 HLbYMnVBv60rA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 56EA7C43619;
	Thu, 13 Jun 2024 23:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESEND bpf-next v3 0/5] bpf: make trusted args nullable
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171832203134.25229.4899596896330603390.git-patchwork-notify@kernel.org>
Date: Thu, 13 Jun 2024 23:40:31 +0000
References: <20240613211817.1551967-1-vadfed@meta.com>
In-Reply-To: <20240613211817.1551967-1-vadfed@meta.com>
To: Vadim Fedorenko <vadfed@meta.com>
Cc: vadim.fedorenko@linux.dev, martin.lau@linux.dev, andrii@kernel.org,
 eddyz87@gmail.com, bpf@vger.kernel.org, ast@kernel.org, mykolal@fb.com,
 daniel@iogearbox.net

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 13 Jun 2024 14:18:12 -0700 you wrote:
> Current verifier checks for the arg to be nullable after checking for
> certain pointer types. It prevents programs to pass NULL to kfunc args
> even if they are marked as nullable. This patchset adjusts verifier and
> changes bpf crypto kfuncs to allow null for IV parameter which is
> optional for some ciphers. Benchmark shows ~4% improvements when there
> is no need to initialise 0-sized dynptr.
> 
> [...]

Here is the summary with links:
  - [RESEND,bpf-next,v3,1/5] bpf: verifier: make kfuncs args nullalble
    https://git.kernel.org/bpf/bpf-next/c/a90797993afc
  - [RESEND,bpf-next,v3,2/5] bpf: crypto: make state and IV dynptr nullable
    https://git.kernel.org/bpf/bpf-next/c/65d6d61d2596
  - [RESEND,bpf-next,v3,3/5] selftests: bpf: crypto: use NULL instead of 0-sized dynptr
    https://git.kernel.org/bpf/bpf-next/c/9363dc8ddc4e
  - [RESEND,bpf-next,v3,4/5] selftests: bpf: crypto: adjust bench to use nullable IV
    https://git.kernel.org/bpf/bpf-next/c/9b560751f75f
  - [RESEND,bpf-next,v3,5/5] selftests: bpf: add testmod kfunc for nullable params
    https://git.kernel.org/bpf/bpf-next/c/2d45ab1eda46

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



