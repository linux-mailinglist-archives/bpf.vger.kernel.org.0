Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22E5D53BFDA
	for <lists+bpf@lfdr.de>; Thu,  2 Jun 2022 22:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238987AbiFBUaR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Jun 2022 16:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239050AbiFBUaQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Jun 2022 16:30:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098B4248F0
        for <bpf@vger.kernel.org>; Thu,  2 Jun 2022 13:30:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BD129B82188
        for <bpf@vger.kernel.org>; Thu,  2 Jun 2022 20:30:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 734A6C34114;
        Thu,  2 Jun 2022 20:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654201812;
        bh=H0VVRp3AD787smXAWEkkRWDQC9YADPlY0W5YWhVq0KE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=o+yZ4cTqahR11CN2skRac5AWpWfaCOS5LQfFnGLPfduZ07rkny0Dnz687fYRAS1cr
         NOlBuNpi2JePCGHuTfE8EsJyT1OVOvhvO9tiYJ6WIai0YRTI0NsCf1PBoMHHQFZKzu
         W2ElzjjmumE4PGY8E0mJj18SlJu59HIkjmKysulyWAL19U1EzJDPm0GEKQFo3g2fQ1
         /M26/F8FnPNMy51iarVQ/wLPcE0T8VQgB6gwkunTXqw2I/PnYFxg1zZXg4eIjLyq1F
         x2O2AoLVr36C8JT3IqOys037o95Yg1FtlJKbc1ZvtszTubH64uujkFYmEnC1hcGi+L
         oDiBxELHMadKw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4C4AAF0394E;
        Thu,  2 Jun 2022 20:30:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix tc_redirect_dtime
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165420181230.28036.5603639848610798718.git-patchwork-notify@kernel.org>
Date:   Thu, 02 Jun 2022 20:30:12 +0000
References: <20220601234050.2572671-1-kafai@fb.com>
In-Reply-To: <20220601234050.2572671-1-kafai@fb.com>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Wed, 1 Jun 2022 16:40:50 -0700 you wrote:
> tc_redirect_dtime was reported flaky from time to time.  It
> always fails at the udp test and complains about the bpf@tc-ingress
> got a skb->tstamp when handling udp packet.  It is unexpected
> because the skb->tstamp should have been cleared when crossing
> different netns.
> 
> The most likely cause is that the skb is actually a tcp packet
> from the earlier tcp test.  It could be the final TCP_FIN handling.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Fix tc_redirect_dtime
    https://git.kernel.org/bpf/bpf-next/c/f7dd4cfb82db

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


