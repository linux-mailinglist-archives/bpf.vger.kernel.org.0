Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E19825BB0EB
	for <lists+bpf@lfdr.de>; Fri, 16 Sep 2022 18:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbiIPQKT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Sep 2022 12:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiIPQKR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Sep 2022 12:10:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93445280A;
        Fri, 16 Sep 2022 09:10:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1939B62CB7;
        Fri, 16 Sep 2022 16:10:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6BA71C433D6;
        Fri, 16 Sep 2022 16:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663344615;
        bh=zHFqHcpj99SbBD9DNjn6APuy0ETml3NbJpfAONyVi8Y=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=f6vJptmp3xyAO67pkzYDp9lnjmxl0Cq9EGnokKnXb122dzgyknUHySsg9d75pJJ6x
         OrprMreu8WxeEkdAfh6ZjA2oIlM66NYnab10tfy+XnR4O5hpIlNeKGoyGezC/AuQAN
         GIBUg4t/WV4j15hcnPtr/FVJh8Uoeig5JH3roEyMmDipt1XheijdVsJCaW6n1FMhEK
         ij62T0W74MKnw5V9NNRFOXN8T3U1myu+hdF+rfB/OwpFloKEREFoyLp0FXue9YJJY5
         yJvHfWJzgUnF9WnS0UC+JFsTm3Tj3S+jqTPYrUYV0kazuW1Zf0x+w388ND1lz0xONN
         DN5Wt6PU35P7g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 46006C59A58;
        Fri, 16 Sep 2022 16:10:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 1/1] bpf: Ensure correct locking around vulnerable function
 find_vpid()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166334461526.1576.4486084011252530218.git-patchwork-notify@kernel.org>
Date:   Fri, 16 Sep 2022 16:10:15 +0000
References: <20220912133855.1218900-1-lee@kernel.org>
In-Reply-To: <20220912133855.1218900-1-lee@kernel.org>
To:     Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org, jolsa@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        bpf@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon, 12 Sep 2022 14:38:55 +0100 you wrote:
> The documentation for find_vpid() clearly states:
> 
>   "Must be called with the tasklist_lock or rcu_read_lock() held."
> 
> Presently we do neither.
> 
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Martin KaFai Lau <martin.lau@linux.dev>
> Cc: Song Liu <song@kernel.org>
> Cc: Yonghong Song <yhs@fb.com>
> Cc: KP Singh <kpsingh@kernel.org>
> Cc: Stanislav Fomichev <sdf@google.com>
> Cc: Hao Luo <haoluo@google.com>
> Cc: bpf@vger.kernel.org
> Fixes: 41bdc4b40ed6f ("bpf: introduce bpf subcommand BPF_TASK_FD_QUERY")
> Signed-off-by: Lee Jones <lee@kernel.org>
> 
> [...]

Here is the summary with links:
  - [v3,1/1] bpf: Ensure correct locking around vulnerable function find_vpid()
    https://git.kernel.org/bpf/bpf/c/83c10cc362d9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


