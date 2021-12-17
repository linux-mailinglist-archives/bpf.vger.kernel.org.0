Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64EAD4796FC
	for <lists+bpf@lfdr.de>; Fri, 17 Dec 2021 23:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbhLQWUP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Dec 2021 17:20:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbhLQWUO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Dec 2021 17:20:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69EDC061574
        for <bpf@vger.kernel.org>; Fri, 17 Dec 2021 14:20:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ABD25B82B1E
        for <bpf@vger.kernel.org>; Fri, 17 Dec 2021 22:20:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7C766C36AEB;
        Fri, 17 Dec 2021 22:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639779611;
        bh=x52AuQG2ulgCUPhyqfeJO3uwoszXz14UMZKO5BqDuRc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=hROsiMIyW4Z/fA+N8SNqJkggZ8eRG+adCtBsIArtcUESB0+O7I1RaUtdJ8r5soylH
         ijhDYMH++cOX6ZGeJVfxnpeZ2kJG2qtVkLjVe2hCWKyjvDXhhx5USKqti2cpx6AkTy
         vPIW4kgIa1pjZBTCYUugPm91kwpoLlvtlfF9MSy4mCV2RxZKiH5Y+npHuJVEIEyN1f
         TqD5MZfkGGc2wGQ7qrrIOjv+0dzDwr3CUlVKAdLQtNPHMpODOqePsIDD6ETI+CaKf3
         KbMvrWyGOyUFeywF7ikJmQdTERvNcQvHFHhzXnNcDNfhOPc1eE0aYep9aix5j1W7Gp
         NM3Wt10ihm/6A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 6096060A3C;
        Fri, 17 Dec 2021 22:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next 0/3] Revamp and fix libbpf's feature-probing APIs
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <163977961139.17343.116378339550967950.git-patchwork-notify@kernel.org>
Date:   Fri, 17 Dec 2021 22:20:11 +0000
References: <20211217171202.3352835-1-andrii@kernel.org>
In-Reply-To: <20211217171202.3352835-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, davemarchevsky@fb.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Fri, 17 Dec 2021 09:11:59 -0800 you wrote:
> Fix and improve libbpf feature-probing APIs. Name them consistently and
> deprecated previous inconsistently named APIs.
> 
> v1->v2:
>   - fixed misleading comment and added acks (Dave).
> 
> Cc: Dave Marchevsky <davemarchevsky@fb.com>
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next,1/3] libbpf: rework feature-probing APIs
    https://git.kernel.org/bpf/bpf-next/c/878d8def0603
  - [v2,bpf-next,2/3] selftests/bpf: add libbpf feature-probing API selftests
    https://git.kernel.org/bpf/bpf-next/c/5a8ea82f9d25
  - [v2,bpf-next,3/3] bpftool: reimplement large insn size limit feature probing
    https://git.kernel.org/bpf/bpf-next/c/e967a20a8fab

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


