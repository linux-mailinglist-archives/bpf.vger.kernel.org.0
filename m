Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E816F62622D
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 20:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234195AbiKKTkV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Nov 2022 14:40:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234224AbiKKTkT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 14:40:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBCE7C8D6;
        Fri, 11 Nov 2022 11:40:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CE3D8B827A9;
        Fri, 11 Nov 2022 19:40:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 50247C433C1;
        Fri, 11 Nov 2022 19:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668195616;
        bh=jl6LdFrqv+4TDnoTaN8guBf6tvRCL8sNT2to4vgs/us=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=UDEh8fZl/ZnGleej3x34oNsi4pLaij4CQJ36lfhEXorhvdPY125u/NXlDEpDw9vcg
         RitZACDN350XkWQXdc6JEYBmDH8qO1yQat9CY/mwuvGcwbEPss/xmkmo9DX9DgPhXL
         0QJcEiwTIgmRvib/A4ZcmuXb+HjUtAYTC4aDB4VcjoFhccnxBHfyJkYtdfqsxV+STN
         N+JGBCg4RsUrepqHyUZ3/PjgNRcFX2hLkUYxQeD3bSn3niGWCEWSpMcgb/5pWgnJZW
         E5pC+BixHNCbIDuO8JlE6wOhTUsse3Xr4cTI31Hcpdqe6G5sYcjpJrL4n3JKDau8wk
         keJPbKIiK/aUw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 32766E270EF;
        Fri, 11 Nov 2022 19:40:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3] docs/bpf: Document BPF map types QUEUE and STACK
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166819561620.2662.16682077750068932473.git-patchwork-notify@kernel.org>
Date:   Fri, 11 Nov 2022 19:40:16 +0000
References: <20221108093314.44851-1-donald.hunter@gmail.com>
In-Reply-To: <20221108093314.44851-1-donald.hunter@gmail.com>
To:     Donald Hunter <donald.hunter@gmail.com>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, corbet@lwn.net,
        yhs@meta.com
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

On Tue,  8 Nov 2022 09:33:14 +0000 you wrote:
> Add documentation for BPF_MAP_TYPE_QUEUE and BPF_MAP_TYPE_STACK,
> including usage and examples.
> 
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
> ---
> v2 -> v3:
> - Add BPF_EXIST to valid flags as reported by Yonghong Song
> - Clarify valid flags for bpf_map_push_elem
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3] docs/bpf: Document BPF map types QUEUE and STACK
    https://git.kernel.org/bpf/bpf-next/c/64488ca57ab8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


