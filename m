Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7DA7689033
	for <lists+bpf@lfdr.de>; Fri,  3 Feb 2023 08:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbjBCHKb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Feb 2023 02:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232037AbjBCHK1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Feb 2023 02:10:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECA06F22E
        for <bpf@vger.kernel.org>; Thu,  2 Feb 2023 23:10:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E6C561DCA
        for <bpf@vger.kernel.org>; Fri,  3 Feb 2023 07:10:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EC4CCC4339B;
        Fri,  3 Feb 2023 07:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675408218;
        bh=sfSssr4+P2pRwhyEez5GJeaxXbjMh5UL8INFeW7HalA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=cVzTBOLaiapvplszbj4GjUyb2m5t1N+Ctll5Niw/SOS9K0Qgkjd5vMtFDgZL7XuU6
         i1ZsgmRF21LJ/27wnp547xo5Td2hs2kek49X3Nsuo/PcGMxPVFu9Om9wMpk8hunW5B
         iZrhe7azQMgadfVl5NfNHYu2v3Isx8nX7blzabFwEfYRv5t07kRBNdxLwkQ0MoqO9o
         0nZdJKQGRwjJCqoWiFwuJeamobLZL6FTOvvEYD/Pyba3AITcWlVERtK2aQNwYpUXUz
         Wtb6AURd74OyrEB8boaRpqZJBrPM7g9V9Yalt3xUxUjCo9Tf83YN7M8G6gnYx2kEOk
         1VEaftFPuK9Mw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D3B0DE270C5;
        Fri,  3 Feb 2023 07:10:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [bpf-next v3] bpftool: profile online CPUs instead of possible
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167540821786.15411.13278278384216061266.git-patchwork-notify@kernel.org>
Date:   Fri, 03 Feb 2023 07:10:17 +0000
References: <20230202131701.29519-1-tong@infragraf.org>
In-Reply-To: <20230202131701.29519-1-tong@infragraf.org>
To:     Tonghao Zhang <tong@infragraf.org>
Cc:     bpf@vger.kernel.org, quentin@isovalent.com, daniel@iogearbox.net,
        ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org
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
by Martin KaFai Lau <martin.lau@kernel.org>:

On Thu,  2 Feb 2023 21:17:01 +0800 you wrote:
> From: Tonghao Zhang <tong@infragraf.org>
> 
> The number of online cpu may be not equal to possible cpu.
> "bpftool prog profile" can not create pmu event on possible
> but on online cpu.
> 
> $ dmidecode -s system-product-name
> PowerEdge R620
> $ cat /sys/devices/system/cpu/possible
> 0-47
> $ cat /sys/devices/system/cpu/online
> 0-31
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3] bpftool: profile online CPUs instead of possible
    https://git.kernel.org/bpf/bpf-next/c/377c16fa3f3c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


