Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4066E1B61
	for <lists+bpf@lfdr.de>; Fri, 14 Apr 2023 07:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjDNFAW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Apr 2023 01:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjDNFAV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Apr 2023 01:00:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7124A2;
        Thu, 13 Apr 2023 22:00:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55520643D0;
        Fri, 14 Apr 2023 05:00:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6BD97C433EF;
        Fri, 14 Apr 2023 05:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681448418;
        bh=Nuj4Q/n+u+sbinQ2UL896QpTHkLhLwc1MiTdNnxNY78=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=d9M58d/HcVeQFN+gwfMVesploSFc5+l8pWtlltiXfi71J5FNhY5WmIaJvPGdyTgQ4
         MAuwAymXreWoZI6Lqw6BR7BTpuxft810fi+K4hgm4eyo0GHxt8LlUoalvzRjnRPRI7
         n/HbfJGoZAnu/Rg5QwU6Bdz3Y+WbQiW8+mBt2q/PMm359/dhkknx99dL/dmeLHYblC
         NtI35Pbov4SiJMqvMc8AJ3eynaGaNx4h0CGfeZtDCz1WyP4l28gl6SujsFj0N4Dr1g
         8rmd1xHlYsHhIhHnBgCi4Wanp3eUglBGxn5w0W0XF9LMMRe12NZUXmZSCuNVBKIHsv
         c9XqtdaItajuQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 51F14E21EDE;
        Fri, 14 Apr 2023 05:00:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] samples/bpf: sampleip: Replace PAGE_OFFSET with
 _text address
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168144841833.15631.13621906411844041748.git-patchwork-notify@kernel.org>
Date:   Fri, 14 Apr 2023 05:00:18 +0000
References: <tencent_A0E82E0BEE925285F8156D540731DF805F05@qq.com>
In-Reply-To: <tencent_A0E82E0BEE925285F8156D540731DF805F05@qq.com>
To:     Rong Tao <rtoax@foxmail.com>
Cc:     ast@kernel.org, rongtao@cestc.cn, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
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

On Wed, 12 Apr 2023 16:16:24 +0800 you wrote:
> From: Rong Tao <rongtao@cestc.cn>
> 
> Macro PAGE_OFFSET(0xffff880000000000) in sampleip_user.c is inaccurate,
> for example, in aarch64 architecture, this value depends on the
> CONFIG_ARM64_VA_BITS compilation configuration, this value defaults to 48,
> the corresponding PAGE_OFFSET is 0xffff800000000000, if we use the value
> defined in sampleip_user.c, then all KSYMs obtained by sampleip are (user)
> 
> [...]

Here is the summary with links:
  - [bpf-next] samples/bpf: sampleip: Replace PAGE_OFFSET with _text address
    https://git.kernel.org/bpf/bpf-next/c/4a1e885c6d14

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


