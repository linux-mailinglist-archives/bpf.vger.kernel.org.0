Return-Path: <bpf+bounces-565-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D946703D99
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 21:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 604001C20C05
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 19:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA4B19503;
	Mon, 15 May 2023 19:20:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792CC18C39
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 19:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 14312C4339B;
	Mon, 15 May 2023 19:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684178420;
	bh=LyOJi/qVgBu0+z0V1xOl962sFcB/Su9DjQmlE4QBRNE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AyyEcuF/IS+wc6DeMZRZrgihgsbzGj6FAxQ2m2WEgXt2VeG83lsZG1YocmTtX30lm
	 I9j78XBptRV9G7xoU8ymS5lery2toYEYr1bgpyNgbkGhlYYz8527EhfpFmKQ8Ic6jK
	 LBQgwzePQy/MBX3RmSGidkXf1fCnC2h2svUJ3kfOAyAkI5slraeIlJHVNrw1659cwU
	 BwA1N9fQtLRvCdgRIXrPKlL8jKPXLw1uKR7oXagNlvwGzx6wRNhOl20EFNGBKypCCT
	 BTw1DtjIr+cp4x50kEecpmJn2uccWIRInciojeeSf3K3xk7H4A9qz7nbndP/Y7owjJ
	 rKdm4V6+RdW/w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DCF01E49FAB;
	Mon, 15 May 2023 19:20:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] arm64,bpf: Support struct arguments in the BPF
 trampoline
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168417841990.1340.9887886289072485201.git-patchwork-notify@kernel.org>
Date: Mon, 15 May 2023 19:20:19 +0000
References: <20230511140507.514888-1-revest@chromium.org>
In-Reply-To: <20230511140507.514888-1-revest@chromium.org>
To: Florent Revest <revest@chromium.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, kpsingh@kernel.org, mark.rutland@arm.com,
 xukuohai@huaweicloud.com, zlim.lnx@gmail.com, yhs@meta.com, yhs@fb.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu, 11 May 2023 16:05:07 +0200 you wrote:
> This extends the BPF trampoline JIT to support attachment to functions
> that take small structures (up to 128bit) as argument. This is trivially
> achieved by saving/restoring a number of "argument registers" rather
> than a number of arguments.
> 
> The AAPCS64 section 6.8.2 describes the parameter passing ABI.
> "Composite types" (like C structs) below 16 bytes (as enforced by the
> BPF verifier) are provided as part of the 8 argument registers as
> explained in the section C.12.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] arm64,bpf: Support struct arguments in the BPF trampoline
    https://git.kernel.org/bpf/bpf-next/c/90564f1e3dd6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



