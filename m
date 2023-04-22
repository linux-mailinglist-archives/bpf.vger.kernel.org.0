Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D1F6EB9FE
	for <lists+bpf@lfdr.de>; Sat, 22 Apr 2023 17:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjDVPaW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 22 Apr 2023 11:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjDVPaV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 22 Apr 2023 11:30:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C18C1719
        for <bpf@vger.kernel.org>; Sat, 22 Apr 2023 08:30:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7F4A60B86
        for <bpf@vger.kernel.org>; Sat, 22 Apr 2023 15:30:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1C759C433EF;
        Sat, 22 Apr 2023 15:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682177418;
        bh=uL+cSFvQjUEaLaeoM7EgLYsBxzs6ta8imoBEZTOA+SI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=n01cPgCHLn3cxdgwIM4KcwKYWf0MPNL6rL1NvJ1xmhqxUk7Ggmgq3YTz6eNv65n6/
         EQ17q1GmM9WiurX8z5qE0DZkRinxMlzHIBzgZfALgXCMkQybkBmMFJ/MHyEHOw+BoQ
         MN54tTkYw5EsDiIzRuaO+mZszI9OBKb1KPscLuQZyUM8NH7dlqGM8Ux1XUOBye+xHJ
         xihrYevCk2qFjkriClqgF1Ljct4kNP955TWo1/vqHwRIPEMHIi7g+rEU8f83EXPnx4
         d/NaHV1qU4FOKezQ1Ypbnv8cda5N8qJk+tCEqY/OJ0qptVBBScr9+1CuwOhBJKQhnM
         v2e0GEMDWCD9w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EFD35E270E0;
        Sat, 22 Apr 2023 15:30:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: fix link failure with NETFILTER=y INET=n
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168217741797.18670.3455015121063652515.git-patchwork-notify@kernel.org>
Date:   Sat, 22 Apr 2023 15:30:17 +0000
References: <20230422073544.17634-1-fw@strlen.de>
In-Reply-To: <20230422073544.17634-1-fw@strlen.de>
To:     Florian Westphal <fw@strlen.de>
Cc:     bpf@vger.kernel.org, ast@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 22 Apr 2023 09:35:44 +0200 you wrote:
> Explicitly check if NETFILTER_BPF_LINK is enabled, else configs
> that have NETFILTER=y but CONFIG_INET=n fail to link:
> 
> > kernel/bpf/syscall.o: undefined reference to `netfilter_prog_ops'
> > kernel/bpf/verifier.o: undefined reference to `netfilter_verifier_ops'
> 
> Fixes: fd9c663b9ad6 ("bpf: minimal support for programs hooked into netfilter framework")
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/oe-kbuild-all/202304220903.fRZTJtxe-lkp@intel.com/
> Signed-off-by: Florian Westphal <fw@strlen.de>
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: fix link failure with NETFILTER=y INET=n
    https://git.kernel.org/bpf/bpf-next/c/6d26d985eeda

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


