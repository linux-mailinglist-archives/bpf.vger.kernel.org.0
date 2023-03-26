Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7426C922F
	for <lists+bpf@lfdr.de>; Sun, 26 Mar 2023 05:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjCZDMN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 25 Mar 2023 23:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbjCZDMM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 25 Mar 2023 23:12:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA91AD29
        for <bpf@vger.kernel.org>; Sat, 25 Mar 2023 20:12:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C471860E55
        for <bpf@vger.kernel.org>; Sun, 26 Mar 2023 03:12:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 141B9C433D2;
        Sun, 26 Mar 2023 03:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679800330;
        bh=Wj45TKqu8AUE1WVmu/JX/4fAYD2tv/kG0fNUfk+gRDM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=gmvug1Qym+81Xgwg6n/TJkldp7uU4TS/VAN52jWSdp7dqQPHYclMmnJvhPbPfQLC6
         23SUsq5iCDyAv/sl3MCv/7mFTlsN1Gc4o3METKcE7Lso1Ozn4AflgY5EPGRck6WM6/
         Ig66J0JqLSE0FrHwl6PN6XP096rm+XJAmUJPcNgUe8ELOuK9t2/lfYYz2zAl/1vgRu
         eGJV8a44zkYEPsvOPbXBfNW3mjrDXqWwyLgPgFP6+CvAqamhtGV91cNSk2Qb5YxoG/
         HlV3z2XGOxACRqdkiwBNHLd1daCoZ/XsleKGZ2AWrVVW+re+awIHjEwo/q3xlltSjy
         OLn+MEpUPdCQA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EBE3FE4F0D7;
        Sun, 26 Mar 2023 03:12:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 bpf-next 0/5] bpf: Use bpf_mem_cache_alloc/free in
 bpf_local_storage
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167980032995.25421.15490327816299888176.git-patchwork-notify@kernel.org>
Date:   Sun, 26 Mar 2023 03:12:09 +0000
References: <20230322215246.1675516-1-martin.lau@linux.dev>
In-Reply-To: <20230322215246.1675516-1-martin.lau@linux.dev>
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@meta.com
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 22 Mar 2023 14:52:41 -0700 you wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
> 
> This set is a continuation of the effort in using
> bpf_mem_cache_alloc/free in bpf_local_storage [1]
> 
> Major change is only using bpf_mem_alloc for task and cgrp storage
> while sk and inode stay with kzalloc/kfree. The details is
> in patch 2.
> 
> [...]

Here is the summary with links:
  - [v3,bpf-next,1/5] bpf: Add a few bpf mem allocator functions
    https://git.kernel.org/bpf/bpf-next/c/e65a5c6edbc6
  - [v3,bpf-next,2/5] bpf: Use bpf_mem_cache_alloc/free in bpf_local_storage_elem
    https://git.kernel.org/bpf/bpf-next/c/08a7ce384e33
  - [v3,bpf-next,3/5] bpf: Use bpf_mem_cache_alloc/free for bpf_local_storage
    https://git.kernel.org/bpf/bpf-next/c/6ae9d5e99e1d
  - [v3,bpf-next,4/5] selftests/bpf: Test task storage when local_storage->smap is NULL
    https://git.kernel.org/bpf/bpf-next/c/d8db84d71c0e
  - [v3,bpf-next,5/5] selftests/bpf: Add bench for task storage creation
    https://git.kernel.org/bpf/bpf-next/c/cbe9d93d58b1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


