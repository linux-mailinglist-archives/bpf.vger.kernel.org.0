Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C529E65C34D
	for <lists+bpf@lfdr.de>; Tue,  3 Jan 2023 16:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbjACPux (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Jan 2023 10:50:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjACPuT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Jan 2023 10:50:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8269E12603
        for <bpf@vger.kernel.org>; Tue,  3 Jan 2023 07:50:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CE536122A
        for <bpf@vger.kernel.org>; Tue,  3 Jan 2023 15:50:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 796F4C433D2;
        Tue,  3 Jan 2023 15:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672761017;
        bh=f0fQTmiIay/WtctHZda1jjvXhFgwVvEcZYZA9R+/WqA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ZCMe0K1i4SUHlAW0gSGU0UMJZfTavFHkdX+SwbaLnDmfSvVA/kxP0BrrsDSS38rXd
         lfovnXtXBnme1shYK0iGYZVsDtU6EdQcB7Eeev4RImViku4eQGXzW45ykni3MR3rxn
         ZTtkzrmXjLFSPtQcX1XtGOTD8g7z0x2YjD6b7OeVRTt2bnM78fzI5hF85bZDah/rx2
         vm1xrvJtbLQsxU8KgqFcG7rnXr0mHJZZe8JIH6FIDm7Z7QdzS3XMiJv4FJHK1Zq0Fr
         Gpbq0COL9sQkxTIcdGcT8s4aHekEWAgHD+k+RD5ES7A3N1FLFvJHi8aXnUlfyBk+bg
         G6jbnaiMOfTXA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5F760E5724D;
        Tue,  3 Jan 2023 15:50:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: Add LoongArch support to bpf_tracing.h
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167276101738.20921.8564438436207074197.git-patchwork-notify@kernel.org>
Date:   Tue, 03 Jan 2023 15:50:17 +0000
References: <20221231100757.3177034-1-hengqi.chen@gmail.com>
In-Reply-To: <20221231100757.3177034-1-hengqi.chen@gmail.com>
To:     Hengqi Chen <hengqi.chen@gmail.com>
Cc:     bpf@vger.kernel.org, loongarch@lists.linux.dev, andrii@kernel.org
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
by Daniel Borkmann <daniel@iogearbox.net>:

On Sat, 31 Dec 2022 18:07:57 +0800 you wrote:
> Add PT_REGS macros for LoongArch ([0]).
> 
>   [0]: https://loongson.github.io/LoongArch-Documentation/LoongArch-ELF-ABI-EN.html
> 
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---
>  tools/lib/bpf/bpf_tracing.h | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> [...]

Here is the summary with links:
  - [bpf-next] libbpf: Add LoongArch support to bpf_tracing.h
    https://git.kernel.org/bpf/bpf-next/c/00883922ab40

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


