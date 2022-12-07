Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4323A645056
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 01:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiLGAaT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 19:30:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiLGAaS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 19:30:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA3F2E6A8;
        Tue,  6 Dec 2022 16:30:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E84986198B;
        Wed,  7 Dec 2022 00:30:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 39F65C433D7;
        Wed,  7 Dec 2022 00:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670373016;
        bh=HgE6BX1D7tm8rWksxQy/cMvN2G3MEa2fHGwjEINKc1c=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=buEs1TSYTwMxo1iRHRTVzmfPXcrFMUOxo9dwgpkshqkPdbM1UyEYWH1JXxqNoiuMc
         YPqMctS/xk0PhLGlR+0x8sDsvT1k1w9bPTc+/026phgRK90d1GVzX7ls7p+dxun1ex
         k46bJ8UAvq+LYfm40HNdHMjUzqdmMx8sTgig3dba9U9LwxXv9wGvY5NtF5qcFxevnm
         r1PDtFq9kohnKdD9zUtS/G6thK01t40F4wpxl4Di9LU5hwMrGgOOnV+24Np06+N8ZK
         MY4Z+b4lm3x8Yr2rjnutLPdlI23iQdrk5TTv7ogxz2cZHJaK25FaesdPe5ycywWJ1B
         iDMtzFHMVK8HA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1C53DE56AA3;
        Wed,  7 Dec 2022 00:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] libbpf: parse usdt args without offset on x86
 (e.g. 8@(%rsp))
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167037301611.10094.8319593461568888275.git-patchwork-notify@kernel.org>
Date:   Wed, 07 Dec 2022 00:30:16 +0000
References: <20221203123746.2160-1-timo.hunziker@eclipso.ch>
In-Reply-To: <20221203123746.2160-1-timo.hunziker@eclipso.ch>
To:     None <timo.hunziker@eclipso.ch>
Cc:     andrii.nakryiko@gmail.com, andrii@kernel.org, ast@kernel.org,
        bpf@vger.kernel.org, daniel@iogearbox.net, haoluo@google.com,
        john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
        linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@google.com,
        song@kernel.org, timo.hunziker@gmx.ch, yhs@fb.com
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

On Sat,  3 Dec 2022 12:37:46 +0000 you wrote:
> From: Timo Hunziker <timo.hunziker@gmx.ch>
> 
> Parse USDT arguments like "8@(%rsp)" on x86. These are emmited by
> SystemTap. The argument syntax is similar to the existing "memory
> dereference case" but the offset left out as it's zero (i.e. read
> the value from the address in the register). We treat it the same
> as the the "memory dereference case", but set the offset to 0.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] libbpf: parse usdt args without offset on x86 (e.g. 8@(%rsp))
    https://git.kernel.org/bpf/bpf-next/c/c21dc529baba

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


