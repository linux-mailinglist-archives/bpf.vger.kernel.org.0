Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A123664F1C
	for <lists+bpf@lfdr.de>; Tue, 10 Jan 2023 23:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235604AbjAJWw1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Jan 2023 17:52:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236083AbjAJWwB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Jan 2023 17:52:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F08671A2;
        Tue, 10 Jan 2023 14:50:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 84108B81A00;
        Tue, 10 Jan 2023 22:50:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1B247C433F0;
        Tue, 10 Jan 2023 22:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673391016;
        bh=DmMuyWhMTg0J1NdZwCFfQoKhQYQFxAiKWqSxSoll1x0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=uRZ3G+h1AaNdw4ODj6yv86kUWrOC2ujxKksv3KEByAwCzpy6GpXW3znPp07VTUDXi
         iSnG53XmoTe2XiDdw7WxbfGcpMxrrLZVFRDaIlGL6fjnf72Ek+e/IaIJaGqAZAsWKW
         0HAvc+jf/MwK9gLd+lb2ehPiV6E3/FRNB0M1g8wefCnq7WoRJ+sXMklD8EiZLef8zx
         8KslucT4696OXef7lrC2DIA81MWpPq5nzBGQMJfg4P+I2RofPr/M2xhiBa664GXpCo
         HbXdjhsHdZpZmBx6v2Qsh+6WubYVga2Q/wQNzQbLIEHEiKaOhyt/pX9AlKcQ4uVSvt
         fldXHbtt/zsVQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 00533E21EE8;
        Tue, 10 Jan 2023 22:50:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf: Replace 0-length arrays with flexible arrays
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167339101599.28902.5327791124067545987.git-patchwork-notify@kernel.org>
Date:   Tue, 10 Jan 2023 22:50:15 +0000
References: <20230105192646.never.154-kees@kernel.org>
In-Reply-To: <20230105192646.never.154-kees@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, gustavoars@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
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

On Thu,  5 Jan 2023 11:26:47 -0800 you wrote:
> Zero-length arrays are deprecated[1]. Replace struct bpf_array's
> union of 0-length arrays with flexible arrays. (How are the
> sizes of these arrays verified?) Detected with GCC 13, using
> -fstrict-flex-arrays=3:
> 
> arch/x86/net/bpf_jit_comp.c: In function 'bpf_tail_call_direct_fixup':
> arch/x86/net/bpf_jit_comp.c:606:37: warning: array subscript <unknown> is outside array bounds of 'void *[0]' [-Warray-bounds=]
>   606 |                 target = array->ptrs[poke->tail_call.key];
>       |                          ~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~
> In file included from include/linux/filter.h:9,
>                  from arch/x86/net/bpf_jit_comp.c:9:
> include/linux/bpf.h:1527:23: note: while referencing 'ptrs'
>  1527 |                 void *ptrs[0] __aligned(8);
>       |                       ^~~~
> 
> [...]

Here is the summary with links:
  - bpf: Replace 0-length arrays with flexible arrays
    https://git.kernel.org/bpf/bpf-next/c/129d868ede1e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


