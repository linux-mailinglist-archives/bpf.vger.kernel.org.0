Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11A1A6CCC44
	for <lists+bpf@lfdr.de>; Tue, 28 Mar 2023 23:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjC1VuX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Mar 2023 17:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjC1VuX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Mar 2023 17:50:23 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0041B8
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 14:50:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 50B21CE1D0A
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 21:50:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 57489C4339B;
        Tue, 28 Mar 2023 21:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680040218;
        bh=ceNFkOz3lphB/tZfPG+obpegZYVsP4dCykLcuPFlji4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Uxp8fcY6eMmOIfI4FtubYGG1ITcyCiugPEY6tP86Z/FrjB1y9Olp6ok03z0bqqnaB
         roX65kYiJNXpY1CebjkV22DGbbZoNY2m6j7fsntZdncXtxM1ceRV19NSBDhV/nOEur
         HtvK/jRagPJrb1ln14RVBeIcALo23Hxpu7q10KXcgHddNgsPziRCXoQblYFh9tzehF
         ABechS8nhUG1Zh+uZ6edtwPHHTICDNPPUGq9V9RYgkA4xWQGBUnqKfCmosdt9f0Nou
         V2W6/zM8GEpLMnRd8P8rkwGUpGLEFM9DlTKMDTHoHzE40ldrLmbaniQpY+SppAmDn6
         1Kg42zUiJKYkg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3AF9DE50D76;
        Tue, 28 Mar 2023 21:50:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/2] verifier/xdp_direct_packet_access.c converted to
 inline assembly
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168004021823.3305.10312090785832689380.git-patchwork-notify@kernel.org>
Date:   Tue, 28 Mar 2023 21:50:18 +0000
References: <20230328020813.392560-1-eddyz87@gmail.com>
In-Reply-To: <20230328020813.392560-1-eddyz87@gmail.com>
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
        yhs@fb.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 28 Mar 2023 05:08:11 +0300 you wrote:
> verifier/xdp_direct_packet_access.c automatically converted to inline
> assembly using [1].
> 
> This is a leftover from [2], the last patch in a batch was blocked by
> mail server for being too long. This patch-set splits it in two:
> - one to add migrated test to progs/
> - one to remove old test from verifier/
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] selftests/bpf: verifier/xdp_direct_packet_access.c converted to inline assembly
    https://git.kernel.org/bpf/bpf-next/c/6e9e141a7a28
  - [bpf-next,2/2] selftests/bpf: remove verifier/xdp_direct_packet_access.c, converted to progs/verifier_xdp_direct_packet_access.c
    https://git.kernel.org/bpf/bpf-next/c/c63a7d8bbb54

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


