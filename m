Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4E76289CC
	for <lists+bpf@lfdr.de>; Mon, 14 Nov 2022 20:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236250AbiKNTud (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 14:50:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235636AbiKNTuR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 14:50:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C479717A96;
        Mon, 14 Nov 2022 11:50:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6ACDE61411;
        Mon, 14 Nov 2022 19:50:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B5A65C433D7;
        Mon, 14 Nov 2022 19:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668455415;
        bh=Ewq+7kBghgMuQKiCyYcVqka2wlNE/4gjkl3ZLYGvwH4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=BccZtJjq+0s4vjQpDh6kgMv2OlNBXO8JeNduc5IOtSrfzblryG9dKRGijApesYKI8
         IqjGj/QDj7zEJD055+joB6cHfv6fO7N6csC5Gi5TU7TF1eUvumoBgjY6wd/z/DoWws
         +a877/vciCMFhyp8gi+Uj1PXON4u9ORfxw8OGbYK0T+XyzToaswAtCHPFciWiGPCrq
         0kMuZ72Kp0WePcDJVEYe0CdIfXYWc1hDgHQ8y4/dxgrDrFCL5/8HK24EpIrnCrrmtU
         RA6Fdbp3p+OLSadDiVvEBemVBcnJ+f/+F3J4s7rdJskWcdbQfgT0lDvIG9QAw7ZdVf
         wif4NMPbpSSqg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 96788E270C2;
        Mon, 14 Nov 2022 19:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/3] libbpf: Fixed various checkpatch issues
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166845541560.2198.17027977446805211141.git-patchwork-notify@kernel.org>
Date:   Mon, 14 Nov 2022 19:50:15 +0000
References: <20221113190648.38556-1-tegongkang@gmail.com>
In-Reply-To: <20221113190648.38556-1-tegongkang@gmail.com>
To:     Kang Minchul <tegongkang@gmail.com>
Cc:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Mon, 14 Nov 2022 04:06:45 +0900 you wrote:
> This patch series contains various checkpatch fixes
> in btf.c, libbpf.c, ringbuf.c.
> 
> I know these are trivial but some issues are hard to ignore
> and I think these checkpatch issues are accumulating.
> 
> v1 -> v2: changed cover letter message.
> 
> [...]

Here is the summary with links:
  - [v2,1/3] libbpf: checkpatch: Fixed code alignments in btf.c
    https://git.kernel.org/bpf/bpf-next/c/c7694ac340b0
  - [v2,2/3] libbpf: Fixed various checkpatch issues in libbpf.c
    https://git.kernel.org/bpf/bpf-next/c/e3ba8e4e8c19
  - [v2,3/3] libbpf: checkpatch: Fixed code alignments in ringbuf.c
    https://git.kernel.org/bpf/bpf-next/c/b486d19a0ab0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


