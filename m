Return-Path: <bpf+bounces-18424-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9CD81A85B
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 22:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B20CFB246E2
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 21:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FD44BA92;
	Wed, 20 Dec 2023 21:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rzvx7L/g"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3E74A9AB
	for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 21:40:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5C5BBC43397;
	Wed, 20 Dec 2023 21:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703108428;
	bh=jGatMqnBvhb8SBTRklohvuFHeHKzbnd1KgBcJPgkY2M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Rzvx7L/ggcW4zdzQgP/VEJYbhG31RVTi9u6GSsn9Jl9fBWfRXU4R08rki1B2lhbbQ
	 MCORVUJfOBH9MtpvIty+1aFGruL5OvQawjK7O84ZOuDfQZqA9wYdUKjl2M3xBEUfYu
	 hcI38jLb/KPSgrY9IRVLfwEk7bA7o5DIQUWnDI8jPddUHy1NSQqTh4evi6ItlhL76p
	 87qzyEzAfpdvFzg22WBbqE6bPsbDon6ZUOqFNh74ADvmzE6nUnw1wU7yKYBdbeISxi
	 6Qz4+iUAtfSZ8HRAlE4dMdbhicd5SqZf3yqb1Qlhq7vlrmdS35OO4qu2TEivb+C465
	 Z5s3Ostt6+O1A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3EF12C561EE;
	Wed, 20 Dec 2023 21:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/2] bpf: Fix warning in check_obj_size()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170310842825.28794.13978474539669943599.git-patchwork-notify@kernel.org>
Date: Wed, 20 Dec 2023 21:40:28 +0000
References: <20231216131052.27621-1-houtao@huaweicloud.com>
In-Reply-To: <20231216131052.27621-1-houtao@huaweicloud.com>
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, alexei.starovoitov@gmail.com,
 andrii@kernel.org, song@kernel.org, haoluo@google.com,
 yonghong.song@linux.dev, daniel@iogearbox.net, kpsingh@kernel.org,
 sdf@google.com, jolsa@kernel.org, john.fastabend@gmail.com,
 oliver.sang@intel.com, houtao1@huawei.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 16 Dec 2023 21:10:50 +0800 you wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> Hi,
> 
> The patch set aims to fix the warning in check_obj_size() as reported by
> lkp [1]. Patch #1 fixes the warning by selecting target cache for free
> request through c->unit_size, so the unnecessary adjustment of
> size_index and the checking in check_obj_size() can be removed. Patch #2
> fixes the test failure in test_bpf_ma after applying patch #1.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpf: Use c->unit_size to select target cache during free
    https://git.kernel.org/bpf/bpf-next/c/7ac5c53e0073
  - [bpf-next,2/2] selftests/bpf: Remove tests for zeroed-array kptr
    https://git.kernel.org/bpf/bpf-next/c/69ff403d87be

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



