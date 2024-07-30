Return-Path: <bpf+bounces-36094-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 523E59421DB
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 22:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED5701F2548B
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 20:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D339A18E02F;
	Tue, 30 Jul 2024 20:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BFAw3mF/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C10D15FCED
	for <bpf@vger.kernel.org>; Tue, 30 Jul 2024 20:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722372633; cv=none; b=TD3ZqdAUaCUWo7zGylEfEk8HkHE7cbZeEcdeNas6E+TGIQxREWZycCQWRwlY0TUey8MYLtaUqGvvWpLOKT7UVxf7gRxbBxuNIju/ghtZpglAP9W6WE1U7RWF9ZhLj14L9UyPNGCm1MMlb9iy4LW0eairAcoDH196jjG2XxixPoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722372633; c=relaxed/simple;
	bh=rqxtZbr4wZs08pqfTsGEcSytO5teCeFJ1ofHlNnAfGQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=q5dW1izQuAlLmf3f01Sr3iJGWHbMkNjnjF7Z85LaT9VH4qtu0VvmuUoRWclFRdQ5yeGc1Gnw1XNUMunmAH2cc29QQEbSjGKJ+LaUZz4/LUjHgkQuMDgteoKb2EB4PpA/zSNbDkyGOS+Uuv6GRo/uQTuBhbNDEdgEoPMZxPYd9fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BFAw3mF/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 333BAC4AF09;
	Tue, 30 Jul 2024 20:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722372631;
	bh=rqxtZbr4wZs08pqfTsGEcSytO5teCeFJ1ofHlNnAfGQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BFAw3mF/fx4nEtGenvUp+Qr4DwUawtmmu13Y1FG2oSyLzuQGHxD1nqmDQaVAR7VZ3
	 wlHZIYMoD/aHrqsvnssHaqlNWFpE61/lkevTIy1M6wrLagyXwvP2sP96c+6dHHBIwe
	 oRQu5FK6NKxUijDFwe2Jv2+JnHG6ENH8WW0tQkDo7Z4S2PJIf5spjDVLD0tVmqaoni
	 Y017M5YBdIwlW2Xxbjgxdc5i1F+m4lbXmf8bBr/pRZg+P+EPd9puISJdIG5X5/pZuT
	 9yRJVksHN6wnaRAzA2oHCIN9YyAQY+mDsIMOJToZN+OWpyFi679DzEqTqim8FZuYCS
	 jbE445S0vpZyQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0F714C43140;
	Tue, 30 Jul 2024 20:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf/selftests: Fix ASSERT_OK condition check in
 uprobe_syscall test
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172237263105.10299.8177231821913240519.git-patchwork-notify@kernel.org>
Date: Tue, 30 Jul 2024 20:50:31 +0000
References: <20240726180847.684584-1-jolsa@kernel.org>
In-Reply-To: <20240726180847.684584-1-jolsa@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 bpf@vger.kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@chromium.org, sdf@google.com,
 haoluo@google.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri, 26 Jul 2024 20:08:47 +0200 you wrote:
> Fixing ASSERT_OK condition check in uprobe_syscall test,
> otherwise we return from test on pipe success.
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [bpf] bpf/selftests: Fix ASSERT_OK condition check in uprobe_syscall test
    https://git.kernel.org/bpf/bpf/c/7764b9622db4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



