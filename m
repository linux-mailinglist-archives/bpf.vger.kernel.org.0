Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418D56D34D2
	for <lists+bpf@lfdr.de>; Sun,  2 Apr 2023 00:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjDAWUX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 1 Apr 2023 18:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjDAWUW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 1 Apr 2023 18:20:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DA412845
        for <bpf@vger.kernel.org>; Sat,  1 Apr 2023 15:20:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DF047B80DBF
        for <bpf@vger.kernel.org>; Sat,  1 Apr 2023 22:20:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9400BC4339B;
        Sat,  1 Apr 2023 22:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680387617;
        bh=4YJK1R8SHQK+kWarIszUO2Hzyj/XfmBI1I2NjjFaJ8M=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=bPQCmt+hloGwApQ9ZpAbE0lKnKIqfdxm9dhUc0GP7ssA2lTAUK50qrpykxDLBi1yo
         nrrD2kje1+26Hzfct04DRHbkNwkjJKl7pugzFfBGAPA1Rw5+HWH5xLj/4VP/cUAdkm
         zEHzrx6fvE8FWAq1qkvGeFurXnlZoRQp8wVBX21JdadDAW8VYKjvsMKXNACr+HBoGT
         w3/bpXkavUO8yihh7JptbkVNhGVOZ2kC++hgtutoEsUjPelh0QzmePSaoPWLaoyqQB
         Vrk2dWTRUxlx9QE2elwd4sFzij5g0m9jU4wjF0QqdgcRv43G0jKyud8wya52WFB3tK
         3iQ6ETmEFmjMQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7878AC395C3;
        Sat,  1 Apr 2023 22:20:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next] bpf: optimize hashmap lookups when key_size is
 divisible by 4
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168038761749.29492.1401049227998557631.git-patchwork-notify@kernel.org>
Date:   Sat, 01 Apr 2023 22:20:17 +0000
References: <20230401200602.3275-1-aspsk@isovalent.com>
In-Reply-To: <20230401200602.3275-1-aspsk@isovalent.com>
To:     Anton Protopopov <aspsk@isovalent.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, john.fastabend@gmail.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat,  1 Apr 2023 20:06:02 +0000 you wrote:
> The BPF hashmap uses the jhash() hash function. There is an optimized version
> of this hash function which may be used if hash size is a multiple of 4. Apply
> this optimization to the hashmap in a similar way as it is done in the bloom
> filter map.
> 
> On practice the optimization is only noticeable for smaller key sizes, which,
> however, is sufficient for many applications. An example is listed in the
> following table of measurements (a hashmap of 65536 elements was used):
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next] bpf: optimize hashmap lookups when key_size is divisible by 4
    https://git.kernel.org/bpf/bpf-next/c/5b85575ad428

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


