Return-Path: <bpf+bounces-5346-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D39759C47
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 19:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A49642819D2
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 17:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5ABC1FB59;
	Wed, 19 Jul 2023 17:20:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4C51FB20;
	Wed, 19 Jul 2023 17:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 01CEFC433CA;
	Wed, 19 Jul 2023 17:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689787225;
	bh=URXPVHsvBOUjIT9KmzBdm/AoUMJJhjsghGcnMvLx9rg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=p+ZTJ/k87gOBjTBkElebeXSjP6H/MvIq02w7qUX3n8MtkjyDR35nRTR9rJeWrdpFU
	 5EKCH1QYQLlWuKyfy72n00iV3FTwxyzar8LDbrWA587JhCpVFc0YXvP5PWAfcJhjK/
	 94yze/ieaGRa9AAMnahWA8Wt98IklQ0XwF/Zal27m/0BKz7A/b53FS67ARKHiOgf1B
	 3xI6n4bWE2BtWSXRhazYTAQKtKyzmlkqZOb8PC+ixtn+wm++WR8XWfqixVz7pNAijw
	 uZYOu/4e9anpTYf3r+tqC7DPNrMPTQ27/dr3TyREze1quMsJ0FuE0dV/DygN/wQv0y
	 YtCF+q/3KdJEg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CF41AE22AE2;
	Wed, 19 Jul 2023 17:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v6 0/8] BPF link support for tc BPF programs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168978722484.3388.18420866659582599783.git-patchwork-notify@kernel.org>
Date: Wed, 19 Jul 2023 17:20:24 +0000
References: <20230719140858.13224-1-daniel@iogearbox.net>
In-Reply-To: <20230719140858.13224-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 razor@blackwall.org, sdf@google.com, john.fastabend@gmail.com,
 kuba@kernel.org, dxu@dxuuu.xyz, joe@cilium.io, toke@kernel.org,
 davem@davemloft.net, bpf@vger.kernel.org, netdev@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 19 Jul 2023 16:08:50 +0200 you wrote:
> This series adds BPF link support for tc BPF programs. We initially
> presented the motivation, related work and design at last year's LPC
> conference in the networking & BPF track [0], and a recent update on
> our progress of the rework during this year's LSF/MM/BPF summit [1].
> The main changes are in first two patches and the last two have an
> extensive batch of test cases we developed along with it, please see
> individual patches for details. We tested this series with tc-testing
> selftest suite as well as BPF CI/selftests. Thanks!
> 
> [...]

Here is the summary with links:
  - [bpf-next,v6,1/8] bpf: Add generic attach/detach/query API for multi-progs
    https://git.kernel.org/bpf/bpf-next/c/053c8e1f235d
  - [bpf-next,v6,2/8] bpf: Add fd-based tcx multi-prog infra with link support
    https://git.kernel.org/bpf/bpf-next/c/e420bed02507
  - [bpf-next,v6,3/8] libbpf: Add opts-based attach/detach/query API for tcx
    https://git.kernel.org/bpf/bpf-next/c/fe20ce3a5126
  - [bpf-next,v6,4/8] libbpf: Add link-based API for tcx
    https://git.kernel.org/bpf/bpf-next/c/55cc3768473e
  - [bpf-next,v6,5/8] libbpf: Add helper macro to clear opts structs
    https://git.kernel.org/bpf/bpf-next/c/4e9c2d9af561
  - [bpf-next,v6,6/8] bpftool: Extend net dump with tcx progs
    https://git.kernel.org/bpf/bpf-next/c/57c61da8bff4
  - [bpf-next,v6,7/8] selftests/bpf: Add mprog API tests for BPF tcx opts
    https://git.kernel.org/bpf/bpf-next/c/cd13c91d9290
  - [bpf-next,v6,8/8] selftests/bpf: Add mprog API tests for BPF tcx links
    https://git.kernel.org/bpf/bpf-next/c/c6d479b3346c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



