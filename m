Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1165B62D41A
	for <lists+bpf@lfdr.de>; Thu, 17 Nov 2022 08:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239350AbiKQHaV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 02:30:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239354AbiKQHaU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 02:30:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED61167F7B;
        Wed, 16 Nov 2022 23:30:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 20609B81FA8;
        Thu, 17 Nov 2022 07:30:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B7A31C433D7;
        Thu, 17 Nov 2022 07:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668670215;
        bh=kHLyUlmjUgfbmzrTdZWyuXrkxfkse5KTcsnWkmG9JoY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Db5a74ZLfgfMrgVePBuuqq90Ut0UCzIeQU97Ss6yUvw+zwn8oiODxJe5qDhyreUKo
         6YZZRNtiq1fikNJRV9kWZw3j0kHEQJ86pu3xaIFBkaXFqs757zWEuj9gXCKI2E7+w4
         +4WFN1o2etFuKFd42duD9RMOh9WfzqNSazhsWYsPPGEstZjoW10X33iiE0Ff4Ar3pK
         E2Sra4Pk1jEk8xj8ymxv8xLPl/+l3cZJDuLaGMQWY5ynJtylPRL8aSQLRq8CKcQQjP
         cXvpiUcP3hsuasKatsN0nTpYT8tljr06F2QX5OEIefaK/q3vLNgPqtMHc3DsgKONED
         AIp0EevzBv5TA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 98C89E21EFB;
        Thu, 17 Nov 2022 07:30:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2] selftests/bpf: fix memory leak of lsm_cgroup
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166867021561.10591.11436633049725137545.git-patchwork-notify@kernel.org>
Date:   Thu, 17 Nov 2022 07:30:15 +0000
References: <1668482980-16163-1-git-send-email-wangyufen@huawei.com>
In-Reply-To: <1668482980-16163-1-git-send-email-wangyufen@huawei.com>
To:     Wang Yufen <wangyufen@huawei.com>
Cc:     linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, paul@paul-moore.com, sdf@google.com
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

On Tue, 15 Nov 2022 11:29:40 +0800 you wrote:
> kmemleak reports this issue:
> 
> unreferenced object 0xffff88810b7835c0 (size 32):
>   comm "test_progs", pid 270, jiffies 4294969007 (age 1621.315s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     03 00 00 00 03 00 00 00 0f 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<00000000376cdeab>] kmalloc_trace+0x27/0x110
>     [<000000003bcdb3b6>] selinux_sk_alloc_security+0x66/0x110
>     [<000000003959008f>] security_sk_alloc+0x47/0x80
>     [<00000000e7bc6668>] sk_prot_alloc+0xbd/0x1a0
>     [<0000000002d6343a>] sk_alloc+0x3b/0x940
>     [<000000009812a46d>] unix_create1+0x8f/0x3d0
>     [<000000005ed0976b>] unix_create+0xa1/0x150
>     [<0000000086a1d27f>] __sock_create+0x233/0x4a0
>     [<00000000cffe3a73>] __sys_socket_create.part.0+0xaa/0x110
>     [<0000000007c63f20>] __sys_socket+0x49/0xf0
>     [<00000000b08753c8>] __x64_sys_socket+0x42/0x50
>     [<00000000b56e26b3>] do_syscall_64+0x3b/0x90
>     [<000000009b4871b8>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> [...]

Here is the summary with links:
  - [bpf,v2] selftests/bpf: fix memory leak of lsm_cgroup
    https://git.kernel.org/bpf/bpf-next/c/c453e64cbc95

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


