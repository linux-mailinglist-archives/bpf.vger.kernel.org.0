Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F865228AA
	for <lists+bpf@lfdr.de>; Wed, 11 May 2022 03:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239965AbiEKBKU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 May 2022 21:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233586AbiEKBKR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 May 2022 21:10:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336E621330F
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 18:10:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CE89BB82075
        for <bpf@vger.kernel.org>; Wed, 11 May 2022 01:10:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6DF95C385D6;
        Wed, 11 May 2022 01:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652231413;
        bh=wZBd8ULT1tYxaEQGSlPzf6YYCsL+7bdToDWewC4Db+4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=iA7nO7XQ/iXlEP/ANUDpDxH954uqE6bbUROlVUJVIU4E/GVXs1tUdT+H3cst0H2Xh
         boM/2IOSQ6EzCR0b05okmNmlKpnZKbqNXY+DiXzzQ8J3IZt4nx76AHe19uvH8AT/IZ
         iVriLzaEw6BLqw53OZmMaH7sk8fv+bVLa6JJQbUI0Q+u1n3XpOqcfpe3Or5Gbj9V4o
         zsjcCgZAvxNt8CxHsiXiuugYCMy5BOIpgsinMN+mc3ixgaoxIfW8VZDpmFElCIDALC
         gERC9yvoFdhIGAqG/0UgnnTZ2IijH10YfsfyJKUzB/UqZEe21mnw5V2NLhoIGn4s0l
         5A0hy3wCPnUWg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 519FEF0392C;
        Wed, 11 May 2022 01:10:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v8 0/5] Attach a cookie to a tracing program.
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165223141333.20219.2489454778876097764.git-patchwork-notify@kernel.org>
Date:   Wed, 11 May 2022 01:10:13 +0000
References: <20220510205923.3206889-1-kuifeng@fb.com>
In-Reply-To: <20220510205923.3206889-1-kuifeng@fb.com>
To:     Kui-Feng Lee <kuifeng@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kernel-team@fb.com, xukuohai@huawei.com
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
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 10 May 2022 13:59:18 -0700 you wrote:
> Allow users to attach a 64-bits cookie to a bpf_link of fentry, fexit,
> or fmod_ret.
> 
> This patchset includes several major changes.
> 
>  - Define struct bpf_tramp_links to replace bpf_tramp_prog.
>    struct bpf_tramp_links collects bpf_links of a trampoline
> 
> [...]

Here is the summary with links:
  - [bpf-next,v8,1/5] bpf, x86: Generate trampolines from bpf_tramp_links
    https://git.kernel.org/bpf/bpf-next/c/f7e0beaf39d3
  - [bpf-next,v8,2/5] bpf, x86: Create bpf_tramp_run_ctx on the caller thread's stack
    https://git.kernel.org/bpf/bpf-next/c/e384c7b7b46d
  - [bpf-next,v8,3/5] bpf, x86: Attach a cookie to fentry/fexit/fmod_ret/lsm.
    https://git.kernel.org/bpf/bpf-next/c/22c1d9a17b82
  - [bpf-next,v8,4/5] libbpf: Assign cookies to links in libbpf.
    https://git.kernel.org/bpf/bpf-next/c/3d5602b6d8b9
  - [bpf-next,v8,5/5] selftest/bpf: The test cses of BPF cookie for fentry/fexit/fmod_ret/lsm.
    https://git.kernel.org/bpf/bpf-next/c/f3273797de13

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


