Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 966106A5A78
	for <lists+bpf@lfdr.de>; Tue, 28 Feb 2023 15:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjB1OAV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Feb 2023 09:00:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjB1OAU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Feb 2023 09:00:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4873712BEB;
        Tue, 28 Feb 2023 06:00:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D02666109E;
        Tue, 28 Feb 2023 14:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 29C17C4339C;
        Tue, 28 Feb 2023 14:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677592818;
        bh=usFwqgpY+ATKAODdZvuI3VzP03kV2w6Ray28rxMK7L4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=iisplRTC0n2sBh6buJNCyaB14vxoQ411G4kohll5JyPKNtY9HZWqCYfbgj3effsrx
         NyqqL3LcsGGAmbgj3bTtIEqIwF1uR4y+zgwnKKlQ4hdyE8WavYxHH3CLwKtb0vrYAN
         ao/JpLewRDUj99YhMIkN7DcF61/K1lVjDIYXbgElM4Vv/OPvqs+7aPkFFW2B7MN+wX
         lruHIZ8q3PCULVlZMOF5HsYbS4n1jHAlnKX1qSIdC/BDodTVOL0fXfqmzj1YZYkyti
         XXZmDnxN7afBktqvjtPbyTbpaJdzoYyWw/BXb9zNMg/MWC+MEyJYc2nSsAYHZBQYiO
         x+s45utHsrNHA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0D9A0C691DE;
        Tue, 28 Feb 2023 14:00:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/2] MIPS: Implement two workarounds for BPF JIT
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167759281805.14618.4922384489244430083.git-patchwork-notify@kernel.org>
Date:   Tue, 28 Feb 2023 14:00:18 +0000
References: <20230228113305.83751-1-jiaxun.yang@flygoat.com>
In-Reply-To: <20230228113305.83751-1-jiaxun.yang@flygoat.com>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        tsbogend@alpha.franken.de, johan.almbladh@anyfinetworks.com,
        paulburton@kernel.org, bpf@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 28 Feb 2023 11:33:03 +0000 you wrote:
> Hi all,
> 
> Just noticed eBPF JIT is not working on R4000 when messing around with QEMU.
> 
> This patchset implements two workarounds that is blocking us from enabling eBPF
> JIT on R4000.
> 
> [...]

Here is the summary with links:
  - [v2,1/2] MIPS: ebpf jit: Implement DADDI workarounds
    https://git.kernel.org/bpf/bpf-next/c/bbefef2f0708
  - [v2,2/2] MIPS: ebpf jit: Implement R4000 workarounds
    https://git.kernel.org/bpf/bpf-next/c/7364d60c2661

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


