Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A515A6A0E1F
	for <lists+bpf@lfdr.de>; Thu, 23 Feb 2023 17:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjBWQkV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Feb 2023 11:40:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233331AbjBWQkU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Feb 2023 11:40:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CEF742BEF;
        Thu, 23 Feb 2023 08:40:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 973086176B;
        Thu, 23 Feb 2023 16:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3BBB2C4339C;
        Thu, 23 Feb 2023 16:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677170418;
        bh=TW4fl3bLDzHaGU8jprSYUuolBkfbQmM6d1zvy/iB5ls=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ABLEcpjn7CTQs1kz1ldEl7TyRr/LIabQu8ogMtBXd6h5sH72itUpNko3nZ1axe8Zv
         PMn/klvoQeRxivqZSC+NDCNN8h6yEcDVpzgcMsgtyMzuXqm0i7qXLndB3+RPICHuVy
         pHC0k/TcTZ+8hSKxfuD/dxSHxnNc208QvwpIZv0K3IE9YvTLNXfxT6Tep2rKBrLLiD
         2P8us6mOPtCqlqpTTi9wfnbuXigzCWzRD0SujphLMpZDxxcL3e7WAQzVcyBs64xAz1
         At38j9PWkfzXUjJV4RWa/WH+eqbYGwxOEFFw+Zl3A12Z8mENYRpGktLqyBWhGihf2L
         7qfnuIKnTMhEw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1D3F8C395E0;
        Thu, 23 Feb 2023 16:40:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/2 bpf-next] bpf: Add bpf_cgroup_from_id() kfunc
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167717041811.11071.10181818674097772190.git-patchwork-notify@kernel.org>
Date:   Thu, 23 Feb 2023 16:40:18 +0000
References: <Y/bBaG96t0/gQl9/@slm.duckdns.org>
In-Reply-To: <Y/bBaG96t0/gQl9/@slm.duckdns.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        davemarchevsky@meta.com, void@manifault.com,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
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

On Wed, 22 Feb 2023 15:29:12 -1000 you wrote:
> cgroup ID is an userspace-visible 64bit value uniquely identifying a given
> cgroup. As the IDs are used widely, it's useful to be able to look up the
> matching cgroups. Add bpf_cgroup_from_id().
> 
> v2: Separate out selftest into its own patch as suggested by Alexei.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> 
> [...]

Here is the summary with links:
  - [v2,1/2,bpf-next] bpf: Add bpf_cgroup_from_id() kfunc
    https://git.kernel.org/bpf/bpf-next/c/332ea1f697be
  - [v2,2/2,bpf-next] selftests/bpf: Add a test case for bpf_cgroup_from_id()
    https://git.kernel.org/bpf/bpf-next/c/d0093aaefa35

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


