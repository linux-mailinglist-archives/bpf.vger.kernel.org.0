Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C49698142
	for <lists+bpf@lfdr.de>; Wed, 15 Feb 2023 17:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjBOQu0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Feb 2023 11:50:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjBOQuX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Feb 2023 11:50:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1071CADF;
        Wed, 15 Feb 2023 08:50:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B7AE9B82315;
        Wed, 15 Feb 2023 16:50:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4A011C4339C;
        Wed, 15 Feb 2023 16:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676479817;
        bh=FelCGJSMNmD0q/gthNIR8bM7VlU6iPsJJYGJXrDNBXc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=oiO2YcE53phhkGP4mQAXZ2XWkLpK3VD9fNFZp/rVqHtZJMs8HWgkmriFQv7EWHQMS
         rjHjY/kaM66vRYV0R/SuT7FMOIQyzi5+T+MiOt+Eq6qkCDfx4B1vjnKa4IxWXHnkRH
         lNfJOgtl//LgvKGPrr3PZZBavSI4SCtY0kuglyHJ2Or/I/BH7MvVmXEXKckOBt/Ajl
         1XaO40raqOYYEv02s4qBauSI3t9lr9WZGQo4h1czhSjERvIrbJJUkY+TQoJYn6hERb
         Z3Lmw0LLNH2XPCvwJYWH7fPK/ibMt+ejDfM/Kb3acOA/V0pIzAnP9nzFffUilGeMUN
         ZNAsR8FHH7jBg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 32E14C4166F;
        Wed, 15 Feb 2023 16:50:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix build error for LoongArch
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167647981720.6958.16652341885651438279.git-patchwork-notify@kernel.org>
Date:   Wed, 15 Feb 2023 16:50:17 +0000
References: <1676458867-22052-1-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1676458867-22052-1-git-send-email-yangtiezhu@loongson.cn>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Wed, 15 Feb 2023 19:01:07 +0800 you wrote:
> There exists build error when make -C tools/testing/selftests/bpf/
> on LoongArch:
> 
>   BINARY   test_verifier
> In file included from test_verifier.c:27:
> tools/include/uapi/linux/bpf_perf_event.h:14:28: error: field 'regs' has incomplete type
>    14 |         bpf_user_pt_regs_t regs;
>       |                            ^~~~
> make: *** [Makefile:577: tools/testing/selftests/bpf/test_verifier] Error 1
> make: Leaving directory 'tools/testing/selftests/bpf'
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Fix build error for LoongArch
    https://git.kernel.org/bpf/bpf-next/c/524581d12164

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


