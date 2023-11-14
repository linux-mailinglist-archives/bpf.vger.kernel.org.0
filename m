Return-Path: <bpf+bounces-15067-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1D87EB561
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 18:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B3091C20ADD
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 17:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3824123E;
	Tue, 14 Nov 2023 17:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQ1eRnaL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940232AF06
	for <bpf@vger.kernel.org>; Tue, 14 Nov 2023 17:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 047FDC433C8;
	Tue, 14 Nov 2023 17:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699981825;
	bh=kWRiG0HTV3DhFnhv9nQNcZEBR68Tzd0347L0HrvQoWg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nQ1eRnaL8UVJjMnt2GFqzK8t7tvLAMaib61thrJjRzp5MvVwuSXejyxJw51bpmEzA
	 80D790Y8t48fQDv3hmiAodrX3KKtuEj92G5bswlPIajjHRjLnV28C2MUDfAGBrCOXs
	 sZPszPL1QrD4TlYK2LwwL0Z/mNHc9uX+BEgrbAflNs8b4VUuK5dN3NSppNOq+HYgqg
	 YfLK/Ucr+L7V5jhlq2lmsWbbO7LFxXFH0vRwzq8TGaysCI0uWIG0ZuJtYA2kodpv1J
	 VmndwbRff1bGTo9CI5ikj+t3HRfgA7Rglw+4Q+mUw7eU+CCWCwlsbjPUSnVoJhM484
	 LrLt3gKsLMgmQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E01B3E1F67A;
	Tue, 14 Nov 2023 17:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 bpf-next 0/6] bpf: Add support for cgroup1, BPF part 
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169998182491.12736.12381980833332353925.git-patchwork-notify@kernel.org>
Date: Tue, 14 Nov 2023 17:10:24 +0000
References: <20231111090034.4248-1-laoar.shao@gmail.com>
In-Reply-To: <20231111090034.4248-1-laoar.shao@gmail.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, tj@kernel.org, bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 11 Nov 2023 09:00:28 +0000 you wrote:
> This is the BPF part of the series "bpf, cgroup: Add BPF support for
> cgroup1 hierarchy" with adjustment in the last two patches compared
> to the previous one.
> 
> v3->v4:
>   - use subsys_name instead of cgrp_name in get_cgroup_hierarchy_id()
>     (Tejun)
>   - use local bpf_link instead of modifying the skeleton in the
>     selftests
> v3: https://lwn.net/Articles/949264/
> 
> [...]

Here is the summary with links:
  - [v4,bpf-next,1/6] bpf: Add a new kfunc for cgroup1 hierarchy
    https://git.kernel.org/bpf/bpf-next/c/fe977716b40c
  - [v4,bpf-next,2/6] selftests/bpf: Fix issues in setup_classid_environment()
    https://git.kernel.org/bpf/bpf-next/c/484977558784
  - [v4,bpf-next,3/6] selftests/bpf: Add parallel support for classid
    https://git.kernel.org/bpf/bpf-next/c/f744d35ecf46
  - [v4,bpf-next,4/6] selftests/bpf: Add a new cgroup helper get_classid_cgroup_id()
    https://git.kernel.org/bpf/bpf-next/c/c1dcc050aa64
  - [v4,bpf-next,5/6] selftests/bpf: Add a new cgroup helper get_cgroup_hierarchy_id()
    https://git.kernel.org/bpf/bpf-next/c/bf47300b186f
  - [v4,bpf-next,6/6] selftests/bpf: Add selftests for cgroup1 hierarchy
    https://git.kernel.org/bpf/bpf-next/c/360769233cc9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



