Return-Path: <bpf+bounces-4875-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 640437512C3
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 23:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94DC31C21038
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 21:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8996AF9E4;
	Wed, 12 Jul 2023 21:50:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EF2F50D;
	Wed, 12 Jul 2023 21:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 02D6BC433C7;
	Wed, 12 Jul 2023 21:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689198624;
	bh=OuAbfPmSlVi4EZZR7sYV2K+yruQB4yKAZfVpBjW/U3c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kHU204c3rkaKDAcBWdrlSI67BN98MeVpHtaMTjYv4bybpXL6RmMA5cgQJz4E2pF2I
	 QBPLZtY8zQDV3f6040cZII8gmyTqAEQQ69EycM51UFD8r4XbdrCCFDZzwiquSYCcO4
	 Fo8cj4XF9wX2Lcb93MoSyeBF/CC1oEMinps9iLysvGslCsnR4YiNaSI/DX5AXStuNn
	 XfSbHMF4WDjypYWrA4yllNJk3Jocg/3bNTrL/Ird1CKuvGz8+/eMpeEWZFRUb9zv94
	 hB/kVgajjkIen7UhJ8nCRJ/EPFxQVWT5J4ckARJBrzaDwosFUCs8fpJySUY119c8JZ
	 ow2+VNgjv9o3Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D7D6AE49BBF;
	Wed, 12 Jul 2023 21:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 bpf-next 00/14] bpf: Introduce bpf_mem_cache_free_rcu().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168919862387.303.8813796941061436903.git-patchwork-notify@kernel.org>
Date: Wed, 12 Jul 2023 21:50:23 +0000
References: <20230706033447.54696-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20230706033447.54696-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: daniel@iogearbox.net, andrii@kernel.org, void@manifault.com,
 houtao@huaweicloud.com, paulmck@kernel.org, tj@kernel.org,
 rcu@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
 kernel-team@fb.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed,  5 Jul 2023 20:34:33 -0700 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> v3->v4:
> - extra patch 14 from Hou to check for object leaks.
> - fixed the race/leak in free_by_rcu_ttrace. Extra hunk in patch 8.
> - added Acks and fixed typos.
> 
> [...]

Here is the summary with links:
  - [v4,bpf-next,01/14] bpf: Rename few bpf_mem_alloc fields.
    https://git.kernel.org/bpf/bpf-next/c/12c8d0f4c870
  - [v4,bpf-next,02/14] bpf: Simplify code of destroy_mem_alloc() with kmemdup().
    https://git.kernel.org/bpf/bpf-next/c/a80672d7e10e
  - [v4,bpf-next,03/14] bpf: Let free_all() return the number of freed elements.
    https://git.kernel.org/bpf/bpf-next/c/9de3e81521b4
  - [v4,bpf-next,04/14] bpf: Refactor alloc_bulk().
    https://git.kernel.org/bpf/bpf-next/c/05ae68656a8e
  - [v4,bpf-next,05/14] bpf: Factor out inc/dec of active flag into helpers.
    https://git.kernel.org/bpf/bpf-next/c/18e027b1c7c6
  - [v4,bpf-next,06/14] bpf: Further refactor alloc_bulk().
    https://git.kernel.org/bpf/bpf-next/c/7468048237b8
  - [v4,bpf-next,07/14] bpf: Change bpf_mem_cache draining process.
    https://git.kernel.org/bpf/bpf-next/c/d114dde245f9
  - [v4,bpf-next,08/14] bpf: Add a hint to allocated objects.
    https://git.kernel.org/bpf/bpf-next/c/822fb26bdb55
  - [v4,bpf-next,09/14] bpf: Allow reuse from waiting_for_gp_ttrace list.
    https://git.kernel.org/bpf/bpf-next/c/04fabf00b4d3
  - [v4,bpf-next,10/14] rcu: Export rcu_request_urgent_qs_task()
    https://git.kernel.org/bpf/bpf-next/c/43a89baecfe2
  - [v4,bpf-next,11/14] selftests/bpf: Improve test coverage of bpf_mem_alloc.
    https://git.kernel.org/bpf/bpf-next/c/f76faa65c971
  - [v4,bpf-next,12/14] bpf: Introduce bpf_mem_free_rcu() similar to kfree_rcu().
    https://git.kernel.org/bpf/bpf-next/c/5af6807bdb10
  - [v4,bpf-next,13/14] bpf: Convert bpf_cpumask to bpf_mem_cache_free_rcu.
    https://git.kernel.org/bpf/bpf-next/c/8e07bb9ebcd9
  - [v4,bpf-next,14/14] bpf: Add object leak check.
    https://git.kernel.org/bpf/bpf-next/c/4ed8b5bcfada

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



