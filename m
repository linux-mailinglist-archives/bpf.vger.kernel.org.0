Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0D9507681
	for <lists+bpf@lfdr.de>; Tue, 19 Apr 2022 19:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344485AbiDSRc7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Apr 2022 13:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355723AbiDSRc6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Apr 2022 13:32:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AAE219C35
        for <bpf@vger.kernel.org>; Tue, 19 Apr 2022 10:30:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C3670B818F2
        for <bpf@vger.kernel.org>; Tue, 19 Apr 2022 17:30:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5BF2EC385A7;
        Tue, 19 Apr 2022 17:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650389411;
        bh=vV9No+odoDpZVUeUgmdQU7YhHYAK7gNxMnuXRs108Bk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=LtBHleP612kX2UYMXuoQOGoBRfSIIKhSfM2WZ6rsh32ERXIc1WwKpXuyxUd+8+ihn
         iayyvJQY1q5jWc/LPlTr7cR7YSNbtj+fU0xTYr4tgr1N0Pp0vbs4Z5g6OjIpDcFNTn
         GmL/2+zrGhqUBExX18oLzjpksdMKlhE9b+bzLWwG2F6r8FH6lt0o3CNWg9R6rnhGC0
         +W3xHnGYdKSuGXAzayh3USjaDhsqA9nECbl+C3j0ShdIN2kazC+xlfHeh68xWh8GrT
         BKVspWivpDCVIsV7yIYfYqFS5GmPRx97T7d8X64Hg7xOZQ7oUj0peguXtCh1g/8Clw
         5tT0wJII5zFBA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3CFEFE8DD61;
        Tue, 19 Apr 2022 17:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: limit unroll_count for pyperf600 test
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165038941124.23729.14913020421463200650.git-patchwork-notify@kernel.org>
Date:   Tue, 19 Apr 2022 17:30:11 +0000
References: <20220419043230.2928530-1-yhs@fb.com>
In-Reply-To: <20220419043230.2928530-1-yhs@fb.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
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

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 18 Apr 2022 21:32:30 -0700 you wrote:
> LLVM commit [1] changed loop pragma behavior such that
> full loop unroll is always honored with user pragma.
> Previously, unroll count also depends on the unrolled
> code size. For pyperf600, without [1], the loop unroll
> count is 150. With [1], the loop unroll count is 600.
> 
> The unroll count of 600 caused the program size close to
> 298k and this caused the following code is generated:
>          0:       7b 1a 00 ff 00 00 00 00 *(u64 *)(r10 - 256) = r1
>   ;       uint64_t pid_tgid = bpf_get_current_pid_tgid();
>          1:       85 00 00 00 0e 00 00 00 call 14
>          2:       bf 06 00 00 00 00 00 00 r6 = r0
>   ;       pid_t pid = (pid_t)(pid_tgid >> 32);
>          3:       bf 61 00 00 00 00 00 00 r1 = r6
>          4:       77 01 00 00 20 00 00 00 r1 >>= 32
>          5:       63 1a fc ff 00 00 00 00 *(u32 *)(r10 - 4) = r1
>          6:       bf a2 00 00 00 00 00 00 r2 = r10
>          7:       07 02 00 00 fc ff ff ff r2 += -4
>   ;       PidData* pidData = bpf_map_lookup_elem(&pidmap, &pid);
>          8:       18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 0 ll
>         10:       85 00 00 00 01 00 00 00 call 1
>         11:       bf 08 00 00 00 00 00 00 r8 = r0
>   ;       if (!pidData)
>         12:       15 08 15 e8 00 00 00 00 if r8 == 0 goto -6123 <LBB0_27588+0xffffffffffdae100>
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: limit unroll_count for pyperf600 test
    https://git.kernel.org/bpf/bpf-next/c/8c89b5db7a28

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


