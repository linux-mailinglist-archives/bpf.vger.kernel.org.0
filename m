Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74661654376
	for <lists+bpf@lfdr.de>; Thu, 22 Dec 2022 16:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiLVPAV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Dec 2022 10:00:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiLVPAU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Dec 2022 10:00:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4131EC55;
        Thu, 22 Dec 2022 07:00:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D57F4B81E0E;
        Thu, 22 Dec 2022 15:00:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 69944C433F1;
        Thu, 22 Dec 2022 15:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671721216;
        bh=CMpa+PUj+j+rbRF2+Y0Z9BM8CsBNizxrpz30DyjWd4U=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=gETHPXTOUhxXueasRNU3fd75z8o5AxBwsvgbVjbScnR6L05XS3Wppy1oP0RSVuEca
         KP+wNLZQa7FryLO8J2tX3IhHZdi4e0n444RQrFmnI5uFcbVSDJsD2wxLjkMbHNtVMA
         vnBPOhh6BV90slOqGsI9f7mNgScZ440PFUWmEY48p46I3UQ+G+/e/geYvq88LvX63r
         6gbthxT7gqQDJOZlJ/ZMokLxQqR6Q/hysRMTKe/XmqSxthKBprR8nOAAXdolX8GSbA
         Blvyvq42iU9dBu0ukQfzJtw/xkv+Kcu759LPHGcSLU9flgbeBTOA1w2vAX63C648IE
         0WGHzy1UaiXng==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4B79BC43159;
        Thu, 22 Dec 2022 15:00:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf: Remove unused field initialization
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167172121630.11988.10950237578875871796.git-patchwork-notify@kernel.org>
Date:   Thu, 22 Dec 2022 15:00:16 +0000
References: <20221221-bpf-syscall-v1-0-9550f5f2c3fc@chromium.org>
In-Reply-To: <20221221-bpf-syscall-v1-0-9550f5f2c3fc@chromium.org>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     john.fastabend@gmail.com, kpsingh@kernel.org, jolsa@kernel.org,
        martin.lau@linux.dev, daniel@iogearbox.net, haoluo@google.com,
        yhs@fb.com, andrii@kernel.org, ast@kernel.org, song@kernel.org,
        sdf@google.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Wed, 21 Dec 2022 20:55:29 +0100 you wrote:
> Maxlen is used by standard proc_handlers such as proc_dointvec(), but in this
> case we have our own proc_handler. Remove the initialization.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
> bpf: Trivial remove of unitialised field.
> 
> [...]

Here is the summary with links:
  - bpf: Remove unused field initialization
    https://git.kernel.org/bpf/bpf-next/c/cfca00767feb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


