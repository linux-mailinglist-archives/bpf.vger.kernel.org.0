Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27D3D5141A7
	for <lists+bpf@lfdr.de>; Fri, 29 Apr 2022 07:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238094AbiD2FDf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Apr 2022 01:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238134AbiD2FDc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Apr 2022 01:03:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4126265
        for <bpf@vger.kernel.org>; Thu, 28 Apr 2022 22:00:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 87587622A2
        for <bpf@vger.kernel.org>; Fri, 29 Apr 2022 05:00:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E0A74C385AC;
        Fri, 29 Apr 2022 05:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651208412;
        bh=NdEQAxDRvPBPikL90BuDBrVowL1w4jOpE1xyhM1mLHk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=KgJ9rgXlX0jIQRArSaqv3cY9LSKdr2MCOmfY7chJgRziKKuVBkJkgk+BuNNrrN9+x
         oG4wRsAwcYgiNfliQnn11cdPfdNs8AZWrH+VnR347Xhli123QvPOuouZoc5dOyBp8Y
         /BqOHEjuiZveCcLNnq+5RdyLyMR898Xt5TtdIpB83iBX1Pzy+qHyfbiSX+ReMio34R
         W+kX9JoGsEz5gFFpHS2y5VpqFqC6RUFPoIze1WkTBRlXjXOUnq5O+Aj3hy4hb2jFFZ
         8Awkxlj2g4dHO6JJUeMK9Ldv39imTaqoe8FBPJX3UvzgORyu1SAO3g93Ziw7VRipeq
         +uUYxlfHbH4Hg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C6778E5D087;
        Fri, 29 Apr 2022 05:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: fix two memory leaks in prog_tests
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165120841280.3034.6705127789894853504.git-patchwork-notify@kernel.org>
Date:   Fri, 29 Apr 2022 05:00:12 +0000
References: <20220428225744.1961643-1-mykolal@fb.com>
In-Reply-To: <20220428225744.1961643-1-mykolal@fb.com>
To:     Mykola Lysenko <mykolal@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
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

On Thu, 28 Apr 2022 15:57:44 -0700 you wrote:
> Fix log_fp memory leak in dispatch_thread_read_log.
> Remove obsolete log_fp clean-up code in dispatch_thread.
> 
> Also, release memory of subtest_selector. This can be
> reproduced with -n 2/1 parameters.
> 
> Signed-off-by: Mykola Lysenko <mykolal@fb.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: fix two memory leaks in prog_tests
    https://git.kernel.org/bpf/bpf-next/c/20b87e7c29df

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


