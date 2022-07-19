Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3004957A477
	for <lists+bpf@lfdr.de>; Tue, 19 Jul 2022 19:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237618AbiGSRAZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Jul 2022 13:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237406AbiGSRAU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Jul 2022 13:00:20 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B6931231
        for <bpf@vger.kernel.org>; Tue, 19 Jul 2022 10:00:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3D5D9CE1CFE
        for <bpf@vger.kernel.org>; Tue, 19 Jul 2022 17:00:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3720DC341CB;
        Tue, 19 Jul 2022 17:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658250014;
        bh=a6f4VWeOzB1iRZc/1aSRysg5YinY/6Y8rmdzKOsnjfo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=q0SawwdcDXX3XFLSHE51HMo/cqQ3DdBd0SLAsBs+eod/UK53eS+yw62HfkDKNVH6R
         UPRYTMGf1x5q4DmUWJLG+JHy7uEeX1pRuG+Ycq0AQPbPz0KzxfTSn+0RjOAbULER73
         vBeORh8g/aKy1XYLL/W4VVTMEvZtyet16uK9iiw4PiotPGSSWjETD3XFQt17wMmkMz
         zHj2QRkZYM2lOoDV4wB9jnN2mIQMPfHZJkKDxjOeINXvIBNHKIk8tSljDmAP28wDe7
         0GJ/Tlj0zdgOdyUyFtLV8oDiT99cyVeZChDrktM7cuinInaORBHNjnLiJLxKGsbbbY
         5r7U2Gy7U7H4Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1BC53D9DDDB;
        Tue, 19 Jul 2022 17:00:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] bpf: fix bpf_skb_pull_data documentation
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165825001410.21239.5854552620287717368.git-patchwork-notify@kernel.org>
Date:   Tue, 19 Jul 2022 17:00:14 +0000
References: <20220715193800.3940070-1-joannelkoong@gmail.com>
In-Reply-To: <20220715193800.3940070-1-joannelkoong@gmail.com>
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf@vger.kernel.org, daniel@iogearbox.net, quentin@isovalent.com,
        andrii@kernel.org, ast@kernel.org
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Fri, 15 Jul 2022 12:38:00 -0700 you wrote:
> Fix documentation for bpf_skb_pull_data() helper for
> when len == 0.
> 
> Fixes: fa15601ab31e ("bpf: add documentation for eBPF helpers (33-41)")
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Acked-by: Quentin Monnet <quentin@isovalent.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] bpf: fix bpf_skb_pull_data documentation
    https://git.kernel.org/bpf/bpf-next/c/bdb2bc759929

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


