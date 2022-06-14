Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9927954BE3F
	for <lists+bpf@lfdr.de>; Wed, 15 Jun 2022 01:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbiFNXUS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Jun 2022 19:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbiFNXUS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Jun 2022 19:20:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B064C326C0
        for <bpf@vger.kernel.org>; Tue, 14 Jun 2022 16:20:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 72E89B81BD0
        for <bpf@vger.kernel.org>; Tue, 14 Jun 2022 23:20:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E72A7C341C0;
        Tue, 14 Jun 2022 23:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655248814;
        bh=+uqqeKGMmF5VXU4n4Agu1vWnoJHvPv9B81ryiybmGLc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=spR3TDX0AuvZwPU1X36nxeDMYmBJwMrsR9xoQSPKApU/ItJ8dctjEp/y3Gt4veRLI
         arBGF5cuKlMQoqiThjkRJiG62AzuSphKVV4GQhxbj76zEwHEmWGLS+sAGxSG2lMaup
         cRlA+c8WWyXDQES7fxCH/4FC8M/IIWnuvNC515i+qVNgEV5DXImUoWxTRNhzCvcmfz
         OO0QkRldemVys83AEwnQsYtqmIjZRXXyuNFUBtccPW5qmbWs/qRGBQ84lAfuw0WNYP
         TYUVHCrF0EXE0hl3eh/jVUpzGmKX1dSXQtZuaoL6FVyrrjSXbsSpMkrYe4wpjm3ASU
         D2zQ19I6ilCIg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CBCAEE73858;
        Tue, 14 Jun 2022 23:20:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix test_varlen verification failure
 with latest llvm
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165524881383.32165.10296942488067106212.git-patchwork-notify@kernel.org>
Date:   Tue, 14 Jun 2022 23:20:13 +0000
References: <20220613233449.2860753-1-yhs@fb.com>
In-Reply-To: <20220613233449.2860753-1-yhs@fb.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Mon, 13 Jun 2022 16:34:49 -0700 you wrote:
> With latest llvm15, test_varlen failed with the following verifier log:
> 
>   17: (85) call bpf_probe_read_kernel_str#115   ; R0_w=scalar(smin=-4095,smax=256)
>   18: (bf) r1 = r0                      ; R0_w=scalar(id=1,smin=-4095,smax=256) R1_w=scalar(id=1,smin=-4095,smax=256)
>   19: (67) r1 <<= 32                    ; R1_w=scalar(smax=1099511627776,umax=18446744069414584320,var_off=(0x0; 0xffffffff00000000),s32_min=0,s32_max=0,u32_max=)
>   20: (bf) r2 = r1                      ; R1_w=scalar(id=2,smax=1099511627776,umax=18446744069414584320,var_off=(0x0; 0xffffffff00000000),s32_min=0,s32_max=0,u32)
>   21: (c7) r2 s>>= 32                   ; R2=scalar(smin=-2147483648,smax=256)
>   ; if (len >= 0) {
>   22: (c5) if r2 s< 0x0 goto pc+7       ; R2=scalar(umax=256,var_off=(0x0; 0x1ff))
>   ; payload4_len1 = len;
>   23: (18) r2 = 0xffffc90000167418      ; R2_w=map_value(off=1048,ks=4,vs=1572,imm=0)
>   25: (63) *(u32 *)(r2 +0) = r0         ; R0=scalar(id=1,smin=-4095,smax=256) R2_w=map_value(off=1048,ks=4,vs=1572,imm=0)
>   26: (77) r1 >>= 32                    ; R1_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
>   ; payload += len;
>   27: (18) r6 = 0xffffc90000167424      ; R6_w=map_value(off=1060,ks=4,vs=1572,imm=0)
>   29: (0f) r6 += r1                     ; R1_w=Pscalar(umax=4294967295,var_off=(0x0; 0xffffffff)) R6_w=map_value(off=1060,ks=4,vs=1572,umax=4294967295,var_off=(0)
>   ; len = bpf_probe_read_kernel_str(payload, MAX_LEN, &buf_in2[0]);
>   30: (bf) r1 = r6                      ; R1_w=map_value(off=1060,ks=4,vs=1572,umax=4294967295,var_off=(0x0; 0xffffffff)) R6_w=map_value(off=1060,ks=4,vs=1572,um)
>   31: (b7) r2 = 256                     ; R2_w=256
>   32: (18) r3 = 0xffffc90000164100      ; R3_w=map_value(off=256,ks=4,vs=1056,imm=0)
>   34: (85) call bpf_probe_read_kernel_str#115
>   R1 unbounded memory access, make sure to bounds check any such access
>   processed 27 insns (limit 1000000) max_states_per_insn 0 total_states 2 peak_states 2 mark_read 1
>   -- END PROG LOAD LOG --
>   libbpf: failed to load program 'handler32_signed'
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Fix test_varlen verification failure with latest llvm
    https://git.kernel.org/bpf/bpf-next/c/96752e1ec0e0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


