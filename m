Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334816ED6C3
	for <lists+bpf@lfdr.de>; Mon, 24 Apr 2023 23:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbjDXVaV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Apr 2023 17:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjDXVaU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Apr 2023 17:30:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45B661A4
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 14:30:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C31960C3A
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 21:30:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C1B84C433D2;
        Mon, 24 Apr 2023 21:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682371818;
        bh=UbpfdKbw6EeE7hMPBOo7TqorAaByywumbFjy+6TPu0w=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Y3KnUQuQSR/rwXPEBqAb1WRGVQOmq3Sr8+NcE+GuQrifSm6sYIPiGvZlDbhXNcRow
         cF7f6/2cbqsWHN5PVs/Sqq7mvJIMUaQb4d50s/wOXKXozPMv/5CvJITbtOBWphEn2f
         YZ2Ln5N1Q6pnYrIOapG05uDbEjPMwQRfaRy+WNuz6tlD/lvfEO6SsNB8fXpCIxfbpx
         Dvlu0RjLZJpSNrILeZ5El1QprbV/xAIrjTO9hY+uRAG1nDxYEpuxOOAmHVEsnhFXC3
         iLfDVKom+sPo4MzujOQkaT7SfqfLD2yEr9U6dphRxxdlps7djHR4kdYKIZ0yKlugfq
         bUvDEnnk5TOvA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 960C6E5FFC7;
        Mon, 24 Apr 2023 21:30:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/2] bpf: Fix issues caused by bpf trampoline 
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168237181860.25354.10356715827184101234.git-patchwork-notify@kernel.org>
Date:   Mon, 24 Apr 2023 21:30:18 +0000
References: <20230424161104.3737-1-laoar.shao@gmail.com>
In-Reply-To: <20230424161104.3737-1-laoar.shao@gmail.com>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 24 Apr 2023 16:11:02 +0000 you wrote:
> The panic caused by fentry[1] drives me to write a testcase[2] to check if
> it safe to attach other kernel functions. Unsurprisingly it catches some
> issues. This patchset fixes them.
> 
> [1]. https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=c11bd046485d7bf1ca200db0e7d0bdc4bafdd395
> [2]. https://github.com/laoar/ebpf/tree/main/fentry
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpf: Add __rcu_read_{lock,unlock} into btf id deny list
    https://git.kernel.org/bpf/bpf-next/c/a0c109dcafb1
  - [bpf-next,2/2] fork: Rename mm_init to task_mm_init
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


