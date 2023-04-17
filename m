Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9409F6E51E1
	for <lists+bpf@lfdr.de>; Mon, 17 Apr 2023 22:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjDQUaY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Apr 2023 16:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbjDQUaX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Apr 2023 16:30:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E7C35A2
        for <bpf@vger.kernel.org>; Mon, 17 Apr 2023 13:30:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 405B06208F
        for <bpf@vger.kernel.org>; Mon, 17 Apr 2023 20:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A8024C433EF;
        Mon, 17 Apr 2023 20:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681763420;
        bh=WcsGBjK1yEWvEhinc0n/yMaxJ9ppPW2DStqzE9uSiqU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=c2ENkNlSLvsXPJWKgdr6J1uRg4zIb4CgRN/dokHBlLDjgBAF32Cvr8nktAyM29N7T
         RQHNCaI2RRDOZYqI+L3FYVoB3RVb5us2kftvmACsfNasz5LUdC/Ynkq9CaByKYnsuh
         P13LcM7hxzcfijE+5tsIawpeYqoCFhDsP9EYaYVQZVw6tMWZOhcCYoRHQUNs+cDvCI
         LUAloIm07HGuSmj+yjlgfvISM/S2/PU/eXTB6QY8eRr2dbv5PFMpNY6CoJKf55ImeL
         aexoT0XIqJu4m1SfKFUdUgvE0LT74/CqIr3YHvs1m+y0x+VZ4yr5vEB9art8N7sFdC
         RTRAtIMjVMbMA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8B53BE3309F;
        Mon, 17 Apr 2023 20:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Set skb redirect and from_ingress info in
 __bpf_tx_skb
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168176342055.32012.12370430661745438242.git-patchwork-notify@kernel.org>
Date:   Mon, 17 Apr 2023 20:30:20 +0000
References: <8cebc8b2b6e967e10cbafe2ffd6795050e74accd.1681739137.git.daniel@iogearbox.net>
In-Reply-To: <8cebc8b2b6e967e10cbafe2ffd6795050e74accd.1681739137.git.daniel@iogearbox.net>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, john.fastabend@gmail.com, toke@redhat.com,
        laoar.shao@gmail.com, xiangxia.m.yue@gmail.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 17 Apr 2023 15:49:15 +0200 you wrote:
> There are some use-cases where it is desirable to use bpf_redirect()
> in combination with ifb device, which currently is not supported, for
> example, around filtering inbound traffic with BPF to then push it to
> ifb which holds the qdisc for shaping in contrast to doing that on the
> egress device.
> 
> Toke mentions the following case related to OpenWrt:
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Set skb redirect and from_ingress info in __bpf_tx_skb
    https://git.kernel.org/bpf/bpf-next/c/59e498a3289f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


