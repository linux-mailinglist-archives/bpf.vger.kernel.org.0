Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11564672F3C
	for <lists+bpf@lfdr.de>; Thu, 19 Jan 2023 03:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjASCuW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Jan 2023 21:50:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjASCuV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 Jan 2023 21:50:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E091CF4B
        for <bpf@vger.kernel.org>; Wed, 18 Jan 2023 18:50:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D0178B8200E
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 02:50:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 73302C433D2;
        Thu, 19 Jan 2023 02:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674096617;
        bh=0aWtTbIR4PCahbtDfr/N6XWpiryukyaEVm/d/3Ku0nM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=CKJzbGVncnzYGcU6uaiRxcFi3B1XsI5ZWulsxO6vIfCxQNb9eza5s2dc579vJYZYz
         ujR6wkCG0pQCe5y/tYc4QO8IeE6/lH+wCl9DBmsnHtEml6S+2xKtRYVqEj2Sc4/AiY
         qlaPqsnoQqbGuOQLBG2itIv8+6EyG9bplF4iwAIwwt5ANXEdzDJTARXqRxSuJLXzm3
         gd90bv6JU3Go1QQQ1vjHlAhNmoWY/oes2bv6iwz9Y6TP9L1ThPTtLPzfOxlfGIaNE4
         dk8twU4sSY1O7Frnvj9u4Tdfz88h79lGQj96/o8pj9AsLhRraew20IT+AvKGS/ZLdX
         AgP+8BVLCJNWg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 55E2FC3959E;
        Thu, 19 Jan 2023 02:50:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: Fix a possible task gone issue with
 bpf_send_signal[_thread]() helpers
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167409661734.25196.8208865085416522489.git-patchwork-notify@kernel.org>
Date:   Thu, 19 Jan 2023 02:50:17 +0000
References: <20230118204815.3331855-1-yhs@fb.com>
In-Reply-To: <20230118204815.3331855-1-yhs@fb.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org,
        sunhao.th@gmail.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 18 Jan 2023 12:48:15 -0800 you wrote:
> In current bpf_send_signal() and bpf_send_signal_thread() helper
> implementation, irq_work is used to handle nmi context. Hao Sun
> reported in [1] that the current task at the entry of the helper
> might be gone during irq_work callback processing. To fix the issue,
> a reference is acquired for the current task before enqueuing into
> the irq_work so that the queued task is still available during
> irq_work callback processing.
> 
> [...]

Here is the summary with links:
  - [bpf] bpf: Fix a possible task gone issue with bpf_send_signal[_thread]() helpers
    https://git.kernel.org/bpf/bpf/c/bdb7fdb0aca8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


