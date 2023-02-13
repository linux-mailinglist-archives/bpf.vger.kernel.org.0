Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F9A69547B
	for <lists+bpf@lfdr.de>; Tue, 14 Feb 2023 00:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjBMXAT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Feb 2023 18:00:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjBMXAS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Feb 2023 18:00:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A53BDE6
        for <bpf@vger.kernel.org>; Mon, 13 Feb 2023 15:00:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 84C8B6131C
        for <bpf@vger.kernel.org>; Mon, 13 Feb 2023 23:00:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D776EC433EF;
        Mon, 13 Feb 2023 23:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676329216;
        bh=Diib3ha0pwbkt3nsE6B9mF2N+sLSAxhmevEghDJ+2pU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=NyUDQU1PDrp//GsGnTrsL6ZWUO0+p5XqyHzZ5i1T97v12UT68Af26o8ct0vF4r5p8
         eniL4/aP2Y2wpru/QmfWp6uVh9MeNSvqiNgJY5owf/G080eGCT9u+w1J1cvVEaxb7G
         mF+hYM7SuuJz8FbiQPYY9XPGNr2xsBAjbfYcuXOTWr6FFo2R4JIrAWgJodWM+U/rSY
         qvyMF405+Hb+GHVbkhNRdDtp7OptjRZJxk38Kk7veE5SHgImTvvll2UoveYW3UePDM
         5z+RVI5XDqHalnqsutpp2cYg9JG05PSfdiReo/i2ZVzfj8G2JVH8dmKlYzCSD+6/wG
         dpJrjvnPohW5A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BD21CC41676;
        Mon, 13 Feb 2023 23:00:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 bpf-next 0/9] BPF rbtree next-gen datastructure
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167632921677.17957.18150265210526463163.git-patchwork-notify@kernel.org>
Date:   Mon, 13 Feb 2023 23:00:16 +0000
References: <20230212092715.1422619-1-davemarchevsky@fb.com>
In-Reply-To: <20230212092715.1422619-1-davemarchevsky@fb.com>
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kernel-team@fb.com, memxor@gmail.com,
        tj@kernel.org
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

On Sun, 12 Feb 2023 01:27:06 -0800 you wrote:
> This series adds a rbtree datastructure following the "next-gen
> datastructure" precedent set by recently-added linked-list [0]. This is
> a reimplementation of previous rbtree RFC [1] to use kfunc + kptr
> instead of adding a new map type. This series adds a smaller set of API
> functions than that RFC - just the minimum needed to support current
> cgfifo example scheduler in ongoing sched_ext effort [2], namely:
> 
> [...]

Here is the summary with links:
  - [v5,bpf-next,1/9] bpf: Migrate release_on_unlock logic to non-owning ref semantics
    https://git.kernel.org/bpf/bpf-next/c/6a3cd3318ff6
  - [v5,bpf-next,2/9] bpf: Add basic bpf_rb_{root,node} support
    (no matching commit)
  - [v5,bpf-next,3/9] bpf: Add bpf_rbtree_{add,remove,first} kfuncs
    (no matching commit)
  - [v5,bpf-next,4/9] bpf: Add support for bpf_rb_root and bpf_rb_node in kfunc args
    (no matching commit)
  - [v5,bpf-next,5/9] bpf: Add callback validation to kfunc verifier logic
    (no matching commit)
  - [v5,bpf-next,6/9] bpf: Special verifier handling for bpf_rbtree_{remove, first}
    (no matching commit)
  - [v5,bpf-next,7/9] bpf: Add bpf_rbtree_{add,remove,first} decls to bpf_experimental.h
    (no matching commit)
  - [v5,bpf-next,8/9] selftests/bpf: Add rbtree selftests
    (no matching commit)
  - [v5,bpf-next,9/9] bpf, documentation: Add graph documentation for non-owning refs
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


