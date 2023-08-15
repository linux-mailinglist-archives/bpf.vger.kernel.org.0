Return-Path: <bpf+bounces-7791-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF0477C715
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 07:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49E4D28133C
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 05:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8686A4418;
	Tue, 15 Aug 2023 05:30:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DE83D87
	for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 05:30:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B6888C433C9;
	Tue, 15 Aug 2023 05:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692077419;
	bh=/qE5d/5Jam386R3Ft9AmQd07cfNv/HcfqtyE0YoJclk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UeKpyUkBqmlH3ZdWvIXvPghRqEI+11/dnSNrTJAh6Hg3BpuZJ8JRWu53F4YS4wo35
	 dVn0Omy0tyOvatMDAEFeKVILr58TN5PhF+UrVjotlNpYokvOiSLAC0t//4u+mpvoTH
	 H4raLZUbxwoBuJpFF+ud+hjihPWP9Pr7CDgHc650ay2/0Rqrin/6hJPM+tQG+SxTFK
	 gB1xq45BJN96EzBoRmQFg0GwBr289cPoy9d1Ft5Q1onOxl9RXBY1yQ+c1g4j4LesmK
	 ZCZvsBFt1epRinePXrOlUpW5L2N0EtjCgI806stqP0fMp4DeVfTESC4Sw7yGu8PpCM
	 TYteAZEXlDP3w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9E301E93B38;
	Tue, 15 Aug 2023 05:30:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Add various more tcx test cases
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169207741964.3389.7478248457019645426.git-patchwork-notify@kernel.org>
Date: Tue, 15 Aug 2023 05:30:19 +0000
References: <8699efc284b75ccdc51ddf7062fa2370330dc6c0.1692029283.git.daniel@iogearbox.net>
In-Reply-To: <8699efc284b75ccdc51ddf7062fa2370330dc6c0.1692029283.git.daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: martin.lau@linux.dev, bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Mon, 14 Aug 2023 18:14:10 +0200 you wrote:
> Add several new tcx test cases to improve test coverage. This also includes
> a few new tests with ingress instead of clsact qdisc, to cover the fix from
> commit dc644b540a2d ("tcx: Fix splat in ingress_destroy upon tcx_entry_free").
> 
>   # ./test_progs -t tc
>   [...]
>   #234     tc_links_after:OK
>   #235     tc_links_append:OK
>   #236     tc_links_basic:OK
>   #237     tc_links_before:OK
>   #238     tc_links_chain_classic:OK
>   #239     tc_links_chain_mixed:OK
>   #240     tc_links_dev_cleanup:OK
>   #241     tc_links_dev_mixed:OK
>   #242     tc_links_ingress:OK
>   #243     tc_links_invalid:OK
>   #244     tc_links_prepend:OK
>   #245     tc_links_replace:OK
>   #246     tc_links_revision:OK
>   #247     tc_opts_after:OK
>   #248     tc_opts_append:OK
>   #249     tc_opts_basic:OK
>   #250     tc_opts_before:OK
>   #251     tc_opts_chain_classic:OK
>   #252     tc_opts_chain_mixed:OK
>   #253     tc_opts_delete_empty:OK
>   #254     tc_opts_demixed:OK
>   #255     tc_opts_detach:OK
>   #256     tc_opts_detach_after:OK
>   #257     tc_opts_detach_before:OK
>   #258     tc_opts_dev_cleanup:OK
>   #259     tc_opts_invalid:OK
>   #260     tc_opts_mixed:OK
>   #261     tc_opts_prepend:OK
>   #262     tc_opts_replace:OK
>   #263     tc_opts_revision:OK
>   [...]
>   Summary: 44/38 PASSED, 0 SKIPPED, 0 FAILED
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Add various more tcx test cases
    https://git.kernel.org/bpf/bpf-next/c/ccd9a8be2e42

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



