Return-Path: <bpf+bounces-9313-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBDF7933DB
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 04:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14A9D1C2092A
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 02:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29027E4;
	Wed,  6 Sep 2023 02:50:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7334B7E
	for <bpf@vger.kernel.org>; Wed,  6 Sep 2023 02:50:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9780FC433C9;
	Wed,  6 Sep 2023 02:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693968627;
	bh=1XHRzrMMV+lnj21rzfdeP3GG0PRTjver90SOcRj/7lU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BAIb/X/DXGtOFlpd1x6e0Qzzu2aVOKBTPtMLhoNTMB7DIjx+0pW9n3bv0cZ2XxptF
	 eaQmGkg5IPQip7grskE3exmjRkjPtCEr6b9c5uMWkyUnHy2iFio7vK62guHCWD+7bU
	 0t/F24LPo/hjXhKczCSfKk/Vi7MtPKyu9p1GSfUXckoXgQAytIbXiPxJFRWjEstpZc
	 ROCqugKdxoGDJ6+l0UnlvprmtDorlXAwb4pYEd9jSjeE6CyFSRwIu/ebdJPj7Zlv1O
	 Oul6pcuvvDj5Wc1ROD+ruafEeZMlimKzMSL+mtnuF2qF56aAj3CS75kKLNF3tyiXfn
	 fISCpKN+Mi9mQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 79492C595C5;
	Wed,  6 Sep 2023 02:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 0/4] bpf,
 riscv: use BPF prog pack allocator in BPF JIT
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <169396862749.1987.4994366714692856707.git-patchwork-notify@kernel.org>
Date: Wed, 06 Sep 2023 02:50:27 +0000
References: <20230831131229.497941-1-puranjay12@gmail.com>
In-Reply-To: <20230831131229.497941-1-puranjay12@gmail.com>
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, pulehui@huawei.com,
 conor.dooley@microchip.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
 kpsingh@kernel.org, bjorn@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Thu, 31 Aug 2023 13:12:25 +0000 you wrote:
> Changes in v3 -> v4:
> 1. Add Acked-by:, Tested-by:, etc.
> 2. Add the core BPF patch[3] which was earlier sent with ARM64 series to
>    this series so it can go with this.
> 
> Changes in v2 -> v3:
> 1. Fix maximum width of code in patches from 80 to 100. [All patches]
> 2. Add checks for ctx->ro_insns == NULL. [Patch 3]
> 3. Fix check for edge condition where amount of text to set > 2 * pagesize
>    [Patch 1 and 2]
> 4. Add reviewed-by in patches.
> 5. Adding results of selftest here:
>    Using the command: ./test_progs on qemu
>    Without the series: Summary: 336/3162 PASSED, 56 SKIPPED, 90 FAILED
>    With this series: Summary: 336/3162 PASSED, 56 SKIPPED, 90 FAILED
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/4] bpf: make bpf_prog_pack allocator portable
    https://git.kernel.org/riscv/c/063119d90a06
  - [bpf-next,v4,2/4] riscv: extend patch_text_nosync() for multiple pages
    https://git.kernel.org/riscv/c/fb81d562ed1f
  - [bpf-next,v4,3/4] riscv: implement a memset like function for text
    https://git.kernel.org/riscv/c/f071fe652d73
  - [bpf-next,v4,4/4] bpf, riscv: use prog pack allocator in the BPF JIT
    https://git.kernel.org/riscv/c/19ea9d201008

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



