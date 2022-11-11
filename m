Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C78976261F0
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 20:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233908AbiKKTaW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Nov 2022 14:30:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233593AbiKKTaU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 14:30:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212176CA2C;
        Fri, 11 Nov 2022 11:30:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 946BEB82798;
        Fri, 11 Nov 2022 19:30:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 301A9C433B5;
        Fri, 11 Nov 2022 19:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668195016;
        bh=+v1+NIo24cO3WPlk7aT5pT5gGXZgqePZFhna1SyKOpQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=beP4hXYfxhapV0/f+vgX82UyoK7M9/yEDWnlPU56MXkvkI2mcnolnB5hNiSZxfJQx
         nJTGTd0PIVs4RUo5ItuF7KBqQHscitgGABljnInUBBzA+xzrDfmRhxfrFrdVULHVRp
         RZAUpEmVlnFG+Q0L7/NBThpuM+tmS1hFpWxxStfPm9jz8sRdXYsRSDgxbBrWHr33eG
         LJoHX6erF8gDQZ8PFV07tJFFQRa5ekeqsn3lPznElpMHf0074ed5/RpnbV0pmlreLp
         kjDKcAoxQ13Gth30kWD0EeNH6ER9R6cICHE5m5jFGFb6tR+kduvMoL4D1UQkt8R7IK
         sVsIwFfoo9XeA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 11690E4D022;
        Fri, 11 Nov 2022 19:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/1] Document BPF_MAP_TYPE_LPM_TRIE
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166819501606.28850.1971179882661561739.git-patchwork-notify@kernel.org>
Date:   Fri, 11 Nov 2022 19:30:16 +0000
References: <20221101114542.24481-1-donald.hunter@gmail.com>
In-Reply-To: <20221101114542.24481-1-donald.hunter@gmail.com>
To:     Donald Hunter <donald.hunter@gmail.com>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, corbet@lwn.net
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
by Andrii Nakryiko <andrii@kernel.org>:

On Tue,  1 Nov 2022 11:45:41 +0000 you wrote:
> Add documentation for BPF_MAP_TYPE_LPM_TRIE including kernel
> BPF helper usage, userspace usage and examples.
> 
> v1->v2:
> - Point to code in tools/testing/selftests/... as requested
>   by John Fastabend
> - Clean up some wording
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/1] Document BPF_MAP_TYPE_LPM_TRIE
    https://git.kernel.org/bpf/bpf-next/c/656234e8e9c1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


