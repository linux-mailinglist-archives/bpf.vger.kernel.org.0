Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8E365C9AE
	for <lists+bpf@lfdr.de>; Tue,  3 Jan 2023 23:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238137AbjACWay (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Jan 2023 17:30:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238178AbjACWag (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Jan 2023 17:30:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83BF612088;
        Tue,  3 Jan 2023 14:30:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3E768B81116;
        Tue,  3 Jan 2023 22:30:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E2724C433F2;
        Tue,  3 Jan 2023 22:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672785017;
        bh=4WsP2lyEb3pMT4xZahQ497hBxlTZfTqec5/jxXBe/ZU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=tsU+PaLkhzWCfEcZdj0cVnRDWOyJ70xDoRUlgUX4KIXzJbCK8HOqDif6asAEof3BI
         DW7Jo9oHjJfGi1pif6cRTpPOfyOQtyZj0rY6zi4t4ybnl/asQP4Yrdu5ibvm0kf8q/
         TqSCBdA/2HtuCeICd+9IKEnqZA77fom4NFB+AtRT7tYzp2iFe3KDt/Jy96WQ1bSN0Z
         l4hzkCEdyZML5luR5mjvX0Glhtmx2+rSzUY1MmOIjtOVQoVpkBc9mrWH2YxPUAouoi
         df+9a2jay+PPBneSk3Qe4midXZcIBoDBbdqlDG6tNngdONhiNnla9qFqlbVvhUCGEB
         HOdvd+fN/Y9aA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C7660C395DF;
        Tue,  3 Jan 2023 22:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] libbpf: Return -ENODATA for missing btf section
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167278501681.19874.1023197471787462697.git-patchwork-notify@kernel.org>
Date:   Tue, 03 Jan 2023 22:30:16 +0000
References: <20221231151436.6541-1-changbin.du@gmail.com>
In-Reply-To: <20221231151436.6541-1-changbin.du@gmail.com>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, leo.yan@linaro.org,
        andrii.nakryiko@gmail.com
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

On Sat, 31 Dec 2022 23:14:36 +0800 you wrote:
> As discussed before, return -ENODATA (No data available) would be more
> meaningful than ENOENT (No such file or directory).
> 
> Suggested-by: Leo Yan <leo.yan@linaro.org>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> 
> [...]

Here is the summary with links:
  - libbpf: Return -ENODATA for missing btf section
    https://git.kernel.org/bpf/bpf-next/c/acd3b7768048

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


