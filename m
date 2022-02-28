Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9634C7266
	for <lists+bpf@lfdr.de>; Mon, 28 Feb 2022 18:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbiB1RUw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Feb 2022 12:20:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233313AbiB1RUv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Feb 2022 12:20:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5A685652;
        Mon, 28 Feb 2022 09:20:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6C5A4B81598;
        Mon, 28 Feb 2022 17:20:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 19D8EC340F0;
        Mon, 28 Feb 2022 17:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646068810;
        bh=DcGqAuTOeJK4O00ul1t6fawIJX6duA+rQ89Lb2Nmxpk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=M17FTQe/LybnGmMvfrcPyegm1NPdccFVQX/l0FSUZI/hpObrnocHZzhioJ+O47hYC
         qGIICMIFCYD+FqaehKh2vvEcL+HbwmMo55EbRJiDcB/FAhNL9/KPIMJPPGg0K3v3v0
         nKe8vct6NyTQf/d11Ru774zkxUcfC05n/GtdemAXhVaRTddxnZxMJ+VE9yuRyXhyVG
         c1NqqnzDzpzvKYCGldds7tTkvptnLEt5ikUw5w6helxM1ci5c9AChADq3D60CWZlqp
         68DkQrlRaorVezG/9FlVDQ40qBsG0SruT1VUUboW4afyneGpgh8SiN4GYo8kpBHnKP
         lYb3OHlx6cLyg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F2E85E5D087;
        Mon, 28 Feb 2022 17:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] bpf: Cache the last valid build_id.
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164606880999.12943.12753138670419777830.git-patchwork-notify@kernel.org>
Date:   Mon, 28 Feb 2022 17:20:09 +0000
References: <20220224000531.1265030-1-haoluo@google.com>
In-Reply-To: <20220224000531.1265030-1-haoluo@google.com>
To:     Hao Luo <haoluo@google.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        songliubraving@fb.com, namhyung@kernel.org, blakejones@google.com,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        gthelen@google.com
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Wed, 23 Feb 2022 16:05:31 -0800 you wrote:
> For binaries that are statically linked, consecutive stack frames are
> likely to be in the same VMA and therefore have the same build id.
> As an optimization for this case, we can cache the previous frame's
> VMA, if the new frame has the same VMA as the previous one, reuse the
> previous one's build id. We are holding the MM locks as reader across
> the entire loop, so we don't need to worry about VMA going away.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] bpf: Cache the last valid build_id.
    https://git.kernel.org/bpf/bpf-next/c/ceac059ed4fd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


