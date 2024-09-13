Return-Path: <bpf+bounces-39862-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC609789DC
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 22:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB1941F25F18
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 20:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A57146593;
	Fri, 13 Sep 2024 20:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UYgodzzC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8783247A73
	for <bpf@vger.kernel.org>; Fri, 13 Sep 2024 20:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726258828; cv=none; b=gfVF3a+usL03v+OlX0abG8D16qLdXfYlrCaKRyTMuU7aCUiSf3dyyTqVRy3R5YmV029utPRVT/23kEIwqIEdAGIhgj5T/Ld/Tci5vE4wdCfCYrQLYGaCXaotmntU3L6QHXH7jtxw2gwOTudWAtXTHNBKxKx2O7s8gIAzQXTeUFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726258828; c=relaxed/simple;
	bh=WfaS/GVYlh1UDTn6E5gmliKjyRBLzsixBq9gyQAsqLI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AEbzj42izA2mgpc/+N7KCMG1XPReETfoyaFcHsKUmp0mpUdPemNbajA2NDRuJPdD50gw9gQ+ZSJGpIF2Iq3kEtjS25n0Z+bk8R0K0fxD4Oob44Bxc8zqKAJIcnQkvZwp8QYsX/VaUhubcKpxmIvuQbfmQbidAqNHbvb1UotTJ2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UYgodzzC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE52DC4CEC0;
	Fri, 13 Sep 2024 20:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726258827;
	bh=WfaS/GVYlh1UDTn6E5gmliKjyRBLzsixBq9gyQAsqLI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UYgodzzCUvIlaXzxNxOVNd27shTiledszfHO8QgihMEaMaa1sWC4jXmYqzWtGzP/d
	 dE8c9BV4d+B+UBRdLxtDs6zbFGqrsgs30MVZWPYqcSKT+yw3hnva7TWC1MWHejusei
	 pT02i3y3LgJmXIoENOoQ1Gf1EhK+D1clEDTmx7sO8YamBW/DhZJTjSTg6aMcXU/cq9
	 bGAdGPMGggZwpbVF3jdaRy5V/N0uQouoKJACzulzFqmptfkw065RMeVKHW2l+UoqyI
	 QrxBTo6NSllAIJsBwCF/gRXDsRqZ01StakyA3C0wUOwmjLGMNymmmmKHV+g6Xoyvbv
	 mPxJ9niRUqzDQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DA53806655;
	Fri, 13 Sep 2024 20:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Fix a sdiv overflow issue
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172625882927.2356446.15293915996403720668.git-patchwork-notify@kernel.org>
Date: Fri, 13 Sep 2024 20:20:29 +0000
References: <20240913150326.1187788-1-yonghong.song@linux.dev>
In-Reply-To: <20240913150326.1187788-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org,
 zacecob@protonmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 13 Sep 2024 08:03:26 -0700 you wrote:
> Zac Ecob reported a problem where a bpf program may cause kernel crash due
> to the following error:
>   Oops: divide error: 0000 [#1] PREEMPT SMP KASAN PTI
> 
> The failure is due to the below signed divide:
>   LLONG_MIN/-1 where LLONG_MIN equals to -9,223,372,036,854,775,808.
> LLONG_MIN/-1 is supposed to give a positive number 9,223,372,036,854,775,808,
> but it is impossible since for 64-bit system, the maximum positive
> number is 9,223,372,036,854,775,807. On x86_64, LLONG_MIN/-1 will
> cause a kernel exception. On arm64, the result for LLONG_MIN/-1 is
> LLONG_MIN.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/2] bpf: Fix a sdiv overflow issue
    https://git.kernel.org/bpf/bpf-next/c/7dd34d7b7dcf
  - [bpf-next,v3,2/2] selftests/bpf: Add tests for sdiv/smod overflow cases
    https://git.kernel.org/bpf/bpf-next/c/a18062d54a0b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



