Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A576B17DF
	for <lists+bpf@lfdr.de>; Thu,  9 Mar 2023 01:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjCIAaZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Mar 2023 19:30:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjCIAaY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Mar 2023 19:30:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A0C9CFC2
        for <bpf@vger.kernel.org>; Wed,  8 Mar 2023 16:30:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 34EBEB81E5C
        for <bpf@vger.kernel.org>; Thu,  9 Mar 2023 00:30:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D8F28C4339C;
        Thu,  9 Mar 2023 00:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678321820;
        bh=rERj7rPrnR/NRing94zfELHlHaM5Eb0k7EWfL4flx6U=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Zj27TBXadvAsO0Tn0/MPCec8gNACswdhsAjEMSw48rzhx3tinaFfONF7cYL17TWWO
         lPBK7Iw4gQIfNztVV8+RgB+vGCMaEe+QhWKj7f2ZpmZfdmphpm/STqCNwKDrnEzJzr
         ASvsUPTDtAqkUQlAkxyerjDmAoqQgheLCA6IMV3dNb8AuJTkIcs2jC2oahuP3clZHc
         ldlIf6iZNgXsut8xF5zvRUZw7w50rKPeRxTlkH+UkPfL6WV51gCaKSIlnbhMoFHAm0
         l5k2DXIcd6yjArVGQCEEVgd86a5j9QnCS5F9bMLRy4G4kl5nv07ACZBN3Nmg9lBk6b
         L6lWdxv2DIwbg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BDFB9E55B25;
        Thu,  9 Mar 2023 00:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 bpf-next 0/8] BPF open-coded iterators
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167832182077.29240.3250045548141316950.git-patchwork-notify@kernel.org>
Date:   Thu, 09 Mar 2023 00:30:20 +0000
References: <20230308184121.1165081-1-andrii@kernel.org>
In-Reply-To: <20230308184121.1165081-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@meta.com, tj@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 8 Mar 2023 10:41:13 -0800 you wrote:
> Add support for open-coded (aka inline) iterators in BPF world. This is a next
> evolution of gradually allowing more powerful and less restrictive looping and
> iteration capabilities to BPF programs.
> 
> We set up a framework for implementing all kinds of iterators (e.g., cgroup,
> task, file, etc, iterators), but this patch set only implements numbers
> iterator, which is used to implement ergonomic bpf_for() for-like construct
> (see patches #4-#5). We also add bpf_for_each(), which is a generic
> foreach-like construct that will work with any kind of open-coded iterator
> implementation, as long as we stick with bpf_iter_<type>_{new,next,destroy}()
> naming pattern (which we now enforce on the kernel side).
> 
> [...]

Here is the summary with links:
  - [v5,bpf-next,1/8] bpf: factor out fetching basic kfunc metadata
    https://git.kernel.org/bpf/bpf-next/c/07236eab7a31
  - [v5,bpf-next,2/8] bpf: add iterator kfuncs registration and validation logic
    https://git.kernel.org/bpf/bpf-next/c/215bf4962f6c
  - [v5,bpf-next,3/8] bpf: add support for open-coded iterator loops
    https://git.kernel.org/bpf/bpf-next/c/06accc8779c1
  - [v5,bpf-next,4/8] bpf: implement numbers iterator
    https://git.kernel.org/bpf/bpf-next/c/6018e1f407cc
  - [v5,bpf-next,5/8] selftests/bpf: add bpf_for_each(), bpf_for(), and bpf_repeat() macros
    https://git.kernel.org/bpf/bpf-next/c/8c2b5e90505e
  - [v5,bpf-next,6/8] selftests/bpf: add iterators tests
    https://git.kernel.org/bpf/bpf-next/c/57400dcce6c2
  - [v5,bpf-next,7/8] selftests/bpf: add number iterator tests
    https://git.kernel.org/bpf/bpf-next/c/f59b14609265
  - [v5,bpf-next,8/8] selftests/bpf: implement and test custom testmod_seq iterator
    https://git.kernel.org/bpf/bpf-next/c/7e86a8c4ac8d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


