Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0252260DB15
	for <lists+bpf@lfdr.de>; Wed, 26 Oct 2022 08:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbiJZGUW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Oct 2022 02:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbiJZGUV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Oct 2022 02:20:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6174E40A
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 23:20:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F0D49B8208D
        for <bpf@vger.kernel.org>; Wed, 26 Oct 2022 06:20:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8B93BC433D7;
        Wed, 26 Oct 2022 06:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666765217;
        bh=g0LDdoDM7ASfRHT82C5+QTlSoeYTLI21f+i3+I4yuLg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=LfoDDxUU23Lq84PWl5A3RhFh2xnYWV0XMAiuXOZek3J6jCwXEUfzjupVD1Cqkpa0M
         Q4HqBkqB8TN2jC6U+Bw4I8zub292Pr82+9c6cqDhJKxzx22etWVw+c4Z4b0CFNAMr2
         A0BwRDI529N3g5LvICnbgn/TNpb9eJb7hF2QSJVV8E/8bZT+N2YqmwUQ+e5+T2vG/K
         0jdJObATS/mURuwsf6hepXWbvYHLiAC9mCpYJaIqUt7XS2WRbCe9IgNxU6qJ+0x6KT
         VPzpQ1O6oYXGMN0jsj4lbI60fNt2t8pa1EZdiacALbqyZ7ZQQNIpClWcYrY3hnWAx+
         isVpirjTfBjNg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 73459E451A7;
        Wed, 26 Oct 2022 06:20:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/9] bpf: Avoid unnecessary deadlock detection and
 failure in task storage
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166676521746.14139.9157565176154592937.git-patchwork-notify@kernel.org>
Date:   Wed, 26 Oct 2022 06:20:17 +0000
References: <20221025184524.3526117-1-martin.lau@linux.dev>
In-Reply-To: <20221025184524.3526117-1-martin.lau@linux.dev>
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, songliubraving@meta.com, kernel-team@meta.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Tue, 25 Oct 2022 11:45:15 -0700 you wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
> 
> The commit bc235cdb423a ("bpf: Prevent deadlock from recursive bpf_task_storage_[get|delete]")
> added deadlock detection to avoid a tracing program from recurring
> on the bpf_task_storage_{get,delete}() helpers.  These helpers acquire
> a spin lock and it will lead to deadlock.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/9] bpf: Remove prog->active check for bpf_lsm and bpf_iter
    https://git.kernel.org/bpf/bpf-next/c/271de525e1d7
  - [bpf-next,2/9] bpf: Append _recur naming to the bpf_task_storage helper proto
    https://git.kernel.org/bpf/bpf-next/c/0593dd34e534
  - [bpf-next,3/9] bpf: Refactor the core bpf_task_storage_get logic into a new function
    https://git.kernel.org/bpf/bpf-next/c/6d65500c34d8
  - [bpf-next,4/9] bpf: Avoid taking spinlock in bpf_task_storage_get if potential deadlock is detected
    https://git.kernel.org/bpf/bpf-next/c/e8b02296a6b8
  - [bpf-next,5/9] bpf: Add new bpf_task_storage_get proto with no deadlock detection
    https://git.kernel.org/bpf/bpf-next/c/4279adb094a1
  - [bpf-next,6/9] bpf: bpf_task_storage_delete_recur does lookup first before the deadlock check
    https://git.kernel.org/bpf/bpf-next/c/fda64ae0bb3e
  - [bpf-next,7/9] bpf: Add new bpf_task_storage_delete proto with no deadlock detection
    https://git.kernel.org/bpf/bpf-next/c/8a7dac37f27a
  - [bpf-next,8/9] selftests/bpf: Ensure no task storage failure for bpf_lsm.s prog due to deadlock detection
    https://git.kernel.org/bpf/bpf-next/c/0334b4d8822a
  - [bpf-next,9/9] selftests/bpf: Tracing prog can still do lookup under busy lock
    https://git.kernel.org/bpf/bpf-next/c/387b532138ee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


