Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46CD8688E96
	for <lists+bpf@lfdr.de>; Fri,  3 Feb 2023 05:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbjBCEaW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Feb 2023 23:30:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbjBCEaV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Feb 2023 23:30:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E204D15541
        for <bpf@vger.kernel.org>; Thu,  2 Feb 2023 20:30:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 827CBB82911
        for <bpf@vger.kernel.org>; Fri,  3 Feb 2023 04:30:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 28983C4339B;
        Fri,  3 Feb 2023 04:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675398618;
        bh=ip0Xf9eGG5TPnaVEmdecwSikVilGAFKyk9RsDXYLDTI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=EdN98cCkRlSH4yRRG4UI8UsVFiMcx8tKS7tBXiHoSReg/pYmGWaKeSuZO5cniuJfZ
         tGoY75MIuQ3a1WSGRffgZ4fnne7gvWoeXVuP8sv3IerccxG1zFv6Woqcttptwm+7qc
         c2BjC6DucWeDNZEeAqzBMREvI6xCtk2DATaWUtv5XHzSwV52u67gixe/0zkYWiIYte
         jhYUzaEdwUP2q4HZnmk7HQYGogfk7O658KKpbsbLeqnBg+i5/QZViSh3yY9wml49a5
         hj66fkTC6j981HAZ5y1hhMF6d6a6mWO3ZFDN+1acY98hf+n3z/ORAW0jYD0xejmTcm
         NnlW5RkQqzDEg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0575AE21ED1;
        Fri,  3 Feb 2023 04:30:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 0/1]  docs/bpf: Add description of register
 liveness tracking algorithm
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167539861801.7452.3340263117512202525.git-patchwork-notify@kernel.org>
Date:   Fri, 03 Feb 2023 04:30:18 +0000
References: <20230202125713.821931-1-eddyz87@gmail.com>
In-Reply-To: <20230202125713.821931-1-eddyz87@gmail.com>
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
        yhs@fb.com, ecree.xilinx@gmail.com
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
by Alexei Starovoitov <ast@kernel.org>:

On Thu,  2 Feb 2023 14:57:12 +0200 you wrote:
> An overview of the register tracking liveness algorithm.
> Previous versions posted here: [1], [2], [3].
> - Changes from RFC to v2 (suggested by Andrii Nakryiko):
>   - wording corrected to use term "stack slot" instead of "stack spill";
>   - parentage chain diagram updated to show nil links for frame #1;
>   - added example for non-BPF_DW writes behavior;
>   - explanation in "Read marks propagation for cache hits" is reworked.
> - Changes from v2 to v3:
>   - lot's of grammatical / wording fixes as suggested by David Vernet;
>   - "Register parentage chains" section is fixed to reflect what
>     happens to r1-r5 when function call is processed (as suggested by David and Alexei);
>   - Example in "Liveness marks tracking" section updated to explain
>     why partial writes should not lead to REG_LIVE_WRITTEN marks
>     (suggested by David);
>   - "Read marks propagation for cache hits" section updates:
>     - Explanation updated to hint why read marks should be propagated
>       before jumping to example (suggested by David);
>     - Removed box around B/D in the diagram updated (suggested by Alexei).
> - Changes from v3 to v4 (suggested by Edward Cree):
>   - register parentage chain diagram updated to explain why r6 mark is
>     not propagated;
>   - read mark propagation algorithm pseudo-code fixed to correctly
>     show "if state->live & REG_LIVE_WRITTEN" stop condition;
>   - general wording improvements in section "Liveness marks tracking".
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/1] docs/bpf: Add description of register liveness tracking algorithm
    https://git.kernel.org/bpf/bpf-next/c/cb6018485cd9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


