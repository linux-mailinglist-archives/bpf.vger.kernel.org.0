Return-Path: <bpf+bounces-1298-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CCF712444
	for <lists+bpf@lfdr.de>; Fri, 26 May 2023 12:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37C121C20EED
	for <lists+bpf@lfdr.de>; Fri, 26 May 2023 10:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25F0156CA;
	Fri, 26 May 2023 10:10:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A518215496
	for <bpf@vger.kernel.org>; Fri, 26 May 2023 10:10:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3E915C4339B;
	Fri, 26 May 2023 10:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685095820;
	bh=JwAL5rqshjZ+/bJEnYcCp6ZLIfcUJcJVkqDi9RVk2ec=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=U8l1XRcXEt2ngRTpsQuYsaThGRblw0Ic7Ui6cyhWqPPwk8ev8F+7u1RY5yoEWA9Mx
	 ZXiurM2BNskhSRbuqSiA3pOuWyH54FpKXjQHJstn9ycvmj0E9bmYYcMldyuQmfOj7H
	 amuyLGsbaK1N6sfLWp2R2Mjqx8b1zmu+PfPiUZySBdKAFgvbIprcCHf8Gh2bYvlGOZ
	 iMUbOyzs1NUPSvOaxJkKLvBDKf6xHaFATAkAf1i9XEIOrt3UGJM6vOIn2/v88CiuYe
	 iz29VcNzW6GdSedAdzrB8ybqc6dmZZ3UqBBDLZXH0KLldMLZL4tDchwU1JXgs2ztXY
	 FuO1hYgR+Ym+Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 23B4AE22B06;
	Fri, 26 May 2023 10:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 1/2] libbpf: ensure libbpf always opens files with
 O_CLOEXEC
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168509582014.13367.5683684106261979910.git-patchwork-notify@kernel.org>
Date: Fri, 26 May 2023 10:10:20 +0000
References: <20230525221311.2136408-1-andrii@kernel.org>
In-Reply-To: <20230525221311.2136408-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, lennart@poettering.net

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu, 25 May 2023 15:13:10 -0700 you wrote:
> Make sure that libbpf code always gets FD with O_CLOEXEC flag set,
> regardless if file is open through open() or fopen(). For the latter
> this means to add "e" to mode string, which is supported since pretty
> ancient glibc v2.7.
> 
> I also dropped outdated TODO comment in usdt.c, which was already completed.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] libbpf: ensure libbpf always opens files with O_CLOEXEC
    https://git.kernel.org/bpf/bpf-next/c/59842c5451fe
  - [bpf-next,2/2] libbpf: ensure FD >= 3 during bpf_map__reuse_fd()
    https://git.kernel.org/bpf/bpf-next/c/4aadd2920b81

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



