Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEDDC6D7133
	for <lists+bpf@lfdr.de>; Wed,  5 Apr 2023 02:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235981AbjDEAUT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Apr 2023 20:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjDEAUS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Apr 2023 20:20:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387A33AA5;
        Tue,  4 Apr 2023 17:20:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB12263AB2;
        Wed,  5 Apr 2023 00:20:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 25176C4339C;
        Wed,  5 Apr 2023 00:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680654017;
        bh=RCqjBwlDw+GoZaYu/kwObCxusUPUKeiFEtjTeqty5Tc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=oBS0AOkUNEeUG3o9FQLIk9SRZTX5k2JVwZD+GO8w+hlmWaO44ib+/DsFdN0Mxl4NM
         HqD3vyaOjb1ozI+Gm/FrXy/ivTFoQm6E92rOm4cyJ9TEiRqFj0Bc9LZDTrf9qNBqkP
         B0OChkdc3GoIV2ud8qCdxO/GW7Hj7jKs2LooMVfE7PR4KGy+JXdHCw5za2ZUBM9Rk2
         tcZPgL4zyAYFv2IwuemxF03dFeu9vMWyg0qtx4IcUMr5kZHEsqlDFCcPTtcui/RZwV
         yUgDtM3diHLJ2tnJcVnBmSxg9SOL93keMShfzLrOr3t+g6SX4OhHlIRha/AdeZJkVD
         G+UaloMqpI84A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 02E85C395C5;
        Wed,  5 Apr 2023 00:20:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] kallsyms: Disable preemption for
 find_kallsyms_symbol_value
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168065401700.950.3027124778713262383.git-patchwork-notify@kernel.org>
Date:   Wed, 05 Apr 2023 00:20:17 +0000
References: <20230403220254.2191240-1-jolsa@kernel.org>
In-Reply-To: <20230403220254.2191240-1-jolsa@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     mcgrof@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, asavkov@redhat.com, bpf@vger.kernel.org,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@chromium.org, sdf@google.com,
        haoluo@google.com, pmladek@suse.com, thunder.leizhen@huawei.com,
        vmalik@redhat.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue,  4 Apr 2023 00:02:54 +0200 you wrote:
> Artem reported suspicious RCU usage [1]. The reason is that verifier
> calls find_kallsyms_symbol_value with preemption enabled which will
> trigger suspicious RCU usage warning in rcu_dereference_sched call.
> 
> Disabling preemption in find_kallsyms_symbol_value and adding
> __find_kallsyms_symbol_value function.
> 
> [...]

Here is the summary with links:
  - [bpf-next] kallsyms: Disable preemption for find_kallsyms_symbol_value
    https://git.kernel.org/bpf/bpf-next/c/d099f594ad56

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


