Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA19E57CAA2
	for <lists+bpf@lfdr.de>; Thu, 21 Jul 2022 14:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbiGUMaS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Jul 2022 08:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbiGUMaR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Jul 2022 08:30:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73A9E028;
        Thu, 21 Jul 2022 05:30:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6E825B8245B;
        Thu, 21 Jul 2022 12:30:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 01998C341CB;
        Thu, 21 Jul 2022 12:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658406614;
        bh=txJSRKRpmnX/OM6BcK0maKHWdxc+gPKeeMEv/+ncWoY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=gEK4hCBrgRRkf9suhs08jS3KR8RD4vbPqoLeOGqQUsh/hFr/VAr8P/XqOV0frPKeM
         QDKBjGznza3thyLUEr4WtvOz100R2+HAC5uWmYRJxWb3XBrnXmMKETZitY7BGYvCKL
         MdsWn4AoFglbOxzlR/WJmt3mRLecBSIb4dB5GuwX9jl7kxX7aFgxD56CUNpueBRoyX
         Ftdv0HQZGR/4BnGgXwuhjj/DecyZt4pDUO4oIIdBECmtZAvMuHnah9UG63yXODhYO6
         l7rPVANbyQ2Cb4Z1p6Nfue4kVRrnoasnbWFTDSAFh9cmrlmNugZkp33v5S+c8bnmnt
         DcyvC8da0B+WA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DB682E451B0;
        Thu, 21 Jul 2022 12:30:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] libbpf: fix sign expansion bug in btf_dump_get_enum_value()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165840661389.30255.12097142217891066504.git-patchwork-notify@kernel.org>
Date:   Thu, 21 Jul 2022 12:30:13 +0000
References: <YtZ+LpgPADm7BeEd@kili>
In-Reply-To: <YtZ+LpgPADm7BeEd@kili>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     andrii@kernel.org, yhs@fb.com, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        kernel-janitors@vger.kernel.org
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 19 Jul 2022 12:49:34 +0300 you wrote:
> The code here is supposed to take a signed int and store it in a
> signed long long.  Unfortunately, the way that the type promotion works
> with this conditional statement is that it takes a signed int, type
> promotes it to a __u32, and then stores that as a signed long long.
> The result is never negative.
> 
> Fixes: d90ec262b35b ("libbpf: Add enum64 support for btf_dump")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> [...]

Here is the summary with links:
  - libbpf: fix sign expansion bug in btf_dump_get_enum_value()
    https://git.kernel.org/bpf/bpf-next/c/c6018fc6e7b6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


