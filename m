Return-Path: <bpf+bounces-6214-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF1A767155
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 18:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44B9F2827A9
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 16:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DE11429B;
	Fri, 28 Jul 2023 16:00:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CA914013
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 16:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 06B70C433CA;
	Fri, 28 Jul 2023 16:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690560022;
	bh=sXyn2a588IKkKfwywYoOCOa5+61dh2DtCVtsVLLgshE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JKUrruMjDYxFKI3uSqNpnFMZkbHf2t8PPSNAYrYsJktTs7p0sEvCRKVSlYujFdR1q
	 E9n7Cq/rCPYeLkUGsuiQpfRuxXLIm1stB7zCjhR6rJr9Jelp2S6b7+B5ch5FvGv1CY
	 pybMmvlvzTmyysvDnhlSF0Kajd6Sw1mN1kganJQfYERivKG8SqyGYgCrCx2dwjT5vN
	 4I0zMwFkt+cLQbKUnj3byHUv3628LSWx9sblEgKtBKlW8AvyHH4nwP02n3c4VZlhFF
	 fxicjnK6Z5nUuJVCVQXwKOpVEO69cyZIe2PmmkLiYVUzu0v8IcpIY3sJouukUz/sJ2
	 sIJjcYEmKpPlA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DDECBE1CF31;
	Fri, 28 Jul 2023 16:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 1/2] bpf: Fix compilation warning with -Wparentheses
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169056002190.17152.2704300359734171993.git-patchwork-notify@kernel.org>
Date: Fri, 28 Jul 2023 16:00:21 +0000
References: <20230728055740.2284534-1-yonghong.song@linux.dev>
In-Reply-To: <20230728055740.2284534-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org,
 lkp@intel.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 27 Jul 2023 22:57:40 -0700 you wrote:
> The kernel test robot reported compilation warnings when -Wparentheses is
> added to KBUILD_CFLAGS with gcc compiler. The following is the error message:
> 
>   .../bpf-next/kernel/bpf/verifier.c: In function ‘coerce_reg_to_size_sx’:
>   .../bpf-next/kernel/bpf/verifier.c:5901:14:
>     error: suggest parentheses around comparison in operand of ‘==’ [-Werror=parentheses]
>     if (s64_max >= 0 == s64_min >= 0) {
>         ~~~~~~~~^~~~
>   .../bpf-next/kernel/bpf/verifier.c: In function ‘coerce_subreg_to_size_sx’:
>   .../bpf-next/kernel/bpf/verifier.c:5965:14:
>     error: suggest parentheses around comparison in operand of ‘==’ [-Werror=parentheses]
>     if (s32_min >= 0 == s32_max >= 0) {
>         ~~~~~~~~^~~~
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpf: Fix compilation warning with -Wparentheses
    https://git.kernel.org/bpf/bpf-next/c/09fedc731874
  - [bpf-next,2/2] selftests/bpf: Enable test test_progs-cpuv4 for gcc build kernel
    https://git.kernel.org/bpf/bpf-next/c/a76584fc9ff6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



