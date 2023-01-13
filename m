Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4CAF66A5EE
	for <lists+bpf@lfdr.de>; Fri, 13 Jan 2023 23:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbjAMWaU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Jan 2023 17:30:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjAMWaT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Jan 2023 17:30:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFAD676EC8
        for <bpf@vger.kernel.org>; Fri, 13 Jan 2023 14:30:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80F9B62378
        for <bpf@vger.kernel.org>; Fri, 13 Jan 2023 22:30:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CBD8BC433EF;
        Fri, 13 Jan 2023 22:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673649016;
        bh=uvHEUxgo78zNGAlyoIEYzJRFsz27yVOXV0wIjV3Uck4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=HGKDMS9g0hoVsPHs0II6u1icBaPYGHRxW8MFShrgn/kQ4bVoXUg9Z66ASYRnXveMY
         huqt9pUnfCuiUevm+ps7d31TynegpMxXfy/UyCcqaR5VSG+BgTxBjLjieX+ZPB/Fqr
         QMuZ4jByQyrqZWI6IZfRvNMJMExXTKR2pV5xn8oPAp8TiepSj+2x1dFC7AEbNyzSPH
         JOmNEzKrxnHfuRt5bPZ6lHMrBXlULB5NFpw+mJwX0s8XE9zLWBT9cDO/VdX8NUKrB4
         aD/enbp0BTm1jL0vsJk4oKjt3a1xNYOWHj1PXLc8J7HEtdclCnwqRZtJSlVei27Gno
         4TDDWfK3vHNHw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A8134C395C7;
        Fri, 13 Jan 2023 22:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests/bpf: Fix missing space error
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167364901668.21586.1192739617753444166.git-patchwork-notify@kernel.org>
Date:   Fri, 13 Jan 2023 22:30:16 +0000
References: <20230113180257.39769-1-valenzuelarober@gmail.com>
In-Reply-To: <20230113180257.39769-1-valenzuelarober@gmail.com>
To:     Roberto Valenzuela <valenzuelarober@gmail.com>
Cc:     andrii@kernel.org, mykolal@fb.com, shuah@kernel.org,
        bpf@vger.kernel.org
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

On Fri, 13 Jan 2023 13:02:57 -0500 you wrote:
> Add the missing space after 'dest' variable assignment.
> This change will resolve the following checkpatch.pl
> script error:
> 
> ERROR: spaces required around that '+=' (ctx:VxW)
> Signed-off-by: Roberto Valenzuela <valenzuelarober@gmail.com>
> 
> [...]

Here is the summary with links:
  - selftests/bpf: Fix missing space error
    https://git.kernel.org/bpf/bpf-next/c/1c48391bc673

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


