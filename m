Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8356ED6B3
	for <lists+bpf@lfdr.de>; Mon, 24 Apr 2023 23:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjDXVUV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Apr 2023 17:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjDXVUU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Apr 2023 17:20:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3966C40FB
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 14:20:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD5C262937
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 21:20:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 283EAC4339B;
        Mon, 24 Apr 2023 21:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682371219;
        bh=7Ia/k4FbGh05kxzzXWRzILC54New6cl4wWVnqpN1dT0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=HdNE9g4gSifMwOqJhWKaYV0wjKMGJpoT0Fc+bt0fmpPGfx62x+1CcCajLhae7E8Hx
         yY3ks70yvmT0/t85ymOYu7cUWq5sadCl8Vg3jcSLP26nTxFzBdSn8z6apMjKTwyzeY
         K5fmw9NrD4LXJt0le2ABAoR5ClfFNyepllTof1rt2fTeJXacdKRpuDtafzNJPTEYCY
         Nj2HBQzS0PSH7B6DPRajqJz+8bP94yFOJmptQSAYhYfnFY8ATEzO1URhTv1pQOnna+
         TrtcB8IcLRWQjv1L65MBSzTouAHX4KfGNGMEfwkMb7tJukjDXlk2KszBGbpCARdtV6
         Pv/m9AWQv3JIQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 06CA4E5FFC9;
        Mon, 24 Apr 2023 21:20:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next] bpf: Disable bpf_refcount_acquire kfunc calls
 until race conditions are fixed
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168237121902.20732.2835681145900174752.git-patchwork-notify@kernel.org>
Date:   Mon, 24 Apr 2023 21:20:19 +0000
References: <20230424204321.2680232-1-davemarchevsky@fb.com>
In-Reply-To: <20230424204321.2680232-1-davemarchevsky@fb.com>
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@kernel.org, kernel-team@fb.com,
        memxor@gmail.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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

On Mon, 24 Apr 2023 13:43:21 -0700 you wrote:
> As reported by Kumar in [0], the shared ownership implementation for BPF
> programs has some race conditions which need to be addressed before it
> can safely be used. This patch does so in a minimal way instead of
> ripping out shared ownership entirely, as proper fixes for the issues
> raised will follow ASAP, at which point this patch's commit can be
> reverted to re-enable shared ownership.
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next] bpf: Disable bpf_refcount_acquire kfunc calls until race conditions are fixed
    https://git.kernel.org/bpf/bpf-next/c/7deca5eae833

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


