Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD3FA58CAC2
	for <lists+bpf@lfdr.de>; Mon,  8 Aug 2022 16:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235534AbiHHOuS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 10:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237965AbiHHOuQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 10:50:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B300CF2
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 07:50:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F7CE60F40
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 14:50:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6630FC433D7;
        Mon,  8 Aug 2022 14:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659970214;
        bh=NkEKv6HWRECe7J6KKDcxJnf6653iCxjGCnQNCjWyewA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=WO6JZb7SRRL0DMz7gPVNtG7l1PRrAA1MlpvAagAihuEu0qpcyPScIpCT46WH5DjJ0
         1x3gV545uwnkaenuS8kVIsHCXOPpXafSp+xRN7+2NVeA0fplSK+G+qO+uoXLtJ3L6h
         r8qFkX9safkXpCtHsMshMEd5CRnHXjmUQFphFw/1r+l1z5WQ4XYW3cBuXbS13R/rzS
         1VjukU4eAUhULUtjydt5Ka5bC1hzw/7JLGFbhsErx2JxUaRDzBF9tWPUb2X2+00Qtv
         JeFfmKv4RRFKf7mEnSV8JJu2jWv6AWLwH1bZkG01gvNzoKHYdj1Q2nMVYNzY8w3/KV
         GB3sIEnTgGVWQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4D63EC43142;
        Mon,  8 Aug 2022 14:50:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf,
 arm64: allocate program buffer using kvcalloc instead of kcalloc
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165997021431.25944.12023505653587471129.git-patchwork-notify@kernel.org>
Date:   Mon, 08 Aug 2022 14:50:14 +0000
References: <20220804025442.22524-1-aijun.sun@unisoc.com>
In-Reply-To: <20220804025442.22524-1-aijun.sun@unisoc.com>
To:     Aijun Sun <aijun.sprd@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        zlim.lnx@gmail.com, bpf@vger.kernel.org, catalin.marinas@arm.com,
        will@kernel.org, aijun.sun@unisoc.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu,  4 Aug 2022 10:54:42 +0800 you wrote:
> It is not necessary to allocate contiguous physical memory for BPF
> program buffer using kcalloc. When the BPF program is large more than
> memory page size, kcalloc allocates multiple memory pages from buddy
> system. If the device can not provide sufficient memory, for example
> in low-end android devices[1], memory allocation for BPF program is likely
> failed.
> 
> [...]

Here is the summary with links:
  - [bpf] bpf, arm64: allocate program buffer using kvcalloc instead of kcalloc
    https://git.kernel.org/bpf/bpf/c/19f68ed6dc90

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


