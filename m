Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE1A66684A
	for <lists+bpf@lfdr.de>; Thu, 12 Jan 2023 02:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234049AbjALBKV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Jan 2023 20:10:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233592AbjALBKU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Jan 2023 20:10:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0BD1CB05;
        Wed, 11 Jan 2023 17:10:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D4EECB81DA6;
        Thu, 12 Jan 2023 01:10:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 70989C433F0;
        Thu, 12 Jan 2023 01:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673485816;
        bh=UHGQfjjAnmFNq8ZHx9S3Yr6sgFXvCig9y+hO7CtFyKY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=PzwIRs95hki+ps5HRq5QyyQY1UFk5Yvr12ujrd0SgyTS9bqEPzqJvuDTLj6ujv0rJ
         aPULbsosStdbVTx1xj31aMJ2/LIN5INHyW6W/9DiT1n5XrHBNwHs+inPEsaiH2SSjv
         rp4vGR6An4IzLlZ055FNP8/3bHTPKNyAbEQTFBZ2Gs3EbRK6ffQhrd9J5bF5TRDoLL
         0TcBgYtK+aKZ4G6gXgptGQW/0gvY+r07LeTgnPw44f2CulXUpqdsPo98qbgHhe7pc4
         7nNXvOT7IjGmE7eyEKnvqbUpd2RNd8jo7XwcriQpo4Nl+LdYT/SsiSFeaJIjDT6gea
         FYEx6v06VVgdw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4E3FCE49FB3;
        Thu, 12 Jan 2023 01:10:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf_doc: Fix build error with older python versions
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167348581631.28711.16500772728751641441.git-patchwork-notify@kernel.org>
Date:   Thu, 12 Jan 2023 01:10:16 +0000
References: <20230109113442.20946-1-msuchanek@suse.de>
In-Reply-To: <20230109113442.20946-1-msuchanek@suse.de>
To:     Michal Suchanek <msuchanek@suse.de>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, toke@redhat.com,
        quentin@isovalent.com, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
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
by Andrii Nakryiko <andrii@kernel.org>:

On Mon,  9 Jan 2023 12:34:42 +0100 you wrote:
> The ability to subscript match result as an array is only available
> since python 3.6. Existing code in bpf_doc uses the older group()
> interface but commit 8a76145a2ec2 adds code using the new interface.
> 
> Use the old interface consistently to avoid build error on older
> distributions like the below:
> 
> [...]

Here is the summary with links:
  - bpf_doc: Fix build error with older python versions
    https://git.kernel.org/bpf/bpf-next/c/5fbea42387eb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


