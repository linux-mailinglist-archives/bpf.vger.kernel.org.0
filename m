Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8491A6A4BDC
	for <lists+bpf@lfdr.de>; Mon, 27 Feb 2023 21:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbjB0UA0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 15:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjB0UAZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 15:00:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB22727D63
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 12:00:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D4FCAB80DB5
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 20:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7F342C4339B;
        Mon, 27 Feb 2023 20:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677528017;
        bh=NCglHArkrl3NefgbO1oDPawFJftuoB2ml7CKMRV5hyo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=SZmW2GMPysRUQQ5woZ60xT/50I3GLEBf3i9fmzhhSdxEF+emoridqGKNOfzlKKIa8
         DKHHbZpl8cyWttBRGcmy1KOTd/7LwenXBCObc1A+NcGyo97fwZ1RftAQCl9n5XPaoB
         iTI8xwjaV5LE6G2az6Ka+0hqsPwAAMYyuov0b7Qd14MRc5y0vPuy9OXN4taBuHU1YV
         SaKdt5CQKQxEp6vU4cwsmfIhniNPQJlKuLIVFeKfp2yv7Zg8Cpyz8a5LLf7lj9C2+V
         E1H2h0ovhtHjY0hkVyCr8Zh/Hczp7y4BHeslZ08r8GEllmAWxrugKLLTvhoZEXvXK5
         v3gtIcud1F8dw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5AAE6E4D00F;
        Mon, 27 Feb 2023 20:00:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] libbpf: Fix arm syscall regs spec in bpf_tracing.h
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167752801736.23362.14047064493818847926.git-patchwork-notify@kernel.org>
Date:   Mon, 27 Feb 2023 20:00:17 +0000
References: <20230223095346.10129-1-puranjay12@gmail.com>
In-Reply-To: <20230223095346.10129-1-puranjay12@gmail.com>
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     puranjaymohan@gmail.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, bpf@vger.kernel.org, iii@linux.ibm.com,
        quentin@isovalent.com
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
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 23 Feb 2023 09:53:46 +0000 you wrote:
> The syscall register definitions for ARM in bpf_tracing.h doesn't define
> the fifth parameter for the syscalls. Because of this some KPROBES based
> selftests fail to compile for ARM architecture.
> 
> Define the fifth parameter that is passed in the R5 register (uregs[4]).
> 
> Fixes: 3a95c42d65d5 ("libbpf: Define arm syscall regs spec in bpf_tracing.h")
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> 
> [...]

Here is the summary with links:
  - [v2] libbpf: Fix arm syscall regs spec in bpf_tracing.h
    https://git.kernel.org/bpf/bpf-next/c/06943ae67594

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


