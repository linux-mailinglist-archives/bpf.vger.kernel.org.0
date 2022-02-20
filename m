Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F664BCB6B
	for <lists+bpf@lfdr.de>; Sun, 20 Feb 2022 01:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237651AbiBTAua (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 19 Feb 2022 19:50:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbiBTAu3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 19 Feb 2022 19:50:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E13047059
        for <bpf@vger.kernel.org>; Sat, 19 Feb 2022 16:50:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A135F60F19
        for <bpf@vger.kernel.org>; Sun, 20 Feb 2022 00:50:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 12590C340EB;
        Sun, 20 Feb 2022 00:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645318209;
        bh=Bnk2t/rKHbfCow0IWELETi1YJBJDBE6/Iv4lPeoMrpE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=md4lba/dYoalSl6dqC7y7JEcjTesLhT+7RNDejuQBbcV89Dsr+ObuhJWTwl1yvnGY
         ddfVauPdtjdWYN29nJ71sUuflCL8xTpor+nIUe36hcAyest6YRX48ilQ7Il2cFLdhm
         IHIViWRHDwxKVWjx3QAm7sz72LTKu8ERV+c5+R6PiWfDElW5nnC6qDl6tJ2QZxfDn4
         83giF6pxhA5R+F80I9H4Qp5ozQcz/WV9qXVIfnEdktHFGNZYw6ASqc7b9O/wGwaAys
         r1Tk4213sqj3lB3Gu2+IYiW3zzqm0Ni9792ECs3ApPpH1MgKOVJQ1iPLCN53TNj6HC
         XOLvg9WHU1e/A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F03A0E7BB0C;
        Sun, 20 Feb 2022 00:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: fix a clang deprecated-declarations
 compilation error
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164531820898.13036.943833614769953266.git-patchwork-notify@kernel.org>
Date:   Sun, 20 Feb 2022 00:50:08 +0000
References: <20220217194005.2765348-1-yhs@fb.com>
In-Reply-To: <20220217194005.2765348-1-yhs@fb.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Thu, 17 Feb 2022 11:40:05 -0800 you wrote:
> Build the kernel and selftest with clang compiler with LLVM=1,
>   make -j LLVM=1
>   make -C tools/testing/selftests/bpf -j LLVM=1
> 
> I hit the following selftests/bpf compilation error:
>   In file included from test_cpp.cpp:3:
>   /.../tools/testing/selftests/bpf/tools/include/bpf/libbpf.h:73:8:
>     error: 'relaxed_core_relocs' is deprecated: libbpf v0.6+: field has no effect [-Werror,-Wdeprecated-declarations]
>   struct bpf_object_open_opts {
>          ^
>   test_cpp.cpp:56:2: note: in implicit move constructor for 'bpf_object_open_opts' first required here
>           LIBBPF_OPTS(bpf_object_open_opts, opts);
>           ^
>   /.../tools/testing/selftests/bpf/tools/include/bpf/libbpf_common.h:77:3: note: expanded from macro 'LIBBPF_OPTS'
>                   (struct TYPE) {                                             \
>                   ^
>   /.../tools/testing/selftests/bpf/tools/include/bpf/libbpf.h:90:2: note: 'relaxed_core_relocs' has been explicitly marked deprecated here
>           LIBBPF_DEPRECATED_SINCE(0, 6, "field has no effect")
>           ^
>   /.../tools/testing/selftests/bpf/tools/include/bpf/libbpf_common.h:24:4: note: expanded from macro 'LIBBPF_DEPRECATED_SINCE'
>                   (LIBBPF_DEPRECATED("libbpf v" # major "." # minor "+: " msg))
>                    ^
>   /.../tools/testing/selftests/bpf/tools/include/bpf/libbpf_common.h:19:47: note: expanded from macro 'LIBBPF_DEPRECATED'
>   #define LIBBPF_DEPRECATED(msg) __attribute__((deprecated(msg)))
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: fix a clang deprecated-declarations compilation error
    https://git.kernel.org/bpf/bpf-next/c/a33c0c792d0a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


