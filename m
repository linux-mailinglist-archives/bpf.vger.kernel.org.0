Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56CE15EB900
	for <lists+bpf@lfdr.de>; Tue, 27 Sep 2022 05:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiI0DuU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Sep 2022 23:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiI0DuT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Sep 2022 23:50:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844588709E
        for <bpf@vger.kernel.org>; Mon, 26 Sep 2022 20:50:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2BFF7B81988
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 03:50:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B4910C433B5;
        Tue, 27 Sep 2022 03:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664250615;
        bh=FeL/ArkKCta/N7GTni9GyuBUmKBAKzrexF/2u3ULfJA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=UGO/pLDa1K/JDUKs6HnCSwpqXtP580NeRwxjULPRhmc+56qqngshfGTiaeu6jzAGX
         L10eMrf802CBwczbmixzViUhdiPGZWwwF2MuKOPZpJn7bikry9ib4wt33f29w8PNDC
         Xjnf2eIWg52ZMXGYV0PPh85YL6V/e+X7PR+gaR6xogUkgIafKagTAT80h6oCqC9ku7
         JBcd6BFOO17lCEyoeWBDNp3M6UGA0YgGIbj5IAY9W4pONc3kk2qw5/KoD2InlZHmTo
         2BYABEBaSWkeyqC4FfpW+g//2rTYECFtbgZRW3Mw7NKjA3MEoxyJ+3IzSjitU+iNTE
         N8Iywo6p2mRNA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 99524E21EC2;
        Tue, 27 Sep 2022 03:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next 0/2] enforce W^X for trampoline and dispatcher
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166425061562.22022.15767427387347504337.git-patchwork-notify@kernel.org>
Date:   Tue, 27 Sep 2022 03:50:15 +0000
References: <20220926184739.3512547-1-song@kernel.org>
In-Reply-To: <20220926184739.3512547-1-song@kernel.org>
To:     Song Liu <song@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        john.fastabend@gmail.com, kpsingh@chromium.org, kernel-team@fb.com,
        haoluo@google.com, jlayton@kernel.org, bjorn@kernel.org
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Mon, 26 Sep 2022 11:47:37 -0700 you wrote:
> Changes v1 => v2:
> 1. Update arch_prepare_bpf_dispatcher to use a RO image and a RW buffer.
>    (Alexei) Note: I haven't found an existing test to cover this part, so
>    this part was tested manually (comparing the generated dispatcher is
>    the same).
> 
> Jeff Layton reported CPA W^X warning linux-next [1]. It turns out to be
> W^X issue with bpf trampoline and bpf dispatcher. Fix these by:
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next,1/2] bpf: use bpf_prog_pack for bpf_dispatcher
    https://git.kernel.org/bpf/bpf-next/c/19c02415da23
  - [v2,bpf-next,2/2] bpf: Enforce W^X for bpf trampoline
    https://git.kernel.org/bpf/bpf-next/c/5b0d1c7bd572

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


