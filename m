Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E136140E0
	for <lists+bpf@lfdr.de>; Mon, 31 Oct 2022 23:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiJaWuT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 31 Oct 2022 18:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiJaWuT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 31 Oct 2022 18:50:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4AC2DC7
        for <bpf@vger.kernel.org>; Mon, 31 Oct 2022 15:50:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1DA86B81AE2
        for <bpf@vger.kernel.org>; Mon, 31 Oct 2022 22:50:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A5F4FC433D6;
        Mon, 31 Oct 2022 22:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667256615;
        bh=bacFh6YTgSFMN8GXsQDqfvtOQsJj3IMTkwKd5RV12HU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=sruh/LI9A61dsrQzkEduk6Q6TAIlBIJa2DQxbt7mFSu8F6joxmM2Qvdr9ic9+/TcO
         WF0UF82e44tCNYcfyCZswU1h/FDeEJLBvFMwGlEcg4R+L4Zpcq3Blun05jwV4Z0F9Y
         DejP/QWzJiEbdBPza2RPTdzNSeN6jGUUkpuefDjV13XcaDj/C34w8XfUV/StfTvWxn
         U7DR6l8+T4X1X1bOQjAOjelihE/2CLU7lq6eyRgg7RdRUzWj/xL7LRJXqcuBSdT8+B
         c+Gb3xF4dlE4tqxpmLjihHefMSqlKRrzW/Xopekc4YZbXHGP1R+B7+xwT/YJqTY5by
         q1Qf1wQ0hb5bw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 87C17C41621;
        Mon, 31 Oct 2022 22:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf: Remove the obsolte u64_stats_fetch_*_irq() users.
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166725661554.6467.13175151760304764686.git-patchwork-notify@kernel.org>
Date:   Mon, 31 Oct 2022 22:50:15 +0000
References: <20221026123110.331690-1-bigeasy@linutronix.de>
In-Reply-To: <20221026123110.331690-1-bigeasy@linutronix.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     bpf@vger.kernel.org, tglx@linutronix.de, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net, haoluo@google.com,
        jolsa@kernel.org, john.fastabend@gmail.com, kpsingh@kernel.org,
        martin.lau@linux.dev, song@kernel.org, sdf@google.com, yhs@fb.com,
        peterz@infradead.org
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed, 26 Oct 2022 14:31:10 +0200 you wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Now that the 32bit UP oddity is gone and 32bit uses always a sequence
> count, there is no need for the fetch_irq() variants anymore.
> 
> Convert to the regular interface.
> 
> [...]

Here is the summary with links:
  - bpf: Remove the obsolte u64_stats_fetch_*_irq() users.
    https://git.kernel.org/bpf/bpf-next/c/97c4090badca

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


