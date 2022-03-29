Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D01A4EA578
	for <lists+bpf@lfdr.de>; Tue, 29 Mar 2022 04:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbiC2Cv4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Mar 2022 22:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiC2Cvy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Mar 2022 22:51:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4D21B0BFA;
        Mon, 28 Mar 2022 19:50:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8474961331;
        Tue, 29 Mar 2022 02:50:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D2981C340F3;
        Tue, 29 Mar 2022 02:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648522211;
        bh=VFNVDTJ88SUpJ6Zwq7mqd7EHeXLrQ/aFLmwE8fbPIoY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Wiv+6vWDp7qX8bzfacwID+uNFwJHaNdMAJt/Ohnc8ju0QIdFFy/BrZVkWWMrCDRCC
         1Xi+QY+z+WcoLnp/PPEyaHCC/Erqed26StqL6H8xiszgXD9FiRHrEy20rPMJQwuD/5
         X05OstagM9aAFCwbcl5ZBWBN+iT4H2Gc8rWJ8hnD3OQJn61Y+oeg1Hzo7KxwPUQl84
         JH3CR1hXMORW5efTx65bq6d0HxJB6JLZsKJq5XSOGaQh4aB6BBaNMgLO19d0IZE5K6
         6fVC49d9+mUFId2If0XznpVDQo2+UYuHl09vZisHQyBBHOoW3PemNNX+j582HeGu+P
         E49rA+3USGvdQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B46A5E7BB0B;
        Tue, 29 Mar 2022 02:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/4] kprobes: rethook: x86: Replace kretprobe
 trampoline with rethook
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164852221173.18072.2644155030177980593.git-patchwork-notify@kernel.org>
Date:   Tue, 29 Mar 2022 02:50:11 +0000
References: <164826160914.2455864.505359679001055158.stgit@devnote2>
In-Reply-To: <164826160914.2455864.505359679001055158.stgit@devnote2>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     ast@kernel.org, andrii.nakryiko@gmail.com, x86@kernel.org,
        peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com,
        dan.carpenter@oracle.com, kernel-janitors@vger.kernel.org,
        rostedt@goodmis.org, jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 26 Mar 2022 11:26:49 +0900 you wrote:
> Hi,
> 
> Here are the 3rd version for generic kretprobe and kretprobe on x86 for
> replacing the kretprobe trampoline with rethook. The previous version
> is here[1]
> 
> [1] https://lore.kernel.org/all/164821817332.2373735.12048266953420821089.stgit@devnote2/T/#u
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/4] kprobes: Use rethook for kretprobe if possible
    https://git.kernel.org/bpf/bpf/c/73f9b911faa7
  - [bpf-next,v3,2/4] x86,rethook,kprobes: Replace kretprobe with rethook on x86
    https://git.kernel.org/bpf/bpf/c/f3a112c0c40d
  - [bpf-next,v3,3/4] x86,rethook: Fix arch_rethook_trampoline() to generate a complete pt_regs
    https://git.kernel.org/bpf/bpf/c/0ef6f5c09371
  - [bpf-next,v3,4/4] x86,kprobes: Fix optprobe trampoline to generate complete pt_regs
    https://git.kernel.org/bpf/bpf/c/45c23bf4d1a4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


