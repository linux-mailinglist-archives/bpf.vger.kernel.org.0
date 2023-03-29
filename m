Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C72F76CF49E
	for <lists+bpf@lfdr.de>; Wed, 29 Mar 2023 22:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjC2UkY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Mar 2023 16:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjC2UkX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Mar 2023 16:40:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13FB95FE7
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 13:40:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B4A7AB8243D
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 20:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5C57BC4339B;
        Wed, 29 Mar 2023 20:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680122420;
        bh=sHucoaaDQHTVkWr+zE1MpWV7BnQVjeHdNpYUSgOgbLk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=l2G+M3YLrJemEPwo6a7mNB0eHBlZVdL7CzvtYOc7y4bOSo/s4bsKglpjh/sWW3i/d
         Vq54bpPO5ethsewkTR7bDqaedFVbpVPcFEtY/xGwhajwvTAC5cpbZkb+AezC2FDCSi
         dGb54nd6CYdUbV1HuDpN5Q/kbSJkcetHzSILcRc1DDiAC4xMEojgoiPiJkl7Z8HPMM
         pMD6yisPfhCw8TaNr0QYqobnY01dhGg0vqw6gQzNC18rngbsaeQ5tRmyhPNJ9q3dCm
         nwA8wLEaiIxrsFZrJ0wvtP+j+gkHz11oUaCk3N3wA0YdyWnrnkIBtjwFSuKlRr6XsO
         XEuqft5EOPfOg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3A431E21EE4;
        Wed, 29 Mar 2023 20:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/2] Allow BPF TCP CCs to write app_limited
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168012242022.23822.8467286004510025048.git-patchwork-notify@kernel.org>
Date:   Wed, 29 Mar 2023 20:40:20 +0000
References: <20230329073558.8136-1-bobankhshen@gmail.com>
In-Reply-To: <20230329073558.8136-1-bobankhshen@gmail.com>
To:     Yixin Shen <bobankhshen@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@kernel.org, song@kernel.org,
        yhs@fb.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Wed, 29 Mar 2023 07:35:56 +0000 you wrote:
> This series allow BPF TCP CCs to write app_limited of struct
> tcp_sock. A built-in CC or one from a kernel module is already
> able to write to app_limited of struct tcp_sock. Until now,
> a BPF CC doesn't have write access to this member of struct
> tcp_sock.
> 
> v2:
>  - Merge the test of writing app_limited into the test of
>    writing sk_pacing. (Martin KaFai Lau)
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] bpf: allow a TCP CC to write app_limited
    https://git.kernel.org/bpf/bpf-next/c/562dc56a8898
  - [bpf-next,v2,2/2] selftests/bpf: test a BPF CC writing app_limited
    https://git.kernel.org/bpf/bpf-next/c/4239561b69fe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


