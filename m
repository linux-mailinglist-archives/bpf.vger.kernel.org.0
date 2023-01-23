Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C31678747
	for <lists+bpf@lfdr.de>; Mon, 23 Jan 2023 21:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbjAWUKY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Jan 2023 15:10:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbjAWUKY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Jan 2023 15:10:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635D933470
        for <bpf@vger.kernel.org>; Mon, 23 Jan 2023 12:10:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1338AB80E94
        for <bpf@vger.kernel.org>; Mon, 23 Jan 2023 20:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BCC67C4339B;
        Mon, 23 Jan 2023 20:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674504619;
        bh=lz8le6u5gtU53QxR72VhKKBaNV0jDnxdo96++4F9Uy4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ROMDgCGBbFCrDbTKVSmnCggeViBaMQ0iCe+2pOAsLB8LUe6cX+pZ1vZkYTxjxpHaW
         Vo8rewzO5suAH9iUliQmvonpPuOblWEPUwQXEykewRtADyW2hX0wS3bZrSkPsIpAqB
         yImY9iHkr7/xtniDfIOeZs0HbmKZaWTY6FC/MGHcmbm6p/4IRtSGCwmVer4H+HKqsM
         5/JghYYmqUxG6pkGIszpkBq8TMcwPXpjgs5EMoceBuWqCiUR4CmFt16XSD9oLIw9is
         MyAocVpbYzr10LD4RDJaLKnJY4Y1xti9ygQtixxvpOuyU6IKr2ZWrGPMplOsLp3d9n
         VphnBnlvuw5dQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A0D3CC5C7D4;
        Mon, 23 Jan 2023 20:10:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next 00/25] libbpf: extend [ku]probe and syscall
 argument tracing support
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167450461965.9309.12572725678017801706.git-patchwork-notify@kernel.org>
Date:   Mon, 23 Jan 2023 20:10:19 +0000
References: <20230120200914.3008030-1-andrii@kernel.org>
In-Reply-To: <20230120200914.3008030-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Fri, 20 Jan 2023 12:08:49 -0800 you wrote:
> This patch set fixes and extends libbpf's bpf_tracing.h support for tracing
> arguments of kprobes/uprobes, and syscall as a special case.
> 
> Depending on the architecture, anywhere between 3 and 8 arguments can be
> passed to a function in registers (so relevant to kprobes and uprobes), but
> before this patch set libbpf's macros in bpf_tracing.h only supported up to
> 5 arguments, which is limiting in practice. This patch set extends
> bpf_tracing.h to support up to 8 arguments, if architecture allows. This
> includes explicit PT_REGS_PARMx() macro family, as well as BPF_KPROBE() macro.
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next,01/25] libbpf: add support for fetching up to 8 arguments in kprobes
    https://git.kernel.org/bpf/bpf-next/c/3c59623d8294
  - [v2,bpf-next,02/25] libbpf: add 6th argument support for x86-64 in bpf_tracing.h
    https://git.kernel.org/bpf/bpf-next/c/013290329a07
  - [v2,bpf-next,03/25] libbpf: fix arm and arm64 specs in bpf_tracing.h
    https://git.kernel.org/bpf/bpf-next/c/1dac40ac8742
  - [v2,bpf-next,04/25] libbpf: complete mips spec in bpf_tracing.h
    https://git.kernel.org/bpf/bpf-next/c/1222445a5bf6
  - [v2,bpf-next,05/25] libbpf: complete powerpc spec in bpf_tracing.h
    https://git.kernel.org/bpf/bpf-next/c/2eb2be30b8da
  - [v2,bpf-next,06/25] libbpf: complete sparc spec in bpf_tracing.h
    https://git.kernel.org/bpf/bpf-next/c/7f60f5d85e29
  - [v2,bpf-next,07/25] libbpf: complete riscv arch spec in bpf_tracing.h
    https://git.kernel.org/bpf/bpf-next/c/b13ed8ca7fba
  - [v2,bpf-next,08/25] libbpf: fix and complete ARC spec in bpf_tracing.h
    https://git.kernel.org/bpf/bpf-next/c/0ac086567916
  - [v2,bpf-next,09/25] libbpf: complete LoongArch (loongarch) spec in bpf_tracing.h
    https://git.kernel.org/bpf/bpf-next/c/55ff00d5393b
  - [v2,bpf-next,10/25] libbpf: add BPF_UPROBE and BPF_URETPROBE macro aliases
    https://git.kernel.org/bpf/bpf-next/c/ac4afd6e6fa4
  - [v2,bpf-next,11/25] selftests/bpf: validate arch-specific argument registers limits
    https://git.kernel.org/bpf/bpf-next/c/bc72742bebec
  - [v2,bpf-next,12/25] libbpf: improve syscall tracing support in bpf_tracing.h
    https://git.kernel.org/bpf/bpf-next/c/8ccabeef9133
  - [v2,bpf-next,13/25] libbpf: define x86-64 syscall regs spec in bpf_tracing.h
    https://git.kernel.org/bpf/bpf-next/c/d21fbceedd90
  - [v2,bpf-next,14/25] libbpf: define i386 syscall regs spec in bpf_tracing.h
    https://git.kernel.org/bpf/bpf-next/c/ff00f9cbd2dd
  - [v2,bpf-next,15/25] libbpf: define s390x syscall regs spec in bpf_tracing.h
    https://git.kernel.org/bpf/bpf-next/c/e82b96a3a99f
  - [v2,bpf-next,16/25] libbpf: define arm syscall regs spec in bpf_tracing.h
    https://git.kernel.org/bpf/bpf-next/c/3a95c42d65d5
  - [v2,bpf-next,17/25] libbpf: define arm64 syscall regs spec in bpf_tracing.h
    https://git.kernel.org/bpf/bpf-next/c/3488ea0584bb
  - [v2,bpf-next,18/25] libbpf: define mips syscall regs spec in bpf_tracing.h
    https://git.kernel.org/bpf/bpf-next/c/cfd0bbe91536
  - [v2,bpf-next,19/25] libbpf: define powerpc syscall regs spec in bpf_tracing.h
    https://git.kernel.org/bpf/bpf-next/c/c1cc01a2d1d1
  - [v2,bpf-next,20/25] libbpf: define sparc syscall regs spec in bpf_tracing.h
    https://git.kernel.org/bpf/bpf-next/c/377c15b1a2cd
  - [v2,bpf-next,21/25] libbpf: define riscv syscall regs spec in bpf_tracing.h
    https://git.kernel.org/bpf/bpf-next/c/a0426216a320
  - [v2,bpf-next,22/25] libbpf: define arc syscall regs spec in bpf_tracing.h
    https://git.kernel.org/bpf/bpf-next/c/2cf802737fb9
  - [v2,bpf-next,23/25] libbpf: define loongarch syscall regs spec in bpf_tracing.h
    https://git.kernel.org/bpf/bpf-next/c/12a299f0b5c7
  - [v2,bpf-next,24/25] selftests/bpf: add 6-argument syscall tracing test
    https://git.kernel.org/bpf/bpf-next/c/92dc5cdfc113
  - [v2,bpf-next,25/25] libbpf: clean up now not needed __PT_PARM{1-6}_SYSCALL_REG defaults
    https://git.kernel.org/bpf/bpf-next/c/a4d325ae461c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


