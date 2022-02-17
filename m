Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82DB4BA94F
	for <lists+bpf@lfdr.de>; Thu, 17 Feb 2022 20:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbiBQTK1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Feb 2022 14:10:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243867AbiBQTKZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Feb 2022 14:10:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247C385941
        for <bpf@vger.kernel.org>; Thu, 17 Feb 2022 11:10:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5C0F61CB3
        for <bpf@vger.kernel.org>; Thu, 17 Feb 2022 19:10:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 24AF6C340EB;
        Thu, 17 Feb 2022 19:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645125010;
        bh=XQSqvTlLD9opVAJl/1FBt0Ozh3CVVAsbaoDayit+wOs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=bC/P0XT0+j8xjFA/YyN+C/EHVzeppJ5VsQLwvmmwNhqFOvyvcRAVTZNFRunaAgcyj
         tK2zmsl7mgPHv6orGC2MhqgF4uvTrL2rMyEX+BozlVq15ntsBDazsvTxyZkJzpBywS
         xFK6iKeF5wAsyqnWEAybpoq88usgPCE73AKpK4jGzlRvKeDPBPTkfcXTTTpUJA+6fn
         NA/ZkRBwE69wXWk9PahiumxUrFkLde6ARSzJzjPiAKPcLr2eRPiNMNiFWTv0I7Yf0k
         NsiIX5qPBOAU6DDUeO9GzidyQ28tovYLFJqvbwCHlMl8B7tRBZUzJl4hjacScSY96Z
         kHbxBDbZR/98w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 10A00E6D446;
        Thu, 17 Feb 2022 19:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: fix crash in core_reloc when bpftool
 btfgen fails
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164512501006.19486.15904148052284847726.git-patchwork-notify@kernel.org>
Date:   Thu, 17 Feb 2022 19:10:10 +0000
References: <20220217180210.2981502-1-fallentree@fb.com>
In-Reply-To: <20220217180210.2981502-1-fallentree@fb.com>
To:     Yucong Sun <fallentree@fb.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, sunyucong@gmail.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 17 Feb 2022 10:02:10 -0800 you wrote:
> Initialize obj to null and skip closing if null.
> 
> Signed-off-by: Yucong Sun <fallentree@fb.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/core_reloc.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [bpf-next] selftests/bpf: fix crash in core_reloc when bpftool btfgen fails
    https://git.kernel.org/bpf/bpf-next/c/b75dacaac465

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


