Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76BE54F214E
	for <lists+bpf@lfdr.de>; Tue,  5 Apr 2022 06:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbiDEC5d (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 4 Apr 2022 22:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbiDEC5Y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 4 Apr 2022 22:57:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E6B22F3EB
        for <bpf@vger.kernel.org>; Mon,  4 Apr 2022 19:07:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E7544B81AE2
        for <bpf@vger.kernel.org>; Mon,  4 Apr 2022 23:50:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AC1BDC340F3;
        Mon,  4 Apr 2022 23:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649116212;
        bh=0+fIzGQK68vxpJkuy5MiGdiuwie8U84JoWwrSdZoWDQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=YResJ/jNhQZM6iIqeENfWaJfSCe82aLmc2tPtjR65lVxohGsGc3NBS3fXpoE4BIBt
         qrcDAntriHRgnlrGH3XqI+Gc5Ef/qBOGEeQwgxJHbaUDCGFcExP378qCAox9xNhSTu
         T7Owk6BxMLk8VQFBJghFCXr1nMcUmygCZ+6DN6G4leLc6egXEFKwqZaoG5J3ovRl4x
         s8+03G8c/otkAyl3idW/PdxsVWhnHCpqRq3O9ianPkxCBVbwnCGAxfhJ/n4tggh3QB
         UKnLKKmU6dAWJBJNbqA07eY7cC/xJCFDPUPtitPt6imLcflhF6DZtiDZTvHyGXkaAZ
         9wVPxcun6Q8gA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8ED09E85B8C;
        Mon,  4 Apr 2022 23:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] libbpf: Support Debian in resolve_full_path()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164911621257.29832.11387489066224428902.git-patchwork-notify@kernel.org>
Date:   Mon, 04 Apr 2022 23:50:12 +0000
References: <20220404225020.51029-1-iii@linux.ibm.com>
In-Reply-To: <20220404225020.51029-1-iii@linux.ibm.com>
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

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue,  5 Apr 2022 00:50:20 +0200 you wrote:
> attach_probe selftest fails on Debian-based distros with `failed to
> resolve full path for 'libc.so.6'`. The reason is that these distros
> embraced multiarch to the point where even for the "main" architecture
> they store libc in /lib/<triple>.
> 
> This is configured in /etc/ld.so.conf and in theory it's possible to
> replicate the loader's parsing and processing logic in libbpf, however
> a much simpler solution is to just enumerate the known library paths.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] libbpf: Support Debian in resolve_full_path()
    https://git.kernel.org/bpf/bpf-next/c/568189310c20

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


