Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 367EF6420F1
	for <lists+bpf@lfdr.de>; Mon,  5 Dec 2022 02:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbiLEBAU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 4 Dec 2022 20:00:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbiLEBAT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 4 Dec 2022 20:00:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DB612AAD
        for <bpf@vger.kernel.org>; Sun,  4 Dec 2022 17:00:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 370C2B80D18
        for <bpf@vger.kernel.org>; Mon,  5 Dec 2022 01:00:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D90BAC433D7;
        Mon,  5 Dec 2022 01:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670202015;
        bh=Hvs6Zf6oJiwquXBslzYkzhH4tI3/x2ox7nANCFnxoaQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=l1ISq4V2/COWCDzWeOr3R1x1zkeqsfyi4Li4YRJCSnAkOxFbGID9I1v3dCEMyAlXK
         5mRi4YU6pGAqO+80+xvCySDi8vMkBwcuXm7n5jlFfNR9+/SjKEKseddhUXJSNKa3yO
         O3F+H5kockbPRh0Yj7he7YdijkFd033So1DgEn5PnylKjOU9XuUnX1UxRUstQFA6Ca
         VW4vZaG0yuM9i5+ItM1QbbxbULQzZfQCtwfUHnLTYexK2y+46eZjgn1W+s7nW9fZhn
         VPX8caQumYkC51cfV0xrGLbfPyOs4Lkti6AGUj7xNlB4ZgHgOH811qiy/YMcLhEZiL
         h/clTd0uPx0sg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BE317E270CF;
        Mon,  5 Dec 2022 01:00:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 1/2] bpf: Enable sleeptable support for cgrp local
 storage
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167020201577.12969.15309558573263860570.git-patchwork-notify@kernel.org>
Date:   Mon, 05 Dec 2022 01:00:15 +0000
References: <20221201050444.2785007-1-yhs@fb.com>
In-Reply-To: <20221201050444.2785007-1-yhs@fb.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 30 Nov 2022 21:04:44 -0800 you wrote:
> Similar to sk/inode/task local storage, enable sleepable support for
> cgrp local storage.
> 
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  kernel/bpf/verifier.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [bpf-next,1/2] bpf: Enable sleeptable support for cgrp local storage
    https://git.kernel.org/bpf/bpf-next/c/2c40d97da1a2
  - [bpf-next,2/2] bpf: Add sleepable prog tests for cgrp local storage
    https://git.kernel.org/bpf/bpf-next/c/41d76c721c5c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


