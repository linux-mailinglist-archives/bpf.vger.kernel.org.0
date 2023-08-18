Return-Path: <bpf+bounces-8089-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A7878102E
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 18:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F8E51C21663
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 16:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9399A19BC0;
	Fri, 18 Aug 2023 16:20:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AC61800B
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 16:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7315BC433C7;
	Fri, 18 Aug 2023 16:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692375621;
	bh=I0xURcgmAbdYaTMWeKmHqo8Q1qdrUiyBhSrBKhxvRt0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=g4h6TEAWe5VXWQ6EoGwAr4Gm5vZaJSrz+3jPpOzft3D81hPZ7c5ojjLcJ3L04UNDr
	 Av+f5zMDO6zw7LR9cX9cEdxNzpwimYWa4QxoOgpN6CXpd3yZSql2JgtchdqsZwoD1u
	 u2PPXWhwf3PKFhnliwOHAWygu8LkmqLVyKzlrLK6Rp43lATe6QrpBnTLoy3Si+tdpY
	 lRa1U6O5B9ycl53w7CI0YLx8w41XUSkH0itXwkbzY/FuaxhsR7haoLg2SAVVTOoP9X
	 mIX5BtBacef8BsPSrXY4EDJ5mFvTqGXG4vjbFVCXx8I6Kyv6jmuVt1xAmtBQhnohex
	 3MyQ/3b38W6Cw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 55EA8C395DC;
	Fri, 18 Aug 2023 16:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 bpf-next 1/2] libbpf: Support triple-underscore flavors for
 kfunc relocation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169237562134.23469.3978013203790673119.git-patchwork-notify@kernel.org>
Date: Fri, 18 Aug 2023 16:20:21 +0000
References: <20230817225353.2570845-1-davemarchevsky@fb.com>
In-Reply-To: <20230817225353.2570845-1-davemarchevsky@fb.com>
To: Dave Marchevsky <davemarchevsky@fb.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@kernel.org, kernel-team@fb.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu, 17 Aug 2023 15:53:52 -0700 you wrote:
> The function signature of kfuncs can change at any time due to their
> intentional lack of stability guarantees. As kfuncs become more widely
> used, BPF program writers will need facilities to support calling
> different versions of a kfunc from a single BPF object. Consider this
> simplified example based on a real scenario we ran into at Meta:
> 
>   /* initial kfunc signature */
>   int some_kfunc(void *ptr)
> 
> [...]

Here is the summary with links:
  - [v3,bpf-next,1/2] libbpf: Support triple-underscore flavors for kfunc relocation
    https://git.kernel.org/bpf/bpf-next/c/5964a223f5e4
  - [v3,bpf-next,2/2] selftests/bpf: Add CO-RE relocs kfunc flavors tests
    https://git.kernel.org/bpf/bpf-next/c/63ae8eb2c5b1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



