Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCDF652A1A
	for <lists+bpf@lfdr.de>; Wed, 21 Dec 2022 01:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234263AbiLUAAZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Dec 2022 19:00:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234287AbiLUAAV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Dec 2022 19:00:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549F820184
        for <bpf@vger.kernel.org>; Tue, 20 Dec 2022 16:00:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 15E98B81A8F
        for <bpf@vger.kernel.org>; Wed, 21 Dec 2022 00:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B8667C433EF;
        Wed, 21 Dec 2022 00:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671580816;
        bh=LClN8ZcX6xv4dU5GuBtGlunD+san/yCLvj35w5bS6QU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=tCrfKbWDWsifx1Cy4cUw/DujemYBUc/KzUBaVDGjSphzGzUMD/uFRXSu+cLHJwilO
         b9I8KX+G2GQ1CbzY8nFsqWn8qMGve7ytDiOB9+StkmywvmpUNfy3yLFh5NcVe8qQrQ
         UZChvzbRiyBKfah3WxATu+KkmZEpPsKIQ0c4EmzU7ziUwUQL+UrXKiszPraFZH9qwO
         Us9yiuAnThi0JraxMOEuuojhHgCbdw2Fm3FQV6FR8S4g6s9rt8UMIj3GcZDKT3mBfI
         NRK6VD+yQxWSbv8Q26JKNi7JrNzQNDpzZRsGQl+ha+zst7h0WC/eAAxIDCryhN/4Pt
         70G+ZmfLMvrZg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 99B25C5C7C4;
        Wed, 21 Dec 2022 00:00:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] libbpf: Fix build warning on ref_ctr_off
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167158081662.32440.15055359412437154748.git-patchwork-notify@kernel.org>
Date:   Wed, 21 Dec 2022 00:00:16 +0000
References: <20221219191526.296264-1-raj.khem@gmail.com>
In-Reply-To: <20221219191526.296264-1-raj.khem@gmail.com>
To:     Khem Raj <raj.khem@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        song@kernel.org, yhs@fb.com, jolsa@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com, nathan@kernel.org,
        ndesaulniers@google.com, andrii.nakryiko@gmail.com
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
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 19 Dec 2022 11:15:26 -0800 you wrote:
> Clang warns on 32-bit ARM on this comparision
> 
> libbpf.c:10497:18: error: result of comparison of constant 4294967296 with expression of type 'size_t' (aka 'unsigned int') is always false [-Werror,-Wtautological-constant-out-of-range-compare]
>         if (ref_ctr_off >= (1ULL << PERF_UPROBE_REF_CTR_OFFSET_BITS))
>             ~~~~~~~~~~~ ^  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> typecast ref_ctr_off to __u64 in the check conditional, it is false on 32bit anyways.
> 
> [...]

Here is the summary with links:
  - [v2] libbpf: Fix build warning on ref_ctr_off
    https://git.kernel.org/bpf/bpf-next/c/1520e8466d68

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


