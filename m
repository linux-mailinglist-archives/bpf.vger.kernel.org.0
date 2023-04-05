Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2C06D89CC
	for <lists+bpf@lfdr.de>; Wed,  5 Apr 2023 23:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjDEVuV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Apr 2023 17:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjDEVuU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Apr 2023 17:50:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8AC44B6
        for <bpf@vger.kernel.org>; Wed,  5 Apr 2023 14:50:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EDFD662AB3
        for <bpf@vger.kernel.org>; Wed,  5 Apr 2023 21:50:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5527EC433D2;
        Wed,  5 Apr 2023 21:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680731418;
        bh=b9rLa4ivJfl7VQxHWk6azzNo04MOo33Q8HkJRGwGMro=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=aR0cw9Ttkwp15jU1ioZkd+zcqq4n4sTt7OxNITsL5OueIpV1Ts7kKtHVVtt6hghi9
         9OSDEpBydOq2f/ycPpuMc8zXJvBQ3i/BqZtmQ5ANcdfHkYAIZy6Pn3kBq8bGy6ulHe
         0gCO0RduKru9FOfXYGm7owV0sNbeiLGIByKxTDVJvtzLGTLXE/UATolGGRw2pPb3si
         uvtrmngzZOf6C5ia3B6XbIR13V6VJ0TY196ZmZJUZknnem2JCARVLjNGhq1HBxCDT9
         MHb8ln/5rza7nN9bpJFUFF32awmKB/s2HuVSVQTUsDcw0vxaqid+5M87uN1iXToqV4
         oRRTAkFNbJFKg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3185AC4167B;
        Wed,  5 Apr 2023 21:50:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf] selftests/bpf: Wait for receive in cg_storage_multi
 test
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168073141817.26121.10974496798503990696.git-patchwork-notify@kernel.org>
Date:   Wed, 05 Apr 2023 21:50:18 +0000
References: <20230405193354.1956209-1-zhuyifei@google.com>
In-Reply-To: <20230405193354.1956209-1-zhuyifei@google.com>
To:     YiFei Zhu <zhuyifei@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        sdf@google.com, martin.lau@linux.dev, andrii@kernel.org
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Wed,  5 Apr 2023 19:33:54 +0000 you wrote:
> In some cases the loopback latency might be large enough, causing
> the assertion on invocations to be run before ingress prog getting
> executed. The assertion would fail and the test would flake.
> 
> This can be reliably reproduced by arbitrarily increasing the
> loopback latency (thanks to [1]):
>   tc qdisc add dev lo root handle 1: htb default 12
>   tc class add dev lo parent 1:1 classid 1:12 htb rate 20kbps ceil 20kbps
>   tc qdisc add dev lo parent 1:12 netem delay 100ms
> 
> [...]

Here is the summary with links:
  - [v2,bpf] selftests/bpf: Wait for receive in cg_storage_multi test
    https://git.kernel.org/bpf/bpf-next/c/5af607a861d4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


