Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF5D5262F1
	for <lists+bpf@lfdr.de>; Fri, 13 May 2022 15:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349165AbiEMNUV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 May 2022 09:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357030AbiEMNUR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 May 2022 09:20:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6AC38DA5
        for <bpf@vger.kernel.org>; Fri, 13 May 2022 06:20:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B690AB8302B
        for <bpf@vger.kernel.org>; Fri, 13 May 2022 13:20:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7C202C34115;
        Fri, 13 May 2022 13:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652448013;
        bh=2PuUDkaRE8lP1X3/fUYzQqAbJZ4luWJXQ5Bps1HQ+o8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=CAGWRIToPxut7GJR2kmdKf987x7bN2SQeqynbp4vE4etwehwqIDSimxs/I+li1Qiv
         JZOfj4+TuvKGCXSB1ZwwUFU26L8Rx7+8tdCUEHeniNvQTFmIt/b228fTOJpAtFaBXj
         ZsTUatoZnB8Qq57JFGTR6CxZ6El/miWKlskp0VGa3+8iIu/D7QBzO53sRl6WxE4b1Z
         XHaE/NQssI2tyAjyXFUlpEbMnx8rWo1D8NaTjFedPDrh67rW9Xinrjhk2JZQovjydB
         QSZW+rFzupcKxaXqAZxhUuzADr4alVfkv7tmoRuiYSlakLO8kwZaQ6t0lfHvIfcVw0
         oZRqdOJUB4q9w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 503C2F03935;
        Fri, 13 May 2022 13:20:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 1/2] libbpf: add safer high-level wrappers for map
 operations
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165244801332.11154.15682130887036366933.git-patchwork-notify@kernel.org>
Date:   Fri, 13 May 2022 13:20:13 +0000
References: <20220512220713.2617964-1-andrii@kernel.org>
In-Reply-To: <20220512220713.2617964-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
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
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu, 12 May 2022 15:07:12 -0700 you wrote:
> Add high-level API wrappers for most common and typical BPF map
> operations that works directly on instances of struct bpf_map * (so you
> don't have to call bpf_map__fd()) and validate key/value size
> expectations.
> 
> These helpers require users to specify key (and value, where
> appropriate) sizes when performing lookup/update/delete/etc. This forces
> user to actually think and validate (for themselves) those. This is
> a good thing as user is expected by kernel to implicitly provide correct
> key/value buffer sizes and kernel will just read/write necessary amount
> of data. If it so happens that user doesn't set up buffers correctly
> (which bit people for per-CPU maps especially) kernel either randomly
> overwrites stack data or return -EFAULT, depending on user's luck and
> circumstances. These high-level APIs are meant to prevent such
> unpleasant and hard to debug bugs.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] libbpf: add safer high-level wrappers for map operations
    https://git.kernel.org/bpf/bpf-next/c/737d0646a83c
  - [bpf-next,2/2] selftests/bpf: convert some selftests to high-level BPF map APIs
    https://git.kernel.org/bpf/bpf-next/c/b2531d4bdce1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


