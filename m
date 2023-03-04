Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7391E6AA838
	for <lists+bpf@lfdr.de>; Sat,  4 Mar 2023 06:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjCDFur (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 4 Mar 2023 00:50:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCDFuq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 4 Mar 2023 00:50:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053B14B831
        for <bpf@vger.kernel.org>; Fri,  3 Mar 2023 21:50:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A2A88B81A55
        for <bpf@vger.kernel.org>; Sat,  4 Mar 2023 05:50:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3BC7AC4339B;
        Sat,  4 Mar 2023 05:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677909042;
        bh=asAp3B4BcWyX9ATdV7+pe7Z3M2rGlLxsip2mQkRFrAU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=tYECgYc5yyiF1g4cWFl/lGkG+TdVLXnfo43+uII9XiNdQ+elEYxq5uZT7FojFhECL
         RJOuXabaLVczgzJNcTGnFk930mzOoY29ugHWO85716FeMKNgG7ENPRsqTIaMesjFYc
         we6AW01ZS5IVonmtX5Qcyy1xxE7D+E/fPcfA3Cx9I1RWGUIzkpuR9C50F0m/EAJLvj
         B+n6YawzltNKgIYsUa8Q4YOuJwXAZS8/WdOehXYRs5LPri4wieWcBsMdqgh8dtQPoB
         MVLqYiJmMyUTPJ6GDClEWJcqhnO+axFL9oli5Wo6Fe9RKby2DamS27dQaYxD0QjePF
         xJflWolWIGrbw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 23BFDE68D5E;
        Sat,  4 Mar 2023 05:50:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/3] bpf: allow ctx writes using BPF_ST_MEM
 instruction
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167790904214.20348.10430967873113079924.git-patchwork-notify@kernel.org>
Date:   Sat, 04 Mar 2023 05:50:42 +0000
References: <20230304011247.566040-1-eddyz87@gmail.com>
In-Reply-To: <20230304011247.566040-1-eddyz87@gmail.com>
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
        yhs@fb.com
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

On Sat,  4 Mar 2023 03:12:44 +0200 you wrote:
> Changes v1 -> v2, suggested by Alexei:
> - Resolved conflict with recent commit:
>   6fcd486b3a0a ("bpf: Refactor RCU enforcement in the verifier");
> - Variable `ctx_access` removed in function `convert_ctx_accesses()`;
> - Macro `BPF_COPY_STORE` renamed to `BPF_EMIT_STORE` and fixed to
>   correctly extract original store instruction class from code.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/3] bpf: allow ctx writes using BPF_ST_MEM instruction
    https://git.kernel.org/bpf/bpf-next/c/0d80a619c113
  - [bpf-next,v2,2/3] selftests/bpf: test if pointer type is tracked for BPF_ST_MEM
    https://git.kernel.org/bpf/bpf-next/c/806f81cd1ee3
  - [bpf-next,v2,3/3] selftests/bpf: Disassembler tests for verifier.c:convert_ctx_access()
    https://git.kernel.org/bpf/bpf-next/c/71cf4d027ad5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


