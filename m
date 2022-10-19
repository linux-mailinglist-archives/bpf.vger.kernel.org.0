Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5A8605023
	for <lists+bpf@lfdr.de>; Wed, 19 Oct 2022 21:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiJSTKX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Oct 2022 15:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiJSTKW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Oct 2022 15:10:22 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D1416F77F
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 12:10:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 27C57CE242E
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 19:10:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5DF5DC433C1;
        Wed, 19 Oct 2022 19:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666206617;
        bh=NY3rLxM8Iev4uNhFHQ0GzgPnH745P5eJ6FKuOAsu06c=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=rlDV3lvM9/y3g/6wpoJoX6VGlcImyBwisllQdvH26TFv0BovHqNIQsOQ6+wvJcGVW
         87+tRlHjYirv/CDi8SF6+5okZZ4C44X2nfgaPrHvYtgegnksO9Lw1jZOkuyeDM9yWQ
         nG/E7flSxhQS5dS3Q8shj51bT/8B7lq+mInB/I9R2N2QgbubfNaa0qJ6Y7iaTydkSD
         QDl1CsE55JX5JV3JSkDc6bnrWjBmPSwoBm6zZQVh5qQ/0r9nTMJjuurZMZO0cLm24o
         4TyDyasdx4Dfam7ZJYweDk4Uxl9vdUFZ11fDWvP+ua1vn2LEqqTNnwkKsBJ0soQ7Rv
         iUl6BjE3Y7M1g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 47627E29F37;
        Wed, 19 Oct 2022 19:10:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] bpf/docs: Summarize CI system and deny lists
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166620661728.13833.11285378321768362046.git-patchwork-notify@kernel.org>
Date:   Wed, 19 Oct 2022 19:10:17 +0000
References: <20221018164015.1970862-1-deso@posteo.net>
In-Reply-To: <20221018164015.1970862-1-deso@posteo.net>
To:     =?utf-8?q?Daniel_M=C3=BCller_=3Cdeso=40posteo=2Enet=3E?=@ci.codeaurora.org
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kafai@fb.com, kernel-team@fb.com,
        void@manifault.com
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Tue, 18 Oct 2022 16:40:15 +0000 you wrote:
> This change adds a brief summary of the BPF continuous integration (CI)
> to the BPF selftest documentation. The summary focuses not so much on
> actual workings of the CI, as it is maintained outside of the
> repository, but aims to document the few bits of it that are sourced
> from this repository and that developers may want to adjust as part of
> patch submissions: the BPF kernel configuration and the deny list
> file(s).
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] bpf/docs: Summarize CI system and deny lists
    https://git.kernel.org/bpf/bpf-next/c/81bfcc3fcd2f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


