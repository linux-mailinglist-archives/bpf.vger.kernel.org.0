Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B76062E17D
	for <lists+bpf@lfdr.de>; Thu, 17 Nov 2022 17:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240414AbiKQQUt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 11:20:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240420AbiKQQUj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 11:20:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89AB97AF67
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 08:20:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 34C7BB82106
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 16:20:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E12E4C433B5;
        Thu, 17 Nov 2022 16:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668702017;
        bh=ey7Z4uMgRUQgBG2pMTdoDwV2YeCWHcGlvpmoxx0u3/g=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=u0M6qf8EQlBT2jCOKEEqp0CFWJebO46oF6L430x1vYCv8NbiLvWZAHQrUEqPkS2iV
         HeQ0TpL4dnOO7W75dvs/3rRhvrlPHA0lgmKWcjJ1B9x8lLwrbBkkCbdxJAYVfNu9Bt
         KXdobvWUg2NeDLjJU8p/5bh+h6mdP3inuTNSZbG/FNIbDaBKT+SS15TdgmfqlGjfBY
         w2egcphXYoM2TBvrxPeLF+jEOommWwxTU8wb5MjgWBPoSjQOooWFF3LzPR20ZL+N4e
         OFKfs8QJ4xbOQnXu9emHohi9c+tVn3zeP1yD01+/IdpsnYNAvjk04BsSZ2TqR/CiA8
         KaP5hD8BiUv/A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B3373E270D5;
        Thu, 17 Nov 2022 16:20:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3] bpf: Pass map file to .map_update_batch directly
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166870201672.18267.1764531191690477448.git-patchwork-notify@kernel.org>
Date:   Thu, 17 Nov 2022 16:20:16 +0000
References: <20221116075059.1551277-1-houtao@huaweicloud.com>
In-Reply-To: <20221116075059.1551277-1-houtao@huaweicloud.com>
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     bpf@vger.kernel.org, martin.lau@linux.dev, andrii@kernel.org,
        song@kernel.org, haoluo@google.com, yhs@fb.com, ast@kernel.org,
        daniel@iogearbox.net, kpsingh@kernel.org, sdf@google.com,
        jolsa@kernel.org, john.fastabend@gmail.com, houtao1@huawei.com
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

On Wed, 16 Nov 2022 15:50:58 +0800 you wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> Currently bpf_map_do_batch() first invokes fdget(batch.map_fd) to get
> the target map file, then it invokes generic_map_update_batch() to do
> batch update. generic_map_update_batch() will get the target map file
> by using fdget(batch.map_fd) again and pass it to
> bpf_map_update_value().
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3] bpf: Pass map file to .map_update_batch directly
    https://git.kernel.org/bpf/bpf-next/c/3af43ba4c601

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


