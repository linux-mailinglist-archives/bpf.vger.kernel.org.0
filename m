Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A886E522339
	for <lists+bpf@lfdr.de>; Tue, 10 May 2022 20:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234534AbiEJSEP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 May 2022 14:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234017AbiEJSEP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 May 2022 14:04:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B089726C4D5
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 11:00:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D4D89B81EF0
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 18:00:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6E8D8C385C2;
        Tue, 10 May 2022 18:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652205613;
        bh=UB7vYQI54ITG92wlKHuyC+r+aL7fpXQRmkhLcEbb9CY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=J9lnGvmJc6CMJyo8GRiliumWJ2VITRF+ol1sh+SA3SvlNGoQNVinnQyocdqcQHDdC
         v01YT5m9qoJFNRPcIYMA6XYgJFe/c/dvGDtbZoznHzSsubbz7AWYMnVEogJ09M6BSL
         TUt3QLNU4dOhwzzg1yhCXDjGNlzKxiKjWDTMtYQNTicZQ8SKcwDhLQKOnETfEYIAUs
         sUoxa1amex2A06eG0qXa9ho21xrsvR170J4b90EMu8noHYTj0bR+KNaONXfPQdhAYg
         OObU0Yrs8ctsiWkABqyQTEFD7BaclmSEYAeDrTuLNbToawsM14heVluIBi6ABbs9je
         yebQxlHY6FiHw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 502E9F0392D;
        Tue, 10 May 2022 18:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [External] [PATCH bpf-next v6 0/3] Add source ip in bpf tunnel key
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165220561332.6035.6652465314332894275.git-patchwork-notify@kernel.org>
Date:   Tue, 10 May 2022 18:00:13 +0000
References: <20220430074844.69214-1-fankaixi.li@bytedance.com>
In-Reply-To: <20220430074844.69214-1-fankaixi.li@bytedance.com>
To:     Kaixi Fan <fankaixi.li@bytedance.com>
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, bpf@vger.kernel.org,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net
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

On Sat, 30 Apr 2022 15:48:41 +0800 you wrote:
> From: Kaixi Fan <fankaixi.li@bytedance.com>
> 
> Now bpf code could not set tunnel source ip address of ip tunnel. So it
> could not support flow based tunnel mode completely. Because flow based
> tunnel mode could set tunnel source, destination ip address and tunnel
> key simultaneously.
> 
> [...]

Here is the summary with links:
  - [External,bpf-next,v6,1/3] bpf: Add source ip in "struct bpf_tunnel_key"
    https://git.kernel.org/bpf/bpf-next/c/26101f5ab6bd
  - [External,bpf-next,v6,2/3] selftests/bpf: Move vxlan tunnel testcases to test_progs
    https://git.kernel.org/bpf/bpf-next/c/1ee7efd40abf
  - [External,bpf-next,v6,3/3] selftests/bpf: Replace bpf_trace_printk in tunnel kernel code
    https://git.kernel.org/bpf/bpf-next/c/71b2ec21c331

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


