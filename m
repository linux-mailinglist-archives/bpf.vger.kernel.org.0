Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 511655EB956
	for <lists+bpf@lfdr.de>; Tue, 27 Sep 2022 06:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiI0EuZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Sep 2022 00:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbiI0EuU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Sep 2022 00:50:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B82FA1D4A
        for <bpf@vger.kernel.org>; Mon, 26 Sep 2022 21:50:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9D051B8198C
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 04:50:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3421FC43140;
        Tue, 27 Sep 2022 04:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664254214;
        bh=QMR9vctYxA6mGQsRQdVqbeSdHxoizVsEr5QR90YouhM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=d8E3WU4Q2fn+70TzWv1018Pztns4Ys82L/iny4pVtUGkm8MmocalrbGoxE0ouAMjA
         q2nEcOJfJAsma2U6Si68/pOGx83ojFYPjNNRiUJG2NAAIjAwDwazd1WaHu6geJ5Qgd
         HBeL0hS01I3G3/FXLJDXPUaBjimprbwuzVo1OVE75jTpsUiNd7RX9v4ninqYv7n32L
         NBQgMVK7AsxIBmDS/T3KRRWdBWQOxE30TWC+1yABeGguG29zMNFfexdD+g0bNTt8C0
         PakhcjAVHgVqPzAY26bP+HSY93CwPUv+wjKUzT9n5e80z+7ZaGN1SQ+Iq+8CqoXyAR
         lFZ4CVnthb1RA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 185D2E21EC1;
        Tue, 27 Sep 2022 04:50:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3] libbpf: Fix the case of running as non-root with
 capabilities
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166425421408.17302.1399574198056311265.git-patchwork-notify@kernel.org>
Date:   Tue, 27 Sep 2022 04:50:14 +0000
References: <20220925070431.1313680-1-arilou@gmail.com>
In-Reply-To: <20220925070431.1313680-1-arilou@gmail.com>
To:     Jon Doron <arilou@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, jond@wiz.io
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Sun, 25 Sep 2022 10:04:31 +0300 you wrote:
> From: Jon Doron <jond@wiz.io>
> 
> When running rootless with special capabilities like:
> FOWNER / DAC_OVERRIDE / DAC_READ_SEARCH
> 
> The "access" API will not make the proper check if there is really
> access to a file or not.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3] libbpf: Fix the case of running as non-root with capabilities
    https://git.kernel.org/bpf/bpf-next/c/6a4ab8869d0b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


