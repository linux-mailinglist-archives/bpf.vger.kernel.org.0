Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76BBB58A2E4
	for <lists+bpf@lfdr.de>; Thu,  4 Aug 2022 23:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239515AbiHDVuW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Aug 2022 17:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239275AbiHDVuT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Aug 2022 17:50:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E10AE79;
        Thu,  4 Aug 2022 14:50:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 68783B82772;
        Thu,  4 Aug 2022 21:50:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1767DC433D7;
        Thu,  4 Aug 2022 21:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659649814;
        bh=U9FHl9gguirW2oSvipcGPJE3ApaupYYhfXavrVBTQ40=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=mNR4Jtu1rQQ9cAnEb6BKOfX7zZQ1UAwrXOLLVz2WTER0gBuPY01AlXM/pvkSaGS5p
         LV28SOWuEamxYbaO6vGKLyJnT1wuodAhHpryOUaGPopltZ07/J0+wpPwb/FKwIe+Nj
         fjPU9k8qiU313eSn3LiVA3KLKrW4rfojcqokqzThNv8scmbiWyXJEgSlz6Ai7w3SCQ
         PF/pVPQbRzBS3qwv8DvrW3QdVY0TIKSEPZRXhECmTuihJpuOEBx6mqWSdGRCIowBtN
         awm42g4C3kgTEHHGB5JMAyhJwFj0aALMplTzIxRNFneaWjAmjcKBeEyxjuoDcX/Fw0
         hkpMLhdElybyA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F0084C43142;
        Thu,  4 Aug 2022 21:50:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] libbpf: ensure functions with always_inline attribute are
 inline
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165964981397.20332.3782445822983785211.git-patchwork-notify@kernel.org>
Date:   Thu, 04 Aug 2022 21:50:13 +0000
References: <20220803151403.793024-1-james.hilliard1@gmail.com>
In-Reply-To: <20220803151403.793024-1-james.hilliard1@gmail.com>
To:     James Hilliard <james.hilliard1@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org
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

On Wed,  3 Aug 2022 09:14:03 -0600 you wrote:
> GCC expects the always_inline attribute to only be set on inline
> functions, as such we should make all functions with this attribute
> use the __always_inline macro which makes the function inline and
> sets the attribute.
> 
> Fixes errors like:
> /home/buildroot/bpf-next/tools/testing/selftests/bpf/tools/include/bpf/bpf_tracing.h:439:1: error: ‘always_inline’ function might not be inlinable [-Werror=attributes]
>   439 | ____##name(unsigned long long *ctx, ##args)
>       | ^~~~
> 
> [...]

Here is the summary with links:
  - [v2] libbpf: ensure functions with always_inline attribute are inline
    https://git.kernel.org/bpf/bpf-next/c/d25f40ff68aa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


