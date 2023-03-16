Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 263266BD6DC
	for <lists+bpf@lfdr.de>; Thu, 16 Mar 2023 18:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjCPRUY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Mar 2023 13:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjCPRUX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Mar 2023 13:20:23 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BEC9EF53
        for <bpf@vger.kernel.org>; Thu, 16 Mar 2023 10:20:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 664CCCE1DE2
        for <bpf@vger.kernel.org>; Thu, 16 Mar 2023 17:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AA489C433D2;
        Thu, 16 Mar 2023 17:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678987218;
        bh=7nKQ0besidCmKBelF3Wxjr5U2Fy+PYQBnS/dwbmeAvI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=c37jFcUM59oC7eIaRLva0DOcjpndJTZGgQuZ9CKIpRCL6EpUoc4+nUAvm/jIoNzB4
         5Je/MfcUEdxoHS/o1N8r5wZNy1aWc3WSTEQSqfdAPkNSLCYkhaiZa0uEJ5WU0pv7gk
         7B5/w6WK2Nr8hnFgSTSpMjYjmniuC0AxdW8aQNzKXDsmDjLbDNhALKtd2Lbs7j2AEg
         TENAmTqS8wt7jp68SZjsxP4A5uMmVGuqGJ+nqAH12v4up7R6GWmVfN6dAhlEXZ8EkM
         mL7h//Ts765/lKVCRs9M9lRsTGE38NNjCP80lrnFaIGwfK4oD/3l9U+4SNZBfW8PJq
         vXtARAfPssxUA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8EBC2E66CBB;
        Thu, 16 Mar 2023 17:20:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 1/2] selftests/bpf: Use ASSERT_EQ instead ASSERT_OK
 for testing memcmp result
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167898721857.17943.15737135719448149645.git-patchwork-notify@kernel.org>
Date:   Thu, 16 Mar 2023 17:20:18 +0000
References: <20230316000726.1016773-1-martin.lau@linux.dev>
In-Reply-To: <20230316000726.1016773-1-martin.lau@linux.dev>
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@meta.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed, 15 Mar 2023 17:07:25 -0700 you wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
> 
> In tcp_hdr_options test, it ensures the received tcp hdr option
> and the sk local storage have the expected values. It uses memcmp
> to check that. Testing the memcmp result with ASSERT_OK is confusing
> because ASSERT_OK will print out the errno which is not set.
> This patch uses ASSERT_EQ to check for 0 instead.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] selftests/bpf: Use ASSERT_EQ instead ASSERT_OK for testing memcmp result
    https://git.kernel.org/bpf/bpf-next/c/ed01385c0d78
  - [bpf-next,2/2] selftests/bpf: Fix a fd leak in an error path in network_helpers.c
    https://git.kernel.org/bpf/bpf-next/c/226efec2b0ef

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


