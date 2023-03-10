Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C9E6B5291
	for <lists+bpf@lfdr.de>; Fri, 10 Mar 2023 22:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjCJVKZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Mar 2023 16:10:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbjCJVKY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Mar 2023 16:10:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112AD12049B
        for <bpf@vger.kernel.org>; Fri, 10 Mar 2023 13:10:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BE482B822AD
        for <bpf@vger.kernel.org>; Fri, 10 Mar 2023 21:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 75209C4339B;
        Fri, 10 Mar 2023 21:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678482620;
        bh=umnA+c7uyfxqMFG+PApy0TOXyorTxiJzDoVZHXAbCII=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=JAceL80Wnki4k0BsnQ+wuNf6lBthC4yP+gCrLYIBlmoJb3gdmK4R41moSWGZI1DKQ
         Z3rNUmtjQcf4KSif6wl6MrcTYvcX0ROaWOJ8Aqgp0zoVtPcntekpHYXXKvmM2f2YGn
         I5dzvA3C7o9kXwcvZGfWCxMsDu9j4UupwACLtaJkBamuzegat35gOLcs2yMV8aImrK
         ILoCKZhNZD0Dfe4DfYXdADeWdQ0xUjqUHf72OZLfpuHuQ1UQOGzqMrt0f3fcRwzYQA
         23mczdSg52wx7C5vtzOaIxdSXpI0MLPMLwwIbXSEonY8V/SVE1jHlK0nHk5x1kcIqQ
         UNbMDf4rA386w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 56A8AE21EEE;
        Fri, 10 Mar 2023 21:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4] bpf, docs: Explain helper functions
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167848262034.18309.4583085760649922064.git-patchwork-notify@kernel.org>
Date:   Fri, 10 Mar 2023 21:10:20 +0000
References: <20230308205303.1308-1-dthaler1968@googlemail.com>
In-Reply-To: <20230308205303.1308-1-dthaler1968@googlemail.com>
To:     Dave Thaler <dthaler1968@googlemail.com>
Cc:     bpf@vger.kernel.org, bpf@ietf.org, dthaler@microsoft.com
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

On Wed,  8 Mar 2023 20:53:03 +0000 you wrote:
> From: Dave Thaler <dthaler@microsoft.com>
> 
> Add brief text about existence of helper functions, with details to go in
> separate psABI text.
> 
> Note that text about runtime functions (kfuncs) is part of a separate patch,
> not this one.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4] bpf, docs: Explain helper functions
    https://git.kernel.org/bpf/bpf-next/c/c1f9e14e3b67

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


