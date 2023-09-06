Return-Path: <bpf+bounces-9309-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC08079331D
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 03:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F4CF281143
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 01:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8163963C;
	Wed,  6 Sep 2023 01:00:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F349A62B
	for <bpf@vger.kernel.org>; Wed,  6 Sep 2023 01:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5C602C433C9;
	Wed,  6 Sep 2023 01:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693962024;
	bh=o/YZ4zJGAAzydKpKfb/gjjU9xIgdU+99bByjeyRQXno=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QYKUIDV1dFDI0LM8wSRPyuAendVxcqwplm8D+aegyhoMxpKn8VuSbq4PSUfMd/NN4
	 hSpNcy8QAxe5Be4zEBKx+w3rsg1bXQy5RSN1vA94Yjrx5hofM6AePMPXMFOF+Dj755
	 dEW97ssSfxUQcTxIV2/avd4df62/KKUF06wlWoe4bQUxJGu79RW5e/MSzgdMo6AAen
	 AxBTiiU+2wEEa7OGcB8+yLIg5sGPLY//5aoE+ATarL1wTRQgCyxXqBBbhFrMEkLfsp
	 HQButVYDyeBH8Wymc4lXbvo2SW0adK1OcFyNlfYlL7qtOGFkNX//g3PTqb24vTGgVK
	 7Y0b8lSK/U4xw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3B472C595C5;
	Wed,  6 Sep 2023 01:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2 0/3] bpf: Enable IRQ after irq_work_raise() completes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169396202423.13785.15659710106837077192.git-patchwork-notify@kernel.org>
Date: Wed, 06 Sep 2023 01:00:24 +0000
References: <20230901111954.1804721-1-houtao@huaweicloud.com>
In-Reply-To: <20230901111954.1804721-1-houtao@huaweicloud.com>
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, alexei.starovoitov@gmail.com,
 andrii@kernel.org, song@kernel.org, haoluo@google.com,
 yonghong.song@linux.dev, daniel@iogearbox.net, kpsingh@kernel.org,
 sdf@google.com, jolsa@kernel.org, john.fastabend@gmail.com,
 houtao1@huawei.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri,  1 Sep 2023 19:19:51 +0800 you wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> Hi,
> 
> The patchset aims to fix the problem that bpf_mem_alloc() may return
> NULL unexpectedly when multiple bpf_mem_alloc() are invoked concurrently
> under process context and there is still free memory available. The
> problem was found when doing stress test for qp-trie but the same
> problem also exists for bpf_obj_new() as demonstrated in patch #3.
> 
> [...]

Here is the summary with links:
  - [bpf,v2,1/3] bpf: Enable IRQ after irq_work_raise() completes in unit_alloc()
    https://git.kernel.org/bpf/bpf-next/c/d2fc491bc41d
  - [bpf,v2,2/3] bpf: Enable IRQ after irq_work_raise() completes in unit_free{_rcu}()
    https://git.kernel.org/bpf/bpf-next/c/9d7f77f997d9
  - [bpf,v2,3/3] selftests/bpf: Test preemption between bpf_obj_new() and bpf_obj_drop()
    https://git.kernel.org/bpf/bpf-next/c/113aa9b83cd6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



