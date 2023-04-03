Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A10626D3B0A
	for <lists+bpf@lfdr.de>; Mon,  3 Apr 2023 02:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjDCAKU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 2 Apr 2023 20:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDCAKT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 2 Apr 2023 20:10:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F665658E
        for <bpf@vger.kernel.org>; Sun,  2 Apr 2023 17:10:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D639C61338
        for <bpf@vger.kernel.org>; Mon,  3 Apr 2023 00:10:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 49E22C4339B;
        Mon,  3 Apr 2023 00:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680480617;
        bh=EIl6/yPEfXCdDogC7703xIS/HvUPM/78su1MkRgyfDQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=uxW7V3cgYvoN3517/RqDiUUCzdzmfJ9xw8+hzu22bM2dS/WBrXowoSMU1wxN1XcO3
         AxBZLOaW6UwA2z/HJpF8C9RKWZzF0XE/qvEKEcV2F7XXGL1Dk55LdC5SqlGLuxDf1g
         0BbnO7GFaiHW+zcO6/LmqN/0H0AeE7NQMYy+bEQN37S4OkLGXa/yWksAmrtBUCePAp
         86mCUmT5IGnme7G0aSz/o1ZPoR/fjNA3nexU6UVBNkS40kbRUGLo4dhvZBkFw524MT
         +dEOIRwOfpnPnACvHHI67EaY155dPUzY1LxD/RRYsy1T8nFhpuL2aRlG4wnfT/aXOJ
         iBUqAFN09fWRg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 30C07E5EA82;
        Mon,  3 Apr 2023 00:10:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4] bpf,
 docs: Add docs on extended 64-bit immediate instructions
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168048061719.20527.3312123090672462351.git-patchwork-notify@kernel.org>
Date:   Mon, 03 Apr 2023 00:10:17 +0000
References: <20230326054946.2331-1-dthaler1968@googlemail.com>
In-Reply-To: <20230326054946.2331-1-dthaler1968@googlemail.com>
To:     Dave Thaler <dthaler1968@googlemail.com>
Cc:     bpf@vger.kernel.org, bpf@ietf.org, dthaler@microsoft.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sun, 26 Mar 2023 05:49:46 +0000 you wrote:
> From: Dave Thaler <dthaler@microsoft.com>
> 
> Add docs on extended 64-bit immediate instructions, including six instructions
> previously undocumented.  Include a brief description of maps and variables,
> as used by those instructions.
> 
> V1 -> V2: rebased on top of latest master
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4] bpf, docs: Add docs on extended 64-bit immediate instructions
    https://git.kernel.org/bpf/bpf-next/c/16b7c970cc81

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


