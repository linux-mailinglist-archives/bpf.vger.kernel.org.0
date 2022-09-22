Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 230C95E57F1
	for <lists+bpf@lfdr.de>; Thu, 22 Sep 2022 03:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbiIVBUS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Sep 2022 21:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiIVBUQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Sep 2022 21:20:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0E89750B
        for <bpf@vger.kernel.org>; Wed, 21 Sep 2022 18:20:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9D4963216
        for <bpf@vger.kernel.org>; Thu, 22 Sep 2022 01:20:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 04CF7C433B5;
        Thu, 22 Sep 2022 01:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663809615;
        bh=vxrl5MskWISLh6saaXZ9q4beRMdTt9DKf8duog7VInw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=uiEtft14lrt2ahJ464W+kYUEpaUYEkVxN3t5p5DOTk6VT0PeOhPlySvsKTtKMBmT9
         MqnMZbtE30G/5Ano57zPqAMZ+YzbhKNJR+EfwdGhY/XOjQIxTaw6eqcMx+gCee91XE
         Cm232XAMht9nqpso9HFa87YVLypWkrn7LF3aBW/X9OBlyfLcTuwQuFE89H4rr1u/0Y
         RzMami0TN9y2uFo9hGuRzcnvXbdDQByGG4QvHMHlmDxL0aQnqfeghkhxdjyhFOk58k
         d23kviuowmJjsrtsc7zD+Rx9yE5JxcaIrX+gQhIEVctS9+YoHBaOUaD3TnAzvolJ/w
         spi+SHm8FSUUw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D7F84E4D03C;
        Thu, 22 Sep 2022 01:20:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next RESEND] bpf: Always use raw spinlock for hash bucket
 lock
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166380961488.28833.2007899206692761423.git-patchwork-notify@kernel.org>
Date:   Thu, 22 Sep 2022 01:20:14 +0000
References: <20220921073826.2365800-1-houtao@huaweicloud.com>
In-Reply-To: <20220921073826.2365800-1-houtao@huaweicloud.com>
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, kafai@fb.com,
        andrii@kernel.org, songliubraving@fb.com, haoluo@google.com,
        yhs@fb.com, daniel@iogearbox.net, kpsingh@kernel.org,
        davem@davemloft.net, kuba@kernel.org, sdf@google.com,
        jolsa@kernel.org, john.fastabend@gmail.com, tglx@linutronix.de,
        houtao1@huawei.com
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
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 21 Sep 2022 15:38:26 +0800 you wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> For a non-preallocated hash map on RT kernel, regular spinlock instead
> of raw spinlock is used for bucket lock. The reason is that on RT kernel
> memory allocation is forbidden under atomic context and regular spinlock
> is sleepable under RT.
> 
> [...]

Here is the summary with links:
  - [bpf-next,RESEND] bpf: Always use raw spinlock for hash bucket lock
    https://git.kernel.org/bpf/bpf-next/c/1d8b82c61329

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


