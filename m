Return-Path: <bpf+bounces-48326-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CFFA06AD1
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 03:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E13671886442
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 02:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8CE784D02;
	Thu,  9 Jan 2025 02:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tdKz8+J7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365726F30F;
	Thu,  9 Jan 2025 02:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736389212; cv=none; b=NdM0mw4m6zpU+Q/B4hOvbcUBZHYe73YP2F6XXalkT1gYt7J0jyOrFjC+0GIml9yISzkjxAWDRsAR1DROLlORRLwLAQf8eRBvXdwlFtxqHoezm7T4ULd1jKTe1OXFP+eEWmPosxwy/XX/LeDui/GRv/ZF8y5Jh0YzDV/tlonG/k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736389212; c=relaxed/simple;
	bh=5o2Si8C+2FKN1RT3tKic0+fY2AVR7kGb/gwSx9YjJxM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ODHwIMnTJgY/lRh3sIMa/b0xqMxNjBewV1iA1VQkqqPx2ZQcbf4yvpM9iDf+AVLSWkwp3LcB2ihz20Mo0uNQNNmwsYMkr1VfQuBPPNRhB/DFqm7QbyP4J+yM5E2fx/FfgJ8ihpYfnX6RAtMfL4ZAWoMMISkhYcCvBtAgnN+i540=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tdKz8+J7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B5D3C4CEDD;
	Thu,  9 Jan 2025 02:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736389211;
	bh=5o2Si8C+2FKN1RT3tKic0+fY2AVR7kGb/gwSx9YjJxM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tdKz8+J7E6I7Y6iNqZF1ZtqQpRGEknpXQEwpvk+cLzJj4022xc74fnepRGfs3ZJG2
	 xgWotQ0tUEyn6oyhE8LcJGbzxTO3c8/EigUYly6XbOkcASYs8yYtQtazDn7nBdNCHr
	 SxUPWg3qO8ycRNEqe3o5uJ4dYoBPMW8H91DkyhtOpty9hKCqdHEWoK2YSuZtf0UHDp
	 CHwc4E+w+77sGcrlMKessGt+Rm7btGpwBVaGOiK01Fj5a7tAtj0C1ad4NI6qtHqlg9
	 E0FirT8NUnBfO3k00t/XjFHMLHi/iCkL0AYoYpW79jfKlTozE/dVes9FyHr7SQ+0V2
	 E8F+AUTXmbqyw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71085380A965;
	Thu,  9 Jan 2025 02:20:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 00/16] bpf: Reduce the use of
 migrate_{disable|enable}()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173638923326.842935.15837805191875975956.git-patchwork-notify@kernel.org>
Date: Thu, 09 Jan 2025 02:20:33 +0000
References: <20250108010728.207536-1-houtao@huaweicloud.com>
In-Reply-To: <20250108010728.207536-1-houtao@huaweicloud.com>
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, martin.lau@linux.dev,
 alexei.starovoitov@gmail.com, andrii@kernel.org, eddyz87@gmail.com,
 song@kernel.org, haoluo@google.com, yonghong.song@linux.dev,
 daniel@iogearbox.net, kpsingh@kernel.org, sdf@fomichev.me, jolsa@kernel.org,
 john.fastabend@gmail.com, houtao1@huawei.com, xukuohai@huawei.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed,  8 Jan 2025 09:07:12 +0800 you wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> Hi,
> 
> The use of migrate_{disable|enable} pair in BPF is mainly due to the
> introduction of bpf memory allocator and the use of per-CPU data struct
> in its internal implementation. The caller needs to disable migration
> before invoking the alloc or free APIs of bpf memory allocator, and
> enable migration after the invocation.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,01/16] bpf: Remove migrate_{disable|enable} from LPM trie
    https://git.kernel.org/bpf/bpf-next/c/1b1a01db17af
  - [bpf-next,v2,02/16] bpf: Remove migrate_{disable|enable} in ->map_for_each_callback
    https://git.kernel.org/bpf/bpf-next/c/ea5b229630a6
  - [bpf-next,v2,03/16] bpf: Remove migrate_{disable|enable} in htab_elem_free
    https://git.kernel.org/bpf/bpf-next/c/53f2ba0b1cc0
  - [bpf-next,v2,04/16] bpf: Remove migrate_{disable|enable} from bpf_cgrp_storage_lock helpers
    https://git.kernel.org/bpf/bpf-next/c/25dc65f75b08
  - [bpf-next,v2,05/16] bpf: Remove migrate_{disable|enable} from bpf_task_storage_lock helpers
    https://git.kernel.org/bpf/bpf-next/c/9e6c958b5466
  - [bpf-next,v2,06/16] bpf: Disable migration when destroying inode storage
    https://git.kernel.org/bpf/bpf-next/c/e319cdc89566
  - [bpf-next,v2,07/16] bpf: Disable migration when destroying sock storage
    https://git.kernel.org/bpf/bpf-next/c/7d1032d1e303
  - [bpf-next,v2,08/16] bpf: Disable migration when cloning sock storage
    https://git.kernel.org/bpf/bpf-next/c/dfccfc47bde5
  - [bpf-next,v2,09/16] bpf: Disable migration in bpf_selem_free_rcu
    https://git.kernel.org/bpf/bpf-next/c/090d7f2e640b
  - [bpf-next,v2,10/16] bpf: Disable migration before calling ops->map_free()
    https://git.kernel.org/bpf/bpf-next/c/4b7e7cd1c105
  - [bpf-next,v2,11/16] bpf: Remove migrate_{disable|enable} in bpf_obj_free_fields()
    https://git.kernel.org/bpf/bpf-next/c/1d2dbe7120e8
  - [bpf-next,v2,12/16] bpf: Remove migrate_{disable,enable} in bpf_cpumask_release()
    https://git.kernel.org/bpf/bpf-next/c/6a52b965ab6f
  - [bpf-next,v2,13/16] bpf: Remove migrate_{disable|enable} from bpf_selem_alloc()
    https://git.kernel.org/bpf/bpf-next/c/2269b32ab00e
  - [bpf-next,v2,14/16] bpf: Remove migrate_{disable|enable} from bpf_local_storage_alloc()
    https://git.kernel.org/bpf/bpf-next/c/4855a75ebf48
  - [bpf-next,v2,15/16] bpf: Remove migrate_{disable|enable} from bpf_local_storage_free()
    https://git.kernel.org/bpf/bpf-next/c/7b984359e097
  - [bpf-next,v2,16/16] bpf: Remove migrate_{disable|enable} from bpf_selem_free()
    https://git.kernel.org/bpf/bpf-next/c/d86088e2c35d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



