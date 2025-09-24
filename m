Return-Path: <bpf+bounces-69499-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D40F6B9804B
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 03:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60F312E762D
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 01:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9991FDE14;
	Wed, 24 Sep 2025 01:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m9a+CW0m"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3460C8CE;
	Wed, 24 Sep 2025 01:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758678021; cv=none; b=pwJhmai0CtenwaLxp4Sg1QffPA2o4x8IaQTWdkuSEkI7JGQgXLeM2VFhadnTN9zXUqOcBtf8mns7Z6kCwHznM9s1MWAzgUnHv5zJseo4T0gA0PUQe0JLN2Mw/5iVGInrgeHqfavw5SGf0UHLu3zHxtHg0UBIcZq+qH1uD4hEZ2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758678021; c=relaxed/simple;
	bh=WgMp+w6UVts3dMLurp52RK6gj7qj78YC9ftL/iqcXqM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oxrUUGjL1/o6KPPAY7xxE+8sJzVLT3UWED3fsSkrvrjf3ZCFwdzg+Ayp281l6h0SaElXJR6P5AAJRM3veYzV6aAS4VAXaxd09rkYCDs7NX1sqLbcwuu/ulNEHs2DLTi6hEH70maToZ3U5gP18iBJq3htfT3bsUiaVyC08drS0vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m9a+CW0m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 667C2C4CEF5;
	Wed, 24 Sep 2025 01:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758678021;
	bh=WgMp+w6UVts3dMLurp52RK6gj7qj78YC9ftL/iqcXqM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=m9a+CW0mkOkOcrwAPz3odyYel9ssV1GNXJN9XOA5OuCNN1XQLc1sGQCrh91ltjXIr
	 aI9EgrOiPDBc3EOSmwifCaIDZtS0N4MwV4HIAMOxZDHXJXvCF2tuFc5fjwb4cIf92t
	 iXu7njsswJZyvQV5sNh1Gi7Uto+DKgYvzDUqHxetjQkevQCZ1fwUswiiBCRYkTj0jk
	 sdG1hAQt9pJuEq5vfNdV2U3VAXSIENgq23ma6BYhFRqC5eikxjDUPFxRQf4PLnG36X
	 btQIgTczrRWgyMQkxrfvfX1Ni/X1baQti8TJmt/zgz/psbqT0QEVJWfX4HykcZmf2x
	 BA3eNZazW1oLQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D1239D0C20;
	Wed, 24 Sep 2025 01:40:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v7 0/8] Add kfunc bpf_xdp_pull_data
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175867801825.1992487.13432380588820410306.git-patchwork-notify@kernel.org>
Date: Wed, 24 Sep 2025 01:40:18 +0000
References: <20250922233356.3356453-1-ameryhung@gmail.com>
In-Reply-To: <20250922233356.3356453-1-ameryhung@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com,
 andrii@kernel.org, daniel@iogearbox.net, paul.chaignon@gmail.com,
 kuba@kernel.org, stfomichev@gmail.com, martin.lau@kernel.org,
 mohsin.bashr@gmail.com, noren@nvidia.com, dtatulea@nvidia.com,
 saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com,
 maciej.fijalkowski@intel.com, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Mon, 22 Sep 2025 16:33:48 -0700 you wrote:
> v7 -> v6
>   patch 5 (new patch)
>   - Rename variables in bpf_prog_test_run_xdp()
> 
>   patch 6
>   - Fix bugs (Martin)
> 
> [...]

Here is the summary with links:
  - [bpf-next,v7,1/8] bpf: Clear pfmemalloc flag when freeing all fragments
    https://git.kernel.org/bpf/bpf-next/c/8f12d1137c23
  - [bpf-next,v7,2/8] bpf: Allow bpf_xdp_shrink_data to shrink a frag from head and tail
    https://git.kernel.org/bpf/bpf-next/c/dea1526fbafb
  - [bpf-next,v7,3/8] bpf: Support pulling non-linear xdp data
    https://git.kernel.org/bpf/bpf-next/c/4dce1a0d7cf3
  - [bpf-next,v7,4/8] bpf: Clear packet pointers after changing packet data in kfuncs
    https://git.kernel.org/bpf/bpf-next/c/0e7a733ab3d7
  - [bpf-next,v7,5/8] bpf: Make variables in bpf_prog_test_run_xdp less confusing
    https://git.kernel.org/bpf/bpf-next/c/7eb83bff02ad
  - [bpf-next,v7,6/8] bpf: Support specifying linear xdp packet data size for BPF_PROG_TEST_RUN
    https://git.kernel.org/bpf/bpf-next/c/fe9544ed1a2e
  - [bpf-next,v7,7/8] selftests/bpf: Test bpf_xdp_pull_data
    https://git.kernel.org/bpf/bpf-next/c/323302f54db9
  - [bpf-next,v7,8/8] selftests: drv-net: Pull data before parsing headers
    https://git.kernel.org/bpf/bpf-next/c/efec2e55bdef

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



