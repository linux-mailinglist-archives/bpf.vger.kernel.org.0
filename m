Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11A176E54E9
	for <lists+bpf@lfdr.de>; Tue, 18 Apr 2023 01:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjDQXAY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Apr 2023 19:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjDQXAU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Apr 2023 19:00:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E017B8
        for <bpf@vger.kernel.org>; Mon, 17 Apr 2023 16:00:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E6DDE62AEB
        for <bpf@vger.kernel.org>; Mon, 17 Apr 2023 23:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4CB1BC4339B;
        Mon, 17 Apr 2023 23:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681772418;
        bh=cSFDE4biLs4O7GmPiCNsrWADOdHBft77IR+GHj8m5Rg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=CcP0yt766guEZLagsLjYKPe82CJHlOz/iY0smqrJSmCO4/i1vXwPwK6FULGmWBIhI
         YI1QC1sMb5zI5/+pAS0ODFI01mirA4Db0MuwRHgLtxGK9X98Te/mGd0XWMYgPN//2q
         ZDACE3b5huRRukLAzSaOQirZKeECHUIpMfZo0T0CGToiEaqPjWkUP4WUHpHTMvFamz
         QLmnQaIsycSIfnRqQvVY0ZiqSRu0Fs9Qostrhpuqj/kXb6VayShHSsQd1keWw7NNfB
         nqakaLsZDZK/aOGx4V4HtEn+/lt6KixqhKj/cG6U5DAgPP9g4dABuz8qAD8zNaAfqo
         wBEB1ohjqGLtw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 289F9C40C5E;
        Mon, 17 Apr 2023 23:00:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Improve verifier u32 scalar equality
 checking
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168177241815.10175.8036375503922112256.git-patchwork-notify@kernel.org>
Date:   Mon, 17 Apr 2023 23:00:18 +0000
References: <20230417222134.359714-1-yhs@fb.com>
In-Reply-To: <20230417222134.359714-1-yhs@fb.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 17 Apr 2023 15:21:34 -0700 you wrote:
> In [1], I tried to remove bpf-specific codes to prevent certain
> llvm optimizations, and add llvm TTI (target transform info) hooks
> to prevent those optimizations. During this process, I found
> if I enable llvm SimplifyCFG:shouldFoldTwoEntryPHINode
> transformation, I will hit the following verification failure with selftests:
> 
>   ...
>   8: (18) r1 = 0xffffc900001b2230       ; R1_w=map_value(off=560,ks=4,vs=564,imm=0)
>   10: (61) r1 = *(u32 *)(r1 +0)         ; R1_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
>   ; if (skb->tstamp == EGRESS_ENDHOST_MAGIC)
>   11: (79) r2 = *(u64 *)(r6 +152)       ; R2_w=scalar() R6=ctx(off=0,imm=0)
>   ; if (skb->tstamp == EGRESS_ENDHOST_MAGIC)
>   12: (55) if r2 != 0xb9fbeef goto pc+10        ; R2_w=195018479
>   13: (bc) w2 = w1                      ; R1_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff)) R2_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
>   ; if (test < __NR_TESTS)
>   14: (a6) if w1 < 0x9 goto pc+1 16: R0=2 R1_w=scalar(umax=8,var_off=(0x0; 0xf)) R2_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff)) R6=ctx(off=0,imm=0) R10=fp0
>   ;
>   16: (27) r2 *= 28                     ; R2_w=scalar(umax=120259084260,var_off=(0x0; 0x1ffffffffc),s32_max=2147483644,u32_max=-4)
>   17: (18) r3 = 0xffffc900001b2118      ; R3_w=map_value(off=280,ks=4,vs=564,imm=0)
>   19: (0f) r3 += r2                     ; R2_w=scalar(umax=120259084260,var_off=(0x0; 0x1ffffffffc),s32_max=2147483644,u32_max=-4) R3_w=map_value(off=280,ks=4,vs=564,umax=120259084260,var_off=(0x0; 0x1ffffffffc),s32_max=2147483644,u32_max=-4)
>   20: (61) r2 = *(u32 *)(r3 +0)
>   R3 unbounded memory access, make sure to bounds check any such access
>   processed 97 insns (limit 1000000) max_states_per_insn 1 total_states 10 peak_states 10 mark_read 6
>   -- END PROG LOAD LOG --
>   libbpf: prog 'ingress_fwdns_prio100': failed to load: -13
>   libbpf: failed to load object 'test_tc_dtime'
>   libbpf: failed to load BPF skeleton 'test_tc_dtime': -13
>   ...
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] bpf: Improve verifier u32 scalar equality checking
    https://git.kernel.org/bpf/bpf-next/c/3be49f79555e
  - [bpf-next,v2,2/2] selftests/bpf: Add a selftest for checking subreg equality
    https://git.kernel.org/bpf/bpf-next/c/49859de997c3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


