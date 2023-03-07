Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A866AFA9F
	for <lists+bpf@lfdr.de>; Wed,  8 Mar 2023 00:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjCGXkZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Mar 2023 18:40:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbjCGXkW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Mar 2023 18:40:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59DA88ABFF
        for <bpf@vger.kernel.org>; Tue,  7 Mar 2023 15:40:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 698EF615DE
        for <bpf@vger.kernel.org>; Tue,  7 Mar 2023 23:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B425FC4339C;
        Tue,  7 Mar 2023 23:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678232419;
        bh=SJP3XkrE31e/btkEbTL1F8ZXKMzuu7BrbIhYa26Y8cs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=HvvRc9wS7ZjiZhM3bJODtBr0s3pJpwhIPQiMotSMXysPksWk4JWTaN7TohAqFwydh
         Z+eual0nKhAQlqK74AyGlJPNMWYgQ67ySYzKCxSR2VSlVz66V7GziF3CZEKCyRgvkY
         I7lUsQwSr0cefOIreCE4djHft1FWHeSZNBDTLLPR4K2a0A2o04irRPHga5QXKM3kt1
         aomJEfuhFZGtv2hsTKXGzl7wBx3n2WmxWKqGKtdREJqzslZZF+5fAAjlk5yOptsXE7
         J7ykvc1aVwu7vvEWmQ8bc9+MR7ywmNWOtUKHbXwcJPz7MInTr0TXwizhgKxS2YeGkh
         zz8vhpUITmraw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8AD4CE61B67;
        Tue,  7 Mar 2023 23:40:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: Fix theoretical u32 underflow in find_cd()
 function
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167823241956.30619.9098880763619441540.git-patchwork-notify@kernel.org>
Date:   Tue, 07 Mar 2023 23:40:19 +0000
References: <20230307215504.837321-1-deso@posteo.net>
In-Reply-To: <20230307215504.837321-1-deso@posteo.net>
To:     =?utf-8?q?Daniel_M=C3=BCller_=3Cdeso=40posteo=2Enet=3E?=@ci.codeaurora.org
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com
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

On Tue,  7 Mar 2023 21:55:04 +0000 you wrote:
> Coverity reported a potential underflow of the offset variable used in
> the find_cd() function. Switch to using a signed 64 bit integer for the
> representation of offset to make sure we can never underflow.
> 
> Fixes: 1eebcb60633f ("libbpf: Implement basic zip archive parsing support")
> Signed-off-by: Daniel Müller <deso@posteo.net>
> 
> [...]

Here is the summary with links:
  - [bpf-next] libbpf: Fix theoretical u32 underflow in find_cd() function
    https://git.kernel.org/bpf/bpf-next/c/3ecde2182adb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


