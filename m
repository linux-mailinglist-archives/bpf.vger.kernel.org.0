Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DAE45E57F2
	for <lists+bpf@lfdr.de>; Thu, 22 Sep 2022 03:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiIVBUU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Sep 2022 21:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiIVBUQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Sep 2022 21:20:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A7691D14
        for <bpf@vger.kernel.org>; Wed, 21 Sep 2022 18:20:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A350960E9B
        for <bpf@vger.kernel.org>; Thu, 22 Sep 2022 01:20:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F0BAFC433D7;
        Thu, 22 Sep 2022 01:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663809615;
        bh=vutIcPb6IP0uMx0vYhr3Bamw+nH0I6g/akUUpFBRe/8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=XaFMco6J3C1ET1xRrWlybL+adW0sCTbtUu8bB+vgL22BTgJNwk/B2odBzcF7/WxRj
         WKFt4JJb6x51r+gtHLjQmweiMTrH+gfj132YdZ2YVoA/hJFyeLCEKZBJ0sB0xQJxiw
         zPbDcOi1q+qw1lGgRnTOj2jJlPmq15qVDwN+hvEFCIj+XDAwK2S+Lc+qEiW7yM6w1F
         CwCF3Otjsgu5iIQZpojIR1R4uLKH2NublJ7KUhY4niXo6i/C/LXjPAtcEKwwDj0WYS
         3PT8cEnjIcMcDI4TGxsaLktwxb6HnY1TN60fh74zmg4pwD0ZxqX7dBEACcPl4deiPl
         qTVEGDTYEXISA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CBDA9E4D03D;
        Thu, 22 Sep 2022 01:20:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv2 bpf-next] bpf: Prevent bpf program recursion for raw
 tracepoint probes
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166380961483.28833.1573067698902385305.git-patchwork-notify@kernel.org>
Date:   Thu, 22 Sep 2022 01:20:14 +0000
References: <20220916071914.7156-1-jolsa@kernel.org>
In-Reply-To: <20220916071914.7156-1-jolsa@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        sdf@google.com,
        syzbot+2251879aa068ad9c960d@syzkaller.appspotmail.com,
        bpf@vger.kernel.org, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@chromium.org,
        haoluo@google.com
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
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 16 Sep 2022 09:19:14 +0200 you wrote:
> We got report from sysbot [1] about warnings that were caused by
> bpf program attached to contention_begin raw tracepoint triggering
> the same tracepoint by using bpf_trace_printk helper that takes
> trace_printk_lock lock.
> 
>  Call Trace:
>   <TASK>
>   ? trace_event_raw_event_bpf_trace_printk+0x5f/0x90
>   bpf_trace_printk+0x2b/0xe0
>   bpf_prog_a9aec6167c091eef_prog+0x1f/0x24
>   bpf_trace_run2+0x26/0x90
>   native_queued_spin_lock_slowpath+0x1c6/0x2b0
>   _raw_spin_lock_irqsave+0x44/0x50
>   bpf_trace_printk+0x3f/0xe0
>   bpf_prog_a9aec6167c091eef_prog+0x1f/0x24
>   bpf_trace_run2+0x26/0x90
>   native_queued_spin_lock_slowpath+0x1c6/0x2b0
>   _raw_spin_lock_irqsave+0x44/0x50
>   bpf_trace_printk+0x3f/0xe0
>   bpf_prog_a9aec6167c091eef_prog+0x1f/0x24
>   bpf_trace_run2+0x26/0x90
>   native_queued_spin_lock_slowpath+0x1c6/0x2b0
>   _raw_spin_lock_irqsave+0x44/0x50
>   bpf_trace_printk+0x3f/0xe0
>   bpf_prog_a9aec6167c091eef_prog+0x1f/0x24
>   bpf_trace_run2+0x26/0x90
>   native_queued_spin_lock_slowpath+0x1c6/0x2b0
>   _raw_spin_lock_irqsave+0x44/0x50
>   __unfreeze_partials+0x5b/0x160
>   ...
> 
> [...]

Here is the summary with links:
  - [PATCHv2,bpf-next] bpf: Prevent bpf program recursion for raw tracepoint probes
    https://git.kernel.org/bpf/bpf-next/c/05b24ff9b2cf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


