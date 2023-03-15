Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4AF6BBD95
	for <lists+bpf@lfdr.de>; Wed, 15 Mar 2023 20:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbjCOTuZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Mar 2023 15:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbjCOTuX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Mar 2023 15:50:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5585BC
        for <bpf@vger.kernel.org>; Wed, 15 Mar 2023 12:50:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 67A26B81F31
        for <bpf@vger.kernel.org>; Wed, 15 Mar 2023 19:50:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 243F7C433D2;
        Wed, 15 Mar 2023 19:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678909818;
        bh=Cg94CEmCEhYX5G8t3hmvAIaPNgPhOJh0BXm3mpsy74U=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=I2H18+xl6gOs0/3UYCBkspCKGTuaa8c5Bwy3jt4Q4dR0naiORwzQQCus2sHy0CAfm
         BLOWM5o8Z7LRdctlv5NWKYyz/gSoRctGaCDgq2CaHhHmUgFGIuPrn+47KYp3bZ6aFQ
         Mxrp0qoThPsyugN/Kjr+rRXLSqznRrkGbyRul2FZlsb7glX13y2Po1uf3c7ApFhHJ5
         EH7Adv0pN11ZvESlMr7lp02alH3aidH62m6uTtDYd+joVn2NrWDRer9/44kxwX2Ysd
         POeNTY4jSWNEkxPGqAph/e43yaF+9jD8tkwIZk3WF195r81hDkPmKJb7S6AZd/vG75
         H0/4H/wHhaQNA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0B345C43161;
        Wed, 15 Mar 2023 19:50:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v10 0/2] Fix attaching fentry/fexit/fmod_ret/lsm to
 modules
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167890981804.20901.17573770241643313641.git-patchwork-notify@kernel.org>
Date:   Wed, 15 Mar 2023 19:50:18 +0000
References: <cover.1678432753.git.vmalik@redhat.com>
In-Reply-To: <cover.1678432753.git.vmalik@redhat.com>
To:     Viktor Malik <vmalik@redhat.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mcgrof@kernel.org
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

On Fri, 10 Mar 2023 08:40:58 +0100 you wrote:
> I noticed that the verifier behaves incorrectly when attaching to fentry
> of multiple functions of the same name located in different modules (or
> in vmlinux). The reason for this is that if the target program is not
> specified, the verifier will search kallsyms for the trampoline address
> to attach to. The entire kallsyms is always searched, not respecting the
> module in which the function to attach to is located.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v10,1/2] bpf: Fix attaching fentry/fexit/fmod_ret/lsm to modules
    https://git.kernel.org/bpf/bpf-next/c/2a6427ca8f3a
  - [bpf-next,v10,2/2] bpf/selftests: Test fentry attachment to shadowed functions
    https://git.kernel.org/bpf/bpf-next/c/873cc3835d80

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


