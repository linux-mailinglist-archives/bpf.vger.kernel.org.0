Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD54E634AA2
	for <lists+bpf@lfdr.de>; Wed, 23 Nov 2022 00:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbiKVXAX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Nov 2022 18:00:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiKVXAV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Nov 2022 18:00:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52386240BC;
        Tue, 22 Nov 2022 15:00:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF8196193E;
        Tue, 22 Nov 2022 23:00:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 284AEC433D7;
        Tue, 22 Nov 2022 23:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669158017;
        bh=hDp7z6c183qc/dv5dfSlL+UMP/F5g0Wo+l1qAFqWm6k=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=oOoOUiGvKEOcVv25z8utcdrvycZKqqlIvpOakpdlYJpJcDQdmwdsLHeeyGQ1brhMB
         w8j2mv7nWwgmQV+Vwbjf45JulqTS+Lcq203hMq9n9RADjWfPGRD62hqVwEZHLmEVmc
         Gt5YpxpR2NmBeF3ONKdUY8b3I9I2Hvm6so7N+NEy+IxJvf1yRy2sJ9iorGV7fj1iZY
         IdTKa5A8Wx0m4aaWmURYDXzi5QEN2D4TgoWJsSB7zsv6Xz1zO+A39ZbU2X1eJkXKQt
         odER13BvL7UWs1V2b3NodK8HGetWZgU93HL6SSgFZYxTyAY4eqVoqKpiqD2Gi4LgZD
         bZFX2CeXoLg9A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 04E08E270E3;
        Tue, 22 Nov 2022 23:00:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/4] Support storing struct cgroup * objects as kptrs
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166915801701.32558.522988930386371911.git-patchwork-notify@kernel.org>
Date:   Tue, 22 Nov 2022 23:00:17 +0000
References: <20221122055458.173143-1-void@manifault.com>
In-Reply-To: <20221122055458.173143-1-void@manifault.com>
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, yhs@fb.com,
        song@kernel.org, sdf@google.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, jolsa@kernel.org, haoluo@google.com,
        tj@kernel.org, kernel-team@fb.com, linux-kernel@vger.kernel.org
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

On Mon, 21 Nov 2022 23:54:54 -0600 you wrote:
> In [0], we added support for storing struct task_struct * objects as
> kptrs. This patch set extends this effort to also include storing struct
> cgroup * object as kptrs.
> 
> As with tasks, there are many possible use cases for storing cgroups in
> maps. During tracing, for example, it could be useful to query cgroup
> statistics such as PSI averages, or tracking which tasks are migrating
> to and from the cgroup.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/4] bpf: Enable cgroups to be used as kptrs
    https://git.kernel.org/bpf/bpf-next/c/fda01efc6160
  - [bpf-next,2/4] selftests/bpf: Add cgroup kfunc / kptr selftests
    https://git.kernel.org/bpf/bpf-next/c/f583ddf15e57
  - [bpf-next,3/4] bpf: Add bpf_cgroup_ancestor() kfunc
    https://git.kernel.org/bpf/bpf-next/c/5ca786707829
  - [bpf-next,4/4] selftests/bpf: Add selftests for bpf_cgroup_ancestor() kfunc
    https://git.kernel.org/bpf/bpf-next/c/227a89cf5041

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


