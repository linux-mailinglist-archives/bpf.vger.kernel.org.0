Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A97A158A2E2
	for <lists+bpf@lfdr.de>; Thu,  4 Aug 2022 23:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237281AbiHDVuS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Aug 2022 17:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237575AbiHDVuQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Aug 2022 17:50:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5FEBC1;
        Thu,  4 Aug 2022 14:50:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BDB63617D4;
        Thu,  4 Aug 2022 21:50:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1E44AC433B5;
        Thu,  4 Aug 2022 21:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659649814;
        bh=i4PJuzDt2glZTSZaQmE3My1ArcAuGpSkA+2xDdLChko=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=XaHo5yFcn0oHiJu6N5owlQQrNuyFtI7xs7Kc7y/siKHuY8C8Qw3Vv+ZGhF4DJn25m
         bAAKviwfna6M+ef18YLL2tL0FeCQ+Vzg1yud65Stx3tFpX1QR9y3/uQXm+RxNLXuU7
         Rrz5LQSCSEGSCkUsLFdxlr3Ja0mmNNyHsw9y3R2Pnm7jYSpK6Pj2Ox7SoSx3Ed1pGz
         ZWrUxi/eiArAwqxDW27c4q4AnX5ycjWT4gsCulG1NTIbgiDGhSAXRzut8udJ1r1lnN
         KJXN14a0oYJFNLD4NMTwuD/nes0jM00aLpM3fsvZJUDqkM4Geer7ggrnqQXRji4ysX
         VQEQO62tmmmhA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0651DC43145;
        Thu,  4 Aug 2022 21:50:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] libbpf: Initialize err in probe_map_create
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165964981402.20332.403823292048774488.git-patchwork-notify@kernel.org>
Date:   Thu, 04 Aug 2022 21:50:14 +0000
References: <20220801025109.1206633-1-f.fainelli@gmail.com>
In-Reply-To: <20220801025109.1206633-1-f.fainelli@gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        davemarchevsky@fb.com, linux-kernel@vger.kernel.org
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
by Andrii Nakryiko <andrii@kernel.org>:

On Sun, 31 Jul 2022 19:51:09 -0700 you wrote:
> GCC-11 warns about the possibly unitialized err variable in
> probe_map_create:
> 
> libbpf_probes.c: In function 'probe_map_create':
> libbpf_probes.c:361:38: error: 'err' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>   361 |                 return fd < 0 && err == exp_err ? 1 : 0;
>       |                                  ~~~~^~~~~~~~~~
> 
> [...]

Here is the summary with links:
  - libbpf: Initialize err in probe_map_create
    https://git.kernel.org/bpf/bpf-next/c/3045f42a6432

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


