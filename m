Return-Path: <bpf+bounces-7047-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5573A770AF3
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 23:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBAEF282548
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 21:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FCE1ED5C;
	Fri,  4 Aug 2023 21:30:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6DC1AA9F
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 21:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C6732C433C8;
	Fri,  4 Aug 2023 21:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691184622;
	bh=YNf+6IbkUsfayTR4SGCw6jfTgFYqCzfOwwETgzF8NT0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EOcVcDnZWd+TFxvONtD/Zx33Lvb1E9TmrUKdOFDJ6wjezXvsComuPPfmTQJPEwRZ2
	 DKiTdng5f4P4W/Gov4IR3KIQauXgQJZ9+QjONMlSo0kGJ20H5O0BAUENAsSg+Nevkx
	 MqVqTmnuxZM4DCe4XOvsfRgALaWSAv3u4HQCJGX8Amwhm/uQlgkyP6xN4YRWFrh0LQ
	 g1S3noFddbBypHs5u1SfStU+pN2NdzKasqMB5534Tbpoqphh5OO3kadULDd79DV07j
	 mQ2QxTwkVOtOslZ6USevsEEC6t5oBWO6c5oIajcKOAAEdBkxlxCfZH1gap1krcrnST
	 dlXtvFzMgDgtw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AACD1C595C3;
	Fri,  4 Aug 2023 21:30:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] selftests/bpf: fix the incorrect verification of
 port numbers.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169118462269.31233.11581133338824223985.git-patchwork-notify@kernel.org>
Date: Fri, 04 Aug 2023 21:30:22 +0000
References: <20230804165831.173627-1-thinker.li@gmail.com>
In-Reply-To: <20230804165831.173627-1-thinker.li@gmail.com>
To: Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
 dan.carpenter@linaro.org, yonghong.song@linux.dev, sinquersw@gmail.com,
 kuifeng@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Fri,  4 Aug 2023 09:58:31 -0700 you wrote:
> From: Kui-Feng Lee <thinker.li@gmail.com>
> 
> Check port numbers before calling htons().
> 
> According to Dan Carpenter's report, Smatch identified incorrect port
> number checks. It is expected that the returned port number is an integer,
> with negative numbers indicating errors. However, the value was mistakenly
> verified after being translated by htons().
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] selftests/bpf: fix the incorrect verification of port numbers.
    https://git.kernel.org/bpf/bpf-next/c/9eab71bd887a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



