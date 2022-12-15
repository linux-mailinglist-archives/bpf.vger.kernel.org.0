Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 848B964E397
	for <lists+bpf@lfdr.de>; Thu, 15 Dec 2022 23:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiLOWAW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Dec 2022 17:00:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiLOWAU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Dec 2022 17:00:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D2B2FBED
        for <bpf@vger.kernel.org>; Thu, 15 Dec 2022 14:00:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 344B2B81CC6
        for <bpf@vger.kernel.org>; Thu, 15 Dec 2022 22:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB835C433F1;
        Thu, 15 Dec 2022 22:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671141616;
        bh=2jeT9dIUC38cc2L6qScxaTBwsySOhDlFkKxwfWhDb6A=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=tJzc8gZWnIsF/Fs5adHh4JOjJEr4QBgOh7AnqE6uN2ucHB49IufGwslwtMgD8t8fT
         FPimbx4vj9RGhq8ju2KII7LJCz2Yi69UKjf8gnykceSVImtrjNRPIj2Y8vSTsoshD9
         2BuS5ghZKPvpHTV13wBOAKHTaxwBPwVbqwcNh9lGjwZNlyMOZcks/17146iWszF8xz
         Io88ri49Jj8fzUgVgFrlvF9UsO5zbIpgY0XLxwydQG/cs/8SC7TIBcqsjdnBx0bspQ
         Yg5lvumCNa6Mpm6yF75e+yihYdgikSrMPQvpX+OJl37EADwNtzNTTMMgA2oNqsa3Mr
         wP5viP3RjotHQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B3B94E4D00F;
        Thu, 15 Dec 2022 22:00:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] tools/resolve_btfids: Use pkg-config to locate libelf
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167114161673.4629.16177455019128800096.git-patchwork-notify@kernel.org>
Date:   Thu, 15 Dec 2022 22:00:16 +0000
References: <20221215044703.400139-1-shen_jiamin@comp.nus.edu.sg>
In-Reply-To: <20221215044703.400139-1-shen_jiamin@comp.nus.edu.sg>
To:     Shen Jiamin <shen_jiamin@comp.nus.edu.sg>
Cc:     jolsa@kernel.org, bpf@vger.kernel.org, nathan@kernel.org
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
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu, 15 Dec 2022 12:47:03 +0800 you wrote:
> When libelf was not installed in the standard location, it cannot be
> located by the current building config.
> 
> Use pkg-config to help locate libelf in such cases.
> 
> Signed-off-by: Shen Jiamin <shen_jiamin@comp.nus.edu.sg>
> 
> [...]

Here is the summary with links:
  - [v2] tools/resolve_btfids: Use pkg-config to locate libelf
    https://git.kernel.org/bpf/bpf-next/c/0e43662e61f2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


