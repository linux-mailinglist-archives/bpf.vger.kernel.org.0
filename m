Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 968E55E8474
	for <lists+bpf@lfdr.de>; Fri, 23 Sep 2022 23:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbiIWVAW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Sep 2022 17:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiIWVAS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Sep 2022 17:00:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04FB4AFAC3;
        Fri, 23 Sep 2022 14:00:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FEAF62A09;
        Fri, 23 Sep 2022 21:00:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C29D2C433B5;
        Fri, 23 Sep 2022 21:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663966816;
        bh=JhBt6Ms7uAuoLBLUEt2HQxj8hae+gpPqtY3jXvXI++0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=lzFhGuxb0Z7jB7A6TUIfXV6B0VNRKCdpP/Q4lhMyFFHK5C54pKjSPPdRN06T1KhW4
         Cr5PZug2+frc4mE7/grwhI9pNtVvZsf90uErgEAqyFoaaLe7894x6OZD/NXwWUyHI6
         hRjlpqpMEoG3Xrb46L94cVcRMC0XqvKbNTnCS3kfcalWRTTj1PHdAJOOV7AeCFX9Q0
         tbzrDJm6wpb0JXBBqPO4L0pcr/JecsPI8jtJdHq9iy2uwOT22va5mbJR2Qnw4skO9A
         M1/Ijbs+zMMrcJNNQQFzqlFgvZN0yuRgN2YLOFOE4NseqLEynCdIcc1ZmfqhApxPr2
         ct7DcWuAxQQfA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A591FC070C8;
        Fri, 23 Sep 2022 21:00:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] selftests/bpf: simplify cgroup_hierarchical_stats
 selftest
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166396681667.28955.11333240473146247883.git-patchwork-notify@kernel.org>
Date:   Fri, 23 Sep 2022 21:00:16 +0000
References: <20220919175330.890793-1-yosryahmed@google.com>
In-Reply-To: <20220919175330.890793-1-yosryahmed@google.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, mykolal@fb.com, song@kernel.org, yhs@fb.com,
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

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 19 Sep 2022 17:53:30 +0000 you wrote:
> The cgroup_hierarchical_stats selftest is complicated. It has to be,
> because it tests an entire workflow of recording, aggregating, and
> dumping cgroup stats. However, some of the complexity is unnecessary.
> The test now enables the memory controller in a cgroup hierarchy, invokes
> reclaim, measure reclaim time, THEN uses that reclaim time to test the
> stats collection and aggregation. We don't need to use such a
> complicated stat, as the context in which the stat is collected is
> orthogonal.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] selftests/bpf: simplify cgroup_hierarchical_stats selftest
    https://git.kernel.org/bpf/bpf-next/c/e0401dce5e28

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


