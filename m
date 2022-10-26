Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C22D60DB75
	for <lists+bpf@lfdr.de>; Wed, 26 Oct 2022 08:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiJZGkY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Oct 2022 02:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbiJZGkW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Oct 2022 02:40:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877EE3C8C3
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 23:40:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CB4F61D52
        for <bpf@vger.kernel.org>; Wed, 26 Oct 2022 06:40:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8787EC433C1;
        Wed, 26 Oct 2022 06:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666766418;
        bh=r0MyIDY1JRwAtb4RlcCMTam3l3bVdzU7+VMq7oZfllM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=mTA9GfDu02Buj7H6jORd1t81Qt4c/Pdb7lDmi0fY4p2FoS3PoeJ+E34ZjgArwpcQ9
         BB5G8tr3g7YjJOTBELsF4Pl6EXlG1otqV6Bz5xr5NpJv3Gf+imF7MEZqB4BhjOOxks
         L7h8HwaseDo5Rcsphdx33+p62cZbkgVot+gLC+rFJpTkY0kBCx/qLDUoW9HWOmuslP
         a0ko9hW8WPnAoD8jOnZjqJLf0aY4v9ZKo+Y8ylxGiw/wYUYTcjPx5HVLELm9QdMDqh
         O7gJLnHHrXvoRmvU4boBDf1hEXq3LZx7ZjDAgi0aDZsGBlNklPVRKj6H9T2BxNnpBo
         aTVK+YSBfVqcw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7137FE270DC;
        Wed, 26 Oct 2022 06:40:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v6 0/9] bpf: Implement cgroup local storage available
 to non-cgroup-attached bpf progs
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166676641845.4978.11078534978845698275.git-patchwork-notify@kernel.org>
Date:   Wed, 26 Oct 2022 06:40:18 +0000
References: <20221026042835.672317-1-yhs@fb.com>
In-Reply-To: <20221026042835.672317-1-yhs@fb.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, kpsingh@kernel.org,
        martin.lau@kernel.org, tj@kernel.org
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Tue, 25 Oct 2022 21:28:35 -0700 you wrote:
> There already exists a local storage implementation for cgroup-attached
> bpf programs. See map type BPF_MAP_TYPE_CGROUP_STORAGE and helper
> bpf_get_local_storage(). But there are use cases such that non-cgroup
> attached bpf progs wants to access cgroup local storage data. For example,
> tc egress prog has access to sk and cgroup. It is possible to use
> sk local storage to emulate cgroup local storage by storing data in socket.
> But this is a waste as it could be lots of sockets belonging to a particular
> cgroup. Alternatively, a separate map can be created with cgroup id as the key.
> But this will introduce additional overhead to manipulate the new map.
> A cgroup local storage, similar to existing sk/inode/task storage,
> should help for this use case.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v6,1/9] bpf: Make struct cgroup btf id global
    https://git.kernel.org/bpf/bpf-next/c/5e67b8ef125b
  - [bpf-next,v6,2/9] bpf: Refactor some inode/task/sk storage functions for reuse
    https://git.kernel.org/bpf/bpf-next/c/c83597fa5dc6
  - [bpf-next,v6,3/9] bpf: Implement cgroup storage available to non-cgroup-attached bpf progs
    https://git.kernel.org/bpf/bpf-next/c/c4bcfb38a95e
  - [bpf-next,v6,4/9] libbpf: Support new cgroup local storage
    https://git.kernel.org/bpf/bpf-next/c/4fe64af23c12
  - [bpf-next,v6,5/9] bpftool: Support new cgroup local storage
    https://git.kernel.org/bpf/bpf-next/c/f7f0f1657d95
  - [bpf-next,v6,6/9] selftests/bpf: Fix test test_libbpf_str/bpf_map_type_str
    https://git.kernel.org/bpf/bpf-next/c/fd4ca6c1facf
  - [bpf-next,v6,7/9] selftests/bpf: Add selftests for new cgroup local storage
    https://git.kernel.org/bpf/bpf-next/c/12bb6ca4e2fa
  - [bpf-next,v6,8/9] selftests/bpf: Add test cgrp_local_storage to DENYLIST.s390x
    https://git.kernel.org/bpf/bpf-next/c/0a1b69d1c736
  - [bpf-next,v6,9/9] docs/bpf: Add documentation for new cgroup local storage
    https://git.kernel.org/bpf/bpf-next/c/d43198017ea3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


