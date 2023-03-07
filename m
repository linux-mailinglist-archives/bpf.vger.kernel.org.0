Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 671ED6AE5C3
	for <lists+bpf@lfdr.de>; Tue,  7 Mar 2023 17:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbjCGQDE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Mar 2023 11:03:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbjCGQCn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Mar 2023 11:02:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81519AA08;
        Tue,  7 Mar 2023 08:00:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 496F5B81929;
        Tue,  7 Mar 2023 16:00:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EEBFBC433D2;
        Tue,  7 Mar 2023 16:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678204819;
        bh=gxm0l3mSjzr0MUO4bkvTPkm5kKjBdTIob0I0BBX1z/0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=PASVappLx5cSXEFAFKUaawNvcR52njMk/PY6qHm3yOFaEBWqUFVpROHx52TFhF8ck
         lY3tZc0gEqz37FjH1mfZZA3A/+8ZVLUTX3tHXlgDSkWUSORKaJ0IlMRPL8vPEIu/Eh
         /kPqS3riDhLTElrsQW9gUYAk2bR0SG/NADY1auYE+cHEFDlViO+wr5MnGYVij9Ubxm
         lu1LtkPEkaP3EWg8yGJNSqdVIb07XAOLPjzNwcSmCvvgxsum38c1mk/z3yOCgpvoyN
         GHi86CCep2vkqo6ND+oGrqkTDmHeUp/cUl5hRKb++5pRslx6+uEwpor9S2qwA98w7L
         ZbvWK4Wh/BaeA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BF266E61B63;
        Tue,  7 Mar 2023 16:00:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Increase size of BTF_ID_LIST without
 CONFIG_DEBUG_INFO_BTF again
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167820481876.4140.8715511443190797476.git-patchwork-notify@kernel.org>
Date:   Tue, 07 Mar 2023 16:00:18 +0000
References: <20230307-bpf-kfuncs-warray-bounds-v1-1-00ad3191f3a6@kernel.org>
In-Reply-To: <20230307-bpf-kfuncs-warray-bounds-v1-1-00ad3191f3a6@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, ndesaulniers@google.com,
        trix@redhat.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, patches@lists.linux.dev
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 07 Mar 2023 08:14:06 -0700 you wrote:
> After commit 66e3a13e7c2c ("bpf: Add bpf_dynptr_slice and
> bpf_dynptr_slice_rdwr"), clang builds without CONFIG_DEBUG_INFO_BTF
> warn:
> 
>   kernel/bpf/verifier.c:10298:24: warning: array index 16 is past the end of the array (that has type 'u32[16]' (aka 'unsigned int[16]')) [-Warray-bounds]
>                                      meta.func_id == special_kfunc_list[KF_bpf_dynptr_slice_rdwr]) {
>                                                      ^                  ~~~~~~~~~~~~~~~~~~~~~~~~
>   kernel/bpf/verifier.c:9150:1: note: array 'special_kfunc_list' declared here
>   BTF_ID_LIST(special_kfunc_list)
>   ^
>   include/linux/btf_ids.h:207:27: note: expanded from macro 'BTF_ID_LIST'
>   #define BTF_ID_LIST(name) static u32 __maybe_unused name[16];
>                             ^
>   1 warning generated.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Increase size of BTF_ID_LIST without CONFIG_DEBUG_INFO_BTF again
    https://git.kernel.org/bpf/bpf-next/c/2d5bcdcda879

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


