Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F045E6302D0
	for <lists+bpf@lfdr.de>; Sat, 19 Nov 2022 00:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235149AbiKRXRz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Nov 2022 18:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235278AbiKRXRY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Nov 2022 18:17:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786D4711AA;
        Fri, 18 Nov 2022 15:00:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D1120627DB;
        Fri, 18 Nov 2022 23:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2AC7EC433D6;
        Fri, 18 Nov 2022 23:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668812418;
        bh=ufnMnm7hU1NeN0wwQvH3qd/2TEn0yGbyHyHllNoy8Cg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=cHNfXbu1Cc+6ivHag6hQ3i46/PYFEyKubTlxcQ5VaBp1SpI5mmBTYlRFBYcKQh07U
         Y4ivLKzkHBE54D3rqh05reYHJ177GgoAxHPhG0b4YRFagpW/MvMdugXDbPdCy9rvGH
         PxpNjvpynpDLSwSkN3UJNoSfRN1LcyI7j/9XcNHkxEFBnOueS6sfxVOSUsoDFe977W
         s+3Wbtl4FyNUJ2e/qp90yNE/FG1H5H8r/IDLNd+97/doPDs4O0IJU/ge/HC8Blb9OJ
         YBhIYtbff9Fmh8pSxkmU+CF2JXIDv+FjUOvlUIwOHbGhz+ofdLUGqPNdY+PTX0/lvr
         LGqbT6kpI/OAw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0B2BAE29F44;
        Fri, 18 Nov 2022 23:00:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] samples: bpf: Use "grep -E" instead of "egrep"
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166881241804.2705.2361476082601817210.git-patchwork-notify@kernel.org>
Date:   Fri, 18 Nov 2022 23:00:18 +0000
References: <1668765001-12477-1-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1668765001-12477-1-git-send-email-yangtiezhu@loongson.cn>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Fri, 18 Nov 2022 17:50:01 +0800 you wrote:
> The latest version of grep claims the egrep is now obsolete so the build
> now contains warnings that look like:
> 	egrep: warning: egrep is obsolescent; using grep -E
> fix this up by moving the related file to use "grep -E" instead.
> 
>   sed -i "s/egrep/grep -E/g" `grep egrep -rwl samples/bpf`
> 
> [...]

Here is the summary with links:
  - [bpf-next] samples: bpf: Use "grep -E" instead of "egrep"
    https://git.kernel.org/bpf/bpf-next/c/ee748cd95e3a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


