Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 179F86539F9
	for <lists+bpf@lfdr.de>; Thu, 22 Dec 2022 01:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbiLVAAX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Dec 2022 19:00:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232553AbiLVAAW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Dec 2022 19:00:22 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B167B11C34
        for <bpf@vger.kernel.org>; Wed, 21 Dec 2022 16:00:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2589FCE1921
        for <bpf@vger.kernel.org>; Thu, 22 Dec 2022 00:00:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 66937C4339B;
        Thu, 22 Dec 2022 00:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671667217;
        bh=qFFULEaqGwpDPuwPpakZ6HgKt7uYK7usTyVV4uX+B6U=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=r+4v6GoI11FyYbPETy6ZrmP+s5Q1NIGBSw0FYKM5/vNntlZtaQuOnW4eyNI4sNAN2
         BYA3xHTwi992xZ+vseC1CSTuRhHn9ANm6E7efbJuppKfkJoITAoGAsh7DX8J0gj2hL
         fnL5nQVkiAn6/Noy2S8D3nuxOQky848/F3NBh8s/8z3umkupaS8BJTJRt3QdFU6O/T
         C/L0r27bPqzwEQ6RZIupYfzxS/sQuOEzuz/tPQhlafk/ExrmGl2CyyCpvryGS9Bf8u
         1jBKU5IugLUYdHgwuhldMSTL6SvmHu2FCNiSJzXHU7+5+P9DH+17Qwj8w1JV+bXnWt
         H5Jq0ChB0cTVw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 517C0C395DF;
        Thu, 22 Dec 2022 00:00:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 bpf-next 1/2] bpf,
 x86: Improve PROBE_MEM runtime load check
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167166721733.20308.6237748522943766049.git-patchwork-notify@kernel.org>
Date:   Thu, 22 Dec 2022 00:00:17 +0000
References: <20221216214319.3408356-1-davemarchevsky@fb.com>
In-Reply-To: <20221216214319.3408356-1-davemarchevsky@fb.com>
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kernel-team@fb.com, yhs@meta.com, yhs@fb.com
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

On Fri, 16 Dec 2022 13:43:18 -0800 you wrote:
> This patch rewrites the runtime PROBE_MEM check insns emitted by the BPF
> JIT in order to ensure load safety. The changes in the patch fix two
> issues with the previous logic and more generally improve size of
> emitted code. Paragraphs between this one and "FIX 1" below explain the
> purpose of the runtime check and examine the current implementation.
> 
> When a load is marked PROBE_MEM - e.g. due to PTR_UNTRUSTED access - the
> address being loaded from is not necessarily valid. The BPF jit sets up
> exception handlers for each such load which catch page faults and 0 out
> the destination register.
> 
> [...]

Here is the summary with links:
  - [v3,bpf-next,1/2] bpf, x86: Improve PROBE_MEM runtime load check
    https://git.kernel.org/bpf/bpf-next/c/90156f4bfa21
  - [v3,bpf-next,2/2] selftests/bpf: Add verifier test exercising jit PROBE_MEM logic
    https://git.kernel.org/bpf/bpf-next/c/59fe41b5255f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


