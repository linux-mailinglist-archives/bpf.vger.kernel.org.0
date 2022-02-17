Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B74B74BA914
	for <lists+bpf@lfdr.de>; Thu, 17 Feb 2022 20:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244846AbiBQTA2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Feb 2022 14:00:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244864AbiBQTA2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Feb 2022 14:00:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B69875C1F
        for <bpf@vger.kernel.org>; Thu, 17 Feb 2022 11:00:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3B825B823C4
        for <bpf@vger.kernel.org>; Thu, 17 Feb 2022 19:00:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C1E4BC340F5;
        Thu, 17 Feb 2022 19:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645124410;
        bh=pXsQuxbDViV+NtOoOCBRV5RnbYAJtPsXAnE1vuNWvTA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Wf0ZsWNbSKoIUJYOU4LO+v2GKM9anJGtA/dYale0Ir0iDVS031osC53A+GoXXNifa
         54IO4ZIRBl8wEv81FBK47sN19ksPx23vDqdC00ZXgVNxu411o8PsvYJr02CD8vjYhE
         y38Q+JX2xwizVaLRgV7yvyGlu1y3yoW3/6yG30NMH/Y/w6Fw9Ooj2BcVhwACGCQ/uy
         hRNHR8aXy57CX8lqCRYWslT02boN79YGn/KnIBoILS5zBK8vIngY+vxTB04zjql65+
         XyJUCywNnq8tJM6N7rZMaDhlUS+XK6GaxdLqZdp91kSGucULw+8u+2SkddWIQIWHvi
         fT2LwHN4nG/cA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B1337E7BB08;
        Thu, 17 Feb 2022 19:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: fix vmtest.sh to launch smp vm.
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164512441071.13752.16041850189800843797.git-patchwork-notify@kernel.org>
Date:   Thu, 17 Feb 2022 19:00:10 +0000
References: <20220217155212.2309672-1-fallentree@fb.com>
In-Reply-To: <20220217155212.2309672-1-fallentree@fb.com>
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

On Thu, 17 Feb 2022 07:52:12 -0800 you wrote:
> Fix typo in vmtest.sh to make sure it launch proper vm with 8 cpus.
> 
> Signed-off-by: Yucong Sun <fallentree@fb.com>
> ---
>  tools/testing/selftests/bpf/vmtest.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [bpf-next] selftests/bpf: fix vmtest.sh to launch smp vm.
    https://git.kernel.org/bpf/bpf-next/c/b38101c57acf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


