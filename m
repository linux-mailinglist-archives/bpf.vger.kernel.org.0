Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8F85A8802
	for <lists+bpf@lfdr.de>; Wed, 31 Aug 2022 23:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiHaVVQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Aug 2022 17:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbiHaVVN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 31 Aug 2022 17:21:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7704D4C617
        for <bpf@vger.kernel.org>; Wed, 31 Aug 2022 14:20:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F723619FA
        for <bpf@vger.kernel.org>; Wed, 31 Aug 2022 21:20:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6CE0CC433D6;
        Wed, 31 Aug 2022 21:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661980816;
        bh=TuyFl/WHOGck7F8qNiT60mXVF2yiGoTHCqViSY3jxbs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=eomLtBYS3iP/yoXHTPuCDyHLuRniQiU9dGxZC1X4H7tVZLTQ2GF++ErMETFBZ9Sjy
         GKBfYY+/zzNsZ9EVD8FTyWELHcbDd4QiCb38NiSiW1uH1H4ASOAEXG3+0SdPJVIUE4
         xIxIRxum5oUVfb+xYjY5KxFF/CqOUL8UeIWnzXMOb6zXshIoAy/pMAd1uyTcEMaaOV
         pf2WzhsJzL+nsEZbxiDqIHoG2l928G/bmtvrzjWj+6z5Y+AlS5YSQeXLIfAbDlgQGJ
         +3Rhkt2OTUqrwkTgS4tVO7qjcsRtQiym9LK0aWiRJddCCQ4vQG3hBy6jboZOFWlk/Q
         AGZedqjsfoA3A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4F0E2C4166F;
        Wed, 31 Aug 2022 21:20:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 0/3] fixes for concurrent htab updates
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166198081631.608.3839068750584107642.git-patchwork-notify@kernel.org>
Date:   Wed, 31 Aug 2022 21:20:16 +0000
References: <20220831042629.130006-1-houtao@huaweicloud.com>
In-Reply-To: <20220831042629.130006-1-houtao@huaweicloud.com>
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     bpf@vger.kernel.org, songliubraving@fb.com, bigeasy@linutronix.de,
        sunhao.th@gmail.com, haoluo@google.com, andrii@kernel.org,
        yhs@fb.com, ast@kernel.org, daniel@iogearbox.net, kafai@fb.com,
        kpsingh@kernel.org, davem@davemloft.net, kuba@kernel.org,
        sdf@google.com, jolsa@kernel.org, john.fastabend@gmail.com,
        oss@lmb.io, houtao1@huawei.com
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
by Martin KaFai Lau <martin.lau@kernel.org>:

On Wed, 31 Aug 2022 12:26:26 +0800 you wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> Hi,
> 
> The patchset aims to fix the issues found during investigating the
> syzkaller problem reported in [0]. It seems that the concurrent updates
> to the same hash-table bucket may fail as shown in patch 1.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/3] bpf: Disable preemption when increasing per-cpu map_locked
    https://git.kernel.org/bpf/bpf-next/c/2775da216287
  - [bpf-next,v4,2/3] bpf: Propagate error from htab_lock_bucket() to userspace
    https://git.kernel.org/bpf/bpf-next/c/66a7a92e4d0d
  - [bpf-next,v4,3/3] selftests/bpf: Add test cases for htab update
    https://git.kernel.org/bpf/bpf-next/c/1c636b6277a2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


