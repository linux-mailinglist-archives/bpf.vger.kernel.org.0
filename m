Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8886C57A4A4
	for <lists+bpf@lfdr.de>; Tue, 19 Jul 2022 19:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236176AbiGSRKR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Jul 2022 13:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238001AbiGSRKR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Jul 2022 13:10:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A557AAE48
        for <bpf@vger.kernel.org>; Tue, 19 Jul 2022 10:10:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5C90BB81C63
        for <bpf@vger.kernel.org>; Tue, 19 Jul 2022 17:10:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 14938C341CF;
        Tue, 19 Jul 2022 17:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658250613;
        bh=RUvGjq2iTbXYBsB//X4iHL0fy4q/BxHfUsfVz+9nkdg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=TcqYaTtnvMWrk5xoehzlzsF85PuFZ+pv54ED96jKhgg7npp6RJH+liNsP+wUcxxT5
         b6EnlU8zNlOnk0WIJ4vKuCHK9PWLT/VicZ/+k/dhCDDp/SUhtvyyumcvdVwByTByPM
         1b/mBYemAxMUl78Z6UMfZOiFjbxpWG5gBCUjp3q0jNuW9Dsg9PkU0RhPKo2Cyjk3Rp
         2oPcwCM//8PYZ3hYkxxNVit5HSf9opC81CCaLl4hEMbwclDy2/D2Ho1aNz5RydfZUT
         1l7Z5OxuIFSAQnRDRpqctlu68xbkbTsdor6I5wHnz/sbGmmZ2xm2w1SlZ6+zuabkUN
         cDD9RbHVZ5Rng==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EFFBDE451B7;
        Tue, 19 Jul 2022 17:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next 1/2] libbpf: make RINGBUF map size adjustments
 more eagerly
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165825061297.26085.18063705514857214587.git-patchwork-notify@kernel.org>
Date:   Tue, 19 Jul 2022 17:10:12 +0000
References: <20220715230952.2219271-1-andrii@kernel.org>
In-Reply-To: <20220715230952.2219271-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Fri, 15 Jul 2022 16:09:51 -0700 you wrote:
> Make libbpf adjust RINGBUF map size (rounding it up to closest power-of-2
> of page_size) more eagerly: during open phase when initializing the map
> and on explicit calls to bpf_map__set_max_entries().
> 
> Such approach allows user to check actual size of BPF ringbuf even
> before it's created in the kernel, but also it prevents various edge
> case scenarios where BPF ringbuf size can get out of sync with what it
> would be in kernel. One of them (reported in [0]) is during an attempt
> to pin/reuse BPF ringbuf.
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next,1/2] libbpf: make RINGBUF map size adjustments more eagerly
    https://git.kernel.org/bpf/bpf-next/c/597fbc468296
  - [v2,bpf-next,2/2] selftests/bpf: test eager BPF ringbuf size adjustment logic
    https://git.kernel.org/bpf/bpf-next/c/e134601961fe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


