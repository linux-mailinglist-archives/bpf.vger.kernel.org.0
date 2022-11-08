Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCA7D620478
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 01:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbiKHAKS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Nov 2022 19:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbiKHAKR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 19:10:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E2E1EEC4;
        Mon,  7 Nov 2022 16:10:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DDF28B816E1;
        Tue,  8 Nov 2022 00:10:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 73EF5C433D6;
        Tue,  8 Nov 2022 00:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667866214;
        bh=bsvTLzsa4iK/5C7WBRfnagSX40VyRJDcI44X6EX4oQE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Xuqji6PxCyBrf8O1jUifjcaKom3IrqVdxgAnUCcDDe9jngbv7ZzBtH7JNyJs6KpgA
         mry3hW+oy/P/nGyH4Nh0ADD0kLRpIkiwHLkA0Sei5lFcO1IZpABL7YOV/Q6aAARYxg
         a0GSixDQPIJ+IMmaa++BhpT1rKlizg5gXF9PWYfzM4S+ikGMvlAb8v2o9ulvkgvBqZ
         wMdxW4c5GR4o85qgjFgYJV0EfmPbFgjO84Uy5IiA4eEMvOSDAfYx12qoBbQexeh6LZ
         hQAw1E5MhbWV4f7hqPl4+oYd94yqQw0J/UCVO60a/NeP7yr7faMIYsjl7ou58Q3sl0
         f2wbX5Obx+kJw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5142AC4166D;
        Tue,  8 Nov 2022 00:10:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: Add explicit cast to 'void *' for
 __BPF_DISPATCHER_UPDATE()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166786621432.9069.11483477802170165558.git-patchwork-notify@kernel.org>
Date:   Tue, 08 Nov 2022 00:10:14 +0000
References: <20221107170711.42409-1-nathan@kernel.org>
In-Reply-To: <20221107170711.42409-1-nathan@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        john.fastabend@gmail.com, jolsa@kernel.org, peterz@infradead.org,
        bjorn@kernel.org, ndesaulniers@google.com, trix@redhat.com,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, patches@lists.linux.dev, lkp@intel.com,
        bot@kernelci.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Mon,  7 Nov 2022 10:07:11 -0700 you wrote:
> When building with clang:
> 
>   kernel/bpf/dispatcher.c:126:33: error: pointer type mismatch ('void *' and 'unsigned int (*)(const void *, const struct bpf_insn *, bpf_func_t)' (aka 'unsigned int (*)(const void *, const struct bpf_insn *, unsigned int (*)(const void *, const struct bpf_insn *))')) [-Werror,-Wpointer-type-mismatch]
>           __BPF_DISPATCHER_UPDATE(d, new ?: &bpf_dispatcher_nop_func);
>                                      ~~~ ^  ~~~~~~~~~~~~~~~~~~~~~~~~
>   ./include/linux/bpf.h:1045:54: note: expanded from macro '__BPF_DISPATCHER_UPDATE'
>           __static_call_update((_d)->sc_key, (_d)->sc_tramp, (_new))
>                                                               ^~~~
>   1 error generated.
> 
> [...]

Here is the summary with links:
  - [bpf] bpf: Add explicit cast to 'void *' for __BPF_DISPATCHER_UPDATE()
    https://git.kernel.org/bpf/bpf/c/a679120edfcf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


