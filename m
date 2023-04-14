Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3DA16E1B33
	for <lists+bpf@lfdr.de>; Fri, 14 Apr 2023 06:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjDNEuV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Apr 2023 00:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjDNEuU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Apr 2023 00:50:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFBC644B2
        for <bpf@vger.kernel.org>; Thu, 13 Apr 2023 21:50:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 47E966439C
        for <bpf@vger.kernel.org>; Fri, 14 Apr 2023 04:50:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 88555C4339B;
        Fri, 14 Apr 2023 04:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681447818;
        bh=KiixsDLjJ72LhJIED8AL77NOJ6FVZNFG780YgmprLfE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=WSWTwwz2Y0+CbCcuEaMWcBjt3BA3/UK3zpq+uUpj9L4jmQ8EOHXzKCaXMNSPz8EKL
         o+diR/b8Dxm3WYp0bMt82aP/fnWW1pE3A6k+k7yNpaC+3Qmutc2knD7KeTkHlMlTI3
         vpBGKOPY5ZRERESh6K04Gpx+eCcRYAiUcvmBdalMFvgmgiS9AN2LUz6zPOvw6EbJUT
         EaZnFl+kLGwePZMQQxgOqrxFPmoR7J6Ck5Ab90mwDdvS+1/IFK2BBiOTt1F1ShPDph
         iJmMtd64RIZcKf8kfS7WG0j0R1LytPA3XPIlzcX6ttjDfCQrl1PmXAMwnQN9/oEO7N
         ok0YmvwrjckPA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6D156E21EDE;
        Fri, 14 Apr 2023 04:50:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v7] bpf: Support 64-bit pointers to kfuncs
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168144781844.11167.14769684854689343132.git-patchwork-notify@kernel.org>
Date:   Fri, 14 Apr 2023 04:50:18 +0000
References: <20230412230632.885985-1-iii@linux.ibm.com>
In-Reply-To: <20230412230632.885985-1-iii@linux.ibm.com>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        bpf@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, olsajiri@gmail.com, sdf@google.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 13 Apr 2023 01:06:32 +0200 you wrote:
> test_ksyms_module fails to emit a kfunc call targeting a module on
> s390x, because the verifier stores the difference between kfunc
> address and __bpf_call_base in bpf_insn.imm, which is s32, and modules
> are roughly (1 << 42) bytes away from the kernel on s390x.
> 
> Fix by keeping BTF id in bpf_insn.imm for BPF_PSEUDO_KFUNC_CALLs,
> and storing the absolute address in bpf_kfunc_desc.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v7] bpf: Support 64-bit pointers to kfuncs
    https://git.kernel.org/bpf/bpf-next/c/1cf3bfc60f98

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


