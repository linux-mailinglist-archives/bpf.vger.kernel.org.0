Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 704D86958BF
	for <lists+bpf@lfdr.de>; Tue, 14 Feb 2023 07:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjBNGAW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Feb 2023 01:00:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjBNGAV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Feb 2023 01:00:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DEC61BC
        for <bpf@vger.kernel.org>; Mon, 13 Feb 2023 22:00:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D5380B81BD2
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 06:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5438CC433EF;
        Tue, 14 Feb 2023 06:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676354417;
        bh=AO0qBYU+1YrFFd5aLMPkLYWxttaX1Ee+QdKeXHEsD0M=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Onu9c+LThmvJoStQOYR6YgWpss239GlRyL23Wl/W4lIr3YglAnHzJMylwDZl/l3oY
         rZJbWAxdverSm7xdDLVGzMe3LAj2xjFEHgZccST9+d09+Ct5bbATiY/R1O4KF1j6jc
         ogkRl5JIcGm3uOCOtwbriKqMAT822cDhX/5tjHDMbb0RBMyJ5QoMyyZ6UW8W7ot/+V
         syyxFo619FAA/nxfx4E82cpgtL3WxTCj6Sv985KOe654mFCY/YkMOiFZJnhGlg0PS1
         OkCHtA3t9Y4hK/53+YNl6G50erRp+TxE44zJNoAgpr3DPmh85/w5HHQXPmwjPyvGrz
         ff8venLkKamZw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3520BC41672;
        Tue, 14 Feb 2023 06:00:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next 1/2] selftests/bpf: Clean up user_ringbuf,
 cgrp_kfunc, kfunc_dynptr_param tests
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167635441720.515.14635169751436559898.git-patchwork-notify@kernel.org>
Date:   Tue, 14 Feb 2023 06:00:17 +0000
References: <20230214051332.4007131-1-joannelkoong@gmail.com>
In-Reply-To: <20230214051332.4007131-1-joannelkoong@gmail.com>
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        ast@kernel.org, martin.lau@linux.dev, kernel-team@fb.com,
        void@manifault.com, roberto.sassu@huawei.com
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

On Mon, 13 Feb 2023 21:13:31 -0800 you wrote:
> Clean up user_ringbuf, cgrp_kfunc, and kfunc_dynptr_param tests to use
> the generic verification tester for checking verifier rejections.
> The generic verification tester uses btf_decl_tag-based annotations
> for verifying that the tests fail with the expected log messages.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Acked-by: David Vernet <void@manifault.com>
> Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next,1/2] selftests/bpf: Clean up user_ringbuf, cgrp_kfunc, kfunc_dynptr_param tests
    https://git.kernel.org/bpf/bpf-next/c/8032cad10302
  - [v2,bpf-next,2/2] selftests/bpf: Clean up dynptr prog_tests
    https://git.kernel.org/bpf/bpf-next/c/50a7cedb150a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


