Return-Path: <bpf+bounces-1868-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 415DD72316E
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 22:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DC4D1C20D2B
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 20:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F85DDDE;
	Mon,  5 Jun 2023 20:30:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CEB261ED
	for <bpf@vger.kernel.org>; Mon,  5 Jun 2023 20:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B523EC4339B;
	Mon,  5 Jun 2023 20:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685997020;
	bh=BNvat+2Nt24JH53lV1dM2vpc1lPblBukImbZaH3NVIE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ThB5i3xzBiM73miYf3HC7sJe5bo81fkqzyPdsy4H9I8PUGBdH7oP1Tunhohtv5dVc
	 uYcrfsMdC58eeCHYXyWOBdwN9o5CkJFdbAKMHn6rtG5K9omaNzkKLrCEhOE5zd1Qta
	 1tABXlkYbpXdUOCZvCJRX/N3N81rQDPSCC9OD7uVDrZCfpR0Wo4L/Y3BDhPQiMsgih
	 LjY5cVo0SlwQrN2mIxid7dCTGZ4ILHQ2/oZcogzsBZ6P/IVekEE5QKvbZbzTJ27CXI
	 tDCQPZtpD0VyOpQOxZ49PztdKfpul7Mk6x8k0lgJ0WeXut6w9BwVVCyeuDpBizokBG
	 Kw3kUgUEXBegg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9871BE87231;
	Mon,  5 Jun 2023 20:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next 0/9] bpf_refcount followups (part 1)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168599702062.20848.16540672579758687326.git-patchwork-notify@kernel.org>
Date: Mon, 05 Jun 2023 20:30:20 +0000
References: <20230602022647.1571784-1-davemarchevsky@fb.com>
In-Reply-To: <20230602022647.1571784-1-davemarchevsky@fb.com>
To: Dave Marchevsky <davemarchevsky@fb.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@kernel.org, kernel-team@fb.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 1 Jun 2023 19:26:38 -0700 you wrote:
> This series is the first of two (or more) followups to address issues in the
> bpf_refcount shared ownership implementation discovered by Kumar.
> Specifically, this series addresses the "bpf_refcount_acquire on non-owning ref
> in another tree" scenario described in [0], and does _not_ address issues
> raised in [1]. Further followups will address the other issues.
> 
> The series can be applied without re-enabling bpf_refcount_acquire calls, which
> were disabled in commit 7deca5eae833 ("bpf: Disable bpf_refcount_acquire kfunc
> calls until race conditions are fixed") until all issues are addressed. Some
> extra patches are included so that BPF CI tests will exercise test changes in
> the series.
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next,1/9,DONOTAPPLY] Revert "bpf: Disable bpf_refcount_acquire kfunc calls until race conditions are fixed"
    (no matching commit)
  - [v2,bpf-next,2/9] bpf: Set kptr_struct_meta for node param to list and rbtree insert funcs
    https://git.kernel.org/bpf/bpf-next/c/2140a6e3422d
  - [v2,bpf-next,3/9] bpf: Fix __bpf_{list,rbtree}_add's beginning-of-node calculation
    https://git.kernel.org/bpf/bpf-next/c/cc0d76cafebb
  - [v2,bpf-next,4/9] bpf: Make bpf_refcount_acquire fallible for non-owning refs
    https://git.kernel.org/bpf/bpf-next/c/7793fc3babe9
  - [v2,bpf-next,5/9,DONOTAPPLY] bpf: Allow KF_DESTRUCTIVE-flagged kfuncs to be called under spinlock
    (no matching commit)
  - [v2,bpf-next,6/9,DONOTAPPLY] selftests/bpf: Add unsafe lock/unlock and refcount_read kfuncs to bpf_testmod
    (no matching commit)
  - [v2,bpf-next,7/9,DONOTAPPLY] selftests/bpf: Add test exercising bpf_refcount_acquire race condition
    (no matching commit)
  - [v2,bpf-next,8/9,DONOTAPPLY] selftests/bpf: Disable newly-added refcounted_kptr_races test
    (no matching commit)
  - [v2,bpf-next,9/9,DONOTAPPLY] Revert "selftests/bpf: Disable newly-added refcounted_kptr_races test"
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



