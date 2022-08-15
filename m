Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA60559320F
	for <lists+bpf@lfdr.de>; Mon, 15 Aug 2022 17:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbiHOPgR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Aug 2022 11:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232234AbiHOPgM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Aug 2022 11:36:12 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2371B13D39
        for <bpf@vger.kernel.org>; Mon, 15 Aug 2022 08:36:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 73F74CE112D
        for <bpf@vger.kernel.org>; Mon, 15 Aug 2022 15:36:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B27BFC433C1;
        Mon, 15 Aug 2022 15:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660577768;
        bh=mGAY0UJmcFjtex+2QDap/OmBluoeoKaXalX+KShTAww=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=fQEGKsZ52hRcRH3CsV9jb9F6oQQRbhDohvS87mzp6YpsSyUKznPCoYxsq7lBDr5cM
         yS23j1zYUxOM85KoYdWCg3lQXHYkrA9bh7QrIXdMrZuVZIdoGnx07cSK4omnav8SFd
         UPbTFirD7GkeGE+G8NltpAdqx07iu70TNfQZ6O24SbZYHzVosTfKk3f15cZR4KVklS
         gUl1OBDGblDn09OcyDzwO4rWoPHovdNJYwgMp7zeI0UEpj80GL0I7pyy2lu05iLOcP
         St+wY4d5lmM6TWRhHFCmarxGQ/tGdwpib1FdTPebuM+wOk74aY2k8zHeU10X/DfC/v
         cbNhjTjjjwu3A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9C4D4E2A050;
        Mon, 15 Aug 2022 15:36:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Clear up confusion in bpf_skb_adjust_room()'s
 documentation
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166057776863.2541.17985979200763729909.git-patchwork-notify@kernel.org>
Date:   Mon, 15 Aug 2022 15:36:08 +0000
References: <20220812153727.224500-3-quentin@isovalent.com>
In-Reply-To: <20220812153727.224500-3-quentin@isovalent.com>
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        rumen.telbizov@menlosecurity.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
by Daniel Borkmann <daniel@iogearbox.net>:

On Fri, 12 Aug 2022 16:37:27 +0100 you wrote:
> Adding or removing room space _below_ layers 2 or 3, as the description
> mentions, is ambiguous. This was written with a mental image of the
> packet with layer 2 at the top, layer 3 under it, and so on. But it has
> led users to believe that it was on lower layers (before the beginning
> of the L2 and L3 headers respectively).
> 
> Let's make it more explicit, and specify between which layers the room
> space is adjusted.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Clear up confusion in bpf_skb_adjust_room()'s documentation
    https://git.kernel.org/bpf/bpf-next/c/4961d0772578

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


