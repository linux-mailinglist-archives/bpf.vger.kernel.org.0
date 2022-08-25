Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E395A1946
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 21:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbiHYTAf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Aug 2022 15:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243607AbiHYTAW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Aug 2022 15:00:22 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7840C9AFE3
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 12:00:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 35C40CE26EE
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 19:00:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 995DDC433D7;
        Thu, 25 Aug 2022 19:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661454015;
        bh=z7n0auvRxRvjnDKNNbgyOyIgTSPSZoPZcr2AxlfzCdw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=H8Xozox+aVR9Kpy9iy+yhWw+K6tJ5PBbyp4rEtIP5i57JakcLN7YGwW/GYSkG+/Pq
         jiWMOyIqjsFLn7GIa7WY9BulIUMZO4FCAmA6y7uFNx/8D2YrhGZ3Ei2Yjlz/DA1ZWq
         Ybxk1O/1N10Jegs0Vw2INiMIdWrY9EORN1WUUIK34Pz4ptPVFzb+mUoEUQoirfc3VR
         M6Az3TJM3MfxlLfFbaK/zn697AVgemxQG8jkC33w+ELF9qkRUVYj9uArzYBmvE/Sja
         d7G56lFcudosHZgstAKYzaEQ/mWrXshVKeMiubYjZaZFQ94WXqFZRy/4/aieU3042I
         MGfA+DoLZmaKw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7CA63C004EF;
        Thu, 25 Aug 2022 19:00:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next,v4] bpf/scripts: assert helper enum value is aligned
 with comment order
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166145401550.6908.8352252313511742991.git-patchwork-notify@kernel.org>
Date:   Thu, 25 Aug 2022 19:00:15 +0000
References: <20220824181043.1601429-1-eyal.birger@gmail.com>
In-Reply-To: <20220824181043.1601429-1-eyal.birger@gmail.com>
To:     Eyal Birger <eyal.birger@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, quentin@isovalent.com,
        bpf@vger.kernel.org
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

On Wed, 24 Aug 2022 21:10:43 +0300 you wrote:
> The helper value is ABI as defined by enum bpf_func_id.
> As bpf_helper_defs.h is used for the userpace part, it must be consistent
> with this enum.
> 
> Before this change the comments order was used by the bpf_doc script in
> order to set the helper values defined in the helpers file.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4] bpf/scripts: assert helper enum value is aligned with comment order
    https://git.kernel.org/bpf/bpf-next/c/0a0d55ef3e61

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


