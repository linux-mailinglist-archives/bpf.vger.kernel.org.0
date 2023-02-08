Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB8468FB44
	for <lists+bpf@lfdr.de>; Thu,  9 Feb 2023 00:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjBHXkU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Feb 2023 18:40:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjBHXkT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Feb 2023 18:40:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1126C19F1A
        for <bpf@vger.kernel.org>; Wed,  8 Feb 2023 15:40:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C5D461806
        for <bpf@vger.kernel.org>; Wed,  8 Feb 2023 23:40:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EC3C6C4339B;
        Wed,  8 Feb 2023 23:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675899617;
        bh=W3xrIXhoDjXZNJdkCocuX30O+ZzH35VnHisIfaFMSPQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=OeKDGC0tHA8/SOaPx2AUacQlxf3fQai5TsMwKIchbkSdFcBGT+7JTV3SjGq7sBho9
         eNRjBx2NPnajv8Shq1ror6otsmBQ1fIDZLqq7uuGrCfg8GDtuyQhAYbkx1XMHlw8Id
         GJeGcdG0AUqsKCbPTRwHVygtQIxOxDxeUJ7124sVOZvwyb5ZBcp7WuZMZE097EPDsw
         Khchlr4MTMmHDukgmWXUnTYF+Ira4sgvT2YCLlLQbgWbLa8wkvhMTpvrGAUddKKKsm
         Ld7hj/5tR4EPCmJfOan3E392L1ttchGKsZycN+tLrAE42pbeJouVu+Wt4CffI1QSQH
         YZUzhgyDTQrDQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D1E22E50D62;
        Wed,  8 Feb 2023 23:40:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4] libbpf: Add sample_period to creation options
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167589961685.16147.9332324795801037113.git-patchwork-notify@kernel.org>
Date:   Wed, 08 Feb 2023 23:40:16 +0000
References: <20230207081916.3398417-1-arilou@gmail.com>
In-Reply-To: <20230207081916.3398417-1-arilou@gmail.com>
To:     Jon Doron <arilou@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, jond@wiz.io
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
by Andrii Nakryiko <andrii@kernel.org>:

On Tue,  7 Feb 2023 10:19:16 +0200 you wrote:
> From: Jon Doron <jond@wiz.io>
> 
> Add option to set when the perf buffer should wake up, by default the
> perf buffer becomes signaled for every event that is being pushed to it.
> 
> In case of a high throughput of events it will be more efficient to wake
> up only once you have X events ready to be read.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4] libbpf: Add sample_period to creation options
    https://git.kernel.org/bpf/bpf-next/c/ab8684b8cecf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


