Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF256762EB
	for <lists+bpf@lfdr.de>; Sat, 21 Jan 2023 03:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbjAUCLD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 21:11:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjAUCLD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 21:11:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949F071365
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 18:10:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7BD1362168
        for <bpf@vger.kernel.org>; Sat, 21 Jan 2023 02:10:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CC0CDC4339B;
        Sat, 21 Jan 2023 02:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674267018;
        bh=vA0nhGLSdzpG31+1rBAMbiy1E6sr43hLWZevThtNJ9Y=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=DbqhzbyEdBi08huXO8IVL0xjHtQz0UlfP7k6yByMCY0EGdtVu6MeTPDul8mB7mF5R
         19pHu6HtRBsb4W2uj+bwTQx9/GVmWRycdfY77h3kSR+iDbte6pFM1Q2Jqu6u5wyVYC
         fcueUADL8YPJ5i2G3shRZMEFrjvYD6AkrxOBEOFuH2ca1L3AJpzqmqUvy7Pm0pr6fa
         /42zuCHuJ3pXqFYm4UnyTlfTEnKStkhAfUDi9HjGBZx5fBcn4bnIspkVWybkAw1yy3
         qdfvXtGRqKyUDmJ6Rhema0QpSr7l7fJKeSnzjw5LROHGsxAFEiUuixD8tZP+ozJYH3
         D868qAQXJHPBg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AE458C04E34;
        Sat, 21 Jan 2023 02:10:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v5 00/12] Dynptr fixes
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167426701870.27266.12568567569882447280.git-patchwork-notify@kernel.org>
Date:   Sat, 21 Jan 2023 02:10:18 +0000
References: <20230121002241.2113993-1-memxor@gmail.com>
In-Reply-To: <20230121002241.2113993-1-memxor@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, martin.lau@kernel.org
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

On Sat, 21 Jan 2023 05:52:29 +0530 you wrote:
> This is part 2 of https://lore.kernel.org/bpf/20221018135920.726360-1-memxor@gmail.com.
> 
> Changelog:
> ----------
> v4 -> v5
> v5: https://lore.kernel.org/bpf/20230120070355.1983560-1-memxor@gmail.com
> 
> [...]

Here is the summary with links:
  - [bpf-next,v5,01/12] bpf: Fix state pruning for STACK_DYNPTR stack slots
    https://git.kernel.org/bpf/bpf-next/c/d6fefa1105da
  - [bpf-next,v5,02/12] bpf: Fix missing var_off check for ARG_PTR_TO_DYNPTR
    https://git.kernel.org/bpf/bpf-next/c/79168a669d81
  - [bpf-next,v5,03/12] bpf: Fix partial dynptr stack slot reads/writes
    https://git.kernel.org/bpf/bpf-next/c/ef8fc7a07c0e
  - [bpf-next,v5,04/12] bpf: Invalidate slices on destruction of dynptrs on stack
    https://git.kernel.org/bpf/bpf-next/c/f8064ab90d66
  - [bpf-next,v5,05/12] bpf: Allow reinitializing unreferenced dynptr stack slots
    https://git.kernel.org/bpf/bpf-next/c/379d4ba831cf
  - [bpf-next,v5,06/12] bpf: Combine dynptr_get_spi and is_spi_bounds_valid
    https://git.kernel.org/bpf/bpf-next/c/f5b625e5f8bb
  - [bpf-next,v5,07/12] bpf: Avoid recomputing spi in process_dynptr_func
    https://git.kernel.org/bpf/bpf-next/c/1ee72bcbe48d
  - [bpf-next,v5,08/12] selftests/bpf: convenience macro for use with 'asm volatile' blocks
    https://git.kernel.org/bpf/bpf-next/c/91b875a5e43b
  - [bpf-next,v5,09/12] selftests/bpf: Add dynptr pruning tests
    https://git.kernel.org/bpf/bpf-next/c/f4d24edf1b92
  - [bpf-next,v5,10/12] selftests/bpf: Add dynptr var_off tests
    https://git.kernel.org/bpf/bpf-next/c/ef4810135396
  - [bpf-next,v5,11/12] selftests/bpf: Add dynptr partial slot overwrite tests
    https://git.kernel.org/bpf/bpf-next/c/011edc8e49b8
  - [bpf-next,v5,12/12] selftests/bpf: Add dynptr helper tests
    https://git.kernel.org/bpf/bpf-next/c/ae8e354c497a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


