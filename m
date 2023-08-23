Return-Path: <bpf+bounces-8389-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DDF785DE0
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 18:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 250E31C20C9F
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 16:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68DE81ED5B;
	Wed, 23 Aug 2023 16:50:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B2EC139
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 16:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6E7E1C433CA;
	Wed, 23 Aug 2023 16:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692809425;
	bh=BgVCl6U0v8iqFt+B96p5RqKFtmg7jPO/Eo1tlV5WRFw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IghSwCn++1gbB2Mv7nGotjsF96Br8VRHDECVNKSMExxxVtJTClyqchvxP1uA+l4Ff
	 +vTWOb/8rgtVaX/9DTMBEkE6y76FUUcpDJVmacGQNHQrzZdpghixDnVzGZmzM5w9Sb
	 Svl/YNgZ0l3gIH2P67oSUL70jYVba4BCWb7HcRE1hrF+ubW7uMCaO5jdq/4/b2BNbR
	 vvCFF3Z5PP8Id9Us8BBcSgD+kYBbYWXPbDkRqQ9sTcYVsR0eA5OtwMRQnHDE0xtDun
	 H3hRYYjQkiO46yFs9Y+Kk919oLDj70tc9A1e9ED6BUCg0CEvNlJANsJhSwMMbtLlfT
	 4v8mbn7nprQUA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4C537E4EAF6;
	Wed, 23 Aug 2023 16:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next 0/2] bpf: Fix an issue in verifing allow_ptr_leaks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169280942530.21426.10827263071903016551.git-patchwork-notify@kernel.org>
Date: Wed, 23 Aug 2023 16:50:25 +0000
References: <20230823020703.3790-1-laoar.shao@gmail.com>
In-Reply-To: <20230823020703.3790-1-laoar.shao@gmail.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, eddyz87@gmail.com, bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 23 Aug 2023 02:07:01 +0000 you wrote:
> Patch #1: An issue found in our local 6.1 kernel.
>           This issue also exists in bpf-next.
> Patch #2: Selftess for #1
> 
> v1->v2:
>   - Add acked-by from Eduard
>   - Fix build error reported by Alexei
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next,1/2] bpf: Fix issue in verifying allow_ptr_leaks
    https://git.kernel.org/bpf/bpf-next/c/d75e30dddf73
  - [v2,bpf-next,2/2] selftests/bpf: Add selftest for allow_ptr_leaks
    https://git.kernel.org/bpf/bpf-next/c/0072e3624b46

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



