Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4DA45B4ADB
	for <lists+bpf@lfdr.de>; Sun, 11 Sep 2022 01:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiIJXaR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 10 Sep 2022 19:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiIJXaR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 10 Sep 2022 19:30:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7622625289;
        Sat, 10 Sep 2022 16:30:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9E0760EC3;
        Sat, 10 Sep 2022 23:30:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 08B9CC433C1;
        Sat, 10 Sep 2022 23:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662852615;
        bh=Hwnu5nbdpFcMVDv71MVzoGlnzgKF2elcFcTIZVTNRFo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=NLgjzhOCSqviRtfn0B2xhXNDvQB6mcj4CdcsGA13FTa7VxwaqOpktpGHTxDSW0NsA
         vGCJJ3DSwyMLd7mRTEg0o3lJYN8KkdJCfiMtuGUmtplAYkdPlr60Nb1tff9l2fDBRt
         diIaRobNU7yVxeQ5RNLai9+WDsxgYaQfO83pD2FiDB6KMJmoGjARg+IesRQO0eo8Qh
         TFMtKOF5HewfVjn3n3Po/PwHK9Ua/HQe2hM9hCHEYScBB36Jj+Nng2V789XqmqX95+
         5H2ThEFG4vwfTrIF5/eUeFZu4RweOxvG/HC8nlZDOtDXCTAHviYeRTwwAQUeRkgg+9
         XWH2i+O/mHk8w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DE931E1CABE;
        Sat, 10 Sep 2022 23:30:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] bpf: Simplify code by using for_each_cpu_wrap()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166285261490.22663.16792763568824873547.git-patchwork-notify@kernel.org>
Date:   Sat, 10 Sep 2022 23:30:14 +0000
References: <20220907155746.1750329-1-punit.agrawal@bytedance.com>
In-Reply-To: <20220907155746.1750329-1-punit.agrawal@bytedance.com>
To:     Punit Agrawal <punit.agrawal@bytedance.com>
Cc:     ast@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhoufeng.zf@bytedance.com, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, jolsa@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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

On Wed,  7 Sep 2022 16:57:46 +0100 you wrote:
> In the percpu freelist code, it is a common pattern to iterate over
> the possible CPUs mask starting with the current CPU. The pattern is
> implemented using a hand rolled while loop with the loop variable
> increment being open-coded.
> 
> Simplify the code by using for_each_cpu_wrap() helper to iterate over
> the possible cpus starting with the current CPU. As a result, some of
> the special-casing in the loop also gets simplified.
> 
> [...]

Here is the summary with links:
  - [v2] bpf: Simplify code by using for_each_cpu_wrap()
    https://git.kernel.org/bpf/bpf-next/c/57c92f11a215

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


