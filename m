Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5915EB8EA
	for <lists+bpf@lfdr.de>; Tue, 27 Sep 2022 05:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiI0DkW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Sep 2022 23:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiI0DkV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Sep 2022 23:40:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9F6B481
        for <bpf@vger.kernel.org>; Mon, 26 Sep 2022 20:40:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 571F7B81910
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 03:40:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 026D1C433D7;
        Tue, 27 Sep 2022 03:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664250017;
        bh=YSujMgLLiqZMlEdyrTa/oPA3HvTtFKbOo/q8kV9WsKE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=OXjslswFWpCK9XE78hD3f/ubWHJ/xvMJAUHZmbIXdRClEAUn+LJgqHpQANPfQaPhW
         ohjFfz8Q8Bm8iXFqDwCoeptPtg7wfIKYZhSuLt4HTVj1jk6ghEN8Ahg3JMRKv6Icn0
         V/r6g0o0qIIf+Mv/fqcFiIPo58ANNi5xxk+I+dIb6etev35eYKbudEaPMvCI6jKkjj
         8zMFDUjqf4SmrRL18O0mEoOacaSiwI2ePTVunfGibSPBXQiHHNjHaT2L+gNnNNN/N8
         ZYulPpDstQdIaZWXK+6+bN5+YlAQ0oq27GZuBKf8j2AUyhRZOyRDgVEjAHooyMtK7L
         db2ZRB0UFR6xw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D43CEE21EC3;
        Tue, 27 Sep 2022 03:40:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv5 bpf-next 0/6] bpf: Fixes for CONFIG_X86_KERNEL_IBT 
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166425001686.15909.4135024467918166776.git-patchwork-notify@kernel.org>
Date:   Tue, 27 Sep 2022 03:40:16 +0000
References: <20220926153340.1621984-1-jolsa@kernel.org>
In-Reply-To: <20220926153340.1621984-1-jolsa@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        bpf@vger.kernel.org, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@chromium.org,
        sdf@google.com, haoluo@google.com, mhiramat@kernel.org,
        peterz@infradead.org, m@lambda.lt
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Mon, 26 Sep 2022 17:33:34 +0200 you wrote:
> hi,
> Martynas reported bpf_get_func_ip returning +4 address when
> CONFIG_X86_KERNEL_IBT option is enabled and I found there are
> some failing bpf tests when this option is enabled.
> 
> The CONFIG_X86_KERNEL_IBT option adds endbr instruction at the
> function entry, so the idea is to 'fix' entry ip for kprobe_multi
> and trampoline probes, because they are placed on the function
> entry.
> 
> [...]

Here is the summary with links:
  - [PATCHv5,bpf-next,1/6] kprobes: Add new KPROBE_FLAG_ON_FUNC_ENTRY kprobe flag
    https://git.kernel.org/bpf/bpf-next/c/bf7a87f1075f
  - [PATCHv5,bpf-next,2/6] ftrace: Keep the resolved addr in kallsyms_callback
    https://git.kernel.org/bpf/bpf-next/c/9d68c19c57d6
  - [PATCHv5,bpf-next,3/6] bpf: Use given function address for trampoline ip arg
    https://git.kernel.org/bpf/bpf-next/c/4d854f4f31ec
  - [PATCHv5,bpf-next,4/6] bpf: Adjust kprobe_multi entry_ip for CONFIG_X86_KERNEL_IBT
    https://git.kernel.org/bpf/bpf-next/c/c09eb2e578eb
  - [PATCHv5,bpf-next,5/6] bpf: Return value in kprobe get_func_ip only for entry address
    https://git.kernel.org/bpf/bpf-next/c/0e253f7e558a
  - [PATCHv5,bpf-next,6/6] selftests/bpf: Fix get_func_ip offset test for CONFIG_X86_KERNEL_IBT
    https://git.kernel.org/bpf/bpf-next/c/738c345b74b8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


