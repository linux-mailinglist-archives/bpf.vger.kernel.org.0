Return-Path: <bpf+bounces-9576-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E3B7992E3
	for <lists+bpf@lfdr.de>; Sat,  9 Sep 2023 01:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C6C7281CE1
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 23:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3857482;
	Fri,  8 Sep 2023 23:40:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C077474
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 23:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7C8C7C433CA;
	Fri,  8 Sep 2023 23:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694216423;
	bh=EYy6dm59NBJFJSkKgAVVKliFV8RPPvIRF78A5HR9JTk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dx3rPf0MzkZsWXLUkXWew2LJ5W//xr3SYY86QyC8Rgn0pdWc/lcZgXiIXqdsmqF+V
	 +57Bz+3Un50MNepPyimHkPA0JvqP7f8jXAEvEqetFgvYvBdSx5JmMV5ydu0RsXG6T8
	 pVk2AbMW/0XCPRhqSPr1SRsqYflSbM/clfQOewEMTs3O0X9XWNVpn9djmG0y83osd1
	 yL3+9xWwoR4SBzCb8Mr7eBjctL96kKBgi3To4SlUvEBr4Pflsk1zTxS5c/nwFkSqus
	 WNtBDOYKj5MLEl46UPF+QHba6kYPteVoM0uaFVoXYtO22WXhM0l3z3rzKFzUCJSP1q
	 kNkKzqdvlElmA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5CAFFF1D6A9;
	Fri,  8 Sep 2023 23:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v12 0/2] selftests/bpf: Optimize kallsyms cache
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169421642337.339.11184428489042288950.git-patchwork-notify@kernel.org>
Date: Fri, 08 Sep 2023 23:40:23 +0000
References: <tencent_FA47B711AB0DEC843EB3362E6355505ED509@qq.com>
In-Reply-To: <tencent_FA47B711AB0DEC843EB3362E6355505ED509@qq.com>
To: Rong Tao <rtoax@foxmail.com>
Cc: olsajiri@gmail.com, andrii@kernel.org, daniel@iogearbox.net,
 rongtao@cestc.cn, ast@kernel.org, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
 shuah@kernel.org, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 laoar.shao@gmail.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu,  7 Sep 2023 09:59:12 +0800 you wrote:
> From: Rong Tao <rongtao@cestc.cn>
> 
> We need to optimize the kallsyms cache, including optimizations for the
> number of symbols limit, and, some test cases add new kernel symbols
> (such as testmods) and we need to refresh kallsyms (reload or refresh).
> 
> Rong Tao (2):
>   selftests/bpf: trace_helpers.c: optimize kallsyms cache
>   selftests/bpf: trace_helpers.c: Add a global ksyms initialization
>     mutex
> 
> [...]

Here is the summary with links:
  - [bpf-next,v12,1/2] selftests/bpf: trace_helpers.c: optimize kallsyms cache
    https://git.kernel.org/bpf/bpf-next/c/c698eaebdf47
  - [bpf-next,v12,2/2] selftests/bpf: trace_helpers.c: Add a global ksyms initialization mutex
    https://git.kernel.org/bpf/bpf-next/c/a28b1ba25934

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



