Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBF9B441DFE
	for <lists+bpf@lfdr.de>; Mon,  1 Nov 2021 17:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbhKAQWm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Nov 2021 12:22:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:44552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232683AbhKAQWm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Nov 2021 12:22:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id B0C9661154;
        Mon,  1 Nov 2021 16:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635783608;
        bh=WBH5x2sQl+H3hGdk/mI4v0/FbeLdnVzHPnqeavXRrFs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=PjF8TodNsj/Xujg0l9Km00KmeSb33FuUJHSRkDBPX0lfsnEqA+0BjROa4646BsHgO
         YO+pFJ3bqmxDBCKXhsQexUU+DmqU70HnP1lHeozwIDRM+Pjc6oTtBLitxryFZtGbu+
         yqj7mjNsIzBXyvlHHNqkcS6no3ZSbXKHtZtl4M+UGYKCGdBgg5uLo3bZZxAGg6z9oW
         WjkoteKsi4XhuYG+dml/b3Hwu0L3sYToEKq8uUUasE/Y5wA2fpY86ctmFXjNT7G11R
         YQaRvZ7+WkUWm2DNhnsPUlCghyEBusVctinz3tzFIOwo0dQnAZra4SzIdsBLYumqpl
         PvA9YwYvj8MZg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id A462060A90;
        Mon,  1 Nov 2021 16:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: fix strobemeta selftest regression
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <163578360866.18867.12937578535017333186.git-patchwork-notify@kernel.org>
Date:   Mon, 01 Nov 2021 16:20:08 +0000
References: <20211029182907.166910-1-andrii@kernel.org>
In-Reply-To: <20211029182907.166910-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Fri, 29 Oct 2021 11:29:07 -0700 you wrote:
> After most recent nightly Clang update strobemeta selftests started
> failing with the following error (relevant portion of assembly included):
> 
>   1624: (85) call bpf_probe_read_user_str#114
>   1625: (bf) r1 = r0
>   1626: (18) r2 = 0xfffffffe
>   1628: (5f) r1 &= r2
>   1629: (55) if r1 != 0x0 goto pc+7
>   1630: (07) r9 += 104
>   1631: (6b) *(u16 *)(r9 +0) = r0
>   1632: (67) r0 <<= 32
>   1633: (77) r0 >>= 32
>   1634: (79) r1 = *(u64 *)(r10 -456)
>   1635: (0f) r1 += r0
>   1636: (7b) *(u64 *)(r10 -456) = r1
>   1637: (79) r1 = *(u64 *)(r10 -368)
>   1638: (c5) if r1 s< 0x1 goto pc+778
>   1639: (bf) r6 = r8
>   1640: (0f) r6 += r7
>   1641: (b4) w1 = 0
>   1642: (6b) *(u16 *)(r6 +108) = r1
>   1643: (79) r3 = *(u64 *)(r10 -352)
>   1644: (79) r9 = *(u64 *)(r10 -456)
>   1645: (bf) r1 = r9
>   1646: (b4) w2 = 1
>   1647: (85) call bpf_probe_read_user_str#114
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: fix strobemeta selftest regression
    https://git.kernel.org/bpf/bpf-next/c/0133c20480b1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


