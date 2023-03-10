Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25B5F6B5033
	for <lists+bpf@lfdr.de>; Fri, 10 Mar 2023 19:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjCJSkV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Mar 2023 13:40:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjCJSkU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Mar 2023 13:40:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4D511EE9D;
        Fri, 10 Mar 2023 10:40:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28AA161CA4;
        Fri, 10 Mar 2023 18:40:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 714AEC4339B;
        Fri, 10 Mar 2023 18:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678473618;
        bh=N7gdznyiUiR97p2vgJ9BEbeYaZYIiLuXK/BYh0jZCbQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=nMhvLJqeIcwCZ1GaYech4O1aqeA7BHp5xohVYfmOo2cYka6RQQnja87/bdq9LQLYz
         8+8nrltDV0ZeKvCU+UgrwUY+8Xz3BEd6wZi0gNLixGdkfT/r5/blskJpahotynrFl4
         77yGYME1SBeI6iIlNn+QwbxBu3jgpjUriHhv88oqfYjYZzoeh4mYZPd8WqbluqRFTK
         DRoQOxr02we+BN+CquO6Ikbvsy3zMdKhmNHeqnobYXtlYuRlEOH/VeLYFpw6jmfXq0
         PKshkxMyqv6zwUqJhaMo5KsnR9BkXTVKgSmHjAqzz8PLrxyZHrmOISeGK1+mYUb8vV
         8rQ1S+2UjbrJA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 56DEDE21EEE;
        Fri, 10 Mar 2023 18:40:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] bpf/selftests: Fix send_signal tracepoint tests
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167847361834.10927.6910636088555902651.git-patchwork-notify@kernel.org>
Date:   Fri, 10 Mar 2023 18:40:18 +0000
References: <20230310061909.1420887-1-void@manifault.com>
In-Reply-To: <20230310061909.1420887-1-void@manifault.com>
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@meta.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
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

On Fri, 10 Mar 2023 00:19:09 -0600 you wrote:
> The send_signal tracepoint tests are non-deterministically failing in
> CI. The test works as follows:
> 
> 1. Two pairs of file descriptors are created using the pipe() function.
>    One pair is used to communicate between a parent process -> child
>    process, and the other for the reverse direction.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] bpf/selftests: Fix send_signal tracepoint tests
    https://git.kernel.org/bpf/bpf-next/c/4a54de65964d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


