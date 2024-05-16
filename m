Return-Path: <bpf+bounces-29884-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E12848C7F09
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 01:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DA42281971
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 23:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEDC2C6B0;
	Thu, 16 May 2024 23:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rRzehdT4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0242C698
	for <bpf@vger.kernel.org>; Thu, 16 May 2024 23:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715903431; cv=none; b=pgDtTQBgjGi+klbEyHYhFiVh4/9Q8Jz5UZUkiPJsPLK0LX58ZG3crX0ejAtXMNbiltBhI6KQ9Nmt4d8snFGAnJ5GbPB9I4/CJaPBJDtaGDo3IaKTKUHosF5SAR3Ra9WsiFUnSD/jSgH+qbNkzIPHMY0/e8TUDO03ps3xuLgcjeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715903431; c=relaxed/simple;
	bh=4+YKYUkaU+RUspYfWcQpM/ud+mbzCyugqCaKIKZNzLQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YwcAuB3WDoUYYJwBaQLsG/h68b5YECds2gLI5N0SkI4+NMLl1/NljSluSuDhU+hhMzP7e0G7Y3ObjrrxFZwXyzBqyUNvGbZBBuBtgOZCB2o8rHOa1rAD+4UK1LuEJyHkvBgFfh9Q2opje5hCmzmqX4irjg8/b8zatfLwxhVEkRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rRzehdT4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 227C3C2BD11;
	Thu, 16 May 2024 23:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715903430;
	bh=4+YKYUkaU+RUspYfWcQpM/ud+mbzCyugqCaKIKZNzLQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rRzehdT4hFFKuyQAa9KqdexjsetBgZAN6o9zWXMysz2QNV+piiivN7dBfoW9x9+Bc
	 SE1jiAyJgp0M6qeC0Z5v424IQ0edgCvgzVqKPBnBNErhZ56WtH2jeLQvWLozP5exNB
	 0RVMfTL74tt/ohKKqJrlZqCM6wOvRtzuCLSTpIFUYZPusiR68LlV1Q5ZIcK4h35sww
	 rS8Jvh/ts0hPuHtHgzyCNdis80/tAAyXQo3Da3Am4NxCmk8x8p1rNHN5AmahGU5siO
	 /dl+gK2as/IGm1Ti9TO57KKNeIGP3bWglayIuTDZmCijzEk+6749Ge6ZijbkuDC5Fr
	 axQl2Fb7Ypmvg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 15416C54BBB;
	Thu, 16 May 2024 23:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] selftests/bpf: Adjust test_access_variable_array after a
 kernel function name change
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171590343008.12220.6314181781608508306.git-patchwork-notify@kernel.org>
Date: Thu, 16 May 2024 23:50:30 +0000
References: <20240516170140.2689430-1-martin.lau@linux.dev>
In-Reply-To: <20240516170140.2689430-1-martin.lau@linux.dev>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu, 16 May 2024 10:01:40 -0700 you wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
> 
> After commit 4c3e509ea9f2 ("sched/balancing: Rename load_balance() => sched_balance_rq()"),
> the load_balance kernel function is renamed to sched_balance_rq.
> 
> This patch adjusts the fentry program in test_access_variable_array.c
> to reflect this kernel function name change.
> 
> [...]

Here is the summary with links:
  - [bpf] selftests/bpf: Adjust test_access_variable_array after a kernel function name change
    https://git.kernel.org/bpf/bpf/c/5405807edd41

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



