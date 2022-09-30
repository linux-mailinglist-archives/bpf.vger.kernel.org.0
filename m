Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA9FD5F1491
	for <lists+bpf@lfdr.de>; Fri, 30 Sep 2022 23:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbiI3VMC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Sep 2022 17:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232660AbiI3VLp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Sep 2022 17:11:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F804F3C59
        for <bpf@vger.kernel.org>; Fri, 30 Sep 2022 14:10:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6AC0CB82A3B
        for <bpf@vger.kernel.org>; Fri, 30 Sep 2022 21:10:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1AA26C433D6;
        Fri, 30 Sep 2022 21:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664572216;
        bh=qt05mUh5X33++lPNLvdioWxP+swWtXJsFmE0XfqS5mI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Rx2M6JKgVKm9bwRlXdqYQiaBdouYDvyHR49t5X4pXur7EcyAiMgCYVITqgueKWRtj
         KWpKOE86rD96JR9sP4xz+AgN8ccHOBWBuWsCmJq5kmG9o0u50R7DfjdqePzB0ou0b9
         FHrfwQ48pGas8WjNtt3vFI6MDO7UrxTIh+uEoAo3NOxlRtiUDfqYp2IKAyNYncudIn
         iXcNqAeHFdUVslu23bIv22C4m2/0ipNPefaiUDj1+1TBdZzcx4HYMaFsI2K/Rl1E1C
         3SBKcHuzhzlgoJunyyfNXTpX7cvN8oJDDfq7aCkk724BF7pr2HbzSDwz3GX8lfI1g7
         9Sx3I6IV5OjDA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F06AAE49FA5;
        Fri, 30 Sep 2022 21:10:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] tools: bpftool: Remove unused struct
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166457221598.29882.2232016600402051935.git-patchwork-notify@kernel.org>
Date:   Fri, 30 Sep 2022 21:10:15 +0000
References: <20220928090440.79637-1-yuancan@huawei.com>
In-Reply-To: <20220928090440.79637-1-yuancan@huawei.com>
To:     Yuan Can <yuancan@huawei.com>
Cc:     quentin@isovalent.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        bpf@vger.kernel.org
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 28 Sep 2022 09:04:38 +0000 you wrote:
> This series contains two cleanup patches, remove unused struct.
> 
> Yuan Can (2):
>   tools: bpftool: Remove unused struct btf_attach_point
>   tools: bpftool: Remove unused struct event_ring_info
> 
>  tools/bpf/bpftool/btf.c           | 5 -----
>  tools/bpf/bpftool/map_perf_ring.c | 7 -------
>  2 files changed, 12 deletions(-)

Here is the summary with links:
  - [1/2] tools: bpftool: Remove unused struct btf_attach_point
    https://git.kernel.org/bpf/bpf-next/c/d863f42930db
  - [2/2] tools: bpftool: Remove unused struct event_ring_info
    https://git.kernel.org/bpf/bpf-next/c/f95a479797dc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


