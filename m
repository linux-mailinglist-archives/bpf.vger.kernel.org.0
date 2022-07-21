Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB5B57CBF0
	for <lists+bpf@lfdr.de>; Thu, 21 Jul 2022 15:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiGUNaS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Jul 2022 09:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiGUNaS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Jul 2022 09:30:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2687F3D
        for <bpf@vger.kernel.org>; Thu, 21 Jul 2022 06:30:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 95FE9B82504
        for <bpf@vger.kernel.org>; Thu, 21 Jul 2022 13:30:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0C88BC341C6;
        Thu, 21 Jul 2022 13:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658410214;
        bh=b92j8HDe+Hmqgm8S8ZnV5dFDFRNMTfhf7IadUJC1rKQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=p28UGCa8hHf7GLb5lDp/yiLq0+wIYZ2wHH50h1aaweoN1ZtysELPznOZnXIDLAhGJ
         OpnZoFBQlV2UWj4wO9CzYpH6IKRoe6RNVK00mc/mZBsu1LhGO43npjdsmvo4JSqHgl
         1bkM1ikxSSx6dHzCDmKNf1iyPA2u2Nrz+5mYJ1dHZ5r80W1DeBWJL+Byx3cqbcx8tg
         4Ast5XeLDjmo31B5WhAnvRiAoFOujH7baiojdoga+l2bHqhf0n0n519fsgcFCCGQ4v
         rNZyYjQwRGJw5rNZ3hg0tqOkVLCC2xbh1S9CAoZaLpLSOrK/tNCbdPgw5dn0zIpbuv
         2wOI/VnpFWQJg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EA5CDE451B0;
        Thu, 21 Jul 2022 13:30:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Check attach_func_proto more carefully in
 check_helper_call
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165841021395.31007.4261003933380275884.git-patchwork-notify@kernel.org>
Date:   Thu, 21 Jul 2022 13:30:13 +0000
References: <20220720164729.147544-1-sdf@google.com>
In-Reply-To: <20220720164729.147544-1-sdf@google.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org,
        syzbot+0f8d989b1fba1addc5e0@syzkaller.appspotmail.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed, 20 Jul 2022 09:47:29 -0700 you wrote:
> Syzkaller found a problem similar to d1a6edecc1fd ("bpf: Check
> attach_func_proto more carefully in check_return_code") where
> attach_func_proto might be NULL:
> 
> RIP: 0010:check_helper_call+0x3dcb/0x8d50 kernel/bpf/verifier.c:7330
>  do_check kernel/bpf/verifier.c:12302 [inline]
>  do_check_common+0x6e1e/0xb980 kernel/bpf/verifier.c:14610
>  do_check_main kernel/bpf/verifier.c:14673 [inline]
>  bpf_check+0x661e/0xc520 kernel/bpf/verifier.c:15243
>  bpf_prog_load+0x11ae/0x1f80 kernel/bpf/syscall.c:2620
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Check attach_func_proto more carefully in check_helper_call
    https://git.kernel.org/bpf/bpf-next/c/aef9d4a34a51

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


