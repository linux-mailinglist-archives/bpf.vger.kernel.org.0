Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED44F611DD8
	for <lists+bpf@lfdr.de>; Sat, 29 Oct 2022 01:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbiJ1XAS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Oct 2022 19:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiJ1XAR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Oct 2022 19:00:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3551ABA12
        for <bpf@vger.kernel.org>; Fri, 28 Oct 2022 16:00:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46FDF62AD5
        for <bpf@vger.kernel.org>; Fri, 28 Oct 2022 23:00:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8EE55C433D7;
        Fri, 28 Oct 2022 23:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666998015;
        bh=PIzE+isqOcIqQfvHh9TmqH8VOCWe2yh7ns6IvCO5WSs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=XZAQ8RVXuoGO5xe6lClhLbUGuQvYFtyhcFTD4ywdh/Z5ewe7TBbo0dwgw0UGXpXmd
         BH4I5lU/CBUhnVBqrQvn5ONU9P+MOmokHU+peuVfUh1wrH1uswQIrN/gxVl+dEpL8w
         kprDdb185SjhL6gf3yj5vaKPdb0Dl+VXkMGpfBxL43mKy7eqYuZJjN1fEUffDg89jx
         l+h7i3ozKQgnkWi2p2wygQvubhQz92chdfUnCIq9lyo9/a5u2WEXQagk6CQzu9MFdx
         W1+vAM3sw7UUbC25HHpCU1tvhDDnPJmGwt9PwsHj9x70D+xMcpZbFmPcfOJcRiHEON
         xg6tPE6iliUMw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6CD95C41676;
        Fri, 28 Oct 2022 23:00:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] bpf: check max_entries before allocating memory
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166699801544.5069.1477658482393785071.git-patchwork-notify@kernel.org>
Date:   Fri, 28 Oct 2022 23:00:15 +0000
References: <20221028183405.59554-1-dev@der-flo.net>
In-Reply-To: <20221028183405.59554-1-dev@der-flo.net>
To:     Florian Lehner <dev@der-flo.net>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
        john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Fri, 28 Oct 2022 20:34:05 +0200 you wrote:
> For maps of type BPF_MAP_TYPE_CPUMAP memory is allocated first before
> checking the max_entries argument. If then max_entries is greater than
> NR_CPUS additional work needs to be done to free allocated memory before
> an error is returned.
> This changes moves the check on max_entries before the allocation
> happens.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] bpf: check max_entries before allocating memory
    https://git.kernel.org/bpf/bpf-next/c/e39e739ab573

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


