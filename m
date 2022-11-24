Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBADB636EBD
	for <lists+bpf@lfdr.de>; Thu, 24 Nov 2022 01:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiKXAKU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Nov 2022 19:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKXAKS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Nov 2022 19:10:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFEC2D740;
        Wed, 23 Nov 2022 16:10:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74FEA61F83;
        Thu, 24 Nov 2022 00:10:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9F3CC433D6;
        Thu, 24 Nov 2022 00:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669248616;
        bh=OQekOYc1r7D8u+bLIKLfVdWn0JN3iU0PVGtiZUjcOzQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=td3cYfgPFwdqw74KoTAXU55tfXsAC5C2/TOqCC4lzh0WlxHfiPr8trTmaon0dXaeL
         eL70r90lKytHxBRJlNRXY5dBK7PMAnSZirVMtxTgWvq+5K/k1hYorn6Yq6MthTFiuA
         W8Du70W566+aOsO1HzNyT+b2xduvNH3p4XdVU3gIIq60dTpl4veYO1UOtT2wILjiQa
         zcmq6Euha+ZHQ2PAQDPyCWRuDqObwlKi1uTFIQyCNb12qU2+74tcJ8sHce1znJcNjs
         MJXGlOCz+BuZ8qkZ3JWESYteT4RTC41AAbypcZRYdbsgJIqLzfhpMobPl9TqO+tqin
         IKVW9hRiekxPw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B37A4C395EE;
        Thu, 24 Nov 2022 00:10:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v1] docs/bpf: Fix sphinx warnings in BPF map docs
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166924861673.26979.2982105409284887364.git-patchwork-notify@kernel.org>
Date:   Thu, 24 Nov 2022 00:10:16 +0000
References: <20221122143933.91321-1-donald.hunter@gmail.com>
In-Reply-To: <20221122143933.91321-1-donald.hunter@gmail.com>
To:     Donald Hunter <donald.hunter@gmail.com>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, corbet@lwn.net,
        akiyks@gmail.com
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

On Tue, 22 Nov 2022 14:39:33 +0000 you wrote:
> Fix duplicate C declaration warnings when using sphinx >= 3.1
> 
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
> Reported-by: Akira Yokosawa <akiyks@gmail.com>
> Link: https://lore.kernel.org/bpf/ed4dac84-1b12-5c58-e4de-93ab9ac67c09@gmail.com
> ---
>  Documentation/bpf/map_array.rst       | 20 ++++++++++++---
>  Documentation/bpf/map_hash.rst        | 33 ++++++++++++++++++++----
>  Documentation/bpf/map_lpm_trie.rst    | 24 +++++++++++++++---
>  Documentation/bpf/map_of_maps.rst     |  6 ++++-
>  Documentation/bpf/map_queue_stack.rst | 36 ++++++++++++++++++++++-----
>  5 files changed, 99 insertions(+), 20 deletions(-)

Here is the summary with links:
  - [bpf-next,v1] docs/bpf: Fix sphinx warnings in BPF map docs
    https://git.kernel.org/bpf/bpf-next/c/539886a32a6a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


