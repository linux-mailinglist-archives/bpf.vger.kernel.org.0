Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 144405E551A
	for <lists+bpf@lfdr.de>; Wed, 21 Sep 2022 23:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiIUVUR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Sep 2022 17:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiIUVUQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Sep 2022 17:20:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC7A8A1C9
        for <bpf@vger.kernel.org>; Wed, 21 Sep 2022 14:20:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9000632F8
        for <bpf@vger.kernel.org>; Wed, 21 Sep 2022 21:20:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4105EC433C1;
        Wed, 21 Sep 2022 21:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663795214;
        bh=q8NQi9M9B4CAytoOqqnooI4j5go6TyWxA9S+aCLGyfU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=b+QdSiLn4W6L68vTV9yRQuB+mnGq3h51xm5TPAOehFeOOqRROKu+hbGJyQ9QUvvG4
         Xwi1DMsBy9Pe9i3RVJ/TJglTPQu6gaqbTJ8NYxTWCtck+YwOMa5LTxcDSM6LaShWt+
         6Sewc2d0FLLtk+9r6m4NqEl3a3PZUR1nXotlJvm2Oq8Aji+CEqbl80eQAwfxTAww3z
         19uhM4Y6CWRmHM/h5gAOb6lIlaWKfjcR8IUaCmZV0MEUUatzUwXbMqzi9l8RSnm3ED
         mdkGURldv2uYHNi0hPYMz9673jVCyu6nIZMytvSoC6EcUAmEsGnvrT/j748tRYnG0+
         7k4dG9ktUETIA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1CFFEE4D03D;
        Wed, 21 Sep 2022 21:20:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2] bpf: Gate dynptr API behind CAP_BPF
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166379521411.5131.648867862425403618.git-patchwork-notify@kernel.org>
Date:   Wed, 21 Sep 2022 21:20:14 +0000
References: <20220921143550.30247-1-memxor@gmail.com>
In-Reply-To: <20220921143550.30247-1-memxor@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, joannelkoong@gmail.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 21 Sep 2022 16:35:50 +0200 you wrote:
> This has been enabled for unprivileged programs for only one kernel
> release, hence the expected annoyances due to this move are low. Users
> using ringbuf can stick to non-dynptr APIs. The actual use cases dynptr
> is meant to serve may not make sense in unprivileged BPF programs.
> 
> Hence, gate these helpers behind CAP_BPF and limit use to privileged
> BPF programs.
> 
> [...]

Here is the summary with links:
  - [bpf,v2] bpf: Gate dynptr API behind CAP_BPF
    https://git.kernel.org/bpf/bpf/c/8addbfc7b308

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


