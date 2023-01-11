Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553FA66502A
	for <lists+bpf@lfdr.de>; Wed, 11 Jan 2023 01:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235466AbjAKAA3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Jan 2023 19:00:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235371AbjAKAAR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Jan 2023 19:00:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94135792C;
        Tue, 10 Jan 2023 16:00:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 853F56195F;
        Wed, 11 Jan 2023 00:00:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D2B56C433F0;
        Wed, 11 Jan 2023 00:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673395215;
        bh=mEWQ7a5qfQ/boPkXx/AzT+t/qpGYEXDz2iCILTDJr0Y=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Jac3BkS/yd1/YSLGRy1V0F4011VX76GJKKlIt1kbTraK5w+9GffVjXtDbIm6gqrI+
         Xr/aJVekD8hqf3yWdhl7p4B/JBAG7u/O7TA5Gpn8V8EelpPvL4Xm4NKIHAx5lPKvB5
         6yDr8VNa6HC3PHI0HmLUtV339LUFF/kE8S9c/2MG2eALwWkGUTHhu5cmEV3F93zsys
         jLckuK9pckrWZnXuhoF7TB5giybxe9IKwQiUUFpxhpONlcDnhmYu/Cz4gKWVKfahG7
         h4g1tqvLTFEBeJIuLw370fyanyNknBguQUkYB4jayzkk+nLDi+Me1CXwiZ3Hbqj2ah
         PiJE0JyEXQGAg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B8A58E21EE9;
        Wed, 11 Jan 2023 00:00:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] bpf,
 x86: Simplify the parsing logic of structure parameters
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167339521575.26336.15370569553745702242.git-patchwork-notify@kernel.org>
Date:   Wed, 11 Jan 2023 00:00:15 +0000
References: <20230105035026.3091988-1-pulehui@huaweicloud.com>
In-Reply-To: <20230105035026.3091988-1-pulehui@huaweicloud.com>
To:     Pu Lehui <pulehui@huaweicloud.com>
Cc:     bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, yhs@fb.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        pulehui@huawei.com
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
by Martin KaFai Lau <martin.lau@kernel.org>:

On Thu,  5 Jan 2023 11:50:26 +0800 you wrote:
> From: Pu Lehui <pulehui@huawei.com>
> 
> Extra_nregs of structure parameters and nr_args can be
> added directly at the beginning, and using a flip flag
> to identifiy structure parameters. Meantime, renaming
> some variables to make them more sense.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] bpf, x86: Simplify the parsing logic of structure parameters
    https://git.kernel.org/bpf/bpf-next/c/7f7880495770

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


