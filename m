Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDD55F1428
	for <lists+bpf@lfdr.de>; Fri, 30 Sep 2022 22:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbiI3Uuk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Sep 2022 16:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbiI3UuX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Sep 2022 16:50:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D67A6ADF
        for <bpf@vger.kernel.org>; Fri, 30 Sep 2022 13:50:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2A96AB82A30
        for <bpf@vger.kernel.org>; Fri, 30 Sep 2022 20:50:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CA853C4347C;
        Fri, 30 Sep 2022 20:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664571015;
        bh=60/fb5yHs+9fcPbMOzF4ME4KyxBvkUmre9vsvVQnQI4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=oAT6AheSWarRgSSDH6c4GdOV/vUiHmlT2NyxmT+4ZSQPGactB6tAf6nl77Fc3xClR
         NoftzHyVB0oN0AVdDdcMGQS3EUQYqwkrcD9gR8E5V0ZiMEfHOh7xL1pmyInHrxAvLx
         t0gAcFqhvxz4YFz8HLVlJUvSS/jKrz2TQbqugSQwd9YeemB9/zoRabbaFWh310M7uc
         1MaHGwuxKgQaUqVjL2dU4W3r6INOg87MqD1pl7EgzYFEiPTv3Rdi88lqgis75FqlFO
         sx0cf/09cNF7DH2y8M6tx8pH73eBiAwjDuMBGnVS3iDelt945Ey95I3DxmT3UlFViH
         wEbdGfSw3MAJg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ABBACE4D013;
        Fri, 30 Sep 2022 20:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 01/15] ebpf-docs: Move legacy packet instructions to a
 separate file
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166457101569.19852.6891307398073238847.git-patchwork-notify@kernel.org>
Date:   Fri, 30 Sep 2022 20:50:15 +0000
References: <20220927185958.14995-1-dthaler1968@googlemail.com>
In-Reply-To: <20220927185958.14995-1-dthaler1968@googlemail.com>
To:     None <dthaler1968@googlemail.com>
Cc:     bpf@vger.kernel.org, dthaler@microsoft.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 27 Sep 2022 18:59:44 +0000 you wrote:
> From: Dave Thaler <dthaler@microsoft.com>
> 
> Signed-off-by: Dave Thaler <dthaler@microsoft.com>
> ---
>  Documentation/bpf/instruction-set.rst | 38 ++--------------
>  Documentation/bpf/linux-notes.rst     | 65 +++++++++++++++++++++++++++
>  2 files changed, 68 insertions(+), 35 deletions(-)
>  create mode 100644 Documentation/bpf/linux-notes.rst

Here is the summary with links:
  - [01/15] ebpf-docs: Move legacy packet instructions to a separate file
    https://git.kernel.org/bpf/bpf-next/c/6166da0a02cd
  - [02/15] ebpf-docs: Linux byteswap note
    https://git.kernel.org/bpf/bpf-next/c/9a0bf21337c6
  - [03/15] ebpf-docs: Move Clang notes to a separate file
    https://git.kernel.org/bpf/bpf-next/c/6c7aaffb24ef
  - [04/15] ebpf-docs: Add Clang note about BPF_ALU
    https://git.kernel.org/bpf/bpf-next/c/ee159bdbdbce
  - [05/15] ebpf-docs: Add TOC and fix formatting
    https://git.kernel.org/bpf/bpf-next/c/5a8921ba96ce
  - [06/15] ebpf-docs: Use standard type convention in standard doc
    (no matching commit)
  - [07/15] ebpf-docs: Fix modulo zero, division by zero, overflow, and underflow
    (no matching commit)
  - [08/15] ebpf-docs: Use consistent names for the same field
    (no matching commit)
  - [09/15] ebpf-docs: Explain helper functions
    (no matching commit)
  - [10/15] ebpf-docs: Add appendix of all opcodes in order
    (no matching commit)
  - [11/15] ebpf-docs: Improve English readability
    (no matching commit)
  - [12/15] ebpf-docs: Add Linux note about register calling convention
    (no matching commit)
  - [13/15] ebpf-docs: Add extended 64-bit immediate instructions
    (no matching commit)
  - [14/15] ebpf-docs: Add extended call instructions
    (no matching commit)
  - [15/15] ebpf-docs: Add note about invalid instruction
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


