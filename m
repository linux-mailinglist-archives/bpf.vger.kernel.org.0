Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18065BB2BD
	for <lists+bpf@lfdr.de>; Fri, 16 Sep 2022 21:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiIPTUS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Sep 2022 15:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiIPTUR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Sep 2022 15:20:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3A8DFD3;
        Fri, 16 Sep 2022 12:20:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF2C562D5B;
        Fri, 16 Sep 2022 19:20:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 53365C433D7;
        Fri, 16 Sep 2022 19:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663356015;
        bh=lPlqkRRudlxXuNXZMNqZogltQqVp/RnS/bAt1ZVpMgY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=TNHUuLeGRztd7W9jf2YzzBni7cCIcl9VmUXP0YidkztTAuRgkXuZ19oHNof1nGrMD
         O2yV+XF0UDPQ63ZDXkokxQ186f9qq8jNSqTm5O99ZzhoU9Cz+9tw/qILxJox7id/QR
         9nnghQqyAlBcJMJo3IuHv7ljGTdd7QZnkrE71bvAwkUoM4zRo8SkRJ85dEYwSEHRH2
         61hhKFJXfYSQgRno/80X9mP4mcv3t/MaMj1/7FPivgfx+Z7Co1mJwo9c2+QLy3IHV/
         NoKAd1aP+eL9Io7+67RdzmgyeuZNZ5B117kp8vh9UM7xor04OzF3xHblHx7k/3NLMT
         KiVuzdEmgdUHg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 33893C73FFD;
        Fri, 16 Sep 2022 19:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [bpf-next v2] bpf: use kvmemdup_bpfptr helper
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166335601520.29954.12078460242323045078.git-patchwork-notify@kernel.org>
Date:   Fri, 16 Sep 2022 19:20:15 +0000
References: <1663058433-14089-1-git-send-email-wangyufen@huawei.com>
In-Reply-To: <1663058433-14089-1-git-send-email-wangyufen@huawei.com>
To:     Wang Yufen <wangyufen@huawei.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Tue, 13 Sep 2022 16:40:33 +0800 you wrote:
> Use kvmemdup_bpfptr helper instead of open-coding to
> simplify the code.
> 
> Signed-off-by: Wang Yufen <wangyufen@huawei.com>
> ---
>  kernel/bpf/syscall.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)

Here is the summary with links:
  - [bpf-next,v2] bpf: use kvmemdup_bpfptr helper
    https://git.kernel.org/bpf/bpf-next/c/a02c118ee9e8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


