Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF10267DE68
	for <lists+bpf@lfdr.de>; Fri, 27 Jan 2023 08:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbjA0HUg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Jan 2023 02:20:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbjA0HUf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 02:20:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6945141A
        for <bpf@vger.kernel.org>; Thu, 26 Jan 2023 23:20:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 49BA4B81FAE
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 07:20:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D73E6C4339B;
        Fri, 27 Jan 2023 07:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674804024;
        bh=kNw/IIo1D213sDd2v3OctO0zOyEBhsq+oOqDdPkgUvY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=BfhzxHF8kR87mO85swrA7s7ei8EnvBGDhVsB0eVBUhZd+x+Pwhp7VsPGgL0FLVUXY
         94VkN87lX7kCZNpJ45lWT87I+R7B6ht2p73v9/dVH9zvdA6KxXBJS6K+8sKgKmw3V8
         uWfxXlrD8gAvHrBAENojQnsoJ3xpY7LSRl5x1ItL6QhWEE3VExTddwVl1gcdGQIYrq
         GF8O8pVcC/f5gcmRFOYqKpcqz3LEHiamChMXF+Xyhg5+OT73BhH3Uu3VXAqD3Q3tPm
         HnZ9y8gw3UCEa/Bct7/NI+S+gShI02o6PWqrf221Tz5mbPvR0/x1XzCvGJD87piaj4
         5kORP2J2PL+yg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A8EBFE54D2C;
        Fri, 27 Jan 2023 07:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Properly enable hwtstamp in
 xdp_hw_metadata
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167480402468.13293.11999774321675833770.git-patchwork-notify@kernel.org>
Date:   Fri, 27 Jan 2023 07:20:24 +0000
References: <20230126225030.510629-1-sdf@google.com>
In-Reply-To: <20230126225030.510629-1-sdf@google.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org, jbrouer@redhat.com
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

On Thu, 26 Jan 2023 14:50:30 -0800 you wrote:
> The existing timestamping_enable() is a no-op because it applies
> to the socket-related path that we are not verifying here
> anymore. (but still leaving the code around hoping we can
> have xdp->skb path verified here as well)
> 
>   poll: 1 (0)
>   xsk_ring_cons__peek: 1
>   0xf64788: rx_desc[0]->addr=100000000008000 addr=8100 comp_addr=8000
>   rx_hash: 3697961069
>   rx_timestamp:  1674657672142214773 (sec:1674657672.1422)
>   XDP RX-time:   1674657709561774876 (sec:1674657709.5618) delta sec:37.4196
>   AF_XDP time:   1674657709561871034 (sec:1674657709.5619) delta
> sec:0.0001 (96.158 usec)
>   0xf64788: complete idx=8 addr=8000
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] selftests/bpf: Properly enable hwtstamp in xdp_hw_metadata
    https://git.kernel.org/bpf/bpf-next/c/a5f3a3f7c172

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


