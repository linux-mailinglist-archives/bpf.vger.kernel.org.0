Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF91E58F17A
	for <lists+bpf@lfdr.de>; Wed, 10 Aug 2022 19:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233543AbiHJRUz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Aug 2022 13:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233686AbiHJRUV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Aug 2022 13:20:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E79A73327
        for <bpf@vger.kernel.org>; Wed, 10 Aug 2022 10:20:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 83EF1B81E61
        for <bpf@vger.kernel.org>; Wed, 10 Aug 2022 17:20:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 32A90C433D7;
        Wed, 10 Aug 2022 17:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660152016;
        bh=1kVPhPPoE/GhkGd+0NckVIA+oTZFE47BopnFBSb0mTs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=KkZbuAozE/MI1nBpXENWXiPCjA+T7SVHjk35m7jZ4C9tdIznX3XsPC+V5Xh6Nl5De
         R971NwYC4YGQ53+qb8ODF1bcnIukT9cf922afZF6Wm7NxXJt2u9D0hcfZA3I7qA1NF
         xHDsndXDf55GWaF4o+H7en91JYwg64sA+qU9JZ6kElIPAsNRMu1sizz1Rrth1dJBeo
         Tng3wH1lbwKoLYSK/mxsbzq7v0PDoxDo4sSW+4wc8xN2b78G0lZ4yWSFfezx6o0MZ1
         hUfyoY8q/3k2RfPCOhL0B8sX80LAFxvX8//L2llvXbYOPx2UcwgngaGSLAK7FDH+RN
         PQ04S6t9nWgpA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 11273C43141;
        Wed, 10 Aug 2022 17:20:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2 0/9] fixes for bpf map iterator
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166015201605.23495.13849985276063325682.git-patchwork-notify@kernel.org>
Date:   Wed, 10 Aug 2022 17:20:16 +0000
References: <20220810080538.1845898-1-houtao@huaweicloud.com>
In-Reply-To: <20220810080538.1845898-1-houtao@huaweicloud.com>
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     bpf@vger.kernel.org, yhs@fb.com, andrii@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, kafai@fb.com, songliubraving@fb.com,
        kpsingh@kernel.org, davem@davemloft.net, kuba@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        john.fastabend@gmail.com, oss@lmb.io, houtao1@huawei.com
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

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 10 Aug 2022 16:05:29 +0800 you wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> Hi,
> 
> The patchset constitues three fixes for bpf map iterator:
> 
> (1) patch 1~4: fix user-after-free during reading map iterator fd
> It is possible when both the corresponding link fd and map fd are
> closed bfore reading the iterator fd. I had squashed these four patches
> into one, but it was not friendly for stable backport, so I break these
> fixes into four single patches in the end. Patch 7 is its testing patch.
> 
> [...]

Here is the summary with links:
  - [bpf,v2,1/9] bpf: Acquire map uref in .init_seq_private for array map iterator
    https://git.kernel.org/bpf/bpf/c/f76fa6b33805
  - [bpf,v2,2/9] bpf: Acquire map uref in .init_seq_private for hash map iterator
    https://git.kernel.org/bpf/bpf/c/ef1e93d2eeb5
  - [bpf,v2,3/9] bpf: Acquire map uref in .init_seq_private for sock local storage map iterator
    https://git.kernel.org/bpf/bpf/c/3c5f6e698b5c
  - [bpf,v2,4/9] bpf: Acquire map uref in .init_seq_private for sock{map,hash} iterator
    https://git.kernel.org/bpf/bpf/c/f0d2b2716d71
  - [bpf,v2,5/9] bpf: Check the validity of max_rdwr_access for sock local storage map iterator
    https://git.kernel.org/bpf/bpf/c/52bd05eb7c88
  - [bpf,v2,6/9] bpf: Only allow sleepable program for resched-able iterator
    https://git.kernel.org/bpf/bpf/c/d247049f4fd0
  - [bpf,v2,7/9] selftests/bpf: Add tests for reading a dangling map iter fd
    https://git.kernel.org/bpf/bpf/c/5836d81e4b03
  - [bpf,v2,8/9] selftests/bpf: Add write tests for sk local storage map iterator
    https://git.kernel.org/bpf/bpf/c/939a1a946d75
  - [bpf,v2,9/9] selftests/bpf: Ensure sleepable program is rejected by hash map iter
    https://git.kernel.org/bpf/bpf/c/c5c0981fd81d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


