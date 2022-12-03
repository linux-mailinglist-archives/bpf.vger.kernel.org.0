Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD186412BF
	for <lists+bpf@lfdr.de>; Sat,  3 Dec 2022 01:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235162AbiLCAq3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Dec 2022 19:46:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235185AbiLCAqM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Dec 2022 19:46:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4763F164AC;
        Fri,  2 Dec 2022 16:40:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E0380B82319;
        Sat,  3 Dec 2022 00:40:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 93D83C433B5;
        Sat,  3 Dec 2022 00:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670028015;
        bh=tbn+33XxyRvy44yXmGANEnrTimqismu1JWxN2YaDJYU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=U2QG3jnpYPIG1e0NnJOBQ9lAHWvq1mmfWtV+nuSxp3MAwkXRuOhKjME8zknaaKa4Y
         bGT1VKeXofGFifDuPZTBXIbvpuuuwFA1PYPH64OY85VwdN1L9TKQgTXP113Kk4jfV2
         7ktR3CPYyiW6k0R72sV8s347EMWtvflXc2LuGKgqJbtPfCD8mupsYa1bnKLMQTcqbw
         lzuTWSV9YxgJnveZufS/RrJ7eU/LMx0vpzChdzXfDoj9s+YVL+woBEANYF5KbMeVJ3
         iQiRsqc9t4kgYE9gcRdP99YvNtF+RHlYYRkLBz4Edj9HHtyqei3kkJbNjzx5rpYY8t
         YhaEgwcjQbZsw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 77B11E21EEF;
        Sat,  3 Dec 2022 00:40:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] libbpf:Improved usability of the Makefile in
 libbpf
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167002801548.8228.2023000257620605263.git-patchwork-notify@kernel.org>
Date:   Sat, 03 Dec 2022 00:40:15 +0000
References: <20221202081738.128513-1-liuxin350@huawei.com>
In-Reply-To: <20221202081738.128513-1-liuxin350@huawei.com>
To:     Xin Liu <liuxin350@huawei.com>
Cc:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, yanan@huawei.com,
        wuchangye@huawei.com, xiesongyang@huawei.com,
        kongweibin2@huawei.com, zhangmingyi5@huawei.com
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

On Fri, 2 Dec 2022 16:17:38 +0800 you wrote:
> Current libbpf Makefile does not contain the help command, which
> is inconvenient to use. Similar to the Makefile help command of the
> perf, a help command is provided to list the commands supported by
> libbpf make and the functions of the commands.
> 
> Signed-off-by: Xin Liu <liuxin350@huawei.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] libbpf:Improved usability of the Makefile in libbpf
    https://git.kernel.org/bpf/bpf-next/c/706819495921

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


