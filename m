Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96FE55A332
	for <lists+bpf@lfdr.de>; Fri, 24 Jun 2022 23:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbiFXVAR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Jun 2022 17:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbiFXVAQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Jun 2022 17:00:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3178E52E79
        for <bpf@vger.kernel.org>; Fri, 24 Jun 2022 14:00:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E4E47B828CE
        for <bpf@vger.kernel.org>; Fri, 24 Jun 2022 21:00:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A824CC3411C;
        Fri, 24 Jun 2022 21:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656104413;
        bh=cqrlCyDsb+3kBnU7rqTxQl0fngrwrryBEjoNuE79acI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=RKmhWvof6VGtfuyBKjhXvTApwsenIRjUZgoCB+z/6JIbaEBR49j/yjImVY2ucgyka
         z8PLfC8Z9UujLKCdXaXvkQtF4Ca7N7z8V15/T8fiIfjq/xhmIudL52+s54Q9MOKtIN
         iEd8AJwNxR9QppKvsh12sAYxHAKvTHdMCAZksFFnGoNFY88ld3prBnksvnV2vWGRcs
         sniQ5xUvQNmxpjwWOO4JfCCDrSrOkKL3RJ4YKkqeQxsWxB5xjHgNqESfcWqM/0Q4NM
         JdUVc75j0zx+HlWhTZV5MOQR0JQTYx0Fc0poMTftFAGT6/UrSmjM/2Jmb1nKqUieWo
         fOOYXHyUFGekg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8A2E2E85C6D;
        Fri, 24 Jun 2022 21:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf, docs: fix the code formatting in instruction-set
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165610441356.9906.12224915027192294296.git-patchwork-notify@kernel.org>
Date:   Fri, 24 Jun 2022 21:00:13 +0000
References: <b6120b31-3d1d-bf2d-2f2a-aa768d91257b@synopsys.com>
In-Reply-To: <b6120b31-3d1d-bf2d-2f2a-aa768d91257b@synopsys.com>
To:     Shahab Vahedi <Shahab.Vahedi@synopsys.com>
Cc:     bpf@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
by Andrii Nakryiko <andrii@kernel.org>:

On Fri, 24 Jun 2022 14:14:11 +0000 you wrote:
> A minor typo fix to include "| BPF_LD" into its previous
> code phrase:
> 
> ``BPF_IND`` | BPF_LD --> ``BPF_IND | BPF_LD``
> 
> Signed-off-by: Shahab Vahedi <shahab@synopsys.com>
> 
> [...]

Here is the summary with links:
  - bpf, docs: fix the code formatting in instruction-set
    https://git.kernel.org/bpf/bpf-next/c/2f6d1e0f8ff3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


