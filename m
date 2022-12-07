Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2376D64509E
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 01:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiLGAuT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 19:50:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiLGAuR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 19:50:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479E5CF3;
        Tue,  6 Dec 2022 16:50:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B30E36198E;
        Wed,  7 Dec 2022 00:50:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0C68CC433B5;
        Wed,  7 Dec 2022 00:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670374216;
        bh=jbnVArGlxnRT5FzNlksKzAI/8V+O9eUpiQYRz9VwdWY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=LP/Km6bIlWJM/OJwWqmbj45/DRNZs5NPDO+y4gdsi55URZjvZZWAO1acKRe5zuXu6
         UwSwOV/SxeeZ9rX5An/okFe6T1u3tsu5TImnsjOymyItjQ8vvm1AaBvjZbmPmTIWIr
         VSVYR8LH3KenEDzbrRq+cwFJS/v1eUQWKIuN75u/kNAVaeuuEfMLxX3bO2ox4lh5r9
         bgtEGeaA5BvYjfxvqMs7d/E9kjHCoMk43VVk/+YZ37UIcnGMa0BzRi6ddLBbtjWNSr
         yef2+IfcSRfqU+ljLuhJORxCAd8WVSSH8Dz0KEBHs8vp/BZO0IK1tufCkJRsgk6GPJ
         sup7l//yU6urQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DDE8AE56AA3;
        Wed,  7 Dec 2022 00:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Don't use rcu_users to refcount in task kfuncs
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167037421590.21168.15544394333663900920.git-patchwork-notify@kernel.org>
Date:   Wed, 07 Dec 2022 00:50:15 +0000
References: <20221206210538.597606-1-void@manifault.com>
In-Reply-To: <20221206210538.597606-1-void@manifault.com>
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@meta.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        matus.jokay@stuba.sk
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

On Tue,  6 Dec 2022 15:05:38 -0600 you wrote:
> A series of prior patches added some kfuncs that allow struct
> task_struct * objects to be used as kptrs. These kfuncs leveraged the
> 'refcount_t rcu_users' field of the task for performing refcounting.
> This field was used instead of 'refcount_t usage', as we wanted to
> leverage the safety provided by RCU for ensuring a task's lifetime.
> 
> A struct task_struct is refcounted by two different refcount_t fields:
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Don't use rcu_users to refcount in task kfuncs
    https://git.kernel.org/bpf/bpf-next/c/156ed20d22ee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


