Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAAB3636B68
	for <lists+bpf@lfdr.de>; Wed, 23 Nov 2022 21:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235311AbiKWUl5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Nov 2022 15:41:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239337AbiKWUli (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Nov 2022 15:41:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C6CD06EF
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 12:40:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C79261F0B
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 20:40:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DDDCFC433B5;
        Wed, 23 Nov 2022 20:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669236017;
        bh=+svj/t3hB1ayvG1ES6wAzz4+UbS7IV/oAIVAm3pxnhk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=M9HK1MyjyuVd8VANxCu2z0YVECVVjjB5o9l/i9JnR9fjdSHCZ15ey1GaR8j0XPuT9
         WZaqNyzuH6xMWWz2zWZt993IllpqgqMw9OCP50lcZONlvpNEe17hvw8qiO1nEXCfZ2
         NULyWRnD4IbUYVIT0XdB9U8win7KgBJ2+Jb0fYUhcQfNbn2mW1kykM0PVYSp8j8sXu
         Z0kUPvlS95DITVEqXQzafG0WKj3evPutlQntsE7h+Y+fhdwVxEJswFXVjqm/PCmnTb
         40wdC4+okZFDmY3YjIDtfQtYDOoglybqGxglZKSmhYpuMMsLHlH3bLVkYAGSzvV9kS
         U6AUs7X5PeX9A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C4268C5C7C6;
        Wed, 23 Nov 2022 20:40:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Mount debugfs in setns_by_fd
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166923601679.11352.8619643103925353553.git-patchwork-notify@kernel.org>
Date:   Wed, 23 Nov 2022 20:40:16 +0000
References: <20221123200829.2226254-1-sdf@google.com>
In-Reply-To: <20221123200829.2226254-1-sdf@google.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org, olsajiri@gmail.com
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

On Wed, 23 Nov 2022 12:08:29 -0800 you wrote:
> Jiri reports broken test_progs after recent commit 68f8e3d4b916
> ("selftests/bpf: Make sure zero-len skbs aren't redirectable").
> Apparently we don't remount debugfs when we switch back networking namespace.
> Let's explicitly mount /sys/kernel/debug.
> 
> 0: https://lore.kernel.org/bpf/63b85917-a2ea-8e35-620c-808560910819@meta.com/T/#ma66ca9c92e99eee0a25e40f422489b26ee0171c1
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Mount debugfs in setns_by_fd
    https://git.kernel.org/bpf/bpf-next/c/8ac88eece800

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


