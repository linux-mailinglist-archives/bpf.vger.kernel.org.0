Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E54E75F1652
	for <lists+bpf@lfdr.de>; Sat,  1 Oct 2022 00:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbiI3WuT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Sep 2022 18:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbiI3WuS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Sep 2022 18:50:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6498CE007A
        for <bpf@vger.kernel.org>; Fri, 30 Sep 2022 15:50:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9445C62566
        for <bpf@vger.kernel.org>; Fri, 30 Sep 2022 22:50:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E10AAC433C1;
        Fri, 30 Sep 2022 22:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664578215;
        bh=mloHjKjhBS69pHPRycOpWhjUCN8lK6EK2CFnauyFWdY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=HXAalcYeoZVaEIup4/tu4m1O4Qf4U9M9o7IXddifLxrUlU2yQfLj4xbAimG4tY+RN
         bwBJSSo4rrBJ21T+Aa0zODnMaduNUx5cOUNt6XU1m7lPrZsLHcqnWMnHs5ISr8SLjo
         L60xn/tEuwxvgbFMQxPJuPnxU7hqztoIUN6aYPs5yUudHY7HcDO54snGwGWZwPqyga
         lEWv7NbuFonbJTsH9thVonbQAnqjPXsDTfGOFbjZDDdusDpXHtsr68y3uUDXZP6d9R
         a3Khsw806HNCf5Cj63/wmwTWWZLcq8DHUZXEsQr/MqJp5psKNmDIk4ekFG/HS/jJxr
         MiuXS4+f/3CJQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C65DAE50D64;
        Fri, 30 Sep 2022 22:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] bpftool: Fix error message of strerror
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166457821580.20099.13099293716781387232.git-patchwork-notify@kernel.org>
Date:   Fri, 30 Sep 2022 22:50:15 +0000
References: <SY4P282MB1084AD9CD84A920F08DF83E29D549@SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM>
In-Reply-To: <SY4P282MB1084AD9CD84A920F08DF83E29D549@SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM>
To:     Tianyi Liu <i.pear@outlook.com>
Cc:     quentin@isovalent.com, bpf@vger.kernel.org
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Wed, 28 Sep 2022 16:09:32 +0800 you wrote:
> strerror() expects a positive errno, however variable err will never be
> positive when an error occurs. This causes bpftool to output too many
> "unknown error", even a simple "file not exist" error can not get an
> accurate message.
> 
> This patch fixed all "strerror(err)" patterns in bpftool.
> Specially in btf.c#L823, hashmap__append() is an internal function of
> libbpf and will not change errno, so there's a little difference.
> Some libbpf_get_error() calls are kept for return values.
> 
> [...]

Here is the summary with links:
  - [v2] bpftool: Fix error message of strerror
    https://git.kernel.org/bpf/bpf-next/c/3ca2fb497440

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


