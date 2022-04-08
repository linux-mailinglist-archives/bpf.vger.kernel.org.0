Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485104F9F8C
	for <lists+bpf@lfdr.de>; Sat,  9 Apr 2022 00:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235397AbiDHWWS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Apr 2022 18:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbiDHWWS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Apr 2022 18:22:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795BEEBBA9
        for <bpf@vger.kernel.org>; Fri,  8 Apr 2022 15:20:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A9A7620E3
        for <bpf@vger.kernel.org>; Fri,  8 Apr 2022 22:20:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 66B33C385A6;
        Fri,  8 Apr 2022 22:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649456412;
        bh=NGb+Xs+/+5lT8E6JDHbzkv5SKBAAvPZ0EmYS+1H7ODU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=imnhuBIoCwhSod28mINY4XcWudCouD3soBkqOZY1x3tjnrTDUEppmd9wzpjTLwNcO
         0S/m9qBaO68k2NK8WGxk8ZCw7GVM8tv6KzLwGsW2LqjFcqn5jWSxC0YXH3eKIp8X1h
         0m3vcnFWlWgN6kc7lfjSV5pRBc4TQiJ5ru/llabAvT3GdFB3M3eEkYYGXULl7wBngV
         dGCOfjl9OCHQczVs/n7rGcTfM4I9wzs80GpyAwSn4WZjUg1c0h2JGOYVlIQt706ajD
         a7jQUSX6Mbk2mX9dIrYhExUQNJZmnrcvIhVzocXXy8iAQAoPQix7GtxmRQCnPraf0p
         GlaMXAJ7IjzkQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4D3F2E8DD5D;
        Fri,  8 Apr 2022 22:20:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] libbpf: add ARC support to bpf_tracing.h
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164945641231.1252.10810225728969757908.git-patchwork-notify@kernel.org>
Date:   Fri, 08 Apr 2022 22:20:12 +0000
References: <20220408153829.582386-1-geomatsi@gmail.com>
In-Reply-To: <20220408153829.582386-1-geomatsi@gmail.com>
To:     Sergey Matyukevich <geomatsi@gmail.com>
Cc:     bpf@vger.kernel.org, isaev@synopsys.com, vgupta@kernel.org
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
by Andrii Nakryiko <andrii@kernel.org>:

On Fri,  8 Apr 2022 18:38:29 +0300 you wrote:
> From: Vladimir Isaev <isaev@synopsys.com>
> 
> Add PT_REGS macros suitable for ARCompact and ARCv2.
> 
> Signed-off-by: Vladimir Isaev <isaev@synopsys.com>
> ---
>  tools/include/uapi/asm/bpf_perf_event.h |  2 ++
>  tools/lib/bpf/bpf_tracing.h             | 23 +++++++++++++++++++++++
>  2 files changed, 25 insertions(+)

Here is the summary with links:
  - libbpf: add ARC support to bpf_tracing.h
    https://git.kernel.org/bpf/bpf-next/c/097caa843fea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


