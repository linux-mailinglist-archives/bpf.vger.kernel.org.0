Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF7C6A4D69
	for <lists+bpf@lfdr.de>; Mon, 27 Feb 2023 22:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjB0VkY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 16:40:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjB0VkX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 16:40:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3511A4A1
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 13:40:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 51158B80DC4
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 21:40:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E68C4C4339E;
        Mon, 27 Feb 2023 21:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677534017;
        bh=n3wJpNRstyeWw7dz7Nq5UI9MuZubWosd+mmge5T1Zhk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=eZxQNxieniH755TREq/EdqflwKUR48wUrh1HFUSvfpauQh8gcrcE4NHDcTZ4C0EPX
         SLltldAtnZ7svfuHoHzCv1ptsPi7z3e/aRFOKDgcli8LwozinFeVWl7QMwd7TP/ztb
         FhmlkYh34XIg6KSWZIPUIsif3cLXMSE0MFbKXVH0Puif58fYyDLEJM4GhNCYQB0Vd5
         VXMvd4cHXDLaTQ72j1bEo2k1SF0nl4qDNUg9MFYKqxEk2KlRhi86aZ/QQImZipc1Gf
         HhuSQ7XKmshgL2KOihy5wp2htGdAL97bhxG3itsSfjxn5Bm5ziKBvatM1K7CBDHxTW
         x4iXV86Y6dtcg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CC50BE21EC4;
        Mon, 27 Feb 2023 21:40:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: Document
 bpf_{btf,link,map,prog}_get_info_by_fd()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167753401683.12319.2210223719634790597.git-patchwork-notify@kernel.org>
Date:   Mon, 27 Feb 2023 21:40:16 +0000
References: <20230220234958.764997-1-iii@linux.ibm.com>
In-Reply-To: <20230220234958.764997-1-iii@linux.ibm.com>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        bpf@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com
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

On Tue, 21 Feb 2023 00:49:58 +0100 you wrote:
> Replace the short informal description with the proper doc comments.
> 
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  tools/lib/bpf/bpf.h | 67 ++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 63 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [bpf-next] libbpf: Document bpf_{btf,link,map,prog}_get_info_by_fd()
    https://git.kernel.org/bpf/bpf-next/c/0a504fa1a780

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


