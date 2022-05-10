Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90C755223FF
	for <lists+bpf@lfdr.de>; Tue, 10 May 2022 20:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236599AbiEJSaS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 May 2022 14:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245498AbiEJSaR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 May 2022 14:30:17 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 366012608E7
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 11:30:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 90B47CE2022
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 18:30:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EFF4AC385A6;
        Tue, 10 May 2022 18:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652207413;
        bh=+DBhuTEFsDQjdimR1NbtCJw0u51g5CqbcWI1GV5O/gg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=CyZLV6C2SW2aGqNYCcYH6xzKMCa23i31S84afj0ojYgiteTP3M1HJRlsQcNEfzztJ
         HcMkfr9QZbyG1oXF1Kp6oHptKRLdfK9LlGaZXI52uAA2ruoDp1WlBIqxONRd9dj88U
         LcgzuhySN8mgc1ymwMmf0BRqwlW/9OlE2ms38Y2ULjf/1ZQf5WF++Qy0w8OobxedGZ
         UHafqk20B6y2J/wDJOpChtRki2A5SHysGy6KR/UNR1k7mwBPM1tXnVGCm7STEjArTi
         uve+2NmqiMefrE+Rm2zN7y61eBEmD72Ybqi5JDp3U87Pt/xel2lv4AESPVNnTUK/JY
         zAaDUIjJjZDdg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D1268F03930;
        Tue, 10 May 2022 18:30:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/4] bpf: bpf link iterator
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165220741285.22644.9429671919023318028.git-patchwork-notify@kernel.org>
Date:   Tue, 10 May 2022 18:30:12 +0000
References: <20220510155233.9815-1-9erthalion6@gmail.com>
In-Reply-To: <20220510155233.9815-1-9erthalion6@gmail.com>
To:     Dmitrii Dolgov <9erthalion6@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, yhs@fb.com, songliubraving@fb.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 10 May 2022 17:52:29 +0200 you wrote:
> Bpf links seem to be one of the important structures for which no
> iterator is provided. Such iterator could be useful in those cases when
> generic 'task/file' is not suitable or better performance is needed.
> 
> The implementation is mostly copied from prog iterator. This time tests were
> executed, although I still had to exclude test_bpf_nf (failed to find BTF info
> for global/extern symbol 'bpf_skb_ct_lookup') -- since it's unrelated, I hope
> it's a minor issue.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/4] bpf: Add bpf_link iterator
    https://git.kernel.org/bpf/bpf-next/c/9f8836127308
  - [bpf-next,v2,2/4] selftests/bpf: Fix result check for test_bpf_hash_map
    https://git.kernel.org/bpf/bpf-next/c/6b2d16b6579a
  - [bpf-next,v2,3/4] selftests/bpf: Use ASSERT_* instead of CHECK
    https://git.kernel.org/bpf/bpf-next/c/f78625fdc95e
  - [bpf-next,v2,4/4] selftests/bpf: Add bpf link iter test
    https://git.kernel.org/bpf/bpf-next/c/5a9b8e2c1ad4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


