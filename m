Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A83DA64638F
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 23:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiLGWAV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 17:00:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiLGWAT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 17:00:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8AF84DC2
        for <bpf@vger.kernel.org>; Wed,  7 Dec 2022 14:00:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6CB4261CCD
        for <bpf@vger.kernel.org>; Wed,  7 Dec 2022 22:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C2D1FC433C1;
        Wed,  7 Dec 2022 22:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670450417;
        bh=ItvLxi/92aZQuLMMkniHAnIPp1XM1NwwagyZrPClIG4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=VGQKzRt2S/90wnVfW6Eoh+CKzhc6MvV5xuVGROH0oaPiBQ37TFkXxkJOGDCqMjG6J
         T6iYSEFhTQwh81oUokSsrQQRxcL51HS7GyRmCmf/snlGKOFFZOoLNWJPtp2BMgpO0F
         V6QngSnt/aKjL7WHAikjZYXPEjXt/2hvpH+mPpxmtC0JQdAX4B8JZLtMv2yPJl+Sei
         SPYB4Yy/FLuIzex8hfjFTGUXjXllVXVoux012JUil+gHc5P6LURk4MCu2foENN5h4A
         fBhLBAJWhUMUtpXlG4HOvHZfn+2dZMRCX6RFFC56SFCYEdJa46HfJ1DATHYdLLT39F
         8yJyb5oSbFYqw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9858FE29F38;
        Wed,  7 Dec 2022 22:00:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: remove unused insn_cnt argument from
 visit_[func_call_]insn()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167045041761.21470.7399425333559579490.git-patchwork-notify@kernel.org>
Date:   Wed, 07 Dec 2022 22:00:17 +0000
References: <20221207195534.2866030-1-andrii@kernel.org>
In-Reply-To: <20221207195534.2866030-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
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
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed, 7 Dec 2022 11:55:34 -0800 you wrote:
> Number of total instructions in BPF program (including subprogs) can and
> is accessed from env->prog->len. visit_func_call_insn() doesn't do any
> checks against insn_cnt anymore, relying on push_insn() to do this check
> internally. So remove unnecessary insn_cnt input argument from
> visit_func_call_insn() and visit_insn() functions.
> 
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: remove unused insn_cnt argument from visit_[func_call_]insn()
    https://git.kernel.org/bpf/bpf-next/c/dcb2288b1fd9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


