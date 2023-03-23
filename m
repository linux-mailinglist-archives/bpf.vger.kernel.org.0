Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15BF6C5AE7
	for <lists+bpf@lfdr.de>; Thu, 23 Mar 2023 01:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjCWAAX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Mar 2023 20:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjCWAAW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Mar 2023 20:00:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DF019114
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 17:00:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 889F7B81EA0
        for <bpf@vger.kernel.org>; Thu, 23 Mar 2023 00:00:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 53397C433D2;
        Thu, 23 Mar 2023 00:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679529619;
        bh=EPZQlf7iyh1ppWWrxT0QP2mWaPboEm9OwLtGtwZOQeA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=LgF77PXiVjlivmYnCyj+12wu4duuwhpw9n43/YezCQXaY9KNV0wd/a4Dh2BNovcxG
         EY7L5j8e2yiTwQnrLgecGmdUwctQqhXtTTHPawIy7/hji/8oVsI3tNFEFvR53I1OYG
         mTk6P9m26r0qVX/vXp4mAI65ofZmw2bs/D6cXYs7vgyXfoYGcG3a60bF+rE5GtpBzx
         L/vPQoqYiWKIKCqhMcKpCVjl+YL4hd4SeYATp8X7EGgcAgqP5i+2FHkDil6wGN7Ea5
         0Mv2TtYLUxH5cGEE+AN1hQyv3pn+0zM25gnT4TmvBOf+p3nWvauStzpXwpCfQhwt2T
         yOncnzKsGc0LQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 34D00E52513;
        Thu, 23 Mar 2023 00:00:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Fix __reg_bound_offset 64->32 var_off
 subreg propagation
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167952961921.23435.18014753719847549116.git-patchwork-notify@kernel.org>
Date:   Thu, 23 Mar 2023 00:00:19 +0000
References: <20230322213056.2470-1-daniel@iogearbox.net>
In-Reply-To: <20230322213056.2470-1-daniel@iogearbox.net>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, xukuohai@huaweicloud.com,
        john.fastabend@gmail.com
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

On Wed, 22 Mar 2023 22:30:55 +0100 you wrote:
> Xu reports that after commit 3f50f132d840 ("bpf: Verifier, do explicit ALU32
> bounds tracking"), the following BPF program is rejected by the verifier:
> 
>    0: (61) r2 = *(u32 *)(r1 +0)          ; R2_w=pkt(off=0,r=0,imm=0)
>    1: (61) r3 = *(u32 *)(r1 +4)          ; R3_w=pkt_end(off=0,imm=0)
>    2: (bf) r1 = r2
>    3: (07) r1 += 1
>    4: (2d) if r1 > r3 goto pc+8
>    5: (71) r1 = *(u8 *)(r2 +0)           ; R1_w=scalar(umax=255,var_off=(0x0; 0xff))
>    6: (18) r0 = 0x7fffffffffffff10
>    8: (0f) r1 += r0                      ; R1_w=scalar(umin=0x7fffffffffffff10,umax=0x800000000000000f)
>    9: (18) r0 = 0x8000000000000000
>   11: (07) r0 += 1
>   12: (ad) if r0 < r1 goto pc-2
>   13: (b7) r0 = 0
>   14: (95) exit
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] bpf: Fix __reg_bound_offset 64->32 var_off subreg propagation
    https://git.kernel.org/bpf/bpf-next/c/7be14c1c9030
  - [bpf-next,v2,2/2] selftests/bpf: Check when bounds are not in the 32-bit range
    https://git.kernel.org/bpf/bpf-next/c/1a3148fc171f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


