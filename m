Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1643F6490E0
	for <lists+bpf@lfdr.de>; Sat, 10 Dec 2022 22:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiLJVuT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 10 Dec 2022 16:50:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLJVuT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 10 Dec 2022 16:50:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1E91581F
        for <bpf@vger.kernel.org>; Sat, 10 Dec 2022 13:50:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE69A60C64
        for <bpf@vger.kernel.org>; Sat, 10 Dec 2022 21:50:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 25243C433EF;
        Sat, 10 Dec 2022 21:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670709017;
        bh=cOY6DPskuUWDEIKHV4UqTbWBCNSHFmcMwVtEraDRipk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=m1TW6ntxXjohxOBD8KHC4NDkB8QmQ4QeBN+2zmQC5PGMFpN2bg4dmI3EfOjHcfBSX
         UMWX5iCOMfseQWY+pbMgiQWLTzh6mgivPFM7PElR/R3Nc4wMu1X0X9bYCch7s/1d3t
         gDs/fP5u+nNgmCPJcrMc8a9CzlqEKFsaN05mN6PHakSvaIxhIL6mQVHCO9Sc6z298v
         wTFuojgTVuQWknIfzQEFhEImMvsu5ZPX4joKVaOTc70lSeOaZ7wACtruTDnzi2ZZqk
         msSj7brMlmLycRarlx4MXyosf+Ds8+qKHM1MiSl6UP09tMnoRJcEd+QXEIQr+s1RY1
         B5gsdCDTMSoFA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0E462C41606;
        Sat, 10 Dec 2022 21:50:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/7] stricter register ID checking in regsafe()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167070901705.12059.17423131126807625637.git-patchwork-notify@kernel.org>
Date:   Sat, 10 Dec 2022 21:50:17 +0000
References: <20221209135733.28851-1-eddyz87@gmail.com>
In-Reply-To: <20221209135733.28851-1-eddyz87@gmail.com>
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com,
        memxor@gmail.com, ecree.xilinx@gmail.com
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
by Alexei Starovoitov <ast@kernel.org>:

On Fri,  9 Dec 2022 15:57:26 +0200 you wrote:
> This patch-set consists of a series of bug fixes for register ID
> tracking in verifier.c:states_equal()/regsafe() functions:
>  - for registers of type PTR_TO_MAP_{KEY,VALUE}, PTR_TO_PACKET[_META]
>    the regsafe() should call check_ids() even if registers are
>    byte-to-byte equal;
>  - states_equal() must maintain idmap that covers all function frames
>    in the state because functions like mark_ptr_or_null_regs() operate
>    on all registers in the state;
>  - regsafe() must compare spin lock ids for PTR_TO_MAP_VALUE registers.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/7] bpf: regsafe() must not skip check_ids()
    https://git.kernel.org/bpf/bpf-next/c/7c884339bbff
  - [bpf-next,2/7] selftests/bpf: test cases for regsafe() bug skipping check_id()
    https://git.kernel.org/bpf/bpf-next/c/cb578c1c9cf6
  - [bpf-next,3/7] bpf: states_equal() must build idmap for all function frames
    https://git.kernel.org/bpf/bpf-next/c/5dd9cdbc9dec
  - [bpf-next,4/7] selftests/bpf: verify states_equal() maintains idmap across all frames
    https://git.kernel.org/bpf/bpf-next/c/7d0579433087
  - [bpf-next,5/7] bpf: use check_ids() for active_lock comparison
    https://git.kernel.org/bpf/bpf-next/c/4ea2bb158bec
  - [bpf-next,6/7] selftests/bpf: Add pruning test case for bpf_spin_lock
    https://git.kernel.org/bpf/bpf-next/c/2026f2062df8
  - [bpf-next,7/7] selftests/bpf: test case for relaxed prunning of active_lock.id
    https://git.kernel.org/bpf/bpf-next/c/efd6286ff74a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


