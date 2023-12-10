Return-Path: <bpf+bounces-17335-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C5C80B925
	for <lists+bpf@lfdr.de>; Sun, 10 Dec 2023 06:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0FBA280F03
	for <lists+bpf@lfdr.de>; Sun, 10 Dec 2023 05:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512261FAE;
	Sun, 10 Dec 2023 05:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hEN7bs9U"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BD91842
	for <bpf@vger.kernel.org>; Sun, 10 Dec 2023 05:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1C531C433C9;
	Sun, 10 Dec 2023 05:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702186824;
	bh=82iyjccXJBcgt+8Iw+jKZiF0i9Eza3Vs0vbLrY4Q8kU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hEN7bs9U9JewGJpQnZD2EGeB8QRqBvEe2QpFCXosMswh8wPcmly7V08iV9xIdrIYf
	 5eDU2xbKeYJT+W2ggl9CtEbH2A7TRkZQwwhzHAMpBl1vdncKLbmlNtfvzfOb6RTDTJ
	 uqpGJe4xsZToD7NUreQv6KN19gT/frKvNympqnILYqsl69C2fY5Rj0dXrZ8h1bHmU0
	 9KHWaRizQbq/rpnOJ4zjBiKK85E+oJF69Lnt7FIy2qVNyxUCZbmR0tZc07d3Qc90/f
	 RH5kYq1iyUKIdgnA3woHmlS3R/ZL1fSsk0haVnNLE6+J1aVqG6wumw5NFzpO88lDfd
	 qL0lqPQ5y3uTw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 02C9FC595CE;
	Sun, 10 Dec 2023 05:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/2] Add new bpf_cpumask_weight() kfunc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170218682400.18582.4497349299416423669.git-patchwork-notify@kernel.org>
Date: Sun, 10 Dec 2023 05:40:24 +0000
References: <20231207210843.168466-1-void@manifault.com>
In-Reply-To: <20231207210843.168466-1-void@manifault.com>
To: David Vernet <void@manifault.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu,  7 Dec 2023 15:08:41 -0600 you wrote:
> It can be useful to query how many bits are set in a cpumask. For
> example, if you want to perform special logic for the last remaining
> core that's set in a mask. This logic is already exposed through the
> main kernel's cpumask header as cpumask_weight(), so it would be useful
> to add a new bpf_cpumask_weight() kfunc which wraps it and does the
> same.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpf: Add bpf_cpumask_weight() kfunc
    https://git.kernel.org/bpf/bpf-next/c/a6de18f310a5
  - [bpf-next,2/2] selftests/bpf: Add test for bpf_cpumask_weight() kfunc
    https://git.kernel.org/bpf/bpf-next/c/88f6047191e6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



