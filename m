Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C6669579A
	for <lists+bpf@lfdr.de>; Tue, 14 Feb 2023 04:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbjBNDuY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Feb 2023 22:50:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbjBNDuX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Feb 2023 22:50:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15980A5FA
        for <bpf@vger.kernel.org>; Mon, 13 Feb 2023 19:50:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B39E1B81AD2
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 03:50:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4388EC4339B;
        Tue, 14 Feb 2023 03:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676346619;
        bh=F1WspPDMe4aBluesCzwtn1tmB1AF8053ec7oCwGE/OY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=fIsuWGxSuZkM2bquiOjPxtxl39gYPm33D6akF0UAp074Hg+hydi3cjAgS7hT4mYwi
         Psnj0huKaC3E5W2mqONPDc6c5MbVTqPt2cXor5dXWJ0R+uXcU1yKvQj3nlRUpxiP4q
         BBiVH/MZkhDpPWtKgAEtC9QBsNbUTEJfXo71tLkHxWfbdhT6G5pwfX2SOCfkmZGUOH
         zTfnwAAjI7pGZrm56D5Qy8MnenOe6HkAogPHUXtAcIPVpz8+Cy5psh0WgRIJYvg6CO
         l8d9aGCH8UXwFYQboTJ3jPIKcQqF2mLPIqJ0AOfoYE/ri2uqpneClZvpE6JvP/IFSG
         w/zDV0OFiPRJw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 292F3E68D2D;
        Tue, 14 Feb 2023 03:50:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 bpf-next 0/8] BPF rbtree next-gen datastructure
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167634661916.22468.7213826080881850256.git-patchwork-notify@kernel.org>
Date:   Tue, 14 Feb 2023 03:50:19 +0000
References: <20230214004017.2534011-1-davemarchevsky@fb.com>
In-Reply-To: <20230214004017.2534011-1-davemarchevsky@fb.com>
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

On Mon, 13 Feb 2023 16:40:09 -0800 you wrote:
> This series adds a rbtree datastructure following the "next-gen
> datastructure" precedent set by recently-added linked-list [0]. This is
> a reimplementation of previous rbtree RFC [1] to use kfunc + kptr
> instead of adding a new map type. This series adds a smaller set of API
> functions than that RFC - just the minimum needed to support current
> cgfifo example scheduler in ongoing sched_ext effort [2], namely:
> 
> [...]

Here is the summary with links:
  - [v6,bpf-next,1/8] bpf: Add basic bpf_rb_{root,node} support
    https://git.kernel.org/bpf/bpf-next/c/9c395c1b99bd
  - [v6,bpf-next,2/8] bpf: Add bpf_rbtree_{add,remove,first} kfuncs
    https://git.kernel.org/bpf/bpf-next/c/bd1279ae8a69
  - [v6,bpf-next,3/8] bpf: Add support for bpf_rb_root and bpf_rb_node in kfunc args
    https://git.kernel.org/bpf/bpf-next/c/cd6791b4b6f6
  - [v6,bpf-next,4/8] bpf: Add callback validation to kfunc verifier logic
    https://git.kernel.org/bpf/bpf-next/c/5d92ddc3de1b
  - [v6,bpf-next,5/8] bpf: Special verifier handling for bpf_rbtree_{remove, first}
    https://git.kernel.org/bpf/bpf-next/c/a40d3632436b
  - [v6,bpf-next,6/8] bpf: Add bpf_rbtree_{add,remove,first} decls to bpf_experimental.h
    https://git.kernel.org/bpf/bpf-next/c/c834df847ee6
  - [v6,bpf-next,7/8] selftests/bpf: Add rbtree selftests
    https://git.kernel.org/bpf/bpf-next/c/215249f6adc0
  - [v6,bpf-next,8/8] bpf, documentation: Add graph documentation for non-owning refs
    https://git.kernel.org/bpf/bpf-next/c/c31315c3aa09

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


