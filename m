Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF97C69F73A
	for <lists+bpf@lfdr.de>; Wed, 22 Feb 2023 16:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbjBVPAc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Feb 2023 10:00:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbjBVPAb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Feb 2023 10:00:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FAC738E80
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 07:00:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2C1DBB815D5
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 15:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 66797C43443;
        Wed, 22 Feb 2023 15:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677078022;
        bh=0oDUe0Xt/tqWs2ZxwJwubY6IyWBJxtkUnsBIUqtVhWM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=kV9DJquxEHU02JBWtaMKauDl9LVCTnoMmVVWpipucOh1AnDtdGGttPPtWXKd3hJMH
         RS5V9w+khbSkP6XQGVjBDXknt5dHLcPAuEMeTgZcJTjHwmEVKYItJDtJCKRQeYTMML
         MRxJxzHS2ANxRXj/iiUkNOk5wkJH/GEDfgIKweqLoi83i5YoTaqA3cMSLZrr0Uo3hp
         HwWDsYxgu8N2xlPzpwbJyL+GkkZAtCZou9e4P8bwHBMW4TanRlEl+NuuJlZ76Flam6
         n2l7Q9ODHLfjJFGNkuPvXvjTDJkqt5OsdeJi5HpnxXcPFXzqBuh+F5iqIni6O8piZ0
         V1PaeNRT92T2g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 422D0E270E2;
        Wed, 22 Feb 2023 15:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv, mm: Perform BPF exhandler fixup on page fault
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <167707802226.24438.2156387825530343210.git-patchwork-notify@kernel.org>
Date:   Wed, 22 Feb 2023 15:00:22 +0000
References: <20230214162515.184827-1-bjorn@kernel.org>
In-Reply-To: <20230214162515.184827-1-bjorn@kernel.org>
To:     =?utf-8?b?QmrDtnJuIFTDtnBlbCA8Ympvcm5Aa2VybmVsLm9yZz4=?=@ci.codeaurora.org
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, bjorn@rivosinc.com,
        bpf@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Tue, 14 Feb 2023 17:25:15 +0100 you wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
> 
> Commit 21855cac82d3 ("riscv/mm: Prevent kernel module to access user
> memory without uaccess routines") added early exits/deaths for page
> faults stemming from accesses to user-space without using proper
> uaccess routines (where sstatus.SUM is set).
> 
> [...]

Here is the summary with links:
  - riscv, mm: Perform BPF exhandler fixup on page fault
    https://git.kernel.org/riscv/c/416721ff05fd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


