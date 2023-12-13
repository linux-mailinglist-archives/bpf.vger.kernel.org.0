Return-Path: <bpf+bounces-17625-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4363280FBA5
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 01:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D22E0B20FB1
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 00:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FBB623AD;
	Wed, 13 Dec 2023 00:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SvFnT+2H"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A5CA21
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 00:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E7629C433C9;
	Wed, 13 Dec 2023 00:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702425624;
	bh=tEFRMsh36y18xLFqg6/3i06WZ/znb4QoQAVxqrw2dGA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SvFnT+2Hjcr7gHK3tejBpT+oHO0SoDFhiPYXw/K0e9XjVzQYor8kLGcFevU2+TJF0
	 TdJWkY4JnAo6p4oXJpg4SsuObGlHzmv28pFaDFkpu4I8fHQfjcfPWhaSKH1rxhmxOz
	 ZjuYSGzfz5a8G8IdFjGxeOGmrMIYf4Egro9GwrY5SS/vppP2O9NJnPw/FmYYFTlfC+
	 ugX4GJvgkMJSv0UeXg30PAIsXrRPHsCRqc2x0JJenJJzDGJCic/EjxbrGeU63s7Qgd
	 jCLLpuAplfzU3EORA57y/Oz9Gvf9Z6J2zvVDTyjJqM0/kzQxEV1sCOHJz3JW82pkLx
	 3Q5AXoilV0cSQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CFF85C4314C;
	Wed, 13 Dec 2023 00:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] selftests/bpf: Relax time_tai test for equal timestamps
 in tai_forward
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170242562384.24748.10242622405343769136.git-patchwork-notify@kernel.org>
Date: Wed, 13 Dec 2023 00:00:23 +0000
References: <20231212182911.3784108-1-zhuyifei@google.com>
In-Reply-To: <20231212182911.3784108-1-zhuyifei@google.com>
To: YiFei Zhu <zhuyifei@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, sdf@google.com,
 martin.lau@linux.dev, andrii@kernel.org, songliubraving@fb.com,
 kurt@linutronix.de

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 12 Dec 2023 18:29:11 +0000 you wrote:
> We're observing test flakiness on an arm64 platform which might not
> have timestamps as precise as x86. The test log looks like:
> 
>   test_time_tai:PASS:tai_open 0 nsec
>   test_time_tai:PASS:test_run 0 nsec
>   test_time_tai:PASS:tai_ts1 0 nsec
>   test_time_tai:PASS:tai_ts2 0 nsec
>   test_time_tai:FAIL:tai_forward unexpected tai_forward: actual 1702348135471494160 <= expected 1702348135471494160
>   test_time_tai:PASS:tai_gettime 0 nsec
>   test_time_tai:PASS:tai_future_ts1 0 nsec
>   test_time_tai:PASS:tai_future_ts2 0 nsec
>   test_time_tai:PASS:tai_range_ts1 0 nsec
>   test_time_tai:PASS:tai_range_ts2 0 nsec
>   #199     time_tai:FAIL
> 
> [...]

Here is the summary with links:
  - [bpf] selftests/bpf: Relax time_tai test for equal timestamps in tai_forward
    https://git.kernel.org/bpf/bpf-next/c/e1ba7f64b192

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



