Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E67A672ADB
	for <lists+bpf@lfdr.de>; Wed, 18 Jan 2023 22:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjARVuV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Jan 2023 16:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjARVuU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 Jan 2023 16:50:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771385898C;
        Wed, 18 Jan 2023 13:50:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 23B96B81E14;
        Wed, 18 Jan 2023 21:50:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B32E6C433F0;
        Wed, 18 Jan 2023 21:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674078616;
        bh=XNMm/2loSgmJ5Uq3L2l1JbuANwqZtOL3gM6GQF/Ckvo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=h3mpKH/XwuM96xuKMNbMPfJMehaagEvljOjehxC2oMbKClcdZXiOXI+3sGI6fTv/o
         S+8YDtlgEU5E94DN5XlF761TbwQnYVOYXvgz9zqH5YDPorB0JLd9oo60gWhQctCylc
         hIYUBvblc5tHHCu2GwfCKgFragU34RXkEBexAth5lzdyaGh4zvP9nciXim3v7GX0Fb
         52gF6XQFmBWGRpNCpzIqlthDfItGwdnbsJFbVUNSLYE+7V7rpuuhnNkb5E0pCL2Mve
         WBbOLw1+JR2cj0CErwViZqAtDp+p7wAQFzUi4Yxqo6qfsQf2BYvU1swakcErxSW9H1
         Kdii/DQMn9pug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 96FECC395C6;
        Wed, 18 Jan 2023 21:50:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Fix build errors if
 CONFIG_NF_CONNTRACK=m
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167407861661.20957.14856268732002086872.git-patchwork-notify@kernel.org>
Date:   Wed, 18 Jan 2023 21:50:16 +0000
References: <1674028604-7113-1-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1674028604-7113-1-git-send-email-yangtiezhu@loongson.cn>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     andrii@kernel.org, mykolal@fb.com, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        lorenzo@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Wed, 18 Jan 2023 15:56:44 +0800 you wrote:
> If CONFIG_NF_CONNTRACK=m, there are no definitions of NF_NAT_MANIP_SRC
> and NF_NAT_MANIP_DST in vmlinux.h, build test_bpf_nf.c failed.
> 
> $ make -C tools/testing/selftests/bpf/
> 
>   CLNG-BPF [test_maps] test_bpf_nf.bpf.o
> progs/test_bpf_nf.c:160:42: error: use of undeclared identifier 'NF_NAT_MANIP_SRC'
>                 bpf_ct_set_nat_info(ct, &saddr, sport, NF_NAT_MANIP_SRC);
>                                                        ^
> progs/test_bpf_nf.c:163:42: error: use of undeclared identifier 'NF_NAT_MANIP_DST'
>                 bpf_ct_set_nat_info(ct, &daddr, dport, NF_NAT_MANIP_DST);
>                                                        ^
> 2 errors generated.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] selftests/bpf: Fix build errors if CONFIG_NF_CONNTRACK=m
    https://git.kernel.org/bpf/bpf-next/c/92afc5329a5b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


