Return-Path: <bpf+bounces-8969-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F063E78D375
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 09:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9E8B281391
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 07:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4AF6187B;
	Wed, 30 Aug 2023 07:00:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832A310EE
	for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 07:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E933BC433C7;
	Wed, 30 Aug 2023 07:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693378823;
	bh=UHXqpDw5ijuysheQKViWUliDESam7OebDyJ3vUIodA4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pCZ0N7Pw445irpaT+Mt/Rlx8WPr8QjgGJvbNxqCZFH5+ib1JALHTR+avyERziSNys
	 CAj7XXAXdCMao7C+2wQcLN4jGkBgtX4pD6/vDvsr8ggYWPZ/FW9Yl2HqIe7du1FFH7
	 dVGHKyUj5634XKoU3OydqfOvzuxm4KULZGLc1r96jnWbUtPcqg4iO7CAzedMPW9sKB
	 uQiCgC2WtOoX/UH4LK1USpqTFpC78vOKCH8wlQq3n4Vn0iw7FnjPE4Psy+61xjT+Ms
	 vuw/RDqIdaHLVc1+VjsQKFlzjsfcMCYeLMM2lnQC/xUwT6FpmMUNM0LmKtwUiDFvIG
	 SfuqPGVFuON7A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CDCAEE29F39;
	Wed, 30 Aug 2023 07:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] selftests/bpf: Fix flaky cgroup_iter_sleepable subtest
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169337882283.5288.11010704935345281978.git-patchwork-notify@kernel.org>
Date: Wed, 30 Aug 2023 07:00:22 +0000
References: <20230827150551.1743497-1-yonghong.song@linux.dev>
In-Reply-To: <20230827150551.1743497-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Sun, 27 Aug 2023 08:05:51 -0700 you wrote:
> Occasionally, with './test_progs -j' on my vm, I will hit the
> following failure:
>   test_cgrp_local_storage:PASS:join_cgroup /cgrp_local_storage 0 nsec
>   test_cgroup_iter_sleepable:PASS:skel_open 0 nsec
>   test_cgroup_iter_sleepable:PASS:skel_load 0 nsec
>   test_cgroup_iter_sleepable:PASS:attach_iter 0 nsec
>   test_cgroup_iter_sleepable:PASS:iter_create 0 nsec
>   test_cgroup_iter_sleepable:FAIL:cgroup_id unexpected cgroup_id: actual 1 != expected 2812
>   #48/5    cgrp_local_storage/cgroup_iter_sleepable:FAIL
>   #48      cgrp_local_storage:FAIL
> 
> [...]

Here is the summary with links:
  - [bpf] selftests/bpf: Fix flaky cgroup_iter_sleepable subtest
    https://git.kernel.org/bpf/bpf/c/5439cfa7fe61

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



