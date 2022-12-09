Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A552E647C67
	for <lists+bpf@lfdr.de>; Fri,  9 Dec 2022 03:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiLICuV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Dec 2022 21:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiLICuU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Dec 2022 21:50:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0705D86F59
        for <bpf@vger.kernel.org>; Thu,  8 Dec 2022 18:50:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 826D4B8277C
        for <bpf@vger.kernel.org>; Fri,  9 Dec 2022 02:50:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3D8A7C433EF;
        Fri,  9 Dec 2022 02:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670554217;
        bh=2+4/Q4LfP1A/LiSFlJdRGdjADqHeW+rDoEvhkJnmTzs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=oIJcY+nSqP6rSufu3vCG3Ru1ubfinAzK/Y+GR/o1dgrF0+hWbVUjsRcwqSd9wxhnT
         BuAkW8nRYpOH2DIaQQonfMe0x9o0HefKT/n2ioQKZD/aQffMZqyvTDfvqiMCLDlQ6D
         vBtf4QLTdcQ1aU4AOE+Bntdr/A9ke7BGHoOqXMaVaVn7VNXcoP0aqvW3Y6dVAYI/c+
         EdHrp7OrDfzstjzgtesFpaeDaDgJg1f8B8V9rXcT4HdwPMmZMvLHjU9d1ugmzxumK4
         G0H1+FyA3mCMp2R3TX0xTJnxr+jtdXah057IgSmsPSQvdC392Vmsc0ThtGIp3HGK6P
         K/FZfBL2JM3ig==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1D5F9C433D7;
        Fri,  9 Dec 2022 02:50:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/7] Dynptr refactorings
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167055421711.8327.12132622553972025169.git-patchwork-notify@kernel.org>
Date:   Fri, 09 Dec 2022 02:50:17 +0000
References: <20221207204141.308952-1-memxor@gmail.com>
In-Reply-To: <20221207204141.308952-1-memxor@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, martin.lau@kernel.org,
        joannelkoong@gmail.com, void@manifault.com
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

On Thu,  8 Dec 2022 02:11:34 +0530 you wrote:
> This is part 1 of https://lore.kernel.org/bpf/20221018135920.726360-1-memxor@gmail.com.
> This thread also gives some background on why the refactor is being done:
> https://lore.kernel.org/bpf/CAEf4Bzb4beTHgVo+G+jehSj8oCeAjRbRcm6MRe=Gr+cajRBwEw@mail.gmail.com
> 
> As requested in patch 6 by Alexei, it only includes patches which
> refactors the code, on top of which further fixes will be made in part
> 2. The refactor itself fixes another issue as a side effect. No
> functional change is intended (except a few modified log messages).
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/7] bpf: Refactor ARG_PTR_TO_DYNPTR checks into process_dynptr_func
    https://git.kernel.org/bpf/bpf-next/c/6b75bd3d0367
  - [bpf-next,v2,2/7] bpf: Propagate errors from process_* checks in check_func_arg
    https://git.kernel.org/bpf/bpf-next/c/ac50fe51ce87
  - [bpf-next,v2,3/7] bpf: Rework process_dynptr_func
    https://git.kernel.org/bpf/bpf-next/c/270605317366
  - [bpf-next,v2,4/7] bpf: Rework check_func_arg_reg_off
    https://git.kernel.org/bpf/bpf-next/c/184c9bdb8f65
  - [bpf-next,v2,5/7] bpf: Move PTR_TO_STACK alignment check to process_dynptr_func
    https://git.kernel.org/bpf/bpf-next/c/f6ee298fa140
  - [bpf-next,v2,6/7] bpf: Use memmove for bpf_dynptr_{read,write}
    https://git.kernel.org/bpf/bpf-next/c/76d16077bef0
  - [bpf-next,v2,7/7] selftests/bpf: Add test for dynptr reinit in user_ringbuf callback
    https://git.kernel.org/bpf/bpf-next/c/292064cce796

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


