Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC21F688E7F
	for <lists+bpf@lfdr.de>; Fri,  3 Feb 2023 05:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjBCEUV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Feb 2023 23:20:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjBCEUU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Feb 2023 23:20:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1D79774
        for <bpf@vger.kernel.org>; Thu,  2 Feb 2023 20:20:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 573E661D68
        for <bpf@vger.kernel.org>; Fri,  3 Feb 2023 04:20:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9CB8AC4339B;
        Fri,  3 Feb 2023 04:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675398017;
        bh=dhqCmpAO0A8lfuvR2pqcWSE+98z5Jub7Mlyv/WjyTUU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=cqFSbiPrYVBcmbmIg4yoyCzlgt8V0yNTir9cZNyi/Yu4+WUB9pgVyzk51kwdAtb2a
         5YbLtwP89JbXhTP+ncSe7vh0k8mnbQQtgMeN5OJDHxHwWPxd8ukGLLNSECAmKa0j6W
         gun/0ghBqvarEhu3ZLxUg/+QpgT8JHPolFWmXRYeIwH9h6DbonVRFm0V9eIcBaALar
         Xtyj0QwGvZEpO17nmWeOgYoqUBjOnAxctCQng4ph1pfzhBptHoiEqXuiRKaodkqCm2
         g93RDpPSVWK0UX11hgLlKn3SF65FECQaNVHaVvtJ7P2v9zkYiAofdk1mv1Pwm4TZIj
         uSfAqE76155vg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8028EE21ED1;
        Fri,  3 Feb 2023 04:20:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Initialize tc in xdp_synproxy
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167539801751.3373.9546426305112362699.git-patchwork-notify@kernel.org>
Date:   Fri, 03 Feb 2023 04:20:17 +0000
References: <20230202235335.3403781-1-iii@linux.ibm.com>
In-Reply-To: <20230202235335.3403781-1-iii@linux.ibm.com>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        bpf@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, joannelkoong@gmail.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri,  3 Feb 2023 00:53:35 +0100 you wrote:
> xdp_synproxy/xdp fails in CI with:
> 
>     Error: bpf_tc_hook_create: File exists
> 
> The XDP version of the test should not be calling bpf_tc_hook_create();
> the reason it's happening anyway is that if we don't specify --tc on the
> command line, tc variable remains uninitialized.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Initialize tc in xdp_synproxy
    https://git.kernel.org/bpf/bpf-next/c/354bb4a0e0b6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


