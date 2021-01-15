Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 124BE2F70E6
	for <lists+bpf@lfdr.de>; Fri, 15 Jan 2021 04:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728941AbhAODUw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jan 2021 22:20:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:59240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726680AbhAODUw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jan 2021 22:20:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 5415423AF8;
        Fri, 15 Jan 2021 03:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610680811;
        bh=ES+nTnJm0IFUEtB4abod7MaMYvzm7eZs5Ug9EnNUrzk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Qn7Z1vomK1ovrWATXzpJxg14mkrEIqEFDNgDOcFbD9ZGA1//dH6hgl5m9qrcLL/Ds
         jO74fo9ZzydgCrvYsa+M6N6tRxMe/U1ZljD2vzUIuQqcWCwItEPNZhxIlSy4TaOKk9
         k/x0XGqw/YiMlMOiC68oZbHp7Yy/gkcYuLb901RfV3TuHzpluUXXR+SdRDn7rmbiZx
         VW65YgwFKm2PcBkx4acanRbg5pGc8fznzHJh3j+dy9wLwcX0CQJwtIXO9x6HsfrDHd
         v7pQIUQsO0qtNszL9hqLENEsvEkqsfeADRLWb/mXmKu73dIBJN5Z5pZ9NYHhmpAD/q
         /W1qzpCE+OPQQ==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id 4466560593;
        Fri, 15 Jan 2021 03:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v7 00/11] Atomics for eBPF
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <161068081127.31171.9881171165657738876.git-patchwork-notify@kernel.org>
Date:   Fri, 15 Jan 2021 03:20:11 +0000
References: <20210114181751.768687-1-jackmanb@google.com>
In-Reply-To: <20210114181751.768687-1-jackmanb@google.com>
To:     Brendan Jackman <jackmanb@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii.nakryiko@gmail.com, kpsingh@chromium.org,
        revest@chromium.org, linux-kernel@vger.kernel.org,
        bjorn.topel@gmail.com, john.fastabend@gmail.com, yhs@fb.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (refs/heads/master):

On Thu, 14 Jan 2021 18:17:40 +0000 you wrote:
> There's still one unresolved review comment from John[3] which I
> will resolve with a followup patch.
> 
> Differences from v6->v7 [1]:
> 
> * Fixed riscv build error detected by 0-day robot.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v7,01/11] bpf: x86: Factor out emission of ModR/M for *(reg + off)
    https://git.kernel.org/bpf/bpf-next/c/11c11d0751fc
  - [bpf-next,v7,02/11] bpf: x86: Factor out emission of REX byte
    https://git.kernel.org/bpf/bpf-next/c/74007cfc1f71
  - [bpf-next,v7,03/11] bpf: x86: Factor out a lookup table for some ALU opcodes
    https://git.kernel.org/bpf/bpf-next/c/e5f02caccfae
  - [bpf-next,v7,04/11] bpf: Rename BPF_XADD and prepare to encode other atomics in .imm
    https://git.kernel.org/bpf/bpf-next/c/91c960b00566
  - [bpf-next,v7,05/11] bpf: Move BPF_STX reserved field check into BPF_STX verifier code
    https://git.kernel.org/bpf/bpf-next/c/c5bcb5eb4db6
  - [bpf-next,v7,06/11] bpf: Add BPF_FETCH field / create atomic_fetch_add instruction
    https://git.kernel.org/bpf/bpf-next/c/5ca419f2864a
  - [bpf-next,v7,07/11] bpf: Add instructions for atomic_[cmp]xchg
    https://git.kernel.org/bpf/bpf-next/c/5ffa25502b5a
  - [bpf-next,v7,08/11] bpf: Pull out a macro for interpreting atomic ALU operations
    https://git.kernel.org/bpf/bpf-next/c/462910670e4a
  - [bpf-next,v7,09/11] bpf: Add bitwise atomic instructions
    https://git.kernel.org/bpf/bpf-next/c/981f94c3e921
  - [bpf-next,v7,10/11] bpf: Add tests for new BPF atomic operations
    https://git.kernel.org/bpf/bpf-next/c/98d666d05a1d
  - [bpf-next,v7,11/11] bpf: Document new atomic instructions
    https://git.kernel.org/bpf/bpf-next/c/de948576f8e7

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


