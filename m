Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A000869FDA3
	for <lists+bpf@lfdr.de>; Wed, 22 Feb 2023 22:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbjBVVUW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Feb 2023 16:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbjBVVUW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Feb 2023 16:20:22 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A84130EB9;
        Wed, 22 Feb 2023 13:20:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 81D5ACE1EF2;
        Wed, 22 Feb 2023 21:20:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AE269C4339B;
        Wed, 22 Feb 2023 21:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677100817;
        bh=VdBqIJRMLIk4EW2pSklQwLkjQJu/N6EZyOkdQDA0yzo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ZvyRe/TrpVPGEIvgK8WDEqhxitBTaeA3ZnFAse0yYacGalHqvlViutBuRnekH/lps
         NeVZ3MByMJoC8evT8bylP/wKRfVhfnOMOek3XHmly56HBMdMjqjq2cs/4z+kQ3Vvj2
         Ef6FtxgabaTTA80gvK3k/WyT8PUi0tFCebIgeQ0rNmImra0MfI6R6s03HnKCzNqD3I
         rhlDXiwNgTB5m10mmvC7ZPJdjRJQdMM6SvpChx7DpeFOM97PgcEukDUTG+kzpVgqNI
         IWyhs/orKYnJpNuaIXOFuinIZtGQJ9vzM1uZobLspP1PitJHhl6ZuTBkSJHr1/6KyT
         YO0s9U4SUdRZg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8B210C395DF;
        Wed, 22 Feb 2023 21:20:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3] riscv, bpf: Add kfunc support for RV64
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167710081756.15608.10141066511588092218.git-patchwork-notify@kernel.org>
Date:   Wed, 22 Feb 2023 21:20:17 +0000
References: <20230221140656.3480496-1-pulehui@huaweicloud.com>
In-Reply-To: <20230221140656.3480496-1-pulehui@huaweicloud.com>
To:     Pu Lehui <pulehui@huaweicloud.com>
Cc:     bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, bjorn@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, pulehui@huawei.com
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

On Tue, 21 Feb 2023 22:06:56 +0800 you wrote:
> From: Pu Lehui <pulehui@huawei.com>
> 
> This patch adds kernel function call support for RV64. Since the offset
> from RV64 kernel and module functions to bpf programs is almost within
> the range of s32, the current infrastructure of RV64 is already
> sufficient for kfunc, so let's turn it on.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3] riscv, bpf: Add kfunc support for RV64
    https://git.kernel.org/bpf/bpf-next/c/d40c3847b485

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


