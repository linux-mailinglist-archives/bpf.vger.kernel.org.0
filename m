Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7C8158C9C0
	for <lists+bpf@lfdr.de>; Mon,  8 Aug 2022 15:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235611AbiHHNuY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 09:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237709AbiHHNuT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 09:50:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A405BE9E
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 06:50:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3FD78B80EA3
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 13:50:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E3426C433D7;
        Mon,  8 Aug 2022 13:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659966613;
        bh=BlcxI7SxWHxvxBiWnJgUeKJePlQEjb8k0CJ7osfR3gg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=hguBepKGv3lqzJ2O3wsffbLGXWwBy4ikBJIO5PjJI8sHgj/3jyCp2gjkk79MQYqe4
         53hbIumbhgKewZoDrJr/j4TvKSoaUlgqLv1burHIWZ3tA+KUHoaVGxoZTuFJZGiLF0
         qsvDV10hozUp+CHK+XMgcl7/CKqKQruioSmY31NunzTBuXEyLH09++DT8MZKlZeye6
         ZkiMUqQFixBAdKl9CmwHt/y1Enw1u/EJuNbid+BTx8ZyaTTMRl96lzvhVVzGKvubIZ
         UUQWhWv6Y5/zdXzPJJfdi0xlHda4j+MRmpDPOvuUw5HSi6gT69IwZDmct+AxaHd1gU
         c63mu6hxyRUpA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C6E62C43140;
        Mon,  8 Aug 2022 13:50:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v1] selftests/bpf: Clean up sys_nanosleep uses
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165996661381.25053.9915236911959115703.git-patchwork-notify@kernel.org>
Date:   Mon, 08 Aug 2022 13:50:13 +0000
References: <20220805171405.2272103-1-joannelkoong@gmail.com>
In-Reply-To: <20220805171405.2272103-1-joannelkoong@gmail.com>
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        ast@kernel.org
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

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Fri,  5 Aug 2022 10:14:05 -0700 you wrote:
> This patch cleans up a few things:
> 
>   * dynptr_fail.c:
>     There is no sys_nanosleep tracepoint. dynptr_fail only tests
>     that the prog load fails, so just SEC("?raw_tp") suffices here.
> 
>   * test_bpf_cookie:
>     There is no sys_nanosleep kprobe. The prog is loaded in
>     userspace through bpf_program__attach_kprobe_opts passing in
>     SYS_NANOSLEEP_KPROBE_NAME, so just SEC("k{ret}probe") suffices here.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v1] selftests/bpf: Clean up sys_nanosleep uses
    https://git.kernel.org/bpf/bpf-next/c/5653f55ebd76

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


