Return-Path: <bpf+bounces-10015-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E27AD7A0475
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 14:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77518B20983
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 12:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6149E2420F;
	Thu, 14 Sep 2023 12:50:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA60241EE
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 12:50:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E8BA4C433CB;
	Thu, 14 Sep 2023 12:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694695827;
	bh=TMjV6+bwe3vJb7gXPII+PE+nTcdt7ZxTl2b7WdEsK1k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pyHJ9QrlbwpiTunl1V3mw4XYCOct1HMqY7QD/YwJTIZ0srvS/6E4QcmQfUOMOKHcT
	 6Xxz9ZkxFNahPpOOmCOIPs5Wl57rSH6rFkWtNb2gakCc1Tg6pmgmCbv6OGnzV13p13
	 DPytoH9Vuc8jQQWTGJn+amdgvNZLArdupbhceALtH1rxEw5jeeqrH4/rjJvEhTViL5
	 r8axKoYdg8843ZzQB5tRXPHKEY/r8OLGt89xQWu35b21Cs6Mn7tBpFprC6MgGfuNkk
	 ih22v51TpOXgRKPAnC93QuT2zIwRoQHQZq+MpufU141eX5iGIVrn3Yyajjte0bTw5Y
	 i+jSvrPqghBLQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CAB5AE1C280;
	Thu, 14 Sep 2023 12:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/3] Revert "selftests/bpf: Add selftest for allow_ptr_leaks"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169469582682.11653.11057987072443096277.git-patchwork-notify@kernel.org>
Date: Thu, 14 Sep 2023 12:50:26 +0000
References: <20230913122514.89078-1-gerhorst@amazon.de>
In-Reply-To: <20230913122514.89078-1-gerhorst@amazon.de>
To: Luis Gerhorst <gerhorst@amazon.de>
Cc: alexei.starovoitov@gmail.com, andrii@kernel.org, ast@kernel.org,
 bpf@vger.kernel.org, daniel@iogearbox.net, haoluo@google.com,
 john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
 laoar.shao@gmail.com, martin.lau@linux.dev, sdf@google.com, song@kernel.org,
 yonghong.song@linux.dev, mykolal@fb.com, shuah@kernel.org, iii@linux.ibm.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 gerhorst@cs.fau.de

Hello:

This series was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed, 13 Sep 2023 12:25:15 +0000 you wrote:
> This reverts commit 0072e3624b463636c842ad8e261f1dc91deb8c78.
> 
> The test tests behavior which can not be permitted because of Spectre
> v1. See the following commit
> 
>   Revert "bpf: Fix issue in verifying allow_ptr_leaks"
> 
> [...]

Here is the summary with links:
  - [1/3] Revert "selftests/bpf: Add selftest for allow_ptr_leaks"
    https://git.kernel.org/bpf/bpf/c/cc7a599ca30f
  - [2/3] Revert "bpf: Fix issue in verifying allow_ptr_leaks"
    https://git.kernel.org/bpf/bpf/c/45f2aaba1079
  - [3/3] selftests/bpf: Add selftest for packet-pointer Spectre v1 gadget
    https://git.kernel.org/bpf/bpf/c/fc7274e42d14

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



