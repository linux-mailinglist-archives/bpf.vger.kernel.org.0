Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 281E14A8FB4
	for <lists+bpf@lfdr.de>; Thu,  3 Feb 2022 22:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354618AbiBCVUL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Feb 2022 16:20:11 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:38736 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbiBCVUK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Feb 2022 16:20:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9324C6168B
        for <bpf@vger.kernel.org>; Thu,  3 Feb 2022 21:20:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 04CE7C340EF;
        Thu,  3 Feb 2022 21:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643923210;
        bh=yJvnm+p5kMK1mXorl6FtPXe1GvpofRcmyb0GSrRRSog=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=PvbO4UOdsLDtrX/bKzANzwcSi2o2Uh+cdXn9CGXhjatg55IYE3f3aDz2MkoJ5IiVP
         OypdSlSymOeP9KEmV6HWiFYxswd3wb+a+DM9HQk7ZYItg2fVgRadhKezHEXtfrzH8v
         9HTnj3N5zCM4IHnIOPcZK8pU8Ihcvxy4+mkIzz9USUO27rGf+7uuaFrWiXqierVXW6
         1VQSHt9Z5AnYUCFIxosL/tYTxPgQtKrJBc+QS5eDO28UfqCcbmyWaOl5ftTD4kL0Ce
         FNQ050GYAQlV8nTOMy/eTLvs8jSsTNKnUrrrvWMFVINeMIHwfQhRuiLmef/5jl9kw/
         I4NDBtM/0DxZQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E2F7AE5869F;
        Thu,  3 Feb 2022 21:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf 1/2] bpf: fix a btf decl_tag bug when tagging a function
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164392320992.7400.15627449270345731975.git-patchwork-notify@kernel.org>
Date:   Thu, 03 Feb 2022 21:20:09 +0000
References: <20220203191727.741862-1-yhs@fb.com>
In-Reply-To: <20220203191727.741862-1-yhs@fb.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com,
        syzbot+53619be9444215e785ed@syzkaller.appspotmail.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 3 Feb 2022 11:17:27 -0800 you wrote:
> syzbot reported a btf decl_tag bug with stack trace below:
> 
>   general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
>   KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
>   CPU: 0 PID: 3592 Comm: syz-executor914 Not tainted 5.16.0-syzkaller-11424-gb7892f7d5cb2 #0
>   Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
>   RIP: 0010:btf_type_vlen include/linux/btf.h:231 [inline]
>   RIP: 0010:btf_decl_tag_resolve+0x83e/0xaa0 kernel/bpf/btf.c:3910
>   ...
>   Call Trace:
>    <TASK>
>    btf_resolve+0x251/0x1020 kernel/bpf/btf.c:4198
>    btf_check_all_types kernel/bpf/btf.c:4239 [inline]
>    btf_parse_type_sec kernel/bpf/btf.c:4280 [inline]
>    btf_parse kernel/bpf/btf.c:4513 [inline]
>    btf_new_fd+0x19fe/0x2370 kernel/bpf/btf.c:6047
>    bpf_btf_load kernel/bpf/syscall.c:4039 [inline]
>    __sys_bpf+0x1cbb/0x5970 kernel/bpf/syscall.c:4679
>    __do_sys_bpf kernel/bpf/syscall.c:4738 [inline]
>    __se_sys_bpf kernel/bpf/syscall.c:4736 [inline]
>    __x64_sys_bpf+0x75/0xb0 kernel/bpf/syscall.c:4736
>    do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>    do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>    entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> [...]

Here is the summary with links:
  - [bpf,1/2] bpf: fix a btf decl_tag bug when tagging a function
    https://git.kernel.org/bpf/bpf-next/c/d7e7b42f4f95
  - [bpf,2/2] selftests/bpf: add a selftest for invalid func btf with btf decl_tag
    https://git.kernel.org/bpf/bpf-next/c/cf1a4cbce63b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


