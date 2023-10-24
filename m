Return-Path: <bpf+bounces-13105-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F307D46D1
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 07:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2C191C20B51
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 05:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53AF76AA2;
	Tue, 24 Oct 2023 05:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mMeAKk8t"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B280B1863
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 05:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1744BC433C9;
	Tue, 24 Oct 2023 05:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698124224;
	bh=YB5ozb50o5OtzjQv7e/2Sk5NglBTOwJrPezph8Y7bXI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mMeAKk8t6fW2Uc5wcMVdZEpiCJQGF8ayZSNoTkkFW2pkbjFhF0u0wlOQxuK9Eccby
	 7WZAqRxpzSY3DuDWJnXA6RuU+YCDgQvPa9MXmL4jmHesAT7vRuny2/kmRXn/vuDdSr
	 ygfPjDu2JddkBS/k0cnC9E2UOu+rFkROUQ+FSJ6dCqmWbhYtee/4I56nvUnB7hIT2u
	 VP8ewBUJ74Xx0Ly2zgk1zj7jxrSP44dYVnHjgSk0un5YmgunXe2/4ilLFCgDv+NZD0
	 oLx/wCn2NMN9A4dN5RhD1aW1MzNaOBvnr1XgiFUjiaOVE9MlQm6HL6XBknYz5VwJe2
	 4iW6FkULD40Bg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F229BE4CC1B;
	Tue, 24 Oct 2023 05:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/7] exact states comparison for iterator
 convergence checks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169812422398.23324.8361385101947039883.git-patchwork-notify@kernel.org>
Date: Tue, 24 Oct 2023 05:10:23 +0000
References: <20231024000917.12153-1-eddyz87@gmail.com>
In-Reply-To: <20231024000917.12153-1-eddyz87@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, memxor@gmail.com, awerner32@gmail.com,
 john.fastabend@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 24 Oct 2023 03:09:10 +0300 you wrote:
> Iterator convergence logic in is_state_visited() uses state_equals()
> for states with branches counter > 0 to check if iterator based loop
> converges. This is not fully correct because state_equals() relies on
> presence of read and precision marks on registers. These marks are not
> guaranteed to be finalized while state has branches.
> Commit message for patch #3 describes a program that exhibits such
> behavior.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/7] bpf: move explored_state() closer to the beginning of verifier.c
    https://git.kernel.org/bpf/bpf-next/c/3c4e420cb653
  - [bpf-next,v3,2/7] bpf: extract same_callsites() as utility function
    https://git.kernel.org/bpf/bpf-next/c/4c97259abc9b
  - [bpf-next,v3,3/7] bpf: exact states comparison for iterator convergence checks
    https://git.kernel.org/bpf/bpf-next/c/2793a8b015f7
  - [bpf-next,v3,4/7] selftests/bpf: tests with delayed read/precision makrs in loop body
    https://git.kernel.org/bpf/bpf-next/c/389ede06c297
  - [bpf-next,v3,5/7] bpf: correct loop detection for iterators convergence
    https://git.kernel.org/bpf/bpf-next/c/2a0992829ea3
  - [bpf-next,v3,6/7] selftests/bpf: test if state loops are detected in a tricky case
    https://git.kernel.org/bpf/bpf-next/c/64870feebecb
  - [bpf-next,v3,7/7] bpf: print full verifier states on infinite loop detection
    https://git.kernel.org/bpf/bpf-next/c/b4d8239534fd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



