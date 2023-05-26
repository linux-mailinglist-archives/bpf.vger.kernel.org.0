Return-Path: <bpf+bounces-1258-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B69C711AEF
	for <lists+bpf@lfdr.de>; Fri, 26 May 2023 02:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9C65281672
	for <lists+bpf@lfdr.de>; Fri, 26 May 2023 00:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BA14403;
	Fri, 26 May 2023 00:00:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63502F5B
	for <bpf@vger.kernel.org>; Fri, 26 May 2023 00:00:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D803C4339B;
	Fri, 26 May 2023 00:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685059220;
	bh=oEeVe5xYiOgo83RBB5Yx62y2jD+HP/qJ3yHolwTCQSI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EGjvf0ZLRbFWsXOONoXjYepDZISLfKeiuD29rEDmsyslIyiEYSgotKA6mzgdDN+Vq
	 +EZk2049qQIC+bvfQQ/BanHnqQ41K0Y5kJ0bJUnme2jLePfiRvWFJD/9XRGnAWPUTq
	 M6BB6gUZU7jOWeWVsK1omb6GIg0u3glc4G2WZcky67hLVEM8nTu77+qmdQV+ESi/Pw
	 9Ms2Lsc6tidSlOIq3RWG+6jq1jiP7b72usUOMoLxiV/n+4ziLtE5TY7CrbSnGtNujc
	 PwTD3+pT+BnpQBy0L16q7QboC5gj8BA+xiat3yfn26+Aot7GYPknukcdhtfGDO5fiW
	 ba3hWbh9uO4yw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 416EEE4D00E;
	Fri, 26 May 2023 00:00:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Check whether to run selftest
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168505922026.4954.3536458878325504754.git-patchwork-notify@kernel.org>
Date: Fri, 26 May 2023 00:00:20 +0000
References: <20230525232248.640465-1-deso@posteo.net>
In-Reply-To: <20230525232248.640465-1-deso@posteo.net>
To: =?utf-8?q?Daniel_M=C3=BCller_=3Cdeso=40posteo=2Enet=3E?=@codeaurora.org
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 25 May 2023 23:22:48 +0000 you wrote:
> The sockopt test invokes test__start_subtest and then unconditionally
> asserts the success. That means that even if deny-listed, any test will
> still run and potentially fail.
> Evaluate the return value of test__start_subtest() to achieve the
> desired behavior, as other tests do.
> 
> Signed-off-by: Daniel Müller <deso@posteo.net>
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Check whether to run selftest
    https://git.kernel.org/bpf/bpf-next/c/321a64b32815

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



