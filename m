Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11AE4AAC79
	for <lists+bpf@lfdr.de>; Sat,  5 Feb 2022 21:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234332AbiBEUaM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 5 Feb 2022 15:30:12 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:45818 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232428AbiBEUaM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 5 Feb 2022 15:30:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3864612E3
        for <bpf@vger.kernel.org>; Sat,  5 Feb 2022 20:30:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 31644C340EF;
        Sat,  5 Feb 2022 20:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644093011;
        bh=nRXWZzNCtiW8KMUCmjnrqK5WMU81UIQOhlFvqpiu+Gw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=in6jGMp+Nf/ZuRleyeMqE48wWaUS67WiZgQgwjQCqI0TyrndTlWHIDeTlvy8NATI+
         bZA1ck5nVdADd1gcHByuXEuTC7Rzb+FVVoYFFwCsp2XU3z62b4+2RIhUg6/Mpd6nW1
         TXf6i5/08SIq3EBkFBPyavOBcbj4X/iiZuskN8hgKWjojPJks0uhK9ck2hNwGDqMNa
         e79ShKKabHY+HU45TW8hewK3o1t6FuYQsiN9s+BwmVMc9zaXECEyd5QCJahyEq8Kwg
         cy3OGYe0aNDUBY2TzHfBcKCF9zP0tliZfVQVYGYW2Ntt+4kNjZH7rEFDcjaWM5+K8d
         DJbZ+GojNALmw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1BC26E6BB30;
        Sat,  5 Feb 2022 20:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 00/11] libbpf: Fix accessing syscall arguments
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164409301110.21063.11730421603542210576.git-patchwork-notify@kernel.org>
Date:   Sat, 05 Feb 2022 20:30:11 +0000
References: <20220204145018.1983773-1-iii@linux.ibm.com>
In-Reply-To: <20220204145018.1983773-1-iii@linux.ibm.com>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii.nakryiko@gmail.com,
        hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@linux.ibm.com,
        agordeev@linux.ibm.com, catalin.marinas@arm.com,
        mpe@ellerman.id.au, paul.walmsley@sifive.com,
        naveen.n.rao@linux.vnet.ibm.com, bpf@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri,  4 Feb 2022 15:50:07 +0100 you wrote:
> libbpf now has macros to access syscall arguments in an
> architecture-agnostic manner, but unfortunately they have a number of
> issues on non-Intel arches, which this series aims to fix.
> 
> v1: https://lore.kernel.org/bpf/20220201234200.1836443-1-iii@linux.ibm.com/
> v1 -> v2:
> * Put orig_gpr2 in place of args[1] on s390 (Vasily).
> * Fix arm64, powerpc and riscv (Heiko).
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,01/11] arm64/bpf: Add orig_x0 to user_pt_regs
    https://git.kernel.org/bpf/bpf-next/c/d473f4062165
  - [bpf-next,v3,02/11] s390/bpf: Add orig_gpr2 to user_pt_regs
    https://git.kernel.org/bpf/bpf-next/c/61f88e88f263
  - [bpf-next,v3,03/11] selftests/bpf: Fix an endianness issue in bpf_syscall_macro test
    https://git.kernel.org/bpf/bpf-next/c/a936c141cbe4
  - [bpf-next,v3,04/11] libbpf: Add __PT_PARM1_REG_SYSCALL macro
    https://git.kernel.org/bpf/bpf-next/c/3a9d84aafb8c
  - [bpf-next,v3,05/11] libbpf: Add PT_REGS_SYSCALL_REGS macro
    https://git.kernel.org/bpf/bpf-next/c/b62a862d42f5
  - [bpf-next,v3,06/11] selftests/bpf: Use PT_REGS_SYSCALL_REGS in bpf_syscall_macro
    https://git.kernel.org/bpf/bpf-next/c/730809c15ac2
  - [bpf-next,v3,07/11] libbpf: Fix accessing the first syscall argument on arm64
    https://git.kernel.org/bpf/bpf-next/c/8b9b06ad4726
  - [bpf-next,v3,08/11] libbpf: Fix accessing syscall arguments on powerpc
    https://git.kernel.org/bpf/bpf-next/c/f5af16d0ae28
  - [bpf-next,v3,09/11] libbpf: Fix accessing program counter on riscv
    https://git.kernel.org/bpf/bpf-next/c/27870c91b5c7
  - [bpf-next,v3,10/11] libbpf: Fix accessing syscall arguments on riscv
    https://git.kernel.org/bpf/bpf-next/c/5860b82236c6
  - [bpf-next,v3,11/11] libbpf: Fix accessing the first syscall argument on s390
    https://git.kernel.org/bpf/bpf-next/c/088d6aafd5bb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


