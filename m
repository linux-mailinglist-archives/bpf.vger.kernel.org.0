Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A911658746
	for <lists+bpf@lfdr.de>; Wed, 28 Dec 2022 23:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbiL1WUV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Dec 2022 17:20:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbiL1WUT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Dec 2022 17:20:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD49513D16
        for <bpf@vger.kernel.org>; Wed, 28 Dec 2022 14:20:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5964AB81907
        for <bpf@vger.kernel.org>; Wed, 28 Dec 2022 22:20:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D493AC433F1;
        Wed, 28 Dec 2022 22:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672266015;
        bh=RStqZZFRpJjPHCLSc6RmPEahtejP5LyoL+zm6xD/vDc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=A+Nv2P5edT+u4NBklnMCk0cb9JGlo+tg+DPvVWq73WXqb5wgcRypcqChUypXaZzJD
         jcN1HLCCt6pXMxvHzI9hSp6KxoLwQgN7XIGvk38V0Q7zDNTXmMFqkrp4Vx5eObIr7a
         P743Bid6zth1MkME9zIHHXhYmKbLrTH1MTwyGdjwl8q2VngOsqT7+5e+4uifCtWiK0
         UMfgMOp59vakrTgwScCE9bzFH7sxrOFCbPsmmEFPI1ob6lokzu4hNzO8lErJtgnAKh
         OJdJbksIsDjIfYPQfZYqrpNh7S24eJ5rboNixZ0HpEhTu2lr+zKLKoLFMOsBBZ1Ntl
         z2JtNWi7xVENw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AB267C395E0;
        Wed, 28 Dec 2022 22:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/2] bpf: fix the crash caused by task iterators
 over vma
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167226601569.12161.1736213050124160637.git-patchwork-notify@kernel.org>
Date:   Wed, 28 Dec 2022 22:20:15 +0000
References: <20221216221855.4122288-1-kuifeng@meta.com>
In-Reply-To: <20221216221855.4122288-1-kuifeng@meta.com>
To:     Kui-Feng Lee <kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        kernel-team@meta.com, song@kernel.org, yhs@meta.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 16 Dec 2022 14:18:53 -0800 you wrote:
> This issue is related to task iterators over vma. A system crash can
> occur when a task iterator travels through vma of tasks as the death
> of a task will clear the pointer to its mm, even though the
> task_struct is still held. As a result, an unexpected crash happens
> due to a null pointer. To address this problem, a reference to mm is
> kept on the iterator to make sure that the pointer is always
> valid. This patch set provides a solution for this crash by properly
> referencing mm on task iterators over vma.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] bpf: keep a reference to the mm, in case the task is dead.
    https://git.kernel.org/bpf/bpf/c/7ff94f276f8e
  - [bpf-next,v2,2/2] selftests/bpf: add a test for iter/task_vma for short-lived processes
    https://git.kernel.org/bpf/bpf/c/b7793c8db7d9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


