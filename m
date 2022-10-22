Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC3E60839A
	for <lists+bpf@lfdr.de>; Sat, 22 Oct 2022 04:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbiJVCa3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Oct 2022 22:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiJVCa2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Oct 2022 22:30:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171DEE52C2
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 19:30:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E3F13B82DC6
        for <bpf@vger.kernel.org>; Sat, 22 Oct 2022 02:30:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7D257C43470;
        Sat, 22 Oct 2022 02:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666405818;
        bh=2FqBDc62ehdA4UbGPIfIf7FPHGSk1ov68bzGPAfqSVg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=DCClv3z/HVL5zgBWrNgQG6B6hldx1blSoKz2qeDSP+Edw/Sh/IZ0nOLQ0/y2A5aMN
         GId/P+YkdrXzdTmN1brB4ERDwSg7RTFOz20Bkbb2llnI4qi1+HalsZYLSUut/sJWTp
         fRN0n44+a3UJFWwsvao4E7MPTmnuU4dKBgZS+S0UavUdQ/SypbBjmUZ3Zt+7KOmEF0
         eYHwoLIapeYbJegRFnD9bpFk5uBtJ6xS2wJkwIFB28WzL14dB4Jquqr5u6TbO5urKJ
         /1CON+SH6QtYebku92zSnvKQzL0s1h1cyupCB+bveeC9fzJh2CRCmO5GM8+x5kvWnb
         q72wOUuQ0uraw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 518DCE270E0;
        Sat, 22 Oct 2022 02:30:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2 0/2] Wait for busy refill_work when destroying bpf
 memory allocator
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166640581830.9082.444322122307473295.git-patchwork-notify@kernel.org>
Date:   Sat, 22 Oct 2022 02:30:18 +0000
References: <20221021114913.60508-1-houtao@huaweicloud.com>
In-Reply-To: <20221021114913.60508-1-houtao@huaweicloud.com>
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, sdf@google.com,
        martin.lau@linux.dev, andrii@kernel.org, song@kernel.org,
        haoluo@google.com, yhs@fb.com, daniel@iogearbox.net,
        kpsingh@kernel.org, jolsa@kernel.org, john.fastabend@gmail.com,
        houtao1@huawei.com
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 21 Oct 2022 19:49:11 +0800 you wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> Hi,
> 
> The patchset aims to fix one problem of bpf memory allocator destruction
> when there is PREEMPT_RT kernel or kernel with arch_irq_work_has_interrupt()
> being false (e.g. 1-cpu arm32 host or mips). The root cause is that
> there may be busy refill_work when the allocator is destroying and it
> may incur oops or other problems as shown in patch #1. Patch #1 fixes
> the problem by waiting for the completion of irq work during destroying
> and patch #2 is just a clean-up patch based on patch #1. Please see
> individual patches for more details.
> 
> [...]

Here is the summary with links:
  - [bpf,v2,1/2] bpf: Wait for busy refill_work when destroying bpf memory allocator
    https://git.kernel.org/bpf/bpf/c/3d05818707bb
  - [bpf,v2,2/2] bpf: Use __llist_del_all() whenever possbile during memory draining
    https://git.kernel.org/bpf/bpf/c/fa4447cb73b2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


