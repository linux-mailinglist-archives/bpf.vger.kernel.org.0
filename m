Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDAC6329FF
	for <lists+bpf@lfdr.de>; Mon, 21 Nov 2022 17:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbiKUQuX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Nov 2022 11:50:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbiKUQuR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Nov 2022 11:50:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093455BD6F
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 08:50:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 907EB6132E
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 16:50:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EB84EC433D6;
        Mon, 21 Nov 2022 16:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669049416;
        bh=F5y43aei7454lMIhWh9LlcVKdSGbBXxyvLIVb64VsjI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=F5GWotr0BiOzmG2nVw1PDfJpaCqF+pibhhziwRrnZku4gBDyFx73hJrP3D9ARVzRH
         eH/i8RoYZlcKUTDrHc45uYMvRqS6ymUqwBBWSwJ33mCq4/Xmiq6uQbwQjdyrhyW8yS
         gzqWDoe7bm8Q4guE23egutusTVYQguwqOlRtBy2x6nj2IiGA1TRaf7k9ybFUvuzEFG
         y0ew0pppdbwN4BEcGV49DGw8sZm3Ni/9Yc2oY4I6OaqLI+4+1ChQSlbIjWm0YvA7r/
         2BFpZICTIEO6zklg2/wYwUJuIlM/xGjqXQAiotTWCcG0LGyk4C/9USIMMm7yqkiimG
         UcGvP3+31e+uQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BE65BE270C7;
        Mon, 21 Nov 2022 16:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/3] bpf: Pin the start cgroup for cgroup iterator
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166904941577.16961.4100589791651140735.git-patchwork-notify@kernel.org>
Date:   Mon, 21 Nov 2022 16:50:15 +0000
References: <20221121073440.1828292-1-houtao@huaweicloud.com>
In-Reply-To: <20221121073440.1828292-1-houtao@huaweicloud.com>
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     bpf@vger.kernel.org, martin.lau@linux.dev, haoluo@google.com,
        yhs@fb.com, andrii@kernel.org, song@kernel.org, ast@kernel.org,
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

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon, 21 Nov 2022 15:34:37 +0800 you wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> Hi,
> 
> The patchset tries to fix the potential use-after-free problem in cgroup
> iterator. The problem is similar with the UAF problem fixed in map
> iterator and the fix is also similar: pinning the iterated resource in
> .init_seq_private() and unpinning it in .fini_seq_private(). An
> alternative fix is pinning iterator link when opening iterator fd, but
> it will make iterator link still being visible after the close of
> iterator link fd and the behavior is different with other link types, so
> just fixing the bug alone by pinning the start cgroup when creating
> cgroup iterator. Also adding a selftests to demonstrate the UAF problem
> when iterating a dead cgroup.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/3] bpf: Pin the start cgroup in cgroup_iter_seq_init()
    https://git.kernel.org/bpf/bpf-next/c/1a5160d4d8fe
  - [bpf-next,v3,2/3] selftests/bpf: Add cgroup helper remove_cgroup()
    https://git.kernel.org/bpf/bpf-next/c/2a42461a8831
  - [bpf-next,v3,3/3] selftests/bpf: Add test for cgroup iterator on a dead cgroup
    https://git.kernel.org/bpf/bpf-next/c/8589e92675aa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


