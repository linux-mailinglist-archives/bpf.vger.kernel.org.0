Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABDC1636C65
	for <lists+bpf@lfdr.de>; Wed, 23 Nov 2022 22:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235409AbiKWVaS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Nov 2022 16:30:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235215AbiKWVaR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Nov 2022 16:30:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C0E9370F
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 13:30:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 719ED61D0B
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 21:30:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB9EFC433D6;
        Wed, 23 Nov 2022 21:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669239015;
        bh=qSjZ99PrPGPCqitcpuJPYMimygZIOv3k6v7kaRXwDVA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=lboBN7f79ZkPcDC1UujBmjUXR34dgmRg/98syuMduJpNyBvPc902JUsnoUPBQ5uCG
         eGuLSIMyYigSuT0CM7W6HNh7OYUwOsxkSAm7+SqfSP9Mqs/DDNTcLaJPrKiENTPvtV
         yHWFMl8/4baqcJl2jx43jo06xSLavZEQZoz2wdjdIISADMllGUo1eKQydVaVC4a00x
         qtKaE6/z3jwd+mABUKfY4wYnKkhNDrPi/6hy5/WUDuyP3jTxGhZo+4ESYIAkHlWNco
         5s+AdywoypJLFSHaMSdP2bv7p52AG9qBGCkENn/CmIJqkhmMRSB8a1Bp7EJBLV4Jmp
         kRDvESM70jxCA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B4995C395C5;
        Wed, 23 Nov 2022 21:30:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Fix a BTF_ID_LIST bug with
 CONFIG_DEBUG_INFO_BTF not set
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166923901573.7482.12330550666164946305.git-patchwork-notify@kernel.org>
Date:   Wed, 23 Nov 2022 21:30:15 +0000
References: <20221123155759.2669749-1-yhs@fb.com>
In-Reply-To: <20221123155759.2669749-1-yhs@fb.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org,
        lkp@intel.com, error27@gmail.com, nathan@kernel.org
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

On Wed, 23 Nov 2022 07:57:59 -0800 you wrote:
> With CONFIG_DEBUG_INFO_BTF not set, we hit the following compilation error,
>   /.../kernel/bpf/verifier.c:8196:23: error: array index 6 is past the end of the array
>   (that has type 'u32[5]' (aka 'unsigned int[5]')) [-Werror,-Warray-bounds]
>         if (meta->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx])
>                              ^                  ~~~~~~~~~~~~~~~~~~~~~~~
>   /.../kernel/bpf/verifier.c:8174:1: note: array 'special_kfunc_list' declared here
>   BTF_ID_LIST(special_kfunc_list)
>   ^
>   /.../include/linux/btf_ids.h:207:27: note: expanded from macro 'BTF_ID_LIST'
>   #define BTF_ID_LIST(name) static u32 __maybe_unused name[5];
>                             ^
>   /.../kernel/bpf/verifier.c:8443:19: error: array index 5 is past the end of the array
>   (that has type 'u32[5]' (aka 'unsigned int[5]')) [-Werror,-Warray-bounds]
>                  btf_id == special_kfunc_list[KF_bpf_list_pop_back];
>                            ^                  ~~~~~~~~~~~~~~~~~~~~
>   /.../kernel/bpf/verifier.c:8174:1: note: array 'special_kfunc_list' declared here
>   BTF_ID_LIST(special_kfunc_list)
>   ^
>   /.../include/linux/btf_ids.h:207:27: note: expanded from macro 'BTF_ID_LIST'
>   #define BTF_ID_LIST(name) static u32 __maybe_unused name[5];
>   ...
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Fix a BTF_ID_LIST bug with CONFIG_DEBUG_INFO_BTF not set
    https://git.kernel.org/bpf/bpf-next/c/beb3d47d1d3d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


