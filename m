Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F75665169
	for <lists+bpf@lfdr.de>; Wed, 11 Jan 2023 03:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjAKCAU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Jan 2023 21:00:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbjAKCAT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Jan 2023 21:00:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2EEAB6B
        for <bpf@vger.kernel.org>; Tue, 10 Jan 2023 18:00:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 81A92B81A96
        for <bpf@vger.kernel.org>; Wed, 11 Jan 2023 02:00:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3053CC433D2;
        Wed, 11 Jan 2023 02:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673402416;
        bh=gOkca6Dcx4+P01ZUVNq6JkeULdBeiDfC9hTGV4ql2II=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=JF04f/Y7JI5pwbDe+N0DsOHZyVAeSCVGFvbNeaZN8adAOLQRV/TrCB0LMV7A5L1sh
         +21lbu6CSCHVTe76Et2438lSD/PFp8d/twGOEYLsmR6IKxOa32/qJHj3Y4LPzsGoUP
         vK4MZ85lzuhj/UsFpthd3OlFVUNYUve+o+4IZtPkwOan96mOtLqDLLq5zt7sbmA5vU
         GBWe4p1gSi4zrrt73zd5fWb8AYsrS01V4XJudJGaTn0HhGD5M7eim1oUNHxUXlrOob
         gUYvsJkgdqhhBL3Qoe4OqclSV8fQUgwdAGBjBo25tKOQ9zuQwyh1IvhtuG8X5fYAmQ
         fJjQTq0K4SPRQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 17300E21EE8;
        Wed, 11 Jan 2023 02:00:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpftool: fix output for skipping kernel config check
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167340241609.29210.4074423609152749474.git-patchwork-notify@kernel.org>
Date:   Wed, 11 Jan 2023 02:00:16 +0000
References: <20230109023742.29657-1-chethan.suresh@sony.com>
In-Reply-To: <20230109023742.29657-1-chethan.suresh@sony.com>
To:     Chethan Suresh <chethan.suresh@sony.com>
Cc:     quentin@isovalent.com, bpf@vger.kernel.org, Kenta.Tada@sony.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Mon,  9 Jan 2023 08:07:42 +0530 you wrote:
> When bpftool feature does not find kernel config
> files under default path or wrong format,
> do not output CONFIG_XYZ is not set.
> Skip kernel config check and continue.
> 
> Signed-off-by: Chethan Suresh <chethan.suresh@sony.com>
> Signed-off-by: Kenta Tada <Kenta.Tada@sony.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpftool: fix output for skipping kernel config check
    https://git.kernel.org/bpf/bpf-next/c/75514e4c6619

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


