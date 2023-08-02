Return-Path: <bpf+bounces-6756-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F88C76D962
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 23:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5966B1C21258
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 21:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD9A125D4;
	Wed,  2 Aug 2023 21:20:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF68B101FC
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 21:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 44973C433C9;
	Wed,  2 Aug 2023 21:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691011221;
	bh=PHuX0utjhqzEQg8OB1w4qikGmM4KBBYjc+Tmuzrxblc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BDmm1078C49x2CVy4zAn582A1B6Ylpa9jq8+ebJiPIX5YOTJfDTayK30GpkfoTcn3
	 4r9EBAeVuOH6vgylP7JR2LH4S5VM3HIlcA4wWmPJY4O4SyEnwzEayw4wNMujMZA4J3
	 uISFahRBKUGWxQqgidLeOqhd4HdW+X6k2/kNsa55dEMBbvzZJ6e9WJUDjxQoNgDZUN
	 VyAq7ZfPDWKnqGc0A0+LrI4p5d+kuyHHAWYMJ+vABUzwQIGH97lbejSouqj8Xka8qQ
	 V2IQ3sBZqJk7ejyWumVh6dYn1OOVt1T3YDvpGlnlv8wD8dIPU2paYEbi3VYXgO6ids
	 DlMn4G5S+YrtQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 26B4EE96ABD;
	Wed,  2 Aug 2023 21:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf] selftests/bpf: fix static assert compilation issue for
 test_cls_*.c
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169101122115.28051.16510564953155235362.git-patchwork-notify@kernel.org>
Date: Wed, 02 Aug 2023 21:20:21 +0000
References: <20230802073906.3197480-1-alan.maguire@oracle.com>
In-Reply-To: <20230802073906.3197480-1-alan.maguire@oracle.com>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: yhs@fb.com, ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
 bpf@vger.kernel.org, colm.harrington@oracle.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed,  2 Aug 2023 08:39:06 +0100 you wrote:
> commit bdeeed3498c7 ("libbpf: fix offsetof() and container_of() to work with CO-RE")
> 
> ...was backported to stable trees such as 5.15. The problem is that with older
> LLVM/clang (14/15) - which is often used for older kernels - we see compilation
> failures in BPF selftests now:
> 
> In file included from progs/test_cls_redirect_subprogs.c:2:
> progs/test_cls_redirect.c:90:2: error: static assertion expression is not an integral constant expression
>         sizeof(flow_ports_t) !=
>         ^~~~~~~~~~~~~~~~~~~~~~~
> progs/test_cls_redirect.c:91:3: note: cast that performs the conversions of a reinterpret_cast is not allowed in a constant expression
>                 offsetofend(struct bpf_sock_tuple, ipv4.dport) -
>                 ^
> progs/test_cls_redirect.c:32:3: note: expanded from macro 'offsetofend'
>         (offsetof(TYPE, MEMBER) + sizeof((((TYPE *)0)->MEMBER)))
>          ^
> tools/testing/selftests/bpf/tools/include/bpf/bpf_helpers.h:86:33: note: expanded from macro 'offsetof'
>                                  ^
> In file included from progs/test_cls_redirect_subprogs.c:2:
> progs/test_cls_redirect.c:95:2: error: static assertion expression is not an integral constant expression
>         sizeof(flow_ports_t) !=
>         ^~~~~~~~~~~~~~~~~~~~~~~
> progs/test_cls_redirect.c:96:3: note: cast that performs the conversions of a reinterpret_cast is not allowed in a constant expression
>                 offsetofend(struct bpf_sock_tuple, ipv6.dport) -
>                 ^
> progs/test_cls_redirect.c:32:3: note: expanded from macro 'offsetofend'
>         (offsetof(TYPE, MEMBER) + sizeof((((TYPE *)0)->MEMBER)))
>          ^
> tools/testing/selftests/bpf/tools/include/bpf/bpf_helpers.h:86:33: note: expanded from macro 'offsetof'
>                                  ^
> 2 errors generated.
> make: *** [Makefile:594: tools/testing/selftests/bpf/test_cls_redirect_subprogs.bpf.o] Error 1
> 
> [...]

Here is the summary with links:
  - [v2,bpf] selftests/bpf: fix static assert compilation issue for test_cls_*.c
    https://git.kernel.org/bpf/bpf-next/c/416c6d01244e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



