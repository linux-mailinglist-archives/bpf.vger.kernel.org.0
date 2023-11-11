Return-Path: <bpf+bounces-14893-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4EE7E8C90
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 21:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A259EB20A77
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 20:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DDF1D6AF;
	Sat, 11 Nov 2023 20:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bN8SDdPJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B9B1D555
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 20:21:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3EDA7C433C9;
	Sat, 11 Nov 2023 20:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699734111;
	bh=GfmoELAesXBT4CT2SxqRGsr4VdGtKIny0oA4jooRDf0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bN8SDdPJOg/NfS8zqSv8u6jM8i4rvkTZHCAOiwCizwv5AP8AojZn4WaU1T4y3Jzh/
	 E64bFmDSA6agb6ZnGsBCzWgaCCvmlUB273dScMKag1vPunrAJ/tSMMjWMvmYbj0QjJ
	 kNPB/t63Run2IFqmtFOMtR44VnTSNoVgSSIOovdqWemCKR3+6ZFSeASjgYnuUTEuf6
	 fJr6xVqyxj5YgfH6uE9Zz+7phAu9vTs8J9DwTOw6uw6NmoTXDiRTKelHNzDAwcHoAr
	 YfSmQlrBG29PCxkkOXNzwbpCDrYn9IafI2tu4o33tm5G+4fyffOpkPVRf5zbHbW8+w
	 Gwp07+4d3uhwQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 28D57E00083;
	Sat, 11 Nov 2023 20:21:51 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Fix pyperf180 compilation failure
 with clang18
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169973411116.26445.4952008382763450181.git-patchwork-notify@kernel.org>
Date: Sat, 11 Nov 2023 20:21:51 +0000
References: <20231110193644.3130906-1-yonghong.song@linux.dev>
In-Reply-To: <20231110193644.3130906-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri, 10 Nov 2023 11:36:44 -0800 you wrote:
> With latest clang18 (main branch of llvm-project repo), when building bpf selftests,
>     [~/work/bpf-next (master)]$ make -C tools/testing/selftests/bpf LLVM=1 -j
> 
> The following compilation error happens:
>     fatal error: error in backend: Branch target out of insn range
>     ...
>     Stack dump:
>     0.      Program arguments: clang -g -Wall -Werror -D__TARGET_ARCH_x86 -mlittle-endian
>       -I/home/yhs/work/bpf-next/tools/testing/selftests/bpf/tools/include
>       -I/home/yhs/work/bpf-next/tools/testing/selftests/bpf -I/home/yhs/work/bpf-next/tools/include/uapi
>       -I/home/yhs/work/bpf-next/tools/testing/selftests/usr/include -idirafter
>       /home/yhs/work/llvm-project/llvm/build.18/install/lib/clang/18/include -idirafter /usr/local/include
>       -idirafter /usr/include -Wno-compare-distinct-pointer-types -DENABLE_ATOMICS_TESTS -O2 --target=bpf
>       -c progs/pyperf180.c -mcpu=v3 -o /home/yhs/work/bpf-next/tools/testing/selftests/bpf/pyperf180.bpf.o
>     1.      <eof> parser at end of file
>     2.      Code generation
>     ...
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] selftests/bpf: Fix pyperf180 compilation failure with clang18
    https://git.kernel.org/bpf/bpf-next/c/100888fb6d8a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



