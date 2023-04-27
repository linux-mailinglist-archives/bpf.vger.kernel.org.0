Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7882D6F0CDE
	for <lists+bpf@lfdr.de>; Thu, 27 Apr 2023 22:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343615AbjD0UKW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 16:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245168AbjD0UKV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 16:10:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE30C2D74;
        Thu, 27 Apr 2023 13:10:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85F1B63F71;
        Thu, 27 Apr 2023 20:10:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CC5DFC4339B;
        Thu, 27 Apr 2023 20:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682626219;
        bh=qoO9gr3mZL+pQDOhmWVeLgTjeillcDNBWuS9b5f9fe0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=MF3G96+od6lS4geKf/YIXKI+tIGvFyP5Uj8zIk4aTh5xcegzW9TmkBe1WqEuiuF2g
         p9VlcCZkT06wwQLbR9JGAmmSH/7uA5CXrQQuCUT9RUcVdGDK+ReUIdCm0H82ejDKaG
         Hps2UeXJn2QxI3fkUVMUbTyjcV1EHvJguYdu2FFED0Nkte53GveFyF0VjcBMShEYQN
         bnZiSnHwY3VXIAB6A2ewh8AXglhI8YKzeYLAsxijUt31NUXbntfgMrUCVU/qozXbC6
         oZsL4CsZpG5HFVIoX/owpTX5kiHWc4QsC2JKXMRWE/d4xH4/a+sQteQZuHV/yse07S
         9GIXh2ZRTkWvg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B12D4C39562;
        Thu, 27 Apr 2023 20:10:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Update the aarch64 tests deny list
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168262621972.29037.2266972486752352083.git-patchwork-notify@kernel.org>
Date:   Thu, 27 Apr 2023 20:10:19 +0000
References: <20230427143207.635263-1-revest@chromium.org>
In-Reply-To: <20230427143207.635263-1-revest@chromium.org>
To:     Florent Revest <revest@chromium.org>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kpsingh@kernel.org,
        mykolal@fb.com, martin.lau@linux.dev, song@kernel.org,
        xukuohai@huaweicloud.com, mark.rutland@arm.com
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu, 27 Apr 2023 16:32:07 +0200 you wrote:
> Now that ftrace supports direct call on arm64, BPF tracing programs work
> on that architecture. This fixes the vast majority of BPF selftests
> except for:
> 
> - multi_kprobe programs which require fprobe, not available on arm64 yet
> - tracing_struct which requires trampoline support to access struct args
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Update the aarch64 tests deny list
    https://git.kernel.org/bpf/bpf-next/c/a46441192084

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


