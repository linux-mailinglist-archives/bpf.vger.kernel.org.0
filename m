Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 889D36CAD52
	for <lists+bpf@lfdr.de>; Mon, 27 Mar 2023 20:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjC0Skx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Mar 2023 14:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbjC0Skx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Mar 2023 14:40:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33AA819BF
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 11:40:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9A21BB818C4
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 18:40:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3C5D4C433D2;
        Mon, 27 Mar 2023 18:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679942418;
        bh=8VpPcxrpnvOlyjZG59wKWXsCK0AtT7zJbpRJcQvZrXo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=IrlTwMucTSniK8jTcyZ35LY8SjAWW0Xp2OK4PTJip+uUEyeOSR/ra8YbNujDXN/y6
         bWP8Pi7AKi790d1ShesZ/ETJ9EDnbmkJskn6j1vQASCx3YxLUrQxa7KWs7ACw8BeLO
         f5hDAEA+a8L+NENlKVd+Y+Vd5k/I/K9towyV2DXprhWA6u0PNHJULaOykV1sXD4YOq
         V7jEEhCDDAZGbRjlCl80brbAg/1NNrRMNudYSG7uC6mWtvfxTrYhXk4yH1oyvuUa5A
         gDPsThsdUvJAVDPnXTrtelt4bP0cuJRV91yBMdJJHRfpMzq08dX45elGnvfZdOjtl+
         ZFP6bWGIeMyTQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1A739E2A038;
        Mon, 27 Mar 2023 18:40:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: synchronize access to print function pointer
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167994241809.20452.240028060464380713.git-patchwork-notify@kernel.org>
Date:   Mon, 27 Mar 2023 18:40:18 +0000
References: <20230325010845.46000-1-inwardvessel@gmail.com>
In-Reply-To: <20230325010845.46000-1-inwardvessel@gmail.com>
To:     JP Kobryn <inwardvessel@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, kernel-team@meta.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri, 24 Mar 2023 18:08:45 -0700 you wrote:
> This patch prevents races on the print function pointer, allowing the
> libbpf_set_print() function to become thread safe.
> 
> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
> ---
>  tools/lib/bpf/libbpf.c | 9 ++++++---
>  tools/lib/bpf/libbpf.h | 3 +++
>  2 files changed, 9 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [bpf-next] libbpf: synchronize access to print function pointer
    https://git.kernel.org/bpf/bpf-next/c/f1cb927cdb62

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


