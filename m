Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B16D94CE7C9
	for <lists+bpf@lfdr.de>; Sun,  6 Mar 2022 00:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbiCEXlE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 5 Mar 2022 18:41:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiCEXlD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 5 Mar 2022 18:41:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31ACE7D006
        for <bpf@vger.kernel.org>; Sat,  5 Mar 2022 15:40:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BAB1460FD8
        for <bpf@vger.kernel.org>; Sat,  5 Mar 2022 23:40:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 19A2EC340F1;
        Sat,  5 Mar 2022 23:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646523612;
        bh=RB47gTdjB0kZo1OMOfQM8iB0+ZDlp5tkS+gTZuldM0k=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=CiknPcj3jGYLsUM4iWNsZ63rf0yqgLC8Gi59Gwe5DLls/dVxf8KS1led256tkp1AB
         wFNPzBNRY/xadJD6+U721la59CjJsCIW9Iaa8v7JYuANyaNz94xIUIkeX1qB76fDPc
         QdJz0z/BdfI96GMZcguHGBdXlcc6NIcdyz4lP6DMifgSGpbgf8gNNq33HXW3rqqMZG
         s6V7ZnUk43qA5dZoXGoLDio00wsTKUqyR9BwrQZGiMQUPVHa26WE7bbwN1vgoVOYWB
         Q9fRetJN9BL15ErNLSVnIN352p5xypw9W2FUpK4NIpFxfiGeyRI2kuGU0uXdKJLBey
         9ltjpfbVVprOQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EEA24F0383A;
        Sat,  5 Mar 2022 23:40:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 0/8] Fixes for bad PTR_TO_BTF_ID offset
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164652361197.32325.912382590495519360.git-patchwork-notify@kernel.org>
Date:   Sat, 05 Mar 2022 23:40:11 +0000
References: <20220304224645.3677453-1-memxor@gmail.com>
In-Reply-To: <20220304224645.3677453-1-memxor@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat,  5 Mar 2022 04:16:37 +0530 you wrote:
> This set fixes a bug related to bad var_off being permitted for kfunc call in
> case of PTR_TO_BTF_ID, consolidates offset checks for all register types allowed
> as helper or kfunc arguments into a common shared helper, and introduces a
> couple of other checks to harden the kfunc release logic and prevent future
> bugs. Some selftests are also included that fail in absence of these fixes,
> serving as demonstration of the issues being fixed.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/8] bpf: Add check_func_arg_reg_off function
    https://git.kernel.org/bpf/bpf-next/c/25b35dd28138
  - [bpf-next,v4,2/8] bpf: Fix PTR_TO_BTF_ID var_off check
    https://git.kernel.org/bpf/bpf-next/c/655efe5089f0
  - [bpf-next,v4,3/8] bpf: Disallow negative offset in check_ptr_off_reg
    https://git.kernel.org/bpf/bpf-next/c/e1fad0ff46b3
  - [bpf-next,v4,4/8] bpf: Harden register offset checks for release helpers and kfuncs
    https://git.kernel.org/bpf/bpf-next/c/24d5bb806c7e
  - [bpf-next,v4,5/8] compiler-clang.h: Add __diag infrastructure for clang
    https://git.kernel.org/bpf/bpf-next/c/f014a00bbeb0
  - [bpf-next,v4,6/8] compiler_types.h: Add unified __diag_ignore_all for GCC/LLVM
    https://git.kernel.org/bpf/bpf-next/c/4d1ea705d797
  - [bpf-next,v4,7/8] bpf: Replace __diag_ignore with unified __diag_ignore_all
    https://git.kernel.org/bpf/bpf-next/c/0b206c6d1066
  - [bpf-next,v4,8/8] selftests/bpf: Add tests for kfunc register offset checks
    https://git.kernel.org/bpf/bpf-next/c/8218ccb5bd68

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


