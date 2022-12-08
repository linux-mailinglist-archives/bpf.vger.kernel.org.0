Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C48B646669
	for <lists+bpf@lfdr.de>; Thu,  8 Dec 2022 02:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiLHBUV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 20:20:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiLHBUT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 20:20:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C6B8E582;
        Wed,  7 Dec 2022 17:20:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F36561D30;
        Thu,  8 Dec 2022 01:20:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7F22EC433C1;
        Thu,  8 Dec 2022 01:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670462417;
        bh=cSto9w8mjmq/CXmkAVhbIHZHjs7H3/Tg1VRKEmKJTa0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=t5dCpj3I35Hwob/RpUZd2N7ilNqd2D2R70weIy9M2sqt12Z+mlZFCLqGy9Bm8qJFy
         q1v23KMNMyrrjh95Ye0vtiYAbIhTwzGRpQxCPnkU4z/WUOWLGaG9WCEjgFIk4OGkx7
         cIt88zLtyHZ5s+V63abrvQ93hn5scQ9JPwVnO6sm5RrHxT6BIn7luqw6as/owsCdof
         dqOX4FjBU36uW11XM4NC/SUjJ7ZDAHODpG2EsyBoKqFcVephPWg8vQHvEqDu0kriI0
         nfe7N1noP4mKGlqovcTInFncI2YNJccmrKAotOzw9nagBR7RXNupYsgMrFzKSxmFU8
         KAcJk5VxFDVTg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6066EE29F38;
        Thu,  8 Dec 2022 01:20:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/2] Document some recent core kfunc additions
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167046241738.30697.7512287636427455231.git-patchwork-notify@kernel.org>
Date:   Thu, 08 Dec 2022 01:20:17 +0000
References: <20221207204911.873646-1-void@manifault.com>
In-Reply-To: <20221207204911.873646-1-void@manifault.com>
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@meta.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed,  7 Dec 2022 14:49:09 -0600 you wrote:
> A series of recent patch sets introduced kfuncs that allowed struct
> task_struct and struct cgroup objects to be used as kptrs. These were
> introduced in [0], [1], and [2].
> 
> [0]: https://lore.kernel.org/lkml/20221120051004.3605026-1-void@manifault.com/
> [1]: https://lore.kernel.org/lkml/20221122145300.251210-2-void@manifault.com/T/
> [2]: https://lore.kernel.org/lkml/20221122055458.173143-1-void@manifault.com/
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/2] bpf/docs: Document struct task_struct * kfuncs
    https://git.kernel.org/bpf/bpf-next/c/25c5e92d197b
  - [bpf-next,v3,2/2] bpf/docs: Document struct cgroup * kfuncs
    https://git.kernel.org/bpf/bpf-next/c/36aa10ffd648

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


