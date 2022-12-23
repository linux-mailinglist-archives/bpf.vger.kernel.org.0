Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F324B6554D4
	for <lists+bpf@lfdr.de>; Fri, 23 Dec 2022 23:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbiLWWAU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Dec 2022 17:00:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiLWWAT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Dec 2022 17:00:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBCB1DA4D
        for <bpf@vger.kernel.org>; Fri, 23 Dec 2022 14:00:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D95B261F62
        for <bpf@vger.kernel.org>; Fri, 23 Dec 2022 22:00:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 34F38C433F0;
        Fri, 23 Dec 2022 22:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671832816;
        bh=Xe9hncai8Y5ueFvLG2pRFFywZXZ2eIc+LcZ1XZIVsng=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=UfnN5zRZIq4IAsV6D6cArmlwDUcJT3PR9fh7C3o5X+/7i3v6nt9+WDsiBy06RhgTP
         TRRyGqC9S9l8nddlauKEQ2pU1NZU9wLSQyHxHn0dKLTQ8JTGr7IkXLurSkUvph453U
         CxptYY5hFnMi2z1B3rvgVeosyukub80t+aSY84wHXOFVoRX8l1qro5GqHf9kzBmKN9
         QW+PfmlGu6fYUWbba+65YeI7WyRaCed4Afc6zM06PMKHMdYINJ1Uqft/PPU4bflAcX
         U6hqJvyYaHNCKKNeCrBOZdNmCEKjrE2USooBmstd41ij2akS5HbeTWxxV5yk561KiW
         SQpHC3HtrRXzw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 15DD2C395E0;
        Fri, 23 Dec 2022 22:00:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Add host-tools to gitignore
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167183281608.18808.15620680788893753346.git-patchwork-notify@kernel.org>
Date:   Fri, 23 Dec 2022 22:00:16 +0000
References: <20221222213958.2302320-1-sdf@google.com>
In-Reply-To: <20221222213958.2302320-1-sdf@google.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org, jsperbeck@google.com
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
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu, 22 Dec 2022 13:39:58 -0800 you wrote:
> Shows up when cross-compiling:
> 
> HOST_SCRATCH_DIR        := $(OUTPUT)/host-tools
> 
> vs
> 
> SCRATCH_DIR := $(OUTPUT)/tools
> HOST_SCRATCH_DIR        := $(SCRATCH_DIR)
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Add host-tools to gitignore
    https://git.kernel.org/bpf/bpf/c/fcbb408a1aaf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


