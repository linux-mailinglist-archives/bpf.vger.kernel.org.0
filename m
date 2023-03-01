Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5691A6A7428
	for <lists+bpf@lfdr.de>; Wed,  1 Mar 2023 20:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjCATUV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Mar 2023 14:20:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjCATUU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Mar 2023 14:20:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CFA39CD7
        for <bpf@vger.kernel.org>; Wed,  1 Mar 2023 11:20:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 236A861488
        for <bpf@vger.kernel.org>; Wed,  1 Mar 2023 19:20:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7140EC4339B;
        Wed,  1 Mar 2023 19:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677698418;
        bh=9x9ayheILaGcnc5y2OuAjythB72olI5wLPzhwyGW9Rc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=QX9RMGPfNtoEgALhclxJmiPnv11vyWzQtVf18AuROJe3dhjfpPMAPRe3SkpemU8vm
         kE1EtgzA4f39DScwj0rwB1VMmMoG+0+t/jBO/ajpMPznCYqL3t7LrmZ27cEI1+nKoo
         WU/Od7uqIKiQXpkAIMeuzG8i6+vUH9086gIF1Sr+ZIPsXJqxXBjE6IO9SovvZevFFr
         SE6ml8uJfiutRLICgx28bLpmdnjcaZY66BRtw1b5WSj5Ql+99h7zGaZnDY2lp0Ipsd
         pu1AkSOa0QIV3Fl2Yc8egYSneUIqrc2ZuR0do40ZVgKz1H1o0A/p5BF3B0dlO+Btkv
         1uAg25bJYVKBQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 52A8CE450A5;
        Wed,  1 Mar 2023 19:20:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/3] libbpf: fix several issues reported by static
 analysers
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167769841833.22651.16790303398957406850.git-patchwork-notify@kernel.org>
Date:   Wed, 01 Mar 2023 19:20:18 +0000
References: <cover.1677658777.git.vmalik@redhat.com>
In-Reply-To: <cover.1677658777.git.vmalik@redhat.com>
To:     Viktor Malik <vmalik@redhat.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        nathan@kernel.org, ndesaulniers@google.com, trix@redhat.com
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

On Wed,  1 Mar 2023 09:53:52 +0100 you wrote:
> Fixing several issues reported by Coverity and Clang Static Analyzer
> (scan-build) for libbpf, mostly removing unnecessary symbols and
> assignments.
> 
> No functional changes should be introduced.
> 
> Viktor Malik (3):
>   libbpf: remove unnecessary ternary operator
>   libbpf: remove several dead assignments
>   libbpf: cleanup linker_append_elf_relos
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/3] libbpf: remove unnecessary ternary operator
    https://git.kernel.org/bpf/bpf-next/c/40e1bcab1e4c
  - [bpf-next,2/3] libbpf: remove several dead assignments
    https://git.kernel.org/bpf/bpf-next/c/7832d06bd9f9
  - [bpf-next,3/3] libbpf: cleanup linker_append_elf_relos
    https://git.kernel.org/bpf/bpf-next/c/4672129127ee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


