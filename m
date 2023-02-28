Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A87F06A5DD1
	for <lists+bpf@lfdr.de>; Tue, 28 Feb 2023 17:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjB1Q6s (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Feb 2023 11:58:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjB1Q6r (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Feb 2023 11:58:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E80D7ECF;
        Tue, 28 Feb 2023 08:58:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C68E7B80E79;
        Tue, 28 Feb 2023 16:50:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 80106C433EF;
        Tue, 28 Feb 2023 16:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677603016;
        bh=/aTK2/syeSPZsRpiFJvh3M8oZMZLM4AGrW2K7HTZDxU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=PHwc1PI80XJkdvRSZ+DS2crwsFckUx6FkQlsL7q0ZUwa5y0d6gPePVd7s4M7F2iWw
         4u/rtBVZBvrM1GAzQBF7CN9u7gMiO7jbl7ODaK8vwdN97oaDzcEOKji9hqOMrSAxsn
         gzZgOKQbBIKcGC0k8f0mUCr++jrFuxtNmDhkqU8a2yGc2YnkJSd8CD1P9brG4S/bHQ
         ic1EEyCP9HR26AIrVHBLFQWrh/P1LmCBTs6m3gNs2bdirT0CQkoAD42EJUFcILWvKo
         dDRMwWwXkxtuJPxjOoCzvvRWYfPKfaToD5yLQc4HCl3/87RCxNLXkL8vbfn+rl56eq
         ro6JnKlTx/uXg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 679AEC691DE;
        Tue, 28 Feb 2023 16:50:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Fix bpf_cgroup_from_id() doxygen header
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167760301642.12188.10114937051269264153.git-patchwork-notify@kernel.org>
Date:   Tue, 28 Feb 2023 16:50:16 +0000
References: <20230228152845.294695-1-void@manifault.com>
In-Reply-To: <20230228152845.294695-1-void@manifault.com>
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@meta.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com, tj@kernel.org
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
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 28 Feb 2023 09:28:45 -0600 you wrote:
> In commit 332ea1f697be ("bpf: Add bpf_cgroup_from_id() kfunc"), a new
> bpf_cgroup_from_id() kfunc was added which allows a BPF program to
> lookup and acquire a reference to a cgroup from a cgroup id. The
> commit's doxygen comment seems to have copy-pasted fields, which causes
> BPF kfunc helper documentation to fail to render:
> 
> <snip>/helpers.c:2114: warning: Excess function parameter 'cgrp'...
> <snip>/helpers.c:2114: warning: Excess function parameter 'level'...
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Fix bpf_cgroup_from_id() doxygen header
    https://git.kernel.org/bpf/bpf-next/c/30a2d8328d8a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


