Return-Path: <bpf+bounces-7028-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEED2770650
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 18:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 730D4282806
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 16:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B324E198AE;
	Fri,  4 Aug 2023 16:50:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730E61802C
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 16:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ECDBBC433C9;
	Fri,  4 Aug 2023 16:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691167823;
	bh=XWN/ERdV4yJNFYO5sEZ8FEKBNFvA2PvP5vHAtN6P4qA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=leQ0ZGVbEx85CsQqrQsci6ByWX6A2y9L4Q4xn1fv2wPSz6qKYfxC/y9iQsgKWQZzR
	 3VQ+0kBq2bOqz/u02sFWk8YMTezmLmvwSpjBHG5JzYtrCDr0DGbNQ0XPA16bjvV7kH
	 ykihcvOAjmYfyURjHbhb6AwphwLNXD379xBKzOkXS/q0NtKbT1hNKr0s9Qwe0Bpws7
	 c3bOEHk5WBs+/JR2Hu1G1yuepA7fj7IESddE1agsNUneYHxXEQ3OrrNZK/wKI12nGG
	 ubskxd7iUL5agNbJkuCX2LgDWkLXRRNHelyaKun/eh6my/ygYTrUL8hcUwlzWySH8x
	 bbVbmcOIBrl8Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D0219C41620;
	Fri,  4 Aug 2023 16:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 1/2] bpf: Fix mprog detachment for empty mprog entry
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169116782284.6928.18233587509770700871.git-patchwork-notify@kernel.org>
Date: Fri, 04 Aug 2023 16:50:22 +0000
References: <20230804131112.11012-1-daniel@iogearbox.net>
In-Reply-To: <20230804131112.11012-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: martin.lau@linux.dev, bpf@vger.kernel.org,
 syzbot+0c06ba0f831fe07a8f27@syzkaller.appspotmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Fri,  4 Aug 2023 15:11:11 +0200 you wrote:
> syzbot reported an UBSAN array-index-out-of-bounds access in bpf_mprog_read()
> upon bpf_mprog_detach(). While it did not have a reproducer, I was able to
> manually reproduce through an empty mprog entry which just has miniq present.
> 
> The latter is important given otherwise we get an ENOENT error as tcx detaches
> the whole mprog entry. The index 4294967295 was triggered via NULL dtuple.prog
> which then attempts to detach from the back. bpf_mprog_fetch() in this case
> did hit the idx == total and therefore tried to grab the entry at idx -1.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpf: Fix mprog detachment for empty mprog entry
    https://git.kernel.org/bpf/bpf-next/c/d210f9735e13
  - [bpf-next,2/2] selftests/bpf: Add test for detachment on empty mprog entry
    https://git.kernel.org/bpf/bpf-next/c/21ce6abe178a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



