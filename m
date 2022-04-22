Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC7D50BA1E
	for <lists+bpf@lfdr.de>; Fri, 22 Apr 2022 16:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448491AbiDVOdH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Apr 2022 10:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378396AbiDVOdH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Apr 2022 10:33:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5270E15835
        for <bpf@vger.kernel.org>; Fri, 22 Apr 2022 07:30:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 09596B82ED8
        for <bpf@vger.kernel.org>; Fri, 22 Apr 2022 14:30:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8CF0FC385A8;
        Fri, 22 Apr 2022 14:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650637811;
        bh=/LlwiSvsGRNdzCz1u15ZrAKSCcsfmxhTIez8/1rsisU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=HIZcSDMvg8IlFYnDRxB45De7LymexWEiuAANQnJkc55kjqmyhwYXZAP514N1IdgwF
         ouGEWe68IfoogBOVwtE9HkTpZI5x0NNk709jBGeKSmi2dHEb0CDeYHmBGS/WxGJL2Y
         Ge+Mud3yrbyEo0g3F5R7MHHeHEF9xE4rwI3Fc+JrW8wIGjNKGAyov0dvpo+U5H7MyO
         Sv6eblN2ev0XqK/4ASuDCkCAqRgXyq2wWDFkcmSFUrdKeBFlE3b7Ywyf3pLEfx5xuI
         GNUUje/HDzuRyd95eE3EedZYNvtgmnQjnjkfpKjo0Vn/GhRDaVx3pcAard+DMD6eAz
         x212xg2KxXeYQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6C186E8DD61;
        Fri, 22 Apr 2022 14:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Improve libbpf API documentation link position
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165063781143.12287.662032513051244085.git-patchwork-notify@kernel.org>
Date:   Fri, 22 Apr 2022 14:30:11 +0000
References: <20220422031050.303984-1-grantseltzer@gmail.com>
In-Reply-To: <20220422031050.303984-1-grantseltzer@gmail.com>
To:     grantseltzer <grantseltzer@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Thu, 21 Apr 2022 23:10:50 -0400 you wrote:
> From: Grant Seltzer <grantseltzer@gmail.com>
> 
> This puts the link for libbpf API documentation into
> the sidebar for much easier navigation.
> 
> You can preview this change at:
> 
> [...]

Here is the summary with links:
  - Improve libbpf API documentation link position
    https://git.kernel.org/bpf/bpf-next/c/e8c5e1a0f78f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


