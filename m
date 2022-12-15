Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 133D864D63A
	for <lists+bpf@lfdr.de>; Thu, 15 Dec 2022 06:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiLOFkV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Dec 2022 00:40:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiLOFkT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Dec 2022 00:40:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2228131376
        for <bpf@vger.kernel.org>; Wed, 14 Dec 2022 21:40:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0E8C61CFE
        for <bpf@vger.kernel.org>; Thu, 15 Dec 2022 05:40:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DCE6EC433EF;
        Thu, 15 Dec 2022 05:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671082817;
        bh=43wrrtleHVlC64fgD7YSI6Lo2PFoL5vUdF7VKovshDw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=aMqfxYQWm+fYVT8l7uX+FqhsteWJEiICy5noeyTGaV5Fgq5b/bFPJye0l0G9PbtfA
         tfXxEXsy6nFbkQ3/5JYHD1MilTvrqjsiprIjsqWDUFRj1aXbQXEZkcETIDRWR705rh
         bslE6RL+1rwg4T1ZebbVYa3EYI1jimxqSIhYm+vOwqUjkHsnVNvQLjj2YOw0zjBB8S
         VjpZrXLUBiTw3w3oNC2TYnPU23Fv6QkOLsihq9Z5tMEEMURwmo9oCBq2vfSpNFtObM
         ILHNmtNIV4wnn9rl2aTFH+mrfzU6tkM7jP0GWi2VTBoaQRs/M6nVq84d4b2gMQrnjm
         xZKbmn7DIbpfg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BB42CC197B4;
        Thu, 15 Dec 2022 05:40:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v5 1/2] bpf: Resolve fext program type when checking map
 compatibility
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167108281676.10931.5422123371986840782.git-patchwork-notify@kernel.org>
Date:   Thu, 15 Dec 2022 05:40:16 +0000
References: <20221214230254.790066-1-toke@redhat.com>
In-Reply-To: <20221214230254.790066-1-toke@redhat.com>
To:     =?utf-8?b?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2VuIDx0b2tlQHJlZGhhdC5jb20+?=@ci.codeaurora.org
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, lorenzo@kernel.org, bpf@vger.kernel.org
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
by Martin KaFai Lau <martin.lau@kernel.org>:

On Thu, 15 Dec 2022 00:02:53 +0100 you wrote:
> The bpf_prog_map_compatible() check makes sure that BPF program types are
> not mixed inside BPF map types that can contain programs (tail call maps,
> cpumaps and devmaps). It does this by setting the fields of the map->owner
> struct to the values of the first program being checked against, and
> rejecting any subsequent programs if the values don't match.
> 
> One of the values being set in the map owner struct is the program type,
> and since the code did not resolve the prog type for fext programs, the map
> owner type would be set to PROG_TYPE_EXT and subsequent loading of programs
> of the target type into the map would fail.
> 
> [...]

Here is the summary with links:
  - [bpf,v5,1/2] bpf: Resolve fext program type when checking map compatibility
    https://git.kernel.org/bpf/bpf/c/1c123c567fb1
  - [bpf,v5,2/2] selftests/bpf: Add a test for using a cpumap from an freplace-to-XDP program
    https://git.kernel.org/bpf/bpf/c/f506439ec3de

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


