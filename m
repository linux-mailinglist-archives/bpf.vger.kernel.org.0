Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4138F5E4F6F
	for <lists+bpf@lfdr.de>; Wed, 21 Sep 2022 20:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbiIUSaV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Sep 2022 14:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiIUSaT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Sep 2022 14:30:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6AA9F749;
        Wed, 21 Sep 2022 11:30:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F5396327A;
        Wed, 21 Sep 2022 18:30:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 73E23C433C1;
        Wed, 21 Sep 2022 18:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663785016;
        bh=SIc3/ndGaw5e+ZCwmuMbrkzE17hFO4zcIMn2UyJWMTg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=m82lQGkvKtsTS+A67ZIQonoNdwpMzPNSHdkECm5LNgz91e9Dhyt81hgcLZHFsCSMj
         7bAvVvkijIpUSWQbDEVv/cdY4Hwk26Ayf7MARrpWyfxRX/3dh8GkzihT5Tdxnlnkgj
         XJs4AaR3clF7AJjPx0d2rhIiMCKdaMKvZd9na+7DhjfIaI2cDV8aJjSQ+OKMdQFpGd
         0DbYapBsVYENGmEqgk27aqL4o7rbJGSitP2mKmQc0sFHzmDKq5qA066sUyGPz06i+/
         7DzulsSnxWhMvCgKRscr4+6PvmUkdg92rHfnx5oygp+PCGIUj1SMS1EF8/71ANAcu0
         JLQUBDKKaJ2xg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 53CD0E4D03E;
        Wed, 21 Sep 2022 18:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v5 0/3] Fix wrong cgroup attach flags being assigned to
 effective progs
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166378501633.16220.12349471417152311868.git-patchwork-notify@kernel.org>
Date:   Wed, 21 Sep 2022 18:30:16 +0000
References: <20220921104604.2340580-1-pulehui@huaweicloud.com>
In-Reply-To: <20220921104604.2340580-1-pulehui@huaweicloud.com>
To:     Pu Lehui <pulehui@huaweicloud.com>
Cc:     martin.lau@linux.dev, sdf@google.com, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, quentin@isovalent.com, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org, pulehui@huawei.com
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

On Wed, 21 Sep 2022 10:46:01 +0000 you wrote:
> From: Pu Lehui <pulehui@huawei.com>
> 
> When root-cgroup attach multi progs and sub-cgroup attach a
> override prog, bpftool will display incorrectly for the attach
> flags of the sub-cgroup’s effective progs:
> 
> $ bpftool cgroup tree /sys/fs/cgroup effective
> CgroupPath
> ID       AttachType      AttachFlags     Name
> /sys/fs/cgroup
> 6        cgroup_sysctl   multi           sysctl_tcp_mem
> 13       cgroup_sysctl   multi           sysctl_tcp_mem
> /sys/fs/cgroup/cg1
> 20       cgroup_sysctl   override        sysctl_tcp_mem
> 6        cgroup_sysctl   override        sysctl_tcp_mem <- wrong
> 13       cgroup_sysctl   override        sysctl_tcp_mem <- wrong
> /sys/fs/cgroup/cg1/cg2
> 20       cgroup_sysctl                   sysctl_tcp_mem
> 6        cgroup_sysctl                   sysctl_tcp_mem
> 13       cgroup_sysctl                   sysctl_tcp_mem
> 
> [...]

Here is the summary with links:
  - [bpf,v5,1/3] bpf, cgroup: Reject prog_attach_flags array when effective query
    https://git.kernel.org/bpf/bpf/c/0e426a3ae030
  - [bpf,v5,2/3] bpftool: Fix wrong cgroup attach flags being assigned to effective progs
    https://git.kernel.org/bpf/bpf/c/bdcee1b0b083
  - [bpf,v5,3/3] selftests/bpf: Adapt cgroup effective query uapi change
    https://git.kernel.org/bpf/bpf/c/d2aa993b7d9d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


