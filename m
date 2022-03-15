Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5CC4DA5D9
	for <lists+bpf@lfdr.de>; Wed, 16 Mar 2022 00:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243667AbiCOXB0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Mar 2022 19:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233625AbiCOXBZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Mar 2022 19:01:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C475D642;
        Tue, 15 Mar 2022 16:00:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16989614D2;
        Tue, 15 Mar 2022 23:00:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 76856C340ED;
        Tue, 15 Mar 2022 23:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647385211;
        bh=ZAYyb2ixDa5wRA9aD6CLX4whJw5yNMl4WGza8Ygu/uk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=cqx/7SfYOQipYK12u0mJ9LQmAFjQPfH0UyLMKdV6yMQg763ezwP6mtB5kqiwFc2f/
         z8nO8jJ/HsF6SlM1tGhbyl2K2GrDhsfs7qtRtdCEq6vAAQz3GP8uBbzoYRbp2s2Huu
         1zyzvdtcuVrYybUq/7Kf3ECKmNTLeIUKDdFw+tBIWnM3eUFhIiwaVmrZZAwkMv6bjR
         D6fdVr4rNUUbda57LGhfWZzBlCMOREN7QOpuy9RwD3wx9xjgqXaP67PidHYtq4JDWt
         3HRhCoiTonfp24iT03HxpagYHOXdsqh4ANe6JQRpnn2ria5CW0u3vwqNUi3lp42NOU
         9eCcIaYZAIozw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 587A1F0383F;
        Tue, 15 Mar 2022 23:00:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpftool: man: Add missing top level docs
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164738521135.3509.18445635022179222335.git-patchwork-notify@kernel.org>
Date:   Tue, 15 Mar 2022 23:00:11 +0000
References: <3049ef5dc509c0d1832f0a8b2dba2ccaad0af688.1647213551.git.dxu@dxuuu.xyz>
In-Reply-To: <3049ef5dc509c0d1832f0a8b2dba2ccaad0af688.1647213551.git.dxu@dxuuu.xyz>
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
by Andrii Nakryiko <andrii@kernel.org>:

On Sun, 13 Mar 2022 16:19:46 -0700 you wrote:
> The top-level (bpftool.8) man page was missing docs for a few
> subcommands and their respective sub-sub-commands.
> 
> This commit brings the top level man page up to date. Note that I've
> kept the ordering of the subcommands the same as in `bpftool help`.
> 
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpftool: man: Add missing top level docs
    https://git.kernel.org/bpf/bpf-next/c/6585abea98ae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


