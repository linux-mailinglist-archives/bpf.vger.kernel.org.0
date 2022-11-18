Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4662A62E9F0
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 01:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbiKRAAW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 19:00:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbiKRAAU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 19:00:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2978742CF
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 16:00:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8270FB8223D
        for <bpf@vger.kernel.org>; Fri, 18 Nov 2022 00:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2B75EC433D7;
        Fri, 18 Nov 2022 00:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668729617;
        bh=37QSvRIbLDgMqZPtbmH2sp8qQFpKd8GW06xFAO+zWxI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=AVhDJZLYW54IocvphsdXTcXXpCD1v56j9NIYMympPhNAjwjAuiX2BQmpbJ87un1y8
         a426MAUYCnsTjDC4LQcQa+qNLQqjfuarPTTst7r3Po3cQd2xfQ3/PbtxdERAE1crM2
         O1GBPGAzgkNiQNDFXAx4rR+NjzGP88CTvtVbJ1gNiihl8crdSJVXIr1ydBSjjgf/0v
         cYKc14bZo6wsLxUkOg9u9IjjAAFiqXkBfjnjp6QaN/wRC91WIfikvP9FIjwtbWJJGZ
         OQkiqMOiZmTcDYnqvwsmFKNA7YJGI04p6dQIZCEIu5bRg+MAdlxbDQJZI/4692zyXr
         4rIVBA69vtGVQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0F8B6E270F6;
        Fri, 18 Nov 2022 00:00:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2 0/4] libbpf: Fixes for ring buffer
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166872961705.10930.1675373691676196370.git-patchwork-notify@kernel.org>
Date:   Fri, 18 Nov 2022 00:00:17 +0000
References: <20221116072351.1168938-1-houtao@huaweicloud.com>
In-Reply-To: <20221116072351.1168938-1-houtao@huaweicloud.com>
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, void@manifault.com,
        martin.lau@linux.dev, song@kernel.org, haoluo@google.com,
        yhs@fb.com, ast@kernel.org, daniel@iogearbox.net,
        kpsingh@kernel.org, sdf@google.com, jolsa@kernel.org,
        john.fastabend@gmail.com, houtao1@huawei.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 16 Nov 2022 15:23:47 +0800 you wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> Hi,
> 
> The patch set tries to fix the problems found when testing ringbuf by
> using 4KB and 2GB size. Patch 1 fixes the probe of ring buffer map on
> host with 64KB page (e.g., an ARM64 host). Patch 2 & 3 fix the overflow
> of length when mmaping 2GB kernel ringbuf or user ringbuf on libbpf.
> Patch 4 just reject the reservation with invalid size.
> 
> [...]

Here is the summary with links:
  - [bpf,v2,1/4] libbpf: Use page size as max_entries when probing ring buffer map
    https://git.kernel.org/bpf/bpf/c/689eb2f1ba46
  - [bpf,v2,2/4] libbpf: Handle size overflow for ringbuf mmap
    https://git.kernel.org/bpf/bpf/c/927cbb478adf
  - [bpf,v2,3/4] libbpf: Handle size overflow for user ringbuf mmap
    https://git.kernel.org/bpf/bpf/c/64176bff2446
  - [bpf,v2,4/4] libbpf: Check the validity of size in user_ring_buffer__reserve()
    https://git.kernel.org/bpf/bpf/c/05c1558bfcb6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


