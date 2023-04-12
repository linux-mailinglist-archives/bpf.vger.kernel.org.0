Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED2A6E02A6
	for <lists+bpf@lfdr.de>; Thu, 13 Apr 2023 01:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjDLXkU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Apr 2023 19:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjDLXkT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 19:40:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2EF394;
        Wed, 12 Apr 2023 16:40:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 513E363A22;
        Wed, 12 Apr 2023 23:40:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A4AAAC4339B;
        Wed, 12 Apr 2023 23:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681342817;
        bh=iim5VEphjW0ZKMsI/9k3ZI2Hlqw0HfANnEn+Cgp/CTE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=kmhn96UN4Ws/OwRmHgixGznU3nO2T044ESmIy2qbNCQTUdBn0Hje0ddwxws1Ds0AP
         9M1XF222LUifeMMJUaXKNJB53tf5QzLwHKfD2PT5ViKPY8m/DngjP8owcp32WAGp2l
         JMnubOFfT8ndTqc7YMTTZ1vKzmtccXXyV0jMqGdMsit/gjG3oEHkPbZfNLQCfBMCam
         ZMv/nGC/2rXIHG+yUFVNgfc1pVp6Bge2QLiTKNwciXngrW6cgxyhoOsq6YQWEQe2Up
         qCFnzV7UbtSCuOTXO2PHRMRjGrNVoC3huR+bw0l5sEz7IfHGuiipAPjAMdV6CgXSpK
         GHklUH/KFMahw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 88354C395C5;
        Wed, 12 Apr 2023 23:40:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf,
 sockmap: fix deadlocks in the sockhash and sockmap
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168134281755.14415.12895311674672248237.git-patchwork-notify@kernel.org>
Date:   Wed, 12 Apr 2023 23:40:17 +0000
References: <20230406122622.109978-1-liuxin350@huawei.com>
In-Reply-To: <20230406122622.109978-1-liuxin350@huawei.com>
To:     Xin Liu <liuxin350@huawei.com>
Cc:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        hsinweih@uci.edu, linux-kernel@vger.kernel.org, yanan@huawei.com,
        wuchangye@huawei.com, xiesongyang@huawei.com,
        kongweibin2@huawei.com, zhangmingyi5@huawei.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 6 Apr 2023 20:26:22 +0800 you wrote:
> When huang uses sched_switch tracepoint, the tracepoint
> does only one thing in the mounted ebpf program, which
> deletes the fixed elements in sockhash ([0])
> 
> It seems that elements in sockhash are rarely actively
> deleted by users or ebpf program. Therefore, we do not
> pay much attention to their deletion. Compared with hash
> maps, sockhash only provides spin_lock_bh protection.
> This causes it to appear to have self-locking behavior
> in the interrupt context.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf, sockmap: fix deadlocks in the sockhash and sockmap
    https://git.kernel.org/bpf/bpf-next/c/ed17aa92dc56

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


