Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25FF66F3A93
	for <lists+bpf@lfdr.de>; Tue,  2 May 2023 00:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjEAWkW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 May 2023 18:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjEAWkV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 May 2023 18:40:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065C910FD
        for <bpf@vger.kernel.org>; Mon,  1 May 2023 15:40:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 87D2D6200A
        for <bpf@vger.kernel.org>; Mon,  1 May 2023 22:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DEAFCC433D2;
        Mon,  1 May 2023 22:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682980819;
        bh=fdu/sUqEfgAXIDmJtkpV98YJm+VfjX8r7sxIDRtDWuU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Bppgi43lJJP0x5v+X6GWZkV5hS74cqJeLlsCtx8JIiCKHBCTKIH4E++JzZXkr404O
         sXfeTI2dCKuwXed90bUVA7LXbpT28Q7hKLDrRFMSGO/vO3IEp8QPB2YzdUwRGhvuoE
         ygILl3394ZfKg8hsb6abQpdP93YBwjNdKm1r9sf2iv4qj5yto7cRCkdmKzKGKStXHM
         f//dCTbjrCKYNhCoumHDFopeH9OLl9f2ZPlgbboXMsWSPgSpurCLsHIxeJ/epDjgel
         Mozo9TySJng7H8sfNAwh6l6a4jnots2YMWP1UMu2CVuqQeEhE3bHBgyjL3K5HSRF93
         hJP4gFUVnKv9g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C5632C43158;
        Mon,  1 May 2023 22:40:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/2] selftests/bpf: test_progs can read test lists
 from file
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168298081980.22124.4046559755108095867.git-patchwork-notify@kernel.org>
Date:   Mon, 01 May 2023 22:40:19 +0000
References: <20230427225333.3506052-1-sveiss@meta.com>
In-Reply-To: <20230427225333.3506052-1-sveiss@meta.com>
To:     Stephen Veiss <sveiss@meta.com>
Cc:     bpf@vger.kernel.org, mykolal@fb.com, andrii@kernel.org,
        yhs@meta.com, daniel@iogearbox.net, ast@kernel.org
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

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 27 Apr 2023 15:53:31 -0700 you wrote:
> BPF selftests have ALLOWLIST and DENYLIST files, used to control which
> tests are run in CI. These files are currently parsed by a shell
> script. [1]
> 
> This patchset allows those files to be specified directly on the
> test_progs command line (eg, as -a @ALLOWLIST).
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] selftests/bpf: extract insert_test from parse_test_list
    https://git.kernel.org/bpf/bpf-next/c/0a5c0de8b66f
  - [bpf-next,v2,2/2] selftests/bpf: test_progs can read test lists from file
    https://git.kernel.org/bpf/bpf-next/c/64276f01dce8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


