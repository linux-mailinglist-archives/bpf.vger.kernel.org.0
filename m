Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E996DA5EC
	for <lists+bpf@lfdr.de>; Fri,  7 Apr 2023 00:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236901AbjDFWkX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Apr 2023 18:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjDFWkX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 18:40:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0A59EED
        for <bpf@vger.kernel.org>; Thu,  6 Apr 2023 15:40:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D723064CEC
        for <bpf@vger.kernel.org>; Thu,  6 Apr 2023 22:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 36A1BC4339B;
        Thu,  6 Apr 2023 22:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680820821;
        bh=vQYqtGRcOjekwPiK2jUvcZ6VCR9c9zo7Z0V4udu5A70=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=bo9+nXcoQmx452yScOrTB94mgfewS57wELp2JcMGerb0LdG7FmLSsbskZljZZLRZE
         0HGYQN2whCRszdMWh5A87RTW21gsLyJ0YXggh8n8szvS18GPneO9fFdR5P6G81EW/D
         t5GplJm6p6SebYAS7L5wTJJXfcloHjiJK6FbSOj82XCtRIhTM2YYuS0S4oEKeK8uRE
         vkdYwSNIjdcFPPh1J4GJ0/FzH65WT2lh9vhhJP8gTI8zXdM/Rm+2RsiS93mA6veqSk
         GhB03UEaYBROhlsgm+HOlmcEszr5Z48vtBQoxV2Z3gPikFUvKnGJB2JIPiOG5SXasa
         tDhrMZ/3qQzlg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0F9A9E4F14C;
        Thu,  6 Apr 2023 22:40:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/4] bpf: Improve verifier for cond_op and spilled
 loop index variables
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168082082105.20613.30150261767059616.git-patchwork-notify@kernel.org>
Date:   Thu, 06 Apr 2023 22:40:21 +0000
References: <20230406164450.1044952-1-yhs@fb.com>
In-Reply-To: <20230406164450.1044952-1-yhs@fb.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 6 Apr 2023 09:44:50 -0700 you wrote:
> LLVM commit [1] introduced hoistMinMax optimization like
>   (i < VIRTIO_MAX_SGS) && (i < out_sgs)
> to
>   upper = MIN(VIRTIO_MAX_SGS, out_sgs)
>   ... i < upper ...
> and caused the verification failure. Commit [2] workarounded the issue by
> adding some bpf assembly code to prohibit the above optimization.
> This patch improved verifier such that verification can succeed without
> the above workaround.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/4] bpf: Improve verifier JEQ/JNE insn branch taken checking
    https://git.kernel.org/bpf/bpf-next/c/13fbcee55706
  - [bpf-next,v2,2/4] selftests/bpf: Add tests for non-constant cond_op NE/EQ bound deduction
    https://git.kernel.org/bpf/bpf-next/c/aec08d677b4d
  - [bpf-next,v2,3/4] bpf: Improve handling of pattern '<const> <cond_op> <non_const>' in verifier
    https://git.kernel.org/bpf/bpf-next/c/953d9f5beaf7
  - [bpf-next,v2,4/4] selftests/bpf: Add verifier tests for code pattern '<const> <cond_op> <non_const>'
    https://git.kernel.org/bpf/bpf-next/c/23a88fae9f20

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


