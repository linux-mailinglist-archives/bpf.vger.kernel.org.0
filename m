Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446C95E56C9
	for <lists+bpf@lfdr.de>; Thu, 22 Sep 2022 01:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiIUXkW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Sep 2022 19:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiIUXkU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Sep 2022 19:40:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2388F67141;
        Wed, 21 Sep 2022 16:40:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CC31EB8336D;
        Wed, 21 Sep 2022 23:40:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 67A7CC433D7;
        Wed, 21 Sep 2022 23:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663803616;
        bh=gx8WMZqzq0+H7zdC8DGV7XVEwgg9fq7Lx1nSTcqWSL8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=O2b7qP8QFLVI7Or467AX5aZXnXOIwz3mEI0cEpKuGBkDDl0RGaUDm3O8tVF8srRnr
         JkhzhswZAAHVr7p7n4EkfHvypauoEV9qT1L7TOgIMs1aw3tvA4c49hfgjr581iPgfp
         JMvfnbjSj9Y2p0MzpCkQeIEzs6JSgQLp7tdyvcvnfjdNsGuDmQyI8wDpCHJwxzBsyw
         ZMdkSGvxXpJDgeIkOKfj3PyLL206I7+s8qaI+LyF/XU/ihVNkhoxtp/FfDhYChyLJZ
         ojAitAoIba+scr/muk7G2CXMTT3PirmpSC9rJpluhLDo/9mavYHOMTOf8us+0j/ugL
         9Op54QyyjSBnA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 460D7E4D03D;
        Wed, 21 Sep 2022 23:40:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 0/4] bpf: Add user-space-publisher ring buffer map type
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166380361628.10161.4038336755255982198.git-patchwork-notify@kernel.org>
Date:   Wed, 21 Sep 2022 23:40:16 +0000
References: <20220920000100.477320-1-void@manifault.com>
In-Reply-To: <20220920000100.477320-1-void@manifault.com>
To:     David Vernet <void@manifault.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, kernel-team@fb.com, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org, tj@kernel.org,
        brho@google.com, joshdon@google.com
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
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 19 Sep 2022 19:00:56 -0500 you wrote:
> This patch set defines a new map type, BPF_MAP_TYPE_USER_RINGBUF, which
> provides single-user-space-producer / single-kernel-consumer semantics over
> a ring buffer.  Along with the new map type, a helper function called
> bpf_user_ringbuf_drain() is added which allows a BPF program to specify a
> callback with the following signature, to which samples are posted by the
> helper:
> 
> [...]

Here is the summary with links:
  - [v6,1/4] bpf: Define new BPF_MAP_TYPE_USER_RINGBUF map type
    https://git.kernel.org/bpf/bpf-next/c/583c1f420173
  - [v6,2/4] bpf: Add bpf_user_ringbuf_drain() helper
    https://git.kernel.org/bpf/bpf-next/c/205715673844
  - [v6,3/4] bpf: Add libbpf logic for user-space ring buffer
    https://git.kernel.org/bpf/bpf-next/c/b66ccae01f1d
  - [v6,4/4] selftests/bpf: Add selftests validating the user ringbuf
    https://git.kernel.org/bpf/bpf-next/c/e5a9df51c746

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


