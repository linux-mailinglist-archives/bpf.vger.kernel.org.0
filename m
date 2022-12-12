Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF5B64A919
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 22:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233544AbiLLVBh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Dec 2022 16:01:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233412AbiLLVBK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 16:01:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87861901E;
        Mon, 12 Dec 2022 13:00:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7FEE0B80E4C;
        Mon, 12 Dec 2022 21:00:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 14156C433F0;
        Mon, 12 Dec 2022 21:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670878816;
        bh=olY/2/zUA2Vqrl5pxOVYLl11ZZ2pXRb7tLPrGknn3wE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Xoinmmtiepef7+orbXQY2ZcqS/1ba0WFQ8oBIdfyDFf2kKya8ADtB7jeHe13WQ3v3
         HBvlSwSurz6ldFHQyySWMbzPRLrdKA+N67R7iURPzQBJm/vu24ZvI5SJd747/utHVN
         PD3/yviMqJOK4ifcgZxAqde+qlZjxXuayxfv02et9+0OwVDN3eGPY7hGsDhjMG/XsD
         6u8rNYZif591chD40EAxQpf7iG+raafH/+t76FibHVKv/EPf1w3SO4OLn5eCTdDP4H
         ARvm0QITjFcDrjIvr31yHyIxBaJf7oMlutT24R5djegz59z7GKUDFTGIiFfrxkHRRb
         ATZJDBm/kWY5g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EB4E7C41606;
        Mon, 12 Dec 2022 21:00:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v1] docs/bpf: Reword docs for BPF_MAP_TYPE_SK_STORAGE
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167087881595.21711.9569936101646684324.git-patchwork-notify@kernel.org>
Date:   Mon, 12 Dec 2022 21:00:15 +0000
References: <20221212101600.56026-1-donald.hunter@gmail.com>
In-Reply-To: <20221212101600.56026-1-donald.hunter@gmail.com>
To:     Donald Hunter <donald.hunter@gmail.com>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, corbet@lwn.net, yhs@meta.com, void@manifault.com
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
by Martin KaFai Lau <martin.lau@kernel.org>:

On Mon, 12 Dec 2022 10:16:00 +0000 you wrote:
> Improve the grammar of the function descriptions and highlight
> that the key is a socket fd.
> 
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
> Fixes: f3212ad5b7e9 ("docs/bpf: Add documentation for BPF_MAP_TYPE_SK_STORAGE")
> Reported-by: Martin KaFai Lau <martin.lau@linux.dev>
> 
> [...]

Here is the summary with links:
  - [bpf-next,v1] docs/bpf: Reword docs for BPF_MAP_TYPE_SK_STORAGE
    https://git.kernel.org/bpf/bpf-next/c/2e75f9aa2bdc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


