Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0AFB61A06C
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 20:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiKDTAY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Nov 2022 15:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiKDTAX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 15:00:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF903122
        for <bpf@vger.kernel.org>; Fri,  4 Nov 2022 12:00:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7B5ADB82F5F
        for <bpf@vger.kernel.org>; Fri,  4 Nov 2022 19:00:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 15277C433C1;
        Fri,  4 Nov 2022 19:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667588418;
        bh=Ed1q4syKwO7QCjaGTYTCr1KFJB5k/5SXUuEyzNjV2EA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=TRnfVMnAeQ5Ffkf9vEs6RfnwV9g/sE6cnc6D4cwVs/qm3TI/sv+WNbLyRSv8/Ksnp
         PlgpOK09geYhtqFXzBFuVgpGEzf/4DozD/aQczLRaThR0JtoVBeIt2bUrNwLdZwQoX
         21zGZDMGcVovKq953KgC8PYbsmKbgVMBenXBIWbhrKxjZIDhPq1fzyzPJ7ZBXpsbHr
         29Y4PRvfOCVP4KXIrkCNmBDmUbPukZVnp9OnBkd1nDP0CH+ufxz4ix2ekjAcuqjl6Q
         8Ni/5COJQ6E3AEbdFnmMg3gWTWqlqfC10ljaF1D21I8POZikUelR6XHgSCGT6VcSFD
         Z8BMoFtbN5pmg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E91FDE52509;
        Fri,  4 Nov 2022 19:00:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next 0/6] BPF verifier precision tracking improvements
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166758841795.26959.16340729986307349960.git-patchwork-notify@kernel.org>
Date:   Fri, 04 Nov 2022 19:00:17 +0000
References: <20221104163649.121784-1-andrii@kernel.org>
In-Reply-To: <20221104163649.121784-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Fri, 4 Nov 2022 09:36:43 -0700 you wrote:
> This patch set fixes and improves BPF verifier's precision tracking logic for
> SCALAR registers.
> 
> Patches #1 and #2 are bug fixes discovered while working on these changes.
> 
> Patch #3 enables precision tracking for BPF programs that contain subprograms.
> This was disabled before and prevent any modern BPF programs that use
> subprograms from enjoying the benefits of SCALAR (im)precise logic.
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next,1/6] bpf: propagate precision in ALU/ALU64 operations
    https://git.kernel.org/bpf/bpf-next/c/a3b666bfa9c9
  - [v2,bpf-next,2/6] bpf: propagate precision across all frames, not just the last one
    https://git.kernel.org/bpf/bpf-next/c/529409ea92d5
  - [v2,bpf-next,3/6] bpf: allow precision tracking for programs with subprogs
    https://git.kernel.org/bpf/bpf-next/c/be2ef8161572
  - [v2,bpf-next,4/6] bpf: stop setting precise in current state
    https://git.kernel.org/bpf/bpf-next/c/f63181b6ae79
  - [v2,bpf-next,5/6] bpf: aggressively forget precise markings during state checkpointing
    https://git.kernel.org/bpf/bpf-next/c/7a830b53c17b
  - [v2,bpf-next,6/6] selftests/bpf: make test_align selftest more robust
    https://git.kernel.org/bpf/bpf-next/c/4f999b767769

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


