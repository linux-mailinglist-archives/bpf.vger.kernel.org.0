Return-Path: <bpf+bounces-4978-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A06FB752E04
	for <lists+bpf@lfdr.de>; Fri, 14 Jul 2023 01:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31B34281FD1
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 23:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011006AA6;
	Thu, 13 Jul 2023 23:40:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE516AA1
	for <bpf@vger.kernel.org>; Thu, 13 Jul 2023 23:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1A72BC433C9;
	Thu, 13 Jul 2023 23:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689291621;
	bh=MKr8QqOL91Ydlhh74xJTAcx0xOfdkEvgd6QOq4OjIuU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=U5WXIZKoffVQW4eyWlhM/ZaPj0yrDmr8IEwx3E+rwQZoi+MavLj2VjMvHwVGPKMS/
	 6QwIV7fFbXXYlM8Ym1HZmRiB3tTSoaEMF3AUrWaP/cn7yv7xWyiO3FH4p88Q+dr3a6
	 MEAt8pw0vMyZn1SRbbQD5H/554cC/sBuPBuo2tVTdmytsGCp3NyRQhZ7jJTf5Tar8h
	 Wkk9xUv0902GvvphKy4yKM4oOOHABdJBP3OELcuewpGGGTW3U0Eh/Aw7942fRt1jPB
	 M1zbGtMNXwQYRpfK5/KIk/UHvYsgDHAOA2PRqym0bAb6jVyGm+mmXzO00hFq7XhyjG
	 79qY+cMnE07Vw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 01602E4508F;
	Thu, 13 Jul 2023 23:40:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next 0/4] bpf: Fix errors in verifying a union 
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168929162100.8931.2518322854720342160.git-patchwork-notify@kernel.org>
Date: Thu, 13 Jul 2023 23:40:21 +0000
References: <20230713025642.27477-1-laoar.shao@gmail.com>
In-Reply-To: <20230713025642.27477-1-laoar.shao@gmail.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 bpf@vger.kernel.org, root@vultr.guest

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 13 Jul 2023 02:56:38 +0000 you wrote:
> From: root <root@vultr.guest>
> 
> Patch #1: Fix an issue found in code review
> Patch #2: Selftest for #1
> Patch #3: Fix an issue found in our dev server
> Patch #4: Selftest for #3
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next,1/4] bpf: Fix an error around PTR_UNTRUSTED
    https://git.kernel.org/bpf/bpf-next/c/7ce4dc3e4a9d
  - [v2,bpf-next,2/4] selftests/bpf: Add selftests for nested_trust
    https://git.kernel.org/bpf/bpf-next/c/d2284d68259c
  - [v2,bpf-next,3/4] bpf: Fix an error in verifying a field in a union
    https://git.kernel.org/bpf/bpf-next/c/33937607efa0
  - [v2,bpf-next,4/4] selftests/bpf: Add selftest for PTR_UNTRUSTED
    https://git.kernel.org/bpf/bpf-next/c/1cd0e7715cad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



