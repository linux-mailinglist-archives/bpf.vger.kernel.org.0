Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B4E4FBFBD
	for <lists+bpf@lfdr.de>; Mon, 11 Apr 2022 17:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347481AbiDKPCa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Apr 2022 11:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347588AbiDKPC3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Apr 2022 11:02:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9BF72125E
        for <bpf@vger.kernel.org>; Mon, 11 Apr 2022 08:00:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53B1D6152A
        for <bpf@vger.kernel.org>; Mon, 11 Apr 2022 15:00:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A2F83C385AA;
        Mon, 11 Apr 2022 15:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649689213;
        bh=V54g/PZEBmb+JWAcE95i2teXsmkq+vHWgOgmnEO0+GI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=CxXIj8HVl+vi11X0GLT5XDDS7N02mF12kpaZlbr825I0jgbC1LoLQ+LFH8s5SuusE
         HjDJ9gOXUq7wqxd7wG9vDzGlVSAE0iBEHueDHnd32AKsCgxlgU31C9DD52/HcYi77B
         qNqao3im9yMah0Ao8zTWbg4Ld3cA+Ev0HcT5Q2EcB41GgvnUr56WY6RXhRkaDhfAHJ
         ZYiEhTtKEZ4AIWGE1aaqViFralU8OvqgN6VtFCASq01Kykqagrs4ZDgIaPODFdzf9B
         nDDvA1QIQA/kJM6PIROMLQCmrHSOpDxapLJY0W+mbNlqJVgOE9fCL344tlVtQt2jMA
         g4ym/5KWjaxGQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7D364E8DBD1;
        Mon, 11 Apr 2022 15:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] riscv,
 bpf: Implement more atomic operations for RV64
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164968921350.21641.10561289384425020291.git-patchwork-notify@kernel.org>
Date:   Mon, 11 Apr 2022 15:00:13 +0000
References: <20220410101246.232875-1-pulehui@huawei.com>
In-Reply-To: <20220410101246.232875-1-pulehui@huawei.com>
To:     Pu Lehui <pulehui@huawei.com>
Cc:     bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
        bjorn@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, luke.r.nels@gmail.com, xi.wang@gmail.com,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
by Daniel Borkmann <daniel@iogearbox.net>:

On Sun, 10 Apr 2022 18:12:46 +0800 you wrote:
> This patch implement more bpf atomic operations for RV64.
> The added operations are shown below:
> 
> atomic[64]_[fetch_]add
> atomic[64]_[fetch_]and
> atomic[64]_[fetch_]or
> atomic[64]_xchg
> atomic[64]_cmpxchg
> 
> [...]

Here is the summary with links:
  - [bpf-next] riscv, bpf: Implement more atomic operations for RV64
    https://git.kernel.org/bpf/bpf-next/c/dd642ccb45ec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


