Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B55AA57D713
	for <lists+bpf@lfdr.de>; Fri, 22 Jul 2022 00:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbiGUWuU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Jul 2022 18:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiGUWuT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Jul 2022 18:50:19 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3B9BC96
        for <bpf@vger.kernel.org>; Thu, 21 Jul 2022 15:50:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id ABE34CE26CF
        for <bpf@vger.kernel.org>; Thu, 21 Jul 2022 22:50:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DDDE2C341C6;
        Thu, 21 Jul 2022 22:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658443812;
        bh=/IJ0pWdlMlN/CCKn57eAEcNJ+L8P8Ssf7LDDgwmGH9o=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=PCuE7unwOQo+0B6QaKwl5onfORgK8faR89wPYQpB6fS+qIt3/1oI9DNbjbAX/4KKl
         4QOTNtrRyI4oWmCbhWscVoRMMJThlUTrWYXhC30GkDQkdB248KREMDekbk3sA9GGiW
         gaelQCS7+rAWf92/YRB8Enend3FL5N4/mbyoNHtuG6cIMjHJt5SUx+zWdfI4tI3nT1
         Bv29gyfvCcKULeSWc52rxS+304p7nbx3mkr0eZ4GH2ZfQUvJ1Rh0hc6Uovbk7vmo0A
         1icdR3y0afzQB7EIEQ2fT9+zMaihs/bXK8sq1Sk3xiZM7hwo1lQDvZ3TDaF2mBwu12
         2P+oYrSDKb/fw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C02E3D9DDDD;
        Thu, 21 Jul 2022 22:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf_doc.py: Use SPDX-License-Identifier
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165844381278.13656.3004635809924499624.git-patchwork-notify@kernel.org>
Date:   Thu, 21 Jul 2022 22:50:12 +0000
References: <20220721110821.8240-1-alx.manpages@gmail.com>
In-Reply-To: <20220721110821.8240-1-alx.manpages@gmail.com>
To:     Alejandro Colomar <alx.manpages@gmail.com>
Cc:     quentin@isovalent.com, bpf@vger.kernel.org, daniel@iogearbox.net
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Thu, 21 Jul 2022 13:08:22 +0200 you wrote:
> The Linux man-pages project now uses SPDX tags,
> instead of the full license text.
> 
> Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
> ---
>  scripts/bpf_doc.py | 22 +---------------------
>  1 file changed, 1 insertion(+), 21 deletions(-)

Here is the summary with links:
  - bpf_doc.py: Use SPDX-License-Identifier
    https://git.kernel.org/bpf/bpf-next/c/5cb62b7598f2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


