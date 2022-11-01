Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026C4614C92
	for <lists+bpf@lfdr.de>; Tue,  1 Nov 2022 15:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbiKAOaS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Nov 2022 10:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiKAOaS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Nov 2022 10:30:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C218A110B;
        Tue,  1 Nov 2022 07:30:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 56F7F615AF;
        Tue,  1 Nov 2022 14:30:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AAF6DC4347C;
        Tue,  1 Nov 2022 14:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667313016;
        bh=ZCJi1QKVSgXppL1wVNoJe/zSNvL8z5hSmZR27la9b/Y=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=GvBVXwwIj8mW9A+n7HSqDg0yiJwREh09RDtxlQpkqpuR7Rszxqsifli5tdjqkujV+
         FRh3puy+f+PpN3+XjglskJGbbrdj5EAi2pElLQJ48fhyuTKrxSPZ7qSr9vpkdhgxPH
         8Qoh+4LQdEtDAZhQ14jLQzwfH0qOTZi4bbYiBoTGPboOFiOHo7SZMjw53HjCFtMxLp
         /gc7Hpm4gqIReSXVImwgR4N4/SlyuAbayiVBDPaKYAfIFMK6H4zAqpgMXFlxtCOUj7
         dqATvyYm4pFCW60k1J1aBmOLN9bk7CQYdEr7nDuu5hVpheAxwkkt1MGhGptuAGyhin
         E8DkXZyark1qQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8E141E270F9;
        Tue,  1 Nov 2022 14:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] samples/bpf: fix typo in README
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166731301656.5047.18005358972567247135.git-patchwork-notify@kernel.org>
Date:   Tue, 01 Nov 2022 14:30:16 +0000
References: <20221030180254.34138-1-tegongkang@gmail.com>
In-Reply-To: <20221030180254.34138-1-tegongkang@gmail.com>
To:     Kang Minchul <tegongkang@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Mon, 31 Oct 2022 03:02:54 +0900 you wrote:
> Fix 'cofiguration' typo in BPF samples README.
> 
> Signed-off-by: Kang Minchul <tegongkang@gmail.com>
> ---
> V1 -> V2: Amended the commit message more precisely
> 
>  samples/bpf/README.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [v2] samples/bpf: fix typo in README
    https://git.kernel.org/bpf/bpf-next/c/3a07dcf8f57b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


