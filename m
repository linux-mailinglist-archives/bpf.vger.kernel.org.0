Return-Path: <bpf+bounces-4144-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF1974934E
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 03:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75CD028116A
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 01:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A55A44;
	Thu,  6 Jul 2023 01:50:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3735E7F
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 01:50:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A0BB2C433C8;
	Thu,  6 Jul 2023 01:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688608220;
	bh=e0deVLmnjR7DOSBT7d3lP+S5ctjsbNgaMmvAvskRevE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=epZR3oA6Wvr24xBiRdZWg5S2ir0aiBjdPRqPVoI2QQLkTbLjQu8wRrKKEzJVWgMu2
	 5jyC9W8gUu6OrUQaRFIF76vIIDq3okWDD/GivMzT2aGJIh5Nh25kMECRl05Jmlow4/
	 fZXMUXd0a5Y8qwxNlpoar9x3AYmGZJ7gTpsoBZEPgcNahv98XNhfetDibF+YEKjfmg
	 7pDi14+fj4My00T/yzw9eCP2OFXmcn9AkY7niVzJHADaWEoL/pAP2sAs1Z5K7lZV7p
	 m3QqwvzQYFX8j3jrZ35fFBOSXcbcCIl6EzJmoIcii6fbiJBhvZ6Tey5gUDh071VmkI
	 I4q62WUWGCVUQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 867D0C40C5E;
	Thu,  6 Jul 2023 01:50:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v9] selftests/bpf: Add benchmark for bpf memory
 allocator
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168860822054.22142.13852026022704379153.git-patchwork-notify@kernel.org>
Date: Thu, 06 Jul 2023 01:50:20 +0000
References: <20230704025039.938914-1-houtao@huaweicloud.com>
In-Reply-To: <20230704025039.938914-1-houtao@huaweicloud.com>
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, alexei.starovoitov@gmail.com,
 andrii@kernel.org, song@kernel.org, haoluo@google.com, yhs@fb.com,
 daniel@iogearbox.net, kpsingh@kernel.org, sdf@google.com, jolsa@kernel.org,
 john.fastabend@gmail.com, paulmck@kernel.org, rcu@vger.kernel.org,
 houtao1@huawei.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue,  4 Jul 2023 10:50:39 +0800 you wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> The benchmark could be used to compare the performance of hash map
> operations and the memory usage between different flavors of bpf memory
> allocator (e.g., no bpf ma vs bpf ma vs reuse-after-gp bpf ma). It also
> could be used to check the performance improvement or the memory saving
> provided by optimization.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v9] selftests/bpf: Add benchmark for bpf memory allocator
    https://git.kernel.org/bpf/bpf-next/c/fd283ab196a8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



