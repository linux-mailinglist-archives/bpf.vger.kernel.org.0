Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4341D4F97B6
	for <lists+bpf@lfdr.de>; Fri,  8 Apr 2022 16:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234454AbiDHOMU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Apr 2022 10:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235124AbiDHOMT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Apr 2022 10:12:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDCA332DC8
        for <bpf@vger.kernel.org>; Fri,  8 Apr 2022 07:10:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 82AC3B82B81
        for <bpf@vger.kernel.org>; Fri,  8 Apr 2022 14:10:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1E22DC385A9;
        Fri,  8 Apr 2022 14:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649427013;
        bh=xJdLK7gwgGYX9zqF0glCmpMV8Zv+wHCol+24rqC5ONY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=uSst4ZvpnD4el5O/LjKUxdfvrso3RMedyPQ2T/mPG6yZ0nCk8ESnfCADHdQlXU2Y5
         MiniSyi/L4blnyZA5sxSKssMd50SDT+5s5xir5BViuRtUIKc6SBL1qd9FH9zsajp2T
         ZWdIdPcT57SrVnsVIV0gn06/yqvujTj0md5fCAlgIF4g16NjMLXzTP0cucbP6TBHDS
         ExooNKlMdpWxmnyoQWgoswi7T1aEaQ8Dvx5hWS4SnJrRrfmS6Q1oMp8GokRd9t4+C2
         diFJIqUucx3xZKmekra1p251QVOg2TH3qDZBLLmfQkaYpIWW6azZiqSj+gpRS3IHxM
         YRJU7nlvqIOhQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F1E34E8DBDA;
        Fri,  8 Apr 2022 14:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/3] Add USDT support for s390
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164942701298.2806.10263967055413459295.git-patchwork-notify@kernel.org>
Date:   Fri, 08 Apr 2022 14:10:12 +0000
References: <20220407214411.257260-1-iii@linux.ibm.com>
In-Reply-To: <20220407214411.257260-1-iii@linux.ibm.com>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii.nakryiko@gmail.com,
        hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@linux.ibm.com,
        agordeev@linux.ibm.com, bpf@vger.kernel.org
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

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu,  7 Apr 2022 23:44:08 +0200 you wrote:
> This series adds USDT support for s390, making the "usdt" test pass
> there. Patch 1 is a collection of minor cleanups, patch 2 adds
> BPF-side support, patch 3 adds userspace-side support.
> 
> Ilya Leoshkevich (3):
>   libbpf: Minor style improvements in USDT code
>   libbpf: Make BPF-side of USDT support work on big-endian machines
>   libbpf: Add s390-specific USDT arg spec parsing logic
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/3] libbpf: Minor style improvements in USDT code
    https://git.kernel.org/bpf/bpf-next/c/e1b6df598aa8
  - [bpf-next,2/3] libbpf: Make BPF-side of USDT support work on big-endian machines
    https://git.kernel.org/bpf/bpf-next/c/6f403d9d5306
  - [bpf-next,3/3] libbpf: Add s390-specific USDT arg spec parsing logic
    https://git.kernel.org/bpf/bpf-next/c/bd022685bd44

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


