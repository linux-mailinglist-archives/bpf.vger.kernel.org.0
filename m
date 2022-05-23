Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4410531E11
	for <lists+bpf@lfdr.de>; Mon, 23 May 2022 23:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbiEWVkW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 May 2022 17:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbiEWVkR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 May 2022 17:40:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DC565D07
        for <bpf@vger.kernel.org>; Mon, 23 May 2022 14:40:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF3BA614FA
        for <bpf@vger.kernel.org>; Mon, 23 May 2022 21:40:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 34D33C385A9;
        Mon, 23 May 2022 21:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653342013;
        bh=vz4jpqPSGre1oM8eH2qYQq1oWVun3vpdLgKlytnTybE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=l+DKRL5Iy/ncQHofOR3vk5kbBendS7tP3yKyjPizWDK71JKXvG12ldXr3Lonu5ej8
         2SZMICjKDlmuRvAtJNa4MRyp5U6Sx08QDscKq4DoaMbH/7Drjp7MkIt8R4/UHf/43F
         RHWNVrvUE7EjLKuJbxVIsTZ0xbGCmJepX0K2SCbQkAV0WbBDI5zO0206r7Yyq8tczz
         Eiy0opfxXAGFtZILEb0HNhW/XOabSqQxsnJ9wq/HPuATd6+pE2YJ2tFGCMWllGvVDu
         BgBmMJDU2MKblWMOtJmjeNl0O3InDATdO93q0TyFh5JrNn/Oml1vC0ZRjH0AbMH9mm
         aA+NvxBxB0ZlA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 180CCF03938;
        Mon, 23 May 2022 21:40:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v6 0/6] Dynamic pointers
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165334201309.19887.998942869996041887.git-patchwork-notify@kernel.org>
Date:   Mon, 23 May 2022 21:40:13 +0000
References: <20220523210712.3641569-1-joannelkoong@gmail.com>
In-Reply-To: <20220523210712.3641569-1-joannelkoong@gmail.com>
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
        daniel@iogearbox.net
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 23 May 2022 14:07:06 -0700 you wrote:
> This patchset implements the basics of dynamic pointers in bpf.
> 
> A dynamic pointer (struct bpf_dynptr) is a pointer that stores extra metadata
> alongside the address it points to. This abstraction is useful in bpf given
> that every memory access in a bpf program must be safe. The verifier and bpf
> helper functions can use the metadata to enforce safety guarantees for things
> such as dynamically sized strings and kernel heap allocations.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v6,1/6] bpf: Add verifier support for dynptrs
    https://git.kernel.org/bpf/bpf-next/c/97e03f521050
  - [bpf-next,v6,2/6] bpf: Add bpf_dynptr_from_mem for local dynptrs
    https://git.kernel.org/bpf/bpf-next/c/263ae152e962
  - [bpf-next,v6,3/6] bpf: Dynptr support for ring buffers
    https://git.kernel.org/bpf/bpf-next/c/bc34dee65a65
  - [bpf-next,v6,4/6] bpf: Add bpf_dynptr_read and bpf_dynptr_write
    https://git.kernel.org/bpf/bpf-next/c/13bbbfbea759
  - [bpf-next,v6,5/6] bpf: Add dynptr data slices
    https://git.kernel.org/bpf/bpf-next/c/34d4ef5775f7
  - [bpf-next,v6,6/6] selftests/bpf: Dynptr tests
    https://git.kernel.org/bpf/bpf-next/c/0cf7052a5512

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


