Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2F56B34B4
	for <lists+bpf@lfdr.de>; Fri, 10 Mar 2023 04:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjCJDU1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Mar 2023 22:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjCJDU0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Mar 2023 22:20:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE2D1033BA
        for <bpf@vger.kernel.org>; Thu,  9 Mar 2023 19:20:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C104D60C12
        for <bpf@vger.kernel.org>; Fri, 10 Mar 2023 03:20:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 293F0C4339B;
        Fri, 10 Mar 2023 03:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678418418;
        bh=s399wVTeZXrJD7o3I87qWCFAhEwC1uwJ9eXCEobgpLk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=WYHFkA31w+12bczn7YHaz3S27fhcy0XqtG96rrev/d/BdMd6Tf06enqcWqxBRL83h
         gXPNaG9kxtnPJa5/OH8a0bsqHBw9I+UGuJGxPhguzdp/2fd8bj0GLRWWd0bGFrFJzT
         L4yaFrTigpAP2P5bnh2NjaH0waVX+ihyhKngdOLNcFDlhwIlf4eeV3z3OGr+6mXTBR
         GUHfs8K5EjygSmwgt1Jb3eswMPoEZLkETVDlF7UfIfSVqdVj9i7KgS4QJRC7mFKU+a
         hL+1enw2lcvSS8s7Hy7f7LfWo998uMNpQP8WI78B5ZkbnVFQCLR139tdtZZtsGrYx8
         3ZWUNzcCjv6GA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0A81EE21EEB;
        Fri, 10 Mar 2023 03:20:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Workaround verification failure for
 fexit_bpf2bpf/func_replace_return_code
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167841841803.8288.15840600513203502382.git-patchwork-notify@kernel.org>
Date:   Fri, 10 Mar 2023 03:20:18 +0000
References: <20230310012410.2920570-1-yhs@fb.com>
In-Reply-To: <20230310012410.2920570-1-yhs@fb.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 9 Mar 2023 17:24:10 -0800 you wrote:
> With latest llvm17, selftest fexit_bpf2bpf/func_replace_return_code
> has the following verification failure:
> 
>   0: R1=ctx(off=0,imm=0) R10=fp0
>   ; int connect_v4_prog(struct bpf_sock_addr *ctx)
>   0: (bf) r7 = r1                       ; R1=ctx(off=0,imm=0) R7_w=ctx(off=0,imm=0)
>   1: (b4) w6 = 0                        ; R6_w=0
>   ; memset(&tuple.ipv4.saddr, 0, sizeof(tuple.ipv4.saddr));
>   ...
>   ; return do_bind(ctx) ? 1 : 0;
>   179: (bf) r1 = r7                     ; R1=ctx(off=0,imm=0) R7=ctx(off=0,imm=0)
>   180: (85) call pc+147
>   Func#3 is global and valid. Skipping.
>   181: R0_w=scalar()
>   181: (bc) w6 = w0                     ; R0_w=scalar() R6_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
>   182: (05) goto pc-129
>   ; }
>   54: (bc) w0 = w6                      ; R0_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff)) R6_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
>   55: (95) exit
>   At program exit the register R0 has value (0x0; 0xffffffff) should have been in (0x0; 0x1)
>   processed 281 insns (limit 1000000) max_states_per_insn 1 total_states 26 peak_states 26 mark_read 13
>   -- END PROG LOAD LOG --
>   libbpf: prog 'connect_v4_prog': failed to load: -22
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Workaround verification failure for fexit_bpf2bpf/func_replace_return_code
    https://git.kernel.org/bpf/bpf-next/c/63d78b7e8ca2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


