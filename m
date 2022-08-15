Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 672F459396D
	for <lists+bpf@lfdr.de>; Mon, 15 Aug 2022 21:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244085AbiHOTVp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Aug 2022 15:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344471AbiHOTVO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Aug 2022 15:21:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97581B51
        for <bpf@vger.kernel.org>; Mon, 15 Aug 2022 11:40:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E38806113D
        for <bpf@vger.kernel.org>; Mon, 15 Aug 2022 18:40:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4C620C43140;
        Mon, 15 Aug 2022 18:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660588814;
        bh=71wMFnMCpbzYuKAFk6EsF5ohcfv3XU/NSO431Qy7O+Q=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=NlKlcAwXTEuRrqeyWuySkMgIWH5YIb3lDCrTvHgmaeAZxFqf+Potr0LUbAa0b+net
         22jIzzdY1HGhOozstrhuX6vi88kcE251MgvQ7AFjunegpJ0F5DZKkktBlcfMrduYbT
         mfJLeJ0cpJZ8MV7zmcgpVWdoaCFlbSnZn+mbxsusxM3h8e1jOQMgwPwbLeZo4Dgbkt
         jfhyPNrEF5jXTZV3ExmH5s3NkziMKPHXY+jcKO0Q9KlDsSyYMiqFZwH2/UnJxf48/D
         6KgJYDeWfLQCXf1fziMOul0YFL4GMm2ARMli0VxbivRwqDsmmpGUj495uDS4TqCB4g
         dT+ulxLjpodQg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 37136E2A051;
        Mon, 15 Aug 2022 18:40:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] bpftool: Clear errno after libcap's checks
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166058881422.31254.5887784010573260506.git-patchwork-notify@kernel.org>
Date:   Mon, 15 Aug 2022 18:40:14 +0000
References: <20220815162205.45043-1-quentin@isovalent.com>
In-Reply-To: <20220815162205.45043-1-quentin@isovalent.com>
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
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

On Mon, 15 Aug 2022 17:22:05 +0100 you wrote:
> When bpftool is linked against libcap, the library runs a "constructor"
> function to compute the number of capabilities of the running kernel
> [0], at the beginning of the execution of the program. As part of this,
> it performs multiple calls to prctl(). Some of these may fail, and set
> errno to a non-zero value:
> 
>     # strace -e prctl ./bpftool version
>     prctl(PR_CAPBSET_READ, CAP_MAC_OVERRIDE) = 1
>     prctl(PR_CAPBSET_READ, 0x30 /* CAP_??? */) = -1 EINVAL (Invalid argument)
>     prctl(PR_CAPBSET_READ, CAP_CHECKPOINT_RESTORE) = 1
>     prctl(PR_CAPBSET_READ, 0x2c /* CAP_??? */) = -1 EINVAL (Invalid argument)
>     prctl(PR_CAPBSET_READ, 0x2a /* CAP_??? */) = -1 EINVAL (Invalid argument)
>     prctl(PR_CAPBSET_READ, 0x29 /* CAP_??? */) = -1 EINVAL (Invalid argument)
>     ** fprintf added at the top of main(): we have errno == 1
>     ./bpftool v7.0.0
>     using libbpf v1.0
>     features: libbfd, libbpf_strict, skeletons
>     +++ exited with 0 +++
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] bpftool: Clear errno after libcap's checks
    https://git.kernel.org/bpf/bpf-next/c/cea558855c39

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


