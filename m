Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2C9631772
	for <lists+bpf@lfdr.de>; Mon, 21 Nov 2022 01:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiKUAAV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Nov 2022 19:00:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiKUAAU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 20 Nov 2022 19:00:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD95725298
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 16:00:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F80C60CEF
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 00:00:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8FEBEC433D7;
        Mon, 21 Nov 2022 00:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668988818;
        bh=25SUpucP5Bd6XRGRUh4HzNJV3tH+Zlc4wioradydIu8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=sRgJNBS9cnrvuADgLuss4mzQASWYeD+FvGG54dvCyfH1ni80JZbkpgn1qaXf5/Ksp
         0typVqh53N0HE4cmMWrYALXsvzw07lGeyEmZL220HZ6R0WRTBac90pVyXM7HVBq28s
         y/daRs5YRB3/EyUBZRCJoqAg/HwIVhk8cA8mjim2ud9pVH7CnNNVdPnqbIfSTuCVxO
         AByC2+7lWrCtE9YRaUP7WGWVlCpUqP2od/jjPP3ruk7gT22dtxDVbwTbCQxwn4inuS
         k1F+EV+gGNc3ehUu+DC05U92KO3phskTJ5nP1lg6b7lnr3rj1GasLxxY5G6St+/zl3
         jgGjxNrOzQqoA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 67008C395F0;
        Mon, 21 Nov 2022 00:00:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 0/4] bpf: Implement two type cast kfuncs
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166898881841.4374.6902269174324571367.git-patchwork-notify@kernel.org>
Date:   Mon, 21 Nov 2022 00:00:18 +0000
References: <20221120195421.3112414-1-yhs@fb.com>
In-Reply-To: <20221120195421.3112414-1-yhs@fb.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, john.fastabend@gmail.com, kernel-team@fb.com,
        memxor@gmail.com, martin.lau@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Sun, 20 Nov 2022 11:54:21 -0800 you wrote:
> Currenty, a non-tracing bpf program typically has a single 'context' argument
> with predefined uapi struct type. Following these uapi struct, user is able
> to access other fields defined in uapi header. Inside the kernel, the
> user-seen 'context' argument is replaced with 'kernel context' (or 'kctx'
> in short) which can access more information than what uapi header provides.
> To access other info not in uapi header, people typically do two things:
>   (1). extend uapi to access more fields rooted from 'context'.
>   (2). use bpf_probe_read_kernl() helper to read particular field based on
>     kctx.
> Using (1) needs uapi change and using (2) makes code more complex since
> direct memory access is not allowed.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/4] bpf: Add support for kfunc set with common btf_ids
    https://git.kernel.org/bpf/bpf-next/c/cfe1456440c8
  - [bpf-next,v4,2/4] bpf: Add a kfunc to type cast from bpf uapi ctx to kernel ctx
    https://git.kernel.org/bpf/bpf-next/c/fd264ca02094
  - [bpf-next,v4,3/4] bpf: Add a kfunc for generic type cast
    https://git.kernel.org/bpf/bpf-next/c/a35b9af4ec2c
  - [bpf-next,v4,4/4] bpf: Add type cast unit tests
    https://git.kernel.org/bpf/bpf-next/c/58d84bee5846

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


