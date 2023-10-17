Return-Path: <bpf+bounces-12480-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF9F7CCCCF
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 22:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D5531C20C04
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 20:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6742E3F2;
	Tue, 17 Oct 2023 20:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rlOhxtoh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C822E3E4
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 20:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 43694C433CB;
	Tue, 17 Oct 2023 20:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697572824;
	bh=9c82IedfM7pycKVz/dbIejd8BitE7xqAJfnPrYMAesY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rlOhxtohx1KFKOhwBDTG1UUly/KzCmZJJp7oqWZm4WW5g/bVsuSL9KY+qtNzHRK5G
	 9BzDKs2Nd0tNi168IUPbn6VqvPJKDzX7JUuRwN6tHpftPrZAwHp+tExXBSOCAqCkZA
	 ZBa27jLDWkXtVnSNQOCc8nL/M6+jUnQqO0b/w5sBFQPYhe+B9kW1a+7kInQ+9kWkUM
	 f+sY+dPRdMUUWu3Iti/HLWE2p96nQTWvK5zbWpIHYUbrGmUiqrjqaT9Ig2IqgZGCvH
	 hxnCti+kyHdhOzsHYf+5+W8T9juq2zN+jlbfO58DqFiJa6ZS3o8cmPxYRjiOyLmJYr
	 E6w1n2sSpCjOQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 28EF7E4E9DD;
	Tue, 17 Oct 2023 20:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Add additional mprog query test
 coverage
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169757282416.23069.14344116792289833086.git-patchwork-notify@kernel.org>
Date: Tue, 17 Oct 2023 20:00:24 +0000
References: <20231017081728.24769-1-daniel@iogearbox.net>
In-Reply-To: <20231017081728.24769-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, martin.lau@linux.dev

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 17 Oct 2023 10:17:28 +0200 you wrote:
> Add several new test cases which assert corner cases on the mprog query
> mechanism, for example, around passing in a too small or a larger array
> than the current count.
> 
>   ./test_progs -t tc_opts
>   #252     tc_opts_after:OK
>   #253     tc_opts_append:OK
>   #254     tc_opts_basic:OK
>   #255     tc_opts_before:OK
>   #256     tc_opts_chain_classic:OK
>   #257     tc_opts_chain_mixed:OK
>   #258     tc_opts_delete_empty:OK
>   #259     tc_opts_demixed:OK
>   #260     tc_opts_detach:OK
>   #261     tc_opts_detach_after:OK
>   #262     tc_opts_detach_before:OK
>   #263     tc_opts_dev_cleanup:OK
>   #264     tc_opts_invalid:OK
>   #265     tc_opts_max:OK
>   #266     tc_opts_mixed:OK
>   #267     tc_opts_prepend:OK
>   #268     tc_opts_query:OK
>   #269     tc_opts_query_attach:OK
>   #270     tc_opts_replace:OK
>   #271     tc_opts_revision:OK
>   Summary: 20/0 PASSED, 0 SKIPPED, 0 FAILED
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Add additional mprog query test coverage
    https://git.kernel.org/bpf/bpf-next/c/24516309e330

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



