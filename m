Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B662F6F52FB
	for <lists+bpf@lfdr.de>; Wed,  3 May 2023 10:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjECIU1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 May 2023 04:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjECIU0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 May 2023 04:20:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86EEE4C21;
        Wed,  3 May 2023 01:20:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E6D6A62B8E;
        Wed,  3 May 2023 08:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3994CC4339B;
        Wed,  3 May 2023 08:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683102021;
        bh=MNbBVlYbis/L18qS6wI8HpvxXDkCPPaY/e5bpD6riks=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=E6cA4YIlZuy27KGN0RmddUDj2Focc2XiIjeWi1cKpUaBFzgwybLyOB55mIKPasYAK
         HOrhGpwpNwq3b23YG+rT2tWxhndaFtGjs3Jb8lJX1sMJ0bF4ML8NXwHamfKi6qMQQD
         DElSIs8q1dtUXNqpId6HZbTOQCd/NYgyy6ooPJT+/3K1G92rgiRN5rO7/NBXzcp9ia
         85iM+bIV71FDtvSZNvP4PXUEO3Ex/IjbVf127STXhFgXNcquYaUeNFhD/zaLZzbKC0
         5Sn2WRJlC+9QYv9s9D3seZcQAGkCBtTX1izY2VznFitvpcCopEfIA2CNb2+jd9DmUr
         MRA8Q2Ksixjyw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 154ADE5FFC9;
        Wed,  3 May 2023 08:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/1] igc: read before write to SRRCTL register
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168310202108.22454.4653955011857932951.git-patchwork-notify@kernel.org>
Date:   Wed, 03 May 2023 08:20:21 +0000
References: <20230502154806.1864762-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20230502154806.1864762-1-anthony.l.nguyen@intel.com>
To:     Tony Nguyen <anthony.l.nguyen@intel.com>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        edumazet@google.com, netdev@vger.kernel.org,
        yoong.siang.song@intel.com, sasha.neftin@intel.com,
        maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
        ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
        john.fastabend@gmail.com, bpf@vger.kernel.org,
        stable@vger.kernel.org, jacob.e.keller@intel.com,
        brouer@redhat.com, naamax.meir@linux.intel.com
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue,  2 May 2023 08:48:06 -0700 you wrote:
> From: Song Yoong Siang <yoong.siang.song@intel.com>
> 
> igc_configure_rx_ring() function will be called as part of XDP program
> setup. If Rx hardware timestamp is enabled prio to XDP program setup,
> this timestamp enablement will be overwritten when buffer size is
> written into SRRCTL register.
> 
> [...]

Here is the summary with links:
  - [net,1/1] igc: read before write to SRRCTL register
    https://git.kernel.org/netdev/net/c/3ce29c17dc84

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


