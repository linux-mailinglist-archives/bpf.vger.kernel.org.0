Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C78224E339D
	for <lists+bpf@lfdr.de>; Mon, 21 Mar 2022 23:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbiCUW5n (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Mar 2022 18:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbiCUW5a (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Mar 2022 18:57:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A6047FC07
        for <bpf@vger.kernel.org>; Mon, 21 Mar 2022 15:37:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 94C5E612AC
        for <bpf@vger.kernel.org>; Mon, 21 Mar 2022 21:50:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F17D1C340EE;
        Mon, 21 Mar 2022 21:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647899411;
        bh=h3un91uY7Om9yGJP/5UalJ7CphAkPzNemFDa21m4Amw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=WymNJb114YQyK1qjZwtafdqbqZ5FbPnxlwl/0OP+ZJ6/xGGtNIFTkzwMZewDjo4Qv
         alMwiw9xoX/0t/zE+UxYcova00/dD2NZW7M+yehgWy6rgSmGuJlL3bkamh026LS7eE
         wHzXSWKyEvbxxKvbSb2hEvwo4bAoYNC1DqXPmo9FBaoDgKETA6DCjSV9cHUqsw+ix6
         zkgeUfaVNNSq8pX0p82nJr4TCl1G8ICOaSssUddQ2XSoqZ48VrjqNUTZU3OSxfclWq
         22lZg+WzaVHsxH914AaANZQjYjDmSIOuWuVCMGKPkfdD7w6C2XPK7hFqcln39b1SnN
         qDSeubDxHVyPg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D5ADEEAC096;
        Mon, 21 Mar 2022 21:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpftool: fix a bug in subskeleton code generation
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164789941087.5210.5420849441093302224.git-patchwork-notify@kernel.org>
Date:   Mon, 21 Mar 2022 21:50:10 +0000
References: <20220320032009.3106133-1-yhs@fb.com>
In-Reply-To: <20220320032009.3106133-1-yhs@fb.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, delyank@fb.com
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Sat, 19 Mar 2022 20:20:09 -0700 you wrote:
> Compiled with clang by adding LLVM=1 both kernel and selftests/bpf
> build, I hit the following compilation error:
> 
> In file included from /.../tools/testing/selftests/bpf/prog_tests/subskeleton.c:6:
>   ./test_subskeleton_lib.subskel.h:168:6: error: variable 'err' is used uninitialized whenever
>       'if' condition is true [-Werror,-Wsometimes-uninitialized]
>           if (!s->progs)
>               ^~~~~~~~~
>   ./test_subskeleton_lib.subskel.h:181:11: note: uninitialized use occurs here
>           errno = -err;
>                    ^~~
>   ./test_subskeleton_lib.subskel.h:168:2: note: remove the 'if' if its condition is always false
>           if (!s->progs)
>           ^~~~~~~~~~~~~~
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpftool: fix a bug in subskeleton code generation
    https://git.kernel.org/bpf/bpf-next/c/f97b8b9bd630

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


