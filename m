Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D2D4C0549
	for <lists+bpf@lfdr.de>; Wed, 23 Feb 2022 00:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbiBVXUh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Feb 2022 18:20:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbiBVXUg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Feb 2022 18:20:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED12F90FFF
        for <bpf@vger.kernel.org>; Tue, 22 Feb 2022 15:20:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8335A60F3D
        for <bpf@vger.kernel.org>; Tue, 22 Feb 2022 23:20:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D9097C340EB;
        Tue, 22 Feb 2022 23:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645572009;
        bh=/5Mz7UJjc1mRhyWcm59ur+cqwTvHt3njD4mG9t/hAFI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=FC8DL34j996VPwlDNHUurQnwhiLBk4e9EcQDgpfg91RiDAp81IJYjStVilg84kuZp
         vDQurHo7YDFvvDJp+NspU1syn9P/M/CprerT6fQGD3WqV3p1z3MZhGJlr6FVOXlfgP
         DkDhkU0Zznmf8RCUyrxUXEehduXW0yPK4apSmDTEhThG+GYbPF1EP15/D9aGIQclSH
         ya2NUCGUjYvYfRV9QGZPll6g5qHyx7PXTGSy9OxWLZZsZU6l+zRL9mpn/9pSjp8wB2
         4qTf0m33Aj188dsb2jh7aksD3eUfl0e5NzEZRU6XHNEBNoU9HCgzKB+LTiebHFptS4
         +EJuAM0VLHEwA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C1544E73590;
        Tue, 22 Feb 2022 23:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 bpf-next] scripts/pahole-flags.sh: Parse DWARF and generate
 BTF with multithreading.
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164557200978.12471.17652002841762108775.git-patchwork-notify@kernel.org>
Date:   Tue, 22 Feb 2022 23:20:09 +0000
References: <20220217175427.649713-1-kuifeng@fb.com>
In-Reply-To: <20220217175427.649713-1-kuifeng@fb.com>
To:     Kui-Feng Lee <kuifeng@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kernel-team@fb.com, yhs@fb.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 17 Feb 2022 09:54:27 -0800 you wrote:
> Pass a "-j" argument to pahole if possible to reduce the time of
> generating BTF info.
> 
> Since v1.22, pahole can parse DWARF and generate BTF with
> multithreading to speed up the conversion.  It will reduce the overall
> build time of the kernel for seconds.
> 
> [...]

Here is the summary with links:
  - [v3,bpf-next] scripts/pahole-flags.sh: Parse DWARF and generate BTF with multithreading.
    https://git.kernel.org/bpf/bpf-next/c/b4f72786429c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


