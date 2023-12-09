Return-Path: <bpf+bounces-17294-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B86580B123
	for <lists+bpf@lfdr.de>; Sat,  9 Dec 2023 02:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01A5F1F2123F
	for <lists+bpf@lfdr.de>; Sat,  9 Dec 2023 01:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8B580E;
	Sat,  9 Dec 2023 01:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZj7k4jQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5574F7F8
	for <bpf@vger.kernel.org>; Sat,  9 Dec 2023 01:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C5E10C433C9;
	Sat,  9 Dec 2023 01:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702083623;
	bh=iMNV9w3HItKaUp7UcdgmrGJdNkYHvxHQbg8J38z8LJY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fZj7k4jQLELVWP2Mz2BXYU9UiHfD2VK94JCkYiAmCBVMIcnP3csRiqrYtgQONEMPy
	 RvcAWlV0cenrO9WO7ryDgS7eYbRroxsEbyqg0lYIKtMaM3cbt5jqTgfAWB8ZtXifZQ
	 45taJEmYrsTnBy6ZBs0l74BjX107/5wnMiYRCsW+Vhn9L+/udGslV3BkNYxAd9D3d3
	 gZXTEMjkfGRaBlffAHxg5mbr8DUxuVXZ+waAH+mwTr7OZ0QHbaLNtTcAc8mRzHcg0c
	 WBTIyAsH8PHY+//m2MbtzSYe3+uMRit2YRvydgga9prEIfoB9xmDyOt5O3/Poxfofv
	 jzGgUxhAGjjkw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AC7E0DD4F1E;
	Sat,  9 Dec 2023 01:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: fix timer/test_bad_ret subtest on
 test_progs-cpuv4 flavor
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170208362370.6704.10705673059158183369.git-patchwork-notify@kernel.org>
Date: Sat, 09 Dec 2023 01:00:23 +0000
References: <20231208233028.3412690-1-andrii@kernel.org>
In-Reply-To: <20231208233028.3412690-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 8 Dec 2023 15:30:28 -0800 you wrote:
> Because test_bad_ret main program is not written in assembly, we don't
> control instruction indices in timer_cb_ret_bad() subprog. This bites us
> in timer/test_bad_ret subtest, where we see difference between cpuv4 and
> other flavors.
> 
> For now, make __msg() expectations not rely on instruction indices by
> anchoring them around bpf_get_prandom_u32 call. Once we have regex/glob
> support for __msg(), this can be expressed a bit more nicely, but for
> now just mitigating the problem with available means.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: fix timer/test_bad_ret subtest on test_progs-cpuv4 flavor
    https://git.kernel.org/bpf/bpf-next/c/1720c42b90c8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



