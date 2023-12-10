Return-Path: <bpf+bounces-17323-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E56A80B86F
	for <lists+bpf@lfdr.de>; Sun, 10 Dec 2023 03:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B712E1C2088D
	for <lists+bpf@lfdr.de>; Sun, 10 Dec 2023 02:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF0E15A0;
	Sun, 10 Dec 2023 02:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNy1MGzO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E927F
	for <bpf@vger.kernel.org>; Sun, 10 Dec 2023 02:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 50FF9C433C9;
	Sun, 10 Dec 2023 02:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702176024;
	bh=qvDLWpMSGv5LL1QCAQRmjUGlb1+rHYmGeDyV52k13rQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SNy1MGzOT9AsaqxwQFrgRzjYQD9dlUNcfdS+EotfCQhncjC1AyIJKXQH+y+CuIm93
	 kiu/tfOkU4muj8KGWUi7LPbISV0pnoR5utmTOw8uXKIXi71DsnXqpxtVlVm8tGck+M
	 LCBzjUDCfumUw2wkcM8REjtuhmvZMZdWW65H273IDB7fDa+193/sGQzb6BGtTzUiMG
	 +yNklPRGjH+pRTJw6rR15bxqeI3pxI6fXgwaL46kbfK9EA/UvTTlov0bOUy8HAAqPB
	 KeiYgwAR3uI7L1wTPOHHOTrwAIXix4FnQsShLz8OVmpCu7NEmNhmzYMWmXJq7lTni+
	 fVY6F88UfGy5g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 31CAEC595CB;
	Sun, 10 Dec 2023 02:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/7] bpf: Fixes for maybe_wait_bpf_programs()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170217602420.3790.3377699982301582485.git-patchwork-notify@kernel.org>
Date: Sun, 10 Dec 2023 02:40:24 +0000
References: <20231208102355.2628918-1-houtao@huaweicloud.com>
In-Reply-To: <20231208102355.2628918-1-houtao@huaweicloud.com>
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, alexei.starovoitov@gmail.com,
 andrii@kernel.org, song@kernel.org, haoluo@google.com,
 yonghong.song@linux.dev, daniel@iogearbox.net, kpsingh@kernel.org,
 sdf@google.com, jolsa@kernel.org, john.fastabend@gmail.com,
 houtao1@huawei.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri,  8 Dec 2023 18:23:48 +0800 you wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> Hi,
> 
> The patch set aims to fix the problems found when inspecting the code
> related with maybe_wait_bpf_programs().
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/7] bpf: Remove unnecessary wait from bpf_map_copy_value()
    https://git.kernel.org/bpf/bpf-next/c/c26f2a890139
  - [bpf-next,2/7] bpf: Call maybe_wait_bpf_programs() only once for generic_map_update_batch()
    https://git.kernel.org/bpf/bpf-next/c/37ba5b59d6ad
  - [bpf-next,3/7] bpf: Add missed maybe_wait_bpf_programs() for htab of maps
    https://git.kernel.org/bpf/bpf-next/c/012772581d04
  - [bpf-next,4/7] bpf: Only call maybe_wait_bpf_programs() when map operation succeeds
    https://git.kernel.org/bpf/bpf-next/c/67ad2c73ff29
  - [bpf-next,5/7] bpf: Set uattr->batch.count as zero before batched update or deletion
    https://git.kernel.org/bpf/bpf-next/c/06e5c999f102
  - [bpf-next,6/7] bpf: Only call maybe_wait_bpf_programs() when at least one map operation succeeds
    (no matching commit)
  - [bpf-next,7/7] bpf: Wait for sleepable BPF program in maybe_wait_bpf_programs()
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



