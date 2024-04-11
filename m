Return-Path: <bpf+bounces-26484-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F5F8A066C
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 05:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 242B3B216E9
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 03:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC88413B787;
	Thu, 11 Apr 2024 03:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYvgyEva"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C5D13B5A5
	for <bpf@vger.kernel.org>; Thu, 11 Apr 2024 03:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712804430; cv=none; b=qX0s1IkROXUIRJwYb2ib2TDIgvd6HC8xaEuDbGSrKp2rngCJ5qMXl4QCZ2uvNs8IXABiQRQ4FO/HlPR0dw3GTZM3Nzfy0HhGG28CjoaFWJJ6DQTDWYVYsiv2GFr40wSUx+h8m4+Gqu3uucaZ3LQ8yNz8yARHkx0qKQ5F0g04y5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712804430; c=relaxed/simple;
	bh=igz2jKuxsnns93WRyOl2TBrKX5wFNilopsDsXw7lX5o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Hm1LXyqQY3ZAwVo6fMbx7Zdf46IjliWlJIyzF0xKv5wTpk4fcuHdAp/fxW0+B0DJGgtxNZ6igteiWXO3tIuRC1hpwtBS2jm6LteVGq7t/hBuPgJCr7QIGygU17VyuEtCJj1CPu89GjverN9NhIQcD0CViRmHA4tw4maV7wx6ut0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYvgyEva; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 19B2DC433F1;
	Thu, 11 Apr 2024 03:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712804430;
	bh=igz2jKuxsnns93WRyOl2TBrKX5wFNilopsDsXw7lX5o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PYvgyEvaYKFTWy1Bg376ir4WTRgnvA4Ie1VZHHjsNQKPihYAMy37j83fyu8ralFwy
	 j4CMY0NcdUS9ejRRk6BVRM4JSZfaj7RmDmRydb5bwPK9PcvbbwwoSBFmaKyG71sawQ
	 +0V2nmN8zsrZZmkOS2vVEDd6Vwt7eIpCJA0WyJlau9lEwPtRc2RBKqnsqU664bLXqj
	 dSXcou4fIOfU/K/yfQ5awY0f35ROxF0KWOgvrOFcsTI9ZIZtmpEXfuXTV/NECYJqLP
	 Kr6VGWH9vElw120NLNKeo/3Vhx9yCLRfiJBp+MSjO4QnoUsbnb+f67Vj3CEtxBlb1i
	 SpQf7W+KF8QDg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 04A16C395F6;
	Thu, 11 Apr 2024 03:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Enable tests for atomics with cpuv4
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171280443001.1698.2924667989538588163.git-patchwork-notify@kernel.org>
Date: Thu, 11 Apr 2024 03:00:30 +0000
References: <20240410153326.1851055-1-yonghong.song@linux.dev>
In-Reply-To: <20240410153326.1851055-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 10 Apr 2024 08:33:26 -0700 you wrote:
> When looking at Alexei's patch ([1]) which added tests for atomics,
> I noticed that the tests will be skipped with cpuv4. For example,
> with latest llvm19, I see:
>   [root@arch-fb-vm1 bpf]# ./test_progs -t arena_atomics
>   #3/1     arena_atomics/add:OK
>   ...
>   #3/7     arena_atomics/xchg:OK
>   #3       arena_atomics:OK
>   Summary: 1/7 PASSED, 0 SKIPPED, 0 FAILED
>   [root@arch-fb-vm1 bpf]# ./test_progs-cpuv4 -t arena_atomics
>   #3       arena_atomics:SKIP
>   Summary: 1/0 PASSED, 1 SKIPPED, 0 FAILED
>   [root@arch-fb-vm1 bpf]#
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Enable tests for atomics with cpuv4
    https://git.kernel.org/bpf/bpf-next/c/ffa6b26b4d8a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



