Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFC15687ADC
	for <lists+bpf@lfdr.de>; Thu,  2 Feb 2023 11:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbjBBKwA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Feb 2023 05:52:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbjBBKvt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Feb 2023 05:51:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491457D994
        for <bpf@vger.kernel.org>; Thu,  2 Feb 2023 02:51:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 560FBB825AD
        for <bpf@vger.kernel.org>; Thu,  2 Feb 2023 10:50:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EBC52C433D2;
        Thu,  2 Feb 2023 10:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675335017;
        bh=pd4HkTj8EZ1vNfpIdkTbnuZrDybXiy10ypPZYjDQ/0I=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=V47tc2zfwJGvhr/Ze0hAsMULM+gMNyHUsq+R3je9BoISwK7rpt+Y45+70X9hhqfTL
         ny5teGe52JrQqqPrIfnpnGfLirnJ9L3WeV7yQJ+mWt/07KLXWK9uT31MGQGOBiyjg9
         QIRMZFRGyk9stEWHUAewCRaJ4HNW7YD/aRTrkySK0aJk/fTJ90VBMWHtAmTKkUGrad
         4oRQckxCij1YdBClBRInq7I2pBn6D79kmJSgJdUCc8Hyx27vgucM1LATqa1fHmj1Id
         TpX9q5qzLIYaSFpwAgUx6/kfrb/1tsJqEMXxuPnLrZUNmtGiegNC10wWHDt33RRpi0
         WKkL5uMZA1K1Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D0516E50D67;
        Thu,  2 Feb 2023 10:50:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Don't refill on completion in
 xdp_metadata
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167533501685.21977.12306829140028998926.git-patchwork-notify@kernel.org>
Date:   Thu, 02 Feb 2023 10:50:16 +0000
References: <20230201233640.367646-1-sdf@google.com>
In-Reply-To: <20230201233640.367646-1-sdf@google.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org
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
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed,  1 Feb 2023 15:36:40 -0800 you wrote:
> We only need to consume TX completion instead of refilling 'fill' ring.
> 
> It's currently not an issue because we never RX more than 8 packets.
> 
> Fixes: e2a46d54d7a1 ("selftests/bpf: Verify xdp_metadata xdp->af_xdp path")
> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Don't refill on completion in xdp_metadata
    https://git.kernel.org/bpf/bpf-next/c/8b79b34a66cd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


