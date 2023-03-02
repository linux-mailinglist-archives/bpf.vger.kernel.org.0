Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE4676A7AD9
	for <lists+bpf@lfdr.de>; Thu,  2 Mar 2023 06:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjCBFuW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Mar 2023 00:50:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjCBFuV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Mar 2023 00:50:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2E11423B
        for <bpf@vger.kernel.org>; Wed,  1 Mar 2023 21:50:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1B083B811F0
        for <bpf@vger.kernel.org>; Thu,  2 Mar 2023 05:50:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9E837C433D2;
        Thu,  2 Mar 2023 05:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677736217;
        bh=Vx6BJM/v3l3BCKpTRZN4TuQ1ZaNhm+hdJ7cTEL2hfKw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=OKzSJSoh1hOdUjKZffkq/j/A6JVpWh3yLW/S6exKXW8+5bhWg6CsTplaYwOi2jKE0
         E3+DaKOoan1Vw2qEO+K/pkX4iLi7+zh4S39f4VlniuPanhN71ixZqWwbOwZNaqH2xe
         3i9zObnV3inimTV0d4UGcQcvGaXNLLn0uTR4dOF9fl+TA6PpjdTG6GgJmKnUCfaNfn
         nJWthtyKVnLmpf6aS9aXJT8hY+NPVzlpqsAD/2jA4bMXozNaAiB7G98TYL4y2Ruyow
         zb0JawwlFyXNJhVobBVcXmWO//jkmGDCMvilFzFUup9bmkmn0v5hQ7LWxOOVd+C5yA
         xKuURg2IhuyOQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 85E2AE4D00C;
        Thu,  2 Mar 2023 05:50:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 bpf-next] bpf: Fix bpf_dynptr_slice{_rdwr} to return NULL
 instead of 0
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167773621754.17370.4852632620989522818.git-patchwork-notify@kernel.org>
Date:   Thu, 02 Mar 2023 05:50:17 +0000
References: <20230302053014.1726219-1-joannelkoong@gmail.com>
In-Reply-To: <20230302053014.1726219-1-joannelkoong@gmail.com>
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf@vger.kernel.org, martin.lau@kernel.org, andrii@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, lkp@intel.com
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

On Wed,  1 Mar 2023 21:30:14 -0800 you wrote:
> Change bpf_dynptr_slice and bpf_dynptr_slice_rdwr to return NULL instead
> of 0, in accordance with the codebase guidelines.
> 
> Fixes: 66e3a13e7c2c ("bpf: Add bpf_dynptr_slice and bpf_dynptr_slice_rdwr")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> 
> [...]

Here is the summary with links:
  - [v1,bpf-next] bpf: Fix bpf_dynptr_slice{_rdwr} to return NULL instead of 0
    https://git.kernel.org/bpf/bpf-next/c/c45eac537bd8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


