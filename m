Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8956532AA
	for <lists+bpf@lfdr.de>; Wed, 21 Dec 2022 15:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbiLUOuU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Dec 2022 09:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbiLUOuT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Dec 2022 09:50:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9FF233AF
        for <bpf@vger.kernel.org>; Wed, 21 Dec 2022 06:50:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF9A3617E7
        for <bpf@vger.kernel.org>; Wed, 21 Dec 2022 14:50:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 011D9C433F0;
        Wed, 21 Dec 2022 14:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671634217;
        bh=kXUgG2a5182+oJEP7AygJUKeRldlvTJ4LkUDDA7REuo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=D9660/TrhsbqQ8kNwDbD8UitjwP3s+OWUNf8aIPtlMnjLq3bdHbntlbSjoQD81yiG
         MVnNxR0JgpjkhevXW5H1aJ5pOYdVPPtXMCUCoXwN/tg5fIRSBxrD0BNmUNAwR+IMSu
         Md+ht4gF5tiEFJFHXjNFxaBJDF1VaIXZn91Yjtc0xTw8elRt+EN2kCLMug5mk6wTiw
         TKntglgTVUMdqzr1s2LS1zAd7Vl2Xy4XVzXueU/O362KltgsJusXlQn/fQhXLrOuwq
         HKB/R1hDhPR44B6++bZt53ANgQ+S7ofr/Zl1zJmJEuoXzVYiCoOnbUQZYMbmLHElXB
         /tZGlnZ0zlzcg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D7642C41622;
        Wed, 21 Dec 2022 14:50:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 bpf-next] bpf: Reduce smap->elem_size
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167163421687.20361.18277279734820984314.git-patchwork-notify@kernel.org>
Date:   Wed, 21 Dec 2022 14:50:16 +0000
References: <20221221013036.3427431-1-martin.lau@linux.dev>
In-Reply-To: <20221221013036.3427431-1-martin.lau@linux.dev>
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@meta.com, yhs@fb.com
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

On Tue, 20 Dec 2022 17:30:36 -0800 you wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
> 
> 'struct bpf_local_storage_elem' has an unused 56 byte padding at the
> end due to struct's cache-line alignment requirement. This padding
> space is overlapped by storage value contents, so if we use sizeof()
> to calculate the total size, we overinflate it by 56 bytes. Use
> offsetof() instead to calculate more exact memory use.
> 
> [...]

Here is the summary with links:
  - [v3,bpf-next] bpf: Reduce smap->elem_size
    https://git.kernel.org/bpf/bpf-next/c/552d42a356eb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


