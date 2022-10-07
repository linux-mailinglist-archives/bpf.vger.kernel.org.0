Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5024F5F79B1
	for <lists+bpf@lfdr.de>; Fri,  7 Oct 2022 16:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiJGOaW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Oct 2022 10:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiJGOaV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Oct 2022 10:30:21 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D289743E75
        for <bpf@vger.kernel.org>; Fri,  7 Oct 2022 07:30:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0C5EDCE1862
        for <bpf@vger.kernel.org>; Fri,  7 Oct 2022 14:30:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 246B6C433D7;
        Fri,  7 Oct 2022 14:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665153016;
        bh=Ul5O1mDZGvzO/Wb4WjLgMeeVHCfLdx0OtuMb6oLJJZk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=hDdth61S0Z1wLsgSH7Op6f+L8ovKFjRkf+InOYNYl0BdW4G2unhzEURd+U6vlNKGj
         08rmxCsPm3Y872er0zBjiSjYu2+oxYtSF6OWCB/+CzaCrEJ+VFgAhgvmJArupUzZtf
         VqQIBnAt9h8lWHOZ5nprsGdC37HqokqN3gqKL5aprEDHYp949FZEgB3niZmlYY0tkM
         2t+OJZeGxjxgIZrqkiAdA3i2ePOE59qlT2+g+sxDqW2Rj/zmZZjHQRQcv5fWT/40yO
         HV6+8PXYq8YxjOuSeA8ho7XIbF5bmB9mrbtJi5I5dgimx5TWkSaL68+hBqQ8TcdFmR
         DOPgxk4vzBy/Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 06ABFE21ED6;
        Fri,  7 Oct 2022 14:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] bpf,x64: Remove unnecessary check on existence of
 SSE2
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166515301602.2538.7324165956325630888.git-patchwork-notify@kernel.org>
Date:   Fri, 07 Oct 2022 14:30:16 +0000
References: <20221005170039.3936894-1-jmeng@fb.com>
In-Reply-To: <20221005170039.3936894-1-jmeng@fb.com>
To:     Jie Meng <jmeng@fb.com>
Cc:     kpsingh@kernel.org, bpf@vger.kernel.org, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net
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
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed, 5 Oct 2022 10:00:39 -0700 you wrote:
> SSE2 and hence lfence are architectural in x86-64 and no need to check
> whether they're supported in CPU. SSE2's CPUID flag is still set to
> maintain backward compatibility with older code or code shared with x86,
> but bpf_jit_comp.c is compiled under x86-64 exclusively so the check is
> redundant.
> 
> Signed-off-by: Jie Meng <jmeng@fb.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] bpf,x64: Remove unnecessary check on existence of SSE2
    https://git.kernel.org/bpf/bpf-next/c/2e30960097f6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


