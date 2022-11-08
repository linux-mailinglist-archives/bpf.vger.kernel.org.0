Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0736205B1
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 02:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbiKHBUR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Nov 2022 20:20:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232075AbiKHBUQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 20:20:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FD213F69;
        Mon,  7 Nov 2022 17:20:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5690A61366;
        Tue,  8 Nov 2022 01:20:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B07D8C433D6;
        Tue,  8 Nov 2022 01:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667870414;
        bh=dpkPDcJPtqZTtIpxNRqZ6cixfRSOG+L+wWBmqj6uDdw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=AS9YWDXOnR0RpUknh0+YAYwdfLgGSQXqwBKXpsoLoKjYTrdTpi2xJ1wIPLs5I1Yjt
         BXFIpdmIRHm7cH5bq0+oO8WaBHeGGxe3lVTuDlhbfSAnq6saXU10F+KNjVRW0/1ZIi
         YPug7jH6Trttkj+Q8Q0CGpypdlk+pL7FhuT/05vdI3AKF3NGLFvc4ED42i0uD2e8Tf
         NgFQorU1mLnBTQXt9qVpPhC0gXeE/dP3VxQkcnxTibvXZ7ZgliQYuBetMOtJ0sJ9yP
         BNk/f//ovTVbtY9ZMyL4tJ76uXgipIx/QQV9wfQomyJdBMYbV6NpcfEMStDRp9M5ek
         LcSj8y7UlohRA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9556EC41671;
        Tue,  8 Nov 2022 01:20:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] samples/bpf: Fix sockex3 error: missing BPF prog
 type
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166787041460.14648.14053712268169387053.git-patchwork-notify@kernel.org>
Date:   Tue, 08 Nov 2022 01:20:14 +0000
References: <tencent_EBA3C18864069E42175946973C2ACBAF5408@qq.com>
In-Reply-To: <tencent_EBA3C18864069E42175946973C2ACBAF5408@qq.com>
To:     Rong Tao <rtoax@foxmail.com>
Cc:     andrii.nakryiko@gmail.com, andrii@kernel.org, ast@kernel.org,
        bpf@vger.kernel.org, daniel@iogearbox.net, haoluo@google.com,
        john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
        linux-kernel@vger.kernel.org, martin.lau@linux.dev,
        rongtao@cestc.cn, sdf@google.com, song@kernel.org, yhs@fb.com
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
by Andrii Nakryiko <andrii@kernel.org>:

On Sat,  5 Nov 2022 14:48:00 +0800 you wrote:
> From: Rong Tao <rongtao@cestc.cn>
> 
> since commit 450b167fb9be("libbpf: clean up SEC() handling"),
> sec_def_matches() does not recognize "socket/xxx" as "socket", therefore,
> the BPF program type is not recognized.
> 
> Instead of sockex3_user.c parsing section names to get the BPF program fd.
> We use the program array map to assign a static index to each BPF program
> (get inspired by selftests/bpf progs/test_prog_array_init.c).
> Therefore, use SEC("socket") as section name instead of SEC("socket/xxx"),
> so that the BPF program is parsed to SOCKET_FILTER type. The "missing BPF
> prog type" problem is solved.
> 
> [...]

Here is the summary with links:
  - [bpf-next] samples/bpf: Fix sockex3 error: missing BPF prog type
    https://git.kernel.org/bpf/bpf-next/c/e5659e4e19e4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


