Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEE7563A77
	for <lists+bpf@lfdr.de>; Fri,  1 Jul 2022 22:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbiGAUKT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 1 Jul 2022 16:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbiGAUKS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Jul 2022 16:10:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44D3101E3
        for <bpf@vger.kernel.org>; Fri,  1 Jul 2022 13:10:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7064DB831E3
        for <bpf@vger.kernel.org>; Fri,  1 Jul 2022 20:10:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 31FC4C341CA;
        Fri,  1 Jul 2022 20:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656706215;
        bh=5lkgv2P9+OMI+a2wydNKtyF+Ixt+vVIGm41iMdLTrgw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=XBq3CZFc7/QtoSWuI64545xh/LqQdmeGIZMomR1pCnXaKs5VRUTrMf0+1E0+SbNIA
         8AWYKFjxZmeISZtAqN6HvaR/risVO5Od+eVsHrB3rJiLd3WcLaDYYCjZv5IpOXpUW6
         WEkc7+HSK6S8VzsfH65FxEVSUKN7i1kKB8CopcnQILsn2N8SvOg/JzFu4WAHCyy8fb
         Wx1gGaDL9Kq3CNv1MBUrSfDsZT8iUY7LsVJyuWzu9Y3Qa6Mi5asQylGjE3IIDhn8GN
         UCnI14jm5Y7ixbW+FwRpSFj9oUjwvMbcrbiBl9Nh5PVVrSgTW5Hr6fKjliWe9CIB7g
         gf1N0vdlp+amA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 13266E49BBC;
        Fri,  1 Jul 2022 20:10:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf 1/4] bpf: Fix incorrect verifier simulation around jmp32's
 jeq/jne
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165670621507.10143.15497711583157007755.git-patchwork-notify@kernel.org>
Date:   Fri, 01 Jul 2022 20:10:15 +0000
References: <20220701124727.11153-1-daniel@iogearbox.net>
In-Reply-To: <20220701124727.11153-1-daniel@iogearbox.net>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     ast@kernel.org, andrii@kernel.org, john.fastabend@gmail.com,
        liulin063@gmail.com, bpf@vger.kernel.org
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri,  1 Jul 2022 14:47:24 +0200 you wrote:
> Kuee reported a quirk in the jmp32's jeq/jne simulation, namely that the
> register value does not match expectations for the fall-through path. For
> example:
> 
> Before fix:
> 
>   0: R1=ctx(off=0,imm=0) R10=fp0
>   0: (b7) r2 = 0                        ; R2_w=P0
>   1: (b7) r6 = 563                      ; R6_w=P563
>   2: (87) r2 = -r2                      ; R2_w=Pscalar()
>   3: (87) r2 = -r2                      ; R2_w=Pscalar()
>   4: (4c) w2 |= w6                      ; R2_w=Pscalar(umin=563,umax=4294967295,var_off=(0x233; 0xfffffdcc),s32_min=-2147483085) R6_w=P563
>   5: (56) if w2 != 0x8 goto pc+1        ; R2_w=P571  <--- [*]
>   6: (95) exit
>   R0 !read_ok
> 
> [...]

Here is the summary with links:
  - [bpf,1/4] bpf: Fix incorrect verifier simulation around jmp32's jeq/jne
    https://git.kernel.org/bpf/bpf/c/a12ca6277eca
  - [bpf,2/4] bpf: Fix insufficient bounds propagation from adjust_scalar_min_max_vals
    https://git.kernel.org/bpf/bpf/c/3844d153a41a
  - [bpf,3/4] bpf, selftests: Add verifier test case for imm=0,umin=0,umax=1 scalar
    https://git.kernel.org/bpf/bpf/c/73c4936f916d
  - [bpf,4/4] bpf, selftests: Add verifier test case for jmp32's jeq/jne
    https://git.kernel.org/bpf/bpf/c/a49b8ce7306c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


