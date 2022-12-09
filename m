Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E631647BC7
	for <lists+bpf@lfdr.de>; Fri,  9 Dec 2022 03:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiLICAT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Dec 2022 21:00:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiLICAS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Dec 2022 21:00:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E5555A95;
        Thu,  8 Dec 2022 18:00:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF64462102;
        Fri,  9 Dec 2022 02:00:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 112D1C433F0;
        Fri,  9 Dec 2022 02:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670551216;
        bh=ZfWZgDyunGe+ymQUBofAg3W3Vow492/HayKThmDQ7js=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=C0CgDZBLFAGJNs+7JpSM7c6bTrNtA3BP/jz8u8V8CifjuUleD0lWeDCU9UNJGgfts
         htfWTG71HyNIO9ODGfebPJIk4w6taD3K7CUFC113MdsGXcHHg7ynTCUj6VSdd2O7Pr
         qtjAsvtqmUQY1VjL/7ulbZ2zuiSbMjkssJgh1Len1XCoTnyVbf6nnMNotmMEnsuZjs
         KuihWFmqiyvwcXBP4Yc5GON2JqzapOzU8V5x79Kn6sTBbuSnqzM3L6sn+lRYG0LjAQ
         tDWTcVJLAXRYgPGaG7L9hF+ScUmkR5eF0hZ3DHm1Dm80uN2oVAbaIiDpmsIK3cFHKn
         j9JqnPP6jqLBQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DDC7CE1B4D8;
        Fri,  9 Dec 2022 02:00:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/2] Misc optimizations for bpf mem allocator
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167055121590.16670.16541321948945881937.git-patchwork-notify@kernel.org>
Date:   Fri, 09 Dec 2022 02:00:15 +0000
References: <20221209010947.3130477-1-houtao@huaweicloud.com>
In-Reply-To: <20221209010947.3130477-1-houtao@huaweicloud.com>
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     bpf@vger.kernel.org, martin.lau@linux.dev, andrii@kernel.org,
        song@kernel.org, haoluo@google.com, yhs@fb.com, ast@kernel.org,
        daniel@iogearbox.net, kpsingh@kernel.org, sdf@google.com,
        jolsa@kernel.org, john.fastabend@gmail.com, paulmck@kernel.org,
        rcu@vger.kernel.org, houtao1@huawei.com
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
by Alexei Starovoitov <ast@kernel.org>:

On Fri,  9 Dec 2022 09:09:45 +0800 you wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> Hi,
> 
> The patchset is just misc optimizations for bpf mem allocator. Patch 1
> fixes the OOM problem found during running hash-table update benchmark
> from qp-trie patchset [0]. The benchmark will add htab elements in
> batch and then delete elements in batch, so freed objects will stack on
> free_by_rcu and wait for the expiration of RCU grace period. There can
> be tens of thousands of freed objects and these objects are not
> available for new allocation, so adding htab element will continue to do
> new allocation.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] bpf: Reuse freed element in free_by_rcu during allocation
    https://git.kernel.org/bpf/bpf-next/c/0893d6007db5
  - [bpf-next,v2,2/2] bpf: Skip rcu_barrier() if rcu_trace_implies_rcu_gp() is true
    https://git.kernel.org/bpf/bpf-next/c/822ed78fab13

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


