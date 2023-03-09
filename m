Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0ACB6B2DED
	for <lists+bpf@lfdr.de>; Thu,  9 Mar 2023 20:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjCITuW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Mar 2023 14:50:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjCITuV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Mar 2023 14:50:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0D2F63A7
        for <bpf@vger.kernel.org>; Thu,  9 Mar 2023 11:50:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8DF461CDA
        for <bpf@vger.kernel.org>; Thu,  9 Mar 2023 19:50:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4C8C6C4339B;
        Thu,  9 Mar 2023 19:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678391419;
        bh=od+XCEqlrXcQG0VRoFANl+5LbLfC1rOC2FuqzhWPtUM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=hYtWf+n+y1i6uFedUDTQQyZcxqjooH8eThkStrzQoEkBBCMxg0AhPKjoijxttGLCG
         dG/NQUPDxzxs/VPnVlWGZGPbEIRbUIYeAm3OtOIdk38Jy/EZwBzVJV1VPDa9m7tIPF
         muTupxkUjLYI0qFVPlFN8cIoptaYdSGGE8JsO3KyA+EHianUM8V2yey+P4QRl1m3BH
         aZm8yPo6dXpZEG3P6LcUCfHCp4jdXAaiapV11wbdhpCMWNP1Wk+JopqZkGF2f2++qm
         Bsn6qkN1hDRZsCmo5HcTg5tac/9aQp6+dbRydff8K4pPhilpkfEF1ensNvuh0bVDfd
         K+3F1DXLOqgcg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 321EDE4D008;
        Thu,  9 Mar 2023 19:50:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next] selftests/bpf: Fix flaky fib_lookup test
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167839141920.24485.6307929046323939565.git-patchwork-notify@kernel.org>
Date:   Thu, 09 Mar 2023 19:50:19 +0000
References: <20230309060244.3242491-1-martin.lau@linux.dev>
In-Reply-To: <20230309060244.3242491-1-martin.lau@linux.dev>
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@meta.com
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
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed,  8 Mar 2023 22:02:44 -0800 you wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
> 
> There is a report that fib_lookup test is flaky when running in parallel.
> A symptom of slowness or delay. An example:
> 
> Testing IPv6 stale neigh
> set_lookup_params:PASS:inet_pton(IPV6_IFACE_ADDR) 0 nsec
> test_fib_lookup:PASS:bpf_prog_test_run_opts 0 nsec
> test_fib_lookup:FAIL:fib_lookup_ret unexpected fib_lookup_ret: actual 0 != expected 7
> test_fib_lookup:FAIL:dmac not match unexpected dmac not match: actual 1 != expected 0
> dmac expected 11:11:11:11:11:11 actual 00:00:00:00:00:00
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next] selftests/bpf: Fix flaky fib_lookup test
    https://git.kernel.org/bpf/bpf-next/c/a6865576317f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


