Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 330335A1BD2
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 00:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244033AbiHYWAd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Aug 2022 18:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243483AbiHYWAS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Aug 2022 18:00:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B06205E9
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 15:00:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 41E03B82EB8
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 22:00:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E3211C433D7;
        Thu, 25 Aug 2022 22:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661464814;
        bh=d3Xd4H1I7tJAsnl8M1UAWaUIDa57Qgtuk79TQk+bBQ0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=necOj/nmggTKYjovoSNBxvVwjrOpQ+nR57h9Fny6jBPwd6GljPuxOT+tL5T6KbU64
         Gae75q0TqfP0Ywqpyr2o4hu/+O1kmr/HQ2ozptjIcyq3q0lqOLOahHTELb1moMRjsU
         4OYjqpV7Picw6u+YAsZGRJ9KcqkmeJb4QGlHAVrZAml6J9TK9xEUWMCd07/DGevrHD
         KCDcJJHaQhJl0RFwMG894haqpAhjOFKWlL6CfY2g2+d32Fg7UawuW3jGk7bzXIU7+O
         pNUqXJfh9U3hSNYVgC2wWr3WwCJjGDiftKYKIMfxBfLQGPuLvQn3QFIqyj6mYStoxg
         i8rGvgoNricIA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C9B19C004EF;
        Thu, 25 Aug 2022 22:00:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: Don't use tnum_range on array range checking for
 poke descriptors
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166146481482.2575.11967391861308704391.git-patchwork-notify@kernel.org>
Date:   Thu, 25 Aug 2022 22:00:14 +0000
References: <984b37f9fdf7ac36831d2137415a4a915744c1b6.1661462653.git.daniel@iogearbox.net>
In-Reply-To: <984b37f9fdf7ac36831d2137415a4a915744c1b6.1661462653.git.daniel@iogearbox.net>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     ast@kernel.org, andrii@kernel.org, bpf@vger.kernel.org,
        hsinweih@uci.edu, shung-hsi.yu@suse.com
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

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 25 Aug 2022 23:26:47 +0200 you wrote:
> Hsin-Wei reported a KASAN splat triggered by their BPF runtime fuzzer which
> is based on a customized syzkaller:
> 
>   BUG: KASAN: slab-out-of-bounds in bpf_int_jit_compile+0x1257/0x13f0
>   Read of size 8 at addr ffff888004e90b58 by task syz-executor.0/1489
>   CPU: 1 PID: 1489 Comm: syz-executor.0 Not tainted 5.19.0 #1
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
>   1.13.0-1ubuntu1.1 04/01/2014
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0x9c/0xc9
>    print_address_description.constprop.0+0x1f/0x1f0
>    ? bpf_int_jit_compile+0x1257/0x13f0
>    kasan_report.cold+0xeb/0x197
>    ? kvmalloc_node+0x170/0x200
>    ? bpf_int_jit_compile+0x1257/0x13f0
>    bpf_int_jit_compile+0x1257/0x13f0
>    ? arch_prepare_bpf_dispatcher+0xd0/0xd0
>    ? rcu_read_lock_sched_held+0x43/0x70
>    bpf_prog_select_runtime+0x3e8/0x640
>    ? bpf_obj_name_cpy+0x149/0x1b0
>    bpf_prog_load+0x102f/0x2220
>    ? __bpf_prog_put.constprop.0+0x220/0x220
>    ? find_held_lock+0x2c/0x110
>    ? __might_fault+0xd6/0x180
>    ? lock_downgrade+0x6e0/0x6e0
>    ? lock_is_held_type+0xa6/0x120
>    ? __might_fault+0x147/0x180
>    __sys_bpf+0x137b/0x6070
>    ? bpf_perf_link_attach+0x530/0x530
>    ? new_sync_read+0x600/0x600
>    ? __fget_files+0x255/0x450
>    ? lock_downgrade+0x6e0/0x6e0
>    ? fput+0x30/0x1a0
>    ? ksys_write+0x1a8/0x260
>    __x64_sys_bpf+0x7a/0xc0
>    ? syscall_enter_from_user_mode+0x21/0x70
>    do_syscall_64+0x3b/0x90
>    entry_SYSCALL_64_after_hwframe+0x63/0xcd
>   RIP: 0033:0x7f917c4e2c2d
> 
> [...]

Here is the summary with links:
  - [bpf] bpf: Don't use tnum_range on array range checking for poke descriptors
    https://git.kernel.org/bpf/bpf/c/a657182a5c51

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


