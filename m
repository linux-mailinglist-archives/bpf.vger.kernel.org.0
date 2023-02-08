Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6C768F48B
	for <lists+bpf@lfdr.de>; Wed,  8 Feb 2023 18:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbjBHRaY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Feb 2023 12:30:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbjBHRaW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Feb 2023 12:30:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13FC2CC55
        for <bpf@vger.kernel.org>; Wed,  8 Feb 2023 09:30:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 47180B81D4A
        for <bpf@vger.kernel.org>; Wed,  8 Feb 2023 17:30:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E7CBAC433D2;
        Wed,  8 Feb 2023 17:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675877417;
        bh=4JbLv7cI+0HoALqSa0EaYwsiPkxijUczxpoWwmNRYOs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=RV6Ju9XSDOinciy4B4BWrS0m68cqKcVmYn2o0Aas7B75XQP78/c7zX0YmP4MEwBFh
         5yFjiL6gFHIyPJFqTsMv3O3dUSjAEYDgoufA53CIRAc0l18SMPYDIv3FwpCIgjKXFT
         Ucnzvgn1nTITdRM3TdZxyVKKRbn/DZjk/vvhOmwwNMV0dD5O3onuB463oTzyypPmYn
         E1Q7N0pRYFDluxmbj1gyqJd8REbJUIFCNbjwS0uDywQbik9RyplOzYjqlM2QjGS0n7
         tIVtE77sbexMq2HuGWpFnXIxu2vtPhNae5dGb0gr1u2IiOLDKRd6FzJEqCPxNCgcf+
         u0imK6LWA/hsg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CC7DEE524E8;
        Wed,  8 Feb 2023 17:30:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf, docs: Add note about type convention
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167587741783.21324.3420192049683322472.git-patchwork-notify@kernel.org>
Date:   Wed, 08 Feb 2023 17:30:17 +0000
References: <20230127014706.1005-1-dthaler1968@googlemail.com>
In-Reply-To: <20230127014706.1005-1-dthaler1968@googlemail.com>
To:     Dave Thaler <dthaler1968@googlemail.com>
Cc:     bpf@vger.kernel.org, bpf@ietf.org, dthaler@microsoft.com
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

On Fri, 27 Jan 2023 01:47:06 +0000 you wrote:
> From: Dave Thaler <dthaler@microsoft.com>
> 
> Add explanation about use of "u64", "u32", etc. as
> the type convention used in BPF documentation.
> 
> Signed-off-by: Dave Thaler <dthaler@microsoft.com>
> 
> [...]

Here is the summary with links:
  - bpf, docs: Add note about type convention
    https://git.kernel.org/bpf/bpf-next/c/d00d5b82f073

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


