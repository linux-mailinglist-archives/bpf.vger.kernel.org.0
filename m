Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A1464C232
	for <lists+bpf@lfdr.de>; Wed, 14 Dec 2022 03:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236997AbiLNCUT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Dec 2022 21:20:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236726AbiLNCUT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Dec 2022 21:20:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C266022514;
        Tue, 13 Dec 2022 18:20:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5CF2A617A4;
        Wed, 14 Dec 2022 02:20:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9D2C1C433F0;
        Wed, 14 Dec 2022 02:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670984416;
        bh=e34cddoHsQG2CptMJkGyXAL9/ccpbDs2SG/xGx1evik=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=pLQv8sqOy+mc9hIQDVLgsTNkCSHgVXYCQzlIMUc9K2hKlmpa47sqpCtrUQNc1zSg+
         VkHm5RO/T9VkNrJ1HvNYGSyWcODzuTvJlIJsevrCBT5GlDzwQecM5aem2r35p/+UN9
         WR2HG232KaxGPUN6VICsKG3hmlysRgzF1UtAxsTKcD6gFQVyPD5oESt4z8GIoALPoB
         5kOPRF2mt3cBgvYNZ9vOGmC2tYp0yzY3D9y+iPW2i+90yVzz8ZMFc3iNlICN4FettM
         LC3xUjMDePI/eVjd7ro2LXHAvtbJM8DyW132GbnloHiz51SpU0vzQJoIpQTLJIh6Nj
         tVSXCOruOEwaw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 80955E4D02A;
        Wed, 14 Dec 2022 02:20:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: prevent leak of lsm program after failed attach
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167098441652.18507.17827174898852419883.git-patchwork-notify@kernel.org>
Date:   Wed, 14 Dec 2022 02:20:16 +0000
References: <20221213175714.31963-1-milan@mdaverde.com>
In-Reply-To: <20221213175714.31963-1-milan@mdaverde.com>
To:     Milan Landaverde <milan@mdaverde.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Tue, 13 Dec 2022 12:57:14 -0500 you wrote:
> In [0], we added the ability to bpf_prog_attach LSM programs to cgroups,
> but in our validation to make sure the prog is meant to be attached to
> BPF_LSM_CGROUP, we return too early if the check fails. This results in
> lack of decrementing prog's refcnt (through bpf_prog_put)
> leaving the LSM program alive past the point of the expected lifecycle.
> This fix allows for the decrement to take place.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: prevent leak of lsm program after failed attach
    https://git.kernel.org/bpf/bpf-next/c/2958c237fd1e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


