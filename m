Return-Path: <bpf+bounces-11558-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBF07BBE98
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 20:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59775282408
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 18:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AED837C95;
	Fri,  6 Oct 2023 18:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kKA6m5+e"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD35936B1D
	for <bpf@vger.kernel.org>; Fri,  6 Oct 2023 18:20:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4897FC433C7;
	Fri,  6 Oct 2023 18:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696616428;
	bh=ogX3BedWWyC2cF1wW8uFkDVW6LrxMAMflmTrglEvTKo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kKA6m5+e8Lmz7nCZRHMwRXQIArFe+B/7KFqyGaNdfWWGJAeBQUFDeW0RaoADeA3Mt
	 u6oPCJVyE7uodjDDWwNygH227STYVmrKyonSOat87bTiSY/NhaSjMeSY81u7dJjvnx
	 205m80y1FibxTYw9nBrklE8eq97x2KkRJjSR8ISGJKEUaiR8HXob8TDv1kgbATBSQQ
	 SIqITImkAuIZmQUi6dOF3K1+sKV4G0zthoNB3/ee5L6u9ONFx0JVP0neBV+QrbpvGc
	 hQV0EGfSIb8RxyUWjDzgcjU7mvBmnBD6hGVQZgLR6u75vZbIM/zvSb1IUOXgrSW4yt
	 yJRxwT9IyaZbA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 23962E632D2;
	Fri,  6 Oct 2023 18:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 1/3] selftests/bpf: fix compiler warnings reported in
 -O2 mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169661642814.9586.15213671983813224846.git-patchwork-notify@kernel.org>
Date: Fri, 06 Oct 2023 18:20:28 +0000
References: <20231004001750.2939898-1-andrii@kernel.org>
In-Reply-To: <20231004001750.2939898-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 3 Oct 2023 17:17:48 -0700 you wrote:
> Fix a bunch of potentially unitialized variable usage warnings that are
> reported by GCC in -O2 mode. Also silence overzealous stringop-truncation
> class of warnings.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  tools/testing/selftests/bpf/Makefile                      | 4 +++-
>  .../selftests/bpf/map_tests/map_in_map_batch_ops.c        | 4 ++--
>  tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c | 4 ++--
>  tools/testing/selftests/bpf/prog_tests/connect_ping.c     | 4 ++--
>  tools/testing/selftests/bpf/prog_tests/linked_list.c      | 2 +-
>  tools/testing/selftests/bpf/prog_tests/lwt_helpers.h      | 3 ++-
>  tools/testing/selftests/bpf/prog_tests/queue_stack_map.c  | 2 +-
>  tools/testing/selftests/bpf/prog_tests/sockmap_basic.c    | 8 ++++----
>  tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h  | 2 +-
>  tools/testing/selftests/bpf/prog_tests/sockmap_listen.c   | 4 ++--
>  tools/testing/selftests/bpf/prog_tests/xdp_metadata.c     | 2 +-
>  tools/testing/selftests/bpf/test_loader.c                 | 4 ++--
>  tools/testing/selftests/bpf/xdp_features.c                | 4 ++--
>  tools/testing/selftests/bpf/xdp_hw_metadata.c             | 2 +-
>  tools/testing/selftests/bpf/xskxceiver.c                  | 2 +-
>  15 files changed, 27 insertions(+), 24 deletions(-)

Here is the summary with links:
  - [bpf-next,1/3] selftests/bpf: fix compiler warnings reported in -O2 mode
    (no matching commit)
  - [bpf-next,2/3] selftests/bpf: support building selftests in optimized -O2 mode
    https://git.kernel.org/bpf/bpf-next/c/46475cc0dded
  - [bpf-next,3/3] selftests/bpf: don't truncate #test/subtest field
    https://git.kernel.org/bpf/bpf-next/c/0af3aace5b91

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



