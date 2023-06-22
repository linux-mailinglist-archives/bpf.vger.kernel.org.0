Return-Path: <bpf+bounces-3135-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B69A739DF4
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 12:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD0511C2107F
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 10:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D0515AF2;
	Thu, 22 Jun 2023 10:00:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D863AA8C
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 10:00:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B87FEC433CA;
	Thu, 22 Jun 2023 10:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687428020;
	bh=t3K3YG9D1u98t4FfA1RCyaURpw39YHXxToOdXhN/APY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rQkOZCoMJsJeB972IHStGN+HWQb7GvSAzyjJbYYyRa+1ZRC4DjEZdXSzrzG2l0Ru6
	 9pARAI/wtrCUn5W5Mm1ypuJ52AcBAsnVA9wuNJyPEHljLWiYJheHbf6/lkMIf0sd1r
	 5lDAgs6PxJUoeKWFw6GQ8jvICQVVMw5dAvxlVQTGZCJM5K9Y9O3NrxNAkIpexswl+s
	 DmKi99SlJnfpjMm1SDPnjXBcOJOyEHFgY2zoBNj8sJlt5DxvvN1+6UMZW5XzQWSi9V
	 w5ZN88ZfgzRYJQqBvfZXBwqlWPoDVwtTDy6guDTNRIJ4vIGCbpdc4+jLxvxJLXUV4N
	 FKxusRyMwTPpA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 966DCC691EF;
	Thu, 22 Jun 2023 10:00:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix compilation failure for prog
 vrf_socket_lookup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168742802061.13102.13847543252562577198.git-patchwork-notify@kernel.org>
Date: Thu, 22 Jun 2023 10:00:20 +0000
References: <20230622061921.816772-1-yhs@fb.com>
In-Reply-To: <20230622061921.816772-1-yhs@fb.com>
To: Yonghong Song <yhs@fb.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed, 21 Jun 2023 23:19:21 -0700 you wrote:
> When building the latest kernel/selftest with clang17 compiler,
>     make LLVM=1 -j                                  <== for kernel
>     make -C tools/testing/selftests/bpf LLVM=1 -j   <== for selftest
> 
> I hit the following compilation error:
>   ...
>   In file included from progs/vrf_socket_lookup.c:3:
>   In file included from /usr/include/linux/ip.h:21:
>   In file included from /usr/include/asm/byteorder.h:5:
>   In file included from /usr/include/linux/byteorder/little_endian.h:13:
>   /usr/include/linux/swab.h:136:8: error: unknown type name '__always_inline'
>     136 | static __always_inline unsigned long __swab(const unsigned long y)
>         |        ^
>   /usr/include/linux/swab.h:171:8: error: unknown type name '__always_inline'
>     171 | static __always_inline __u16 __swab16p(const __u16 *p)
>         |        ^
>   /usr/include/linux/swab.h:171:29: error: expected ';' after top level declarator
>     171 | static __always_inline __u16 __swab16p(const __u16 *p)
>         |                             ^
>   ...
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Fix compilation failure for prog vrf_socket_lookup
    https://git.kernel.org/bpf/bpf-next/c/ee77f3d602b0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



