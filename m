Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3D56988E5
	for <lists+bpf@lfdr.de>; Thu, 16 Feb 2023 00:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjBOXuU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Feb 2023 18:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjBOXuU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Feb 2023 18:50:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE0E2E80D
        for <bpf@vger.kernel.org>; Wed, 15 Feb 2023 15:50:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1BBE61E01
        for <bpf@vger.kernel.org>; Wed, 15 Feb 2023 23:50:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3ED7DC4339B;
        Wed, 15 Feb 2023 23:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676505018;
        bh=dn2QSdXrOPxJRh9Gjwe+YTuXbXcBmO8scispptu4Vog=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=igSyMIBbdjBdYEOVTrd3+zoIfh72+vBVOo9sq3fTIyFLxeNAhmwDQwruss/J2OpRE
         F80gqG9S/8BivFz5b0IaSm97nVDXU544pkVUZZLtvR/ECXTZw/gqFcgCpr0/Ol45iC
         hndVzVTrpcZpyMJA0YPoaGCBDggSxLiks3h3YIhIVTToYxk/1LZWx3T7p+zB+/nK3V
         6pFeNx/Gtci1CjVrR8E+1vXU2X+blz88Joun2tl03wCh3eFlOwWh7NYYtHfbbB4NBH
         clXOK6U/6hGOFRNxjUfq+psrIKTUdH3Og1PAmeFCTZyucVeRmIlWnZFvCdwtaa+AnB
         Ah1/L1Fw4Tk/g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 24AF4C41676;
        Wed, 15 Feb 2023 23:50:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/2] Use __GFP_ZERO in bpf memory allocator
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167650501814.26864.1394037113331993225.git-patchwork-notify@kernel.org>
Date:   Wed, 15 Feb 2023 23:50:18 +0000
References: <20230215082132.3856544-1-houtao@huaweicloud.com>
In-Reply-To: <20230215082132.3856544-1-houtao@huaweicloud.com>
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     bpf@vger.kernel.org, martin.lau@linux.dev, andrii@kernel.org,
        song@kernel.org, haoluo@google.com, yhs@fb.com, ast@kernel.org,
        daniel@iogearbox.net, kpsingh@kernel.org, sdf@google.com,
        jolsa@kernel.org, john.fastabend@gmail.com, memxor@gmail.com,
        houtao1@huawei.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 15 Feb 2023 16:21:30 +0800 you wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> Hi,
> 
> The patchset tries to fix the hard-up problem found when checking how htab
> handles element reuse in bpf memory allocator. The immediate reuse of
> freed elements will reinitialize special fields (e.g., bpf_spin_lock) in
> htab map value and it may corrupt lookup procedure with BFP_F_LOCK flag
> which acquires bpf-spin-lock during value copying, and lead to hard-lock
> as shown in patch #2. Patch #1 fixes it by using __GFP_ZERO when allocating
> the object from slab and the behavior is similar with the preallocated
> hash-table case. Please see individual patches for more details. And comments
> are always welcome.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpf: Zeroing allocated object from slab in bpf memory allocator
    https://git.kernel.org/bpf/bpf-next/c/997849c4b969
  - [bpf-next,2/2] selftests/bpf: Add test case for element reuse in htab map
    https://git.kernel.org/bpf/bpf-next/c/f88da2d46cc9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


