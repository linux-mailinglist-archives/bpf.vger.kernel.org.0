Return-Path: <bpf+bounces-704-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00640705E80
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 06:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E01AA1C20D68
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 04:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1774440B;
	Wed, 17 May 2023 04:00:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615D81844
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 04:00:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1523AC4339B;
	Wed, 17 May 2023 04:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684296020;
	bh=43y7EUJuSQWnsMtyRPvrkpUXtAQexdcIzE3qi5UqiCg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GoHkSm1sFtqsq1em5H1kbocVBUn+FkVgeV2uu8T5oFyAte1JcTkc7z1noXhqtPrM4
	 BaFWDsShvpzqxhJtJkr9X+6AbqfzpTA2QGmCBIFkL3XHaS77humKRidgrwfQEPTqMc
	 RkI8qe5EMOTckrBAPNunrIMk5O4ONxMAP71ZYPvIKvmgV0a3mOkDPnkp4qAEhndqMQ
	 M95W6oFu4JC/HHYiGnnTZaOwVuHyjHqpRi956tGIeFu7Nf3swdjwtDZMZ/YVPuNBIT
	 A7bCqo3Js7o9jx0QvvIXHlukUv3NTo6WceyELjW11LG3wsG2CwgXdy20sY6/ZXum9O
	 zLnBrR1KqmvPA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E4D4AE5421C;
	Wed, 17 May 2023 04:00:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix s390 sock_field test failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168429601993.23839.3806765038041059248.git-patchwork-notify@kernel.org>
Date: Wed, 17 May 2023 04:00:19 +0000
References: <20230516214945.1013578-1-yhs@fb.com>
In-Reply-To: <20230516214945.1013578-1-yhs@fb.com>
To: Yonghong Song <yhs@fb.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org,
 iii@linux.ibm.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 16 May 2023 14:49:45 -0700 you wrote:
> llvm patch [1] enabled cross-function optimization for func arguments
> (ArgumentPromotion) at -O2 level. And this caused s390 sock_fields
> test failure ([2]). The failure is gone right now as patch [1] was
> reverted in [3]. But it is possible that patch [3] will be reverted
> again and then the test failure in [2] will show up again. So it is
> desirable to fix the failure regardless.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Fix s390 sock_field test failure
    https://git.kernel.org/bpf/bpf-next/c/de58ef414d8d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



