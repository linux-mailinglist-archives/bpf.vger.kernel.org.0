Return-Path: <bpf+bounces-11403-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3617B8E39
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 22:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 12C752820E0
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 20:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545AA22F16;
	Wed,  4 Oct 2023 20:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GpfoRLTt"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E8B219F2;
	Wed,  4 Oct 2023 20:40:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 34070C433C7;
	Wed,  4 Oct 2023 20:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696452028;
	bh=9yZh2beLb9G2aKpM6U7zBwPSD2FoKcYtlW6kX68GteU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GpfoRLTt6lNmVwofbWMhFGJxZ82HcDCnBclDn3BiHTGVC2EMtiOR6DfEUsPdCfzUw
	 cfVlMOixBU8LEKwB8yg1gvR/3BWMeE5zwvyBhv02z3h9DlMLEBJe2OjOYcOL56Stsy
	 8F3eOcxrVdyiiDdD1vx18RRAF8tKPyefmV3OleIjCDkjvavNSNE3w2VucDIe4rGxS4
	 Mj46nrbflO6qS+K9Sz04L5NIQI5CIEHQWAoa5znvmoQxlj829ML08rd/VS3JTWGKMN
	 M3Y6zdnYdHeLFrZmTA4YgYm8cW5GHfjxhpCnHA5JM5m6OAUAOHM3GU3JHu6AyxUeVD
	 fY9z58Em1TiIA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 158A0C595D2;
	Wed,  4 Oct 2023 20:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/3] selftest/bpf,
 riscv: Improved cross-building support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169645202808.14504.11589049001858545591.git-patchwork-notify@kernel.org>
Date: Wed, 04 Oct 2023 20:40:28 +0000
References: <20231004122721.54525-1-bjorn@kernel.org>
In-Reply-To: <20231004122721.54525-1-bjorn@kernel.org>
To: =?utf-8?b?QmrDtnJuIFTDtnBlbCA8Ympvcm5Aa2VybmVsLm9yZz4=?=@codeaurora.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, mykolal@fb.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org, bjorn@rivosinc.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed,  4 Oct 2023 14:27:18 +0200 you wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
> 
> Yet another "more cross-building support for RISC-V" series.
> 
> An example how to invoke a gen_tar build:
> 
>   | make ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- CC=riscv64-linux-gnu-gcc \
>   |    HOSTCC=gcc O=/workspace/kbuild FORMAT= \
>   |    SKIP_TARGETS="arm64 ia64 powerpc sparc64 x86 sgx" -j $(($(nproc)-1)) \
>   |    -C tools/testing/selftests gen_tar
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/3] selftests/bpf: Add cross-build support for urandom_read et al
    https://git.kernel.org/bpf/bpf-next/c/97a79e502e25
  - [bpf-next,2/3] selftests/bpf: Enable lld usage for RISC-V
    https://git.kernel.org/bpf/bpf-next/c/72fae6319962
  - [bpf-next,3/3] selftests/bpf: Add uprobe_multi to gen_tar target
    https://git.kernel.org/bpf/bpf-next/c/e096ab9d9f45

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



