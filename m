Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9FD57BDEF
	for <lists+bpf@lfdr.de>; Wed, 20 Jul 2022 20:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbiGTSkQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Jul 2022 14:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiGTSkP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Jul 2022 14:40:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8EE2E027
        for <bpf@vger.kernel.org>; Wed, 20 Jul 2022 11:40:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F2616195A
        for <bpf@vger.kernel.org>; Wed, 20 Jul 2022 18:40:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B5AFBC341C7;
        Wed, 20 Jul 2022 18:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658342413;
        bh=j17jrwufvErsSn2QeiD+aogMt7cq9EfoIJkVG7eDHiM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=aumAtLOorK4e/lhpN7brZGhd0IbQedfIFipXc3UbeKTRMJgjK7vAQVc8D/kVqEYPI
         RltkWN56ZqD9wHeS4xb/xbkD3EtABKjYBuP4ldjBf2jblBm4/sMj9CF5GLNdtlqzyj
         vmFz7P7c37BCh40G5JmCEqwYO/EofbuRNGzzlMnGDIuAwIo7MwIPlSmilkfWMzRkKW
         gSyLRb8ZaQanFGECfzKyRRnSQ8avUHxGDGU15PWXkvciCxDtyC/slKE1h61XeIR8KH
         dqf6Vjbh7UcEzTBKeIUQTj7Ewr6Ct7o6ms/Te9h08b1o9BJBdNQvCP31fXgDUIXu7+
         tp5BtjDztxAuQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9DD15E451BA;
        Wed, 20 Jul 2022 18:40:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] bpf: fix bpf_trampoline_{,un}link_cgroup_shim
 ifdef guards
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165834241364.19703.7279176048763775789.git-patchwork-notify@kernel.org>
Date:   Wed, 20 Jul 2022 18:40:13 +0000
References: <20220720155220.4087433-1-sdf@google.com>
In-Reply-To: <20220720155220.4087433-1-sdf@google.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org, sfr@canb.auug.org.au
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed, 20 Jul 2022 08:52:20 -0700 you wrote:
> They were updated in kernel/bpf/trampoline.c to fix another build
> issue. We should to do the same for include/linux/bpf.h header.
> 
> v2:
> - Martin: bpf_trampoline_link_cgroup_shim should be fixed as well
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Fixes: 3908fcddc65d ("bpf: fix lsm_cgroup build errors on esoteric configs")
> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] bpf: fix bpf_trampoline_{,un}link_cgroup_shim ifdef guards
    https://git.kernel.org/bpf/bpf-next/c/9cb61fda8c71

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


