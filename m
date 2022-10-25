Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCA460D276
	for <lists+bpf@lfdr.de>; Tue, 25 Oct 2022 19:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbiJYRa0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Oct 2022 13:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbiJYRaZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Oct 2022 13:30:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BC79DDAB
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 10:30:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E4148B81E51
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 17:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8907EC433D7;
        Tue, 25 Oct 2022 17:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666719020;
        bh=KOxGILVyUKK0Okuxtqn6u4l0bpfkXQIdHqoqllxzCBE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Y3eWDylmv5Tc0H1BHMR9LldJzlsgu4BSLcNGB/dhosrW9gDNZ67tBHmlqNdozI+m9
         peXWxTn99KYARFn78YKrukdq1edTVAtYEyCYvH6iSRnTksQihp6VunJQ+ZjNYc5JRa
         ym5v48NeZks3We21bNOuhhKt/8KzxWVERX/pDXbvZyVB96u5c6Vc3zMkQJ+F75fUiX
         2baffI7a1J3CkgA8V8Hf2mAgs40VnuphLoIl3wzwWPhTcdy1Ft5Cukx036ZQQjWf6W
         lSudKMOiMeJuSPOzAxAZiGYuTrdEGVagaMUklvAPxChXRQTBg23FxFPxL5K9HDLDKN
         Rjd6HuoxfWhiQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6EDEEE270DE;
        Tue, 25 Oct 2022 17:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv3 bpf-next 0/8] bpf: Fixes for kprobe multi on kernel modules
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166671902044.11420.15052398788909717790.git-patchwork-notify@kernel.org>
Date:   Tue, 25 Oct 2022 17:30:20 +0000
References: <20221025134148.3300700-1-jolsa@kernel.org>
In-Reply-To: <20221025134148.3300700-1-jolsa@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        bpf@vger.kernel.org, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@chromium.org,
        sdf@google.com, haoluo@google.com, hch@lst.de, mhiramat@kernel.org,
        m@lambda.lt
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Tue, 25 Oct 2022 15:41:40 +0200 you wrote:
> hi,
> Martynas reported kprobe _multi link does not resolve symbols
> from kernel modules, which attach by address works.
> 
> In addition while fixing that I realized we do not take module
> reference if the module has kprobe_multi link on top of it and
> can be removed.
> 
> [...]

Here is the summary with links:
  - [PATCHv3,bpf-next,1/8] kallsyms: Make module_kallsyms_on_each_symbol generally available
    https://git.kernel.org/bpf/bpf-next/c/73feb8d5fa3b
  - [PATCHv3,bpf-next,2/8] ftrace: Add support to resolve module symbols in ftrace_lookup_symbols
    https://git.kernel.org/bpf/bpf-next/c/3640bf8584f4
  - [PATCHv3,bpf-next,3/8] bpf: Rename __bpf_kprobe_multi_cookie_cmp to bpf_kprobe_multi_addrs_cmp
    https://git.kernel.org/bpf/bpf-next/c/1a1b0716d36d
  - [PATCHv3,bpf-next,4/8] bpf: Take module reference on kprobe_multi link
    https://git.kernel.org/bpf/bpf-next/c/e22061b2d309
  - [PATCHv3,bpf-next,5/8] selftests/bpf: Add load_kallsyms_refresh function
    https://git.kernel.org/bpf/bpf-next/c/10705b2b7a8e
  - [PATCHv3,bpf-next,6/8] selftests/bpf: Add bpf_testmod_fentry_* functions
    https://git.kernel.org/bpf/bpf-next/c/fee356ede980
  - [PATCHv3,bpf-next,7/8] selftests/bpf: Add kprobe_multi check to module attach test
    https://git.kernel.org/bpf/bpf-next/c/e697d8dcebd2
  - [PATCHv3,bpf-next,8/8] selftests/bpf: Add kprobe_multi kmod attach api tests
    https://git.kernel.org/bpf/bpf-next/c/b2440443a64f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


