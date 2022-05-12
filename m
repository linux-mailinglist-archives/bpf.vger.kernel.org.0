Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3DD52420B
	for <lists+bpf@lfdr.de>; Thu, 12 May 2022 03:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbiELBaS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 May 2022 21:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbiELBaP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 May 2022 21:30:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139F2154B3F
        for <bpf@vger.kernel.org>; Wed, 11 May 2022 18:30:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 394FE61E7A
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 01:30:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8B4A8C34113;
        Thu, 12 May 2022 01:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652319013;
        bh=RaFFYgBcRpcOwyYLFg/OfPUWU2HaxupEfVbRq3PvQ6c=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=iH1P7lSwCgJZzbk21/RkMqTjmXA2crB30R8u5pzgxOp6gtzjeDXE0jddOQzerX1qT
         b9B3246H8/ZxGeR3U7wn9WBE6yTvairMXdgTB5rdxWStGqjF7++0EGu9UuwPqdcAxg
         IS2bGCogUjI8NLIv0DYM589JLdtORiV5HWX4mb313C5dcgauqgaaYaaK+OjSwjmHZt
         ITQ4Z4YIa5E99uBgSIguouo1XONjLupZja9qt6M8EddZYoiIxc46Sf93+E5qaeoHcC
         b2rNp+Cu/DjWP/TaMNqwtdQna84GgbMgqOBgIl+8948udHAHwTWnJ8g1fC1eEw6L+T
         ULznAEZJixcmA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 69CF5F03934;
        Thu, 12 May 2022 01:30:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: make fexit_stress test run in serial
 mode
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165231901342.29050.15976101462470678107.git-patchwork-notify@kernel.org>
Date:   Thu, 12 May 2022 01:30:13 +0000
References: <20220511232012.609370-1-andrii@kernel.org>
In-Reply-To: <20220511232012.609370-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 11 May 2022 16:20:12 -0700 you wrote:
> fexit_stress is attaching maximum allowed amount of fexit programs to
> bpf_fentry_test1 kernel function, which is used by a bunch of other
> parallel tests, thus pretty frequently interfering with their execution.
> 
> Given the test assumes nothing else is attaching to bpf_fentry_test1,
> mark it serial.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: make fexit_stress test run in serial mode
    https://git.kernel.org/bpf/bpf-next/c/5790a2fee02c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


