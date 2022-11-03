Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64CA86189EC
	for <lists+bpf@lfdr.de>; Thu,  3 Nov 2022 21:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbiKCUuV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Nov 2022 16:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiKCUuU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Nov 2022 16:50:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F14CBBE
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 13:50:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AE0E2B82A62
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 20:50:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 57E45C433C1;
        Thu,  3 Nov 2022 20:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667508616;
        bh=A8spzyhMlq2PxF3Ki4krf9ovEnPJb3xBS0itEw5Pp/4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=nGF1QZfPi4FuDFhCk4F7D0ZBHDTVVUZqExw3Y2sMJc5h8c0LRvKHADZX1bDdFqa4a
         4v91bP0ogYVdqm+1oQSPcpzx7DNUJozkHGuIHTCiExIZDly/8Pki5re/LceV9IMNT0
         /Zd7L/XSgrc0RqeQpCiZxcnOeG5mjasI9h9w/J1jjgizxsKd/L365CUESTmC00CjUB
         fVHffibg8Etf/NI/bHjJ67B6aOyHEUtRIxEP4Y2P5TRfzB2u7U1TR4mCAQdxyuCRbf
         fkAAl2dAGEkff6OZIn6Uzs93vskH+MknCGPmf7S9EHO83ZbRJMpQZN3ebQ73PbrV1z
         Pfzt8+PXXYqhA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3A139E270F6;
        Thu,  3 Nov 2022 20:50:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: make sure skb->len != 0 when redirecting to a
 tunneling device
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166750861623.15406.9834935004945257134.git-patchwork-notify@kernel.org>
Date:   Thu, 03 Nov 2022 20:50:16 +0000
References: <20221027225537.353077-1-sdf@google.com>
In-Reply-To: <20221027225537.353077-1-sdf@google.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org, edumazet@google.com,
        syzbot+f635e86ec3fa0a37e019@syzkaller.appspotmail.com
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Thu, 27 Oct 2022 15:55:37 -0700 you wrote:
> syzkaller managed to trigger another case where skb->len == 0
> when we enter __dev_queue_xmit:
> 
> WARNING: CPU: 0 PID: 2470 at include/linux/skbuff.h:2576 skb_assert_len include/linux/skbuff.h:2576 [inline]
> WARNING: CPU: 0 PID: 2470 at include/linux/skbuff.h:2576 __dev_queue_xmit+0x2069/0x35e0 net/core/dev.c:4295
> 
> Call Trace:
>  dev_queue_xmit+0x17/0x20 net/core/dev.c:4406
>  __bpf_tx_skb net/core/filter.c:2115 [inline]
>  __bpf_redirect_no_mac net/core/filter.c:2140 [inline]
>  __bpf_redirect+0x5fb/0xda0 net/core/filter.c:2163
>  ____bpf_clone_redirect net/core/filter.c:2447 [inline]
>  bpf_clone_redirect+0x247/0x390 net/core/filter.c:2419
>  bpf_prog_48159a89cb4a9a16+0x59/0x5e
>  bpf_dispatcher_nop_func include/linux/bpf.h:897 [inline]
>  __bpf_prog_run include/linux/filter.h:596 [inline]
>  bpf_prog_run include/linux/filter.h:603 [inline]
>  bpf_test_run+0x46c/0x890 net/bpf/test_run.c:402
>  bpf_prog_test_run_skb+0xbdc/0x14c0 net/bpf/test_run.c:1170
>  bpf_prog_test_run+0x345/0x3c0 kernel/bpf/syscall.c:3648
>  __sys_bpf+0x43a/0x6c0 kernel/bpf/syscall.c:5005
>  __do_sys_bpf kernel/bpf/syscall.c:5091 [inline]
>  __se_sys_bpf kernel/bpf/syscall.c:5089 [inline]
>  __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5089
>  do_syscall_64+0x54/0x70 arch/x86/entry/common.c:48
>  entry_SYSCALL_64_after_hwframe+0x61/0xc6
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: make sure skb->len != 0 when redirecting to a tunneling device
    https://git.kernel.org/bpf/bpf-next/c/0ed041b1dd33

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


