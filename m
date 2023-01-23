Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A1A67868E
	for <lists+bpf@lfdr.de>; Mon, 23 Jan 2023 20:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbjAWTkS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Jan 2023 14:40:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbjAWTkS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Jan 2023 14:40:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7463535AC;
        Mon, 23 Jan 2023 11:40:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08D3460FE5;
        Mon, 23 Jan 2023 19:40:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 55488C4339B;
        Mon, 23 Jan 2023 19:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674502816;
        bh=5lBWMYNgZQvPJeTDiQf4Kmnv05FRhUH4zpAWpNmGm74=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=s3wFsDrrPMYSI+NsJOkxfs4y9aY/jn77daAkd9YfdlINbwEtA0t2HhW/mP1y17Kcj
         Z3aDbLbiHHiy9noHkFMZLL2jXfAS/4JjeXcn3LFVug3Vl60WrfALYsHX7j1MW7LEqo
         WKzFt8/BE2T8f7mSiy53d1Ss/kPUso2jtvs3IB907Ujh+OJSH14qdeE8ZxNTDXOWfb
         BQZ4k+9nXm81HwnNXWg91+0CzH/sDdm2e/3z6mBPbsjDscg3doe7hnVZRv1Qcvlr1d
         DbTvGoe+1P8hLGfKy868wu9OOG2+aWhPzIXV13PTENEWLRSpJepoK8nM2XyvfXdhAk
         bkUvtIxLgumqw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3BAC4C5C7D4;
        Mon, 23 Jan 2023 19:40:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Use __failure macro in task kfunc
 testsuite
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167450281624.26102.4253414545595285478.git-patchwork-notify@kernel.org>
Date:   Mon, 23 Jan 2023 19:40:16 +0000
References: <20230120021844.3048244-1-void@manifault.com>
In-Reply-To: <20230120021844.3048244-1-void@manifault.com>
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@meta.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
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

On Thu, 19 Jan 2023 20:18:44 -0600 you wrote:
> In commit 537c3f66eac1 ("selftests/bpf: add generic BPF program
> tester-loader"), a new mechanism was added to the BPF selftest framework
> to allow testsuites to use macros to define expected failing testcases.
> This allows any testsuite which tests verification failure to remove a
> good amount of boilerplate code. This patch updates the task_kfunc
> selftest suite to use these new macros.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Use __failure macro in task kfunc testsuite
    https://git.kernel.org/bpf/bpf-next/c/7525daeefc8c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


