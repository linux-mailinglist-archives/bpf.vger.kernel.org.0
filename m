Return-Path: <bpf+bounces-1890-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8811C723357
	for <lists+bpf@lfdr.de>; Tue,  6 Jun 2023 00:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE9BC1C20DAB
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 22:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F0E27200;
	Mon,  5 Jun 2023 22:50:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000FD37F
	for <bpf@vger.kernel.org>; Mon,  5 Jun 2023 22:50:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 51C01C4339B;
	Mon,  5 Jun 2023 22:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686005420;
	bh=JUpK/G8XP/C+LoyHL8gca1CSDBYC7WS02XYWws9OfWo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PZl5eRmcee/5MINq7bBaecodDOxqPx4LfuN40+BrPv0ZlACWu4ZT8L0uBIe06y19S
	 NS7yyg8fThXnP2bvwP8MzAaG4xrAAqRXZs4ZagUAkOwyULE1mwV6rwfS0/6fMRo1zx
	 DXXKrhUgvCSANYAcVNAuzJ0pGataAJcXwkzkx25/ok8nut5ZqwiUKR5iMJ36Hz3Jhk
	 fbWcXukmVA1PI0f5z6rFNM89todaaWYKN9/FhelaYGw7PeEMi/LHUhHevy0lHnSnKV
	 ab8ciiXg+9b1ABzZgI4bEYCDQfTtcssT+M/z+EgWQii/kzZ+ZkbpaFvVIoP2oXEnXX
	 Aw8sm3k+pK57w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 33C58E4F0A7;
	Mon,  5 Jun 2023 22:50:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] tools/resolve_btfids: fix setting HOSTCFLAGS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168600542020.23821.4344558119805146993.git-patchwork-notify@kernel.org>
Date: Mon, 05 Jun 2023 22:50:20 +0000
References: <20230530123352.1308488-1-vmalik@redhat.com>
In-Reply-To: <20230530123352.1308488-1-vmalik@redhat.com>
To: Viktor Malik <vmalik@redhat.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, irogers@google.com,
 shen_jiamin@comp.nus.edu.sg

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 30 May 2023 14:33:52 +0200 you wrote:
> Building BPF selftests with custom HOSTCFLAGS yields an error:
> 
>     # make HOSTCFLAGS="-O2"
>     [...]
>       HOSTCC  ./tools/testing/selftests/bpf/tools/build/resolve_btfids/main.o
>     main.c:73:10: fatal error: linux/rbtree.h: No such file or directory
>        73 | #include <linux/rbtree.h>
>           |          ^~~~~~~~~~~~~~~~
> 
> [...]

Here is the summary with links:
  - [bpf-next] tools/resolve_btfids: fix setting HOSTCFLAGS
    https://git.kernel.org/bpf/bpf-next/c/edd75c802855

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



