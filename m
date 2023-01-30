Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAB5680449
	for <lists+bpf@lfdr.de>; Mon, 30 Jan 2023 04:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235116AbjA3Da2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 29 Jan 2023 22:30:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235082AbjA3Da1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 29 Jan 2023 22:30:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA9A1E1F4
        for <bpf@vger.kernel.org>; Sun, 29 Jan 2023 19:30:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B76D60EAC
        for <bpf@vger.kernel.org>; Mon, 30 Jan 2023 03:30:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EC713C433EF;
        Mon, 30 Jan 2023 03:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675049418;
        bh=2Y+8raFQwqp/fTjdID60WTbjq70ctGnpgIiYfLsC6is=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=BNqgrvjS84kCeKDqe1WD4wKWIovO+1SdHtPKq4wpjP/VMbj2kDT55QVN7Dg+WFieL
         sRK8ujExbbpSEZsJs3pCPMWVHpcubl/WYjvG8Ajqt52AOPBGDPURyBLLKQSt+QNyGr
         jlqUPXes31yMo95yepoVL9Ao0pkHYv6ADxBNjChuCaGcNxbty+44E8NDt8f66Y4His
         PGrx1+fCjfwxeg4YqYO5m05oY1hytO7A1W98KlKZb+lyoqRRRJeJu1U/EaQWC0CU0g
         0w5cP2x1DXKL8g3wuHscWGbjoQQvAuOQB8XSxWNs7GrK++x3+7JW3sjzdYvfAnYTRB
         swctEkljrawMw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D445CC4167B;
        Mon, 30 Jan 2023 03:30:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/8] Support bpf trampoline for s390x
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167504941786.21800.8142936651872871592.git-patchwork-notify@kernel.org>
Date:   Mon, 30 Jan 2023 03:30:17 +0000
References: <20230129190501.1624747-1-iii@linux.ibm.com>
In-Reply-To: <20230129190501.1624747-1-iii@linux.ibm.com>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        bpf@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sun, 29 Jan 2023 20:04:53 +0100 you wrote:
> v2: https://lore.kernel.org/bpf/20230128000650.1516334-1-iii@linux.ibm.com/#t
> v2 -> v3:
> - Make __arch_prepare_bpf_trampoline static.
>   (Reported-by: kernel test robot <lkp@intel.com>)
> - Support both old- and new- style map definitions in sk_assign. (Alexei)
> - Trim DENYLIST.s390x. (Alexei)
> - Adjust s390x vmlinux path in vmtest.sh.
> - Drop merged fixes.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/8] selftests/bpf: Fix sk_assign on s390x
    https://git.kernel.org/bpf/bpf-next/c/7ce878ca81bc
  - [bpf-next,v3,2/8] s390/bpf: Add expoline to tail calls
    https://git.kernel.org/bpf/bpf-next/c/bb4ef8fc3d19
  - [bpf-next,v3,3/8] s390/bpf: Implement bpf_arch_text_poke()
    https://git.kernel.org/bpf/bpf-next/c/f1d5df84cd8c
  - [bpf-next,v3,4/8] s390/bpf: Implement arch_prepare_bpf_trampoline()
    https://git.kernel.org/bpf/bpf-next/c/528eb2cb87bc
  - [bpf-next,v3,5/8] s390/bpf: Implement bpf_jit_supports_subprog_tailcalls()
    https://git.kernel.org/bpf/bpf-next/c/dd691e847d28
  - [bpf-next,v3,6/8] s390/bpf: Implement bpf_jit_supports_kfunc_call()
    https://git.kernel.org/bpf/bpf-next/c/63d7b53ab59f
  - [bpf-next,v3,7/8] selftests/bpf: Fix s390x vmlinux path
    https://git.kernel.org/bpf/bpf-next/c/af320fb7ddb0
  - [bpf-next,v3,8/8] selftests/bpf: Trim DENYLIST.s390x
    https://git.kernel.org/bpf/bpf-next/c/ee105d5a50d4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


