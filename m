Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8801F659287
	for <lists+bpf@lfdr.de>; Thu, 29 Dec 2022 23:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbiL2WkV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Dec 2022 17:40:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiL2WkT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Dec 2022 17:40:19 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1228214024;
        Thu, 29 Dec 2022 14:40:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 555BACE16CA;
        Thu, 29 Dec 2022 22:40:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 93C77C433F0;
        Thu, 29 Dec 2022 22:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672353615;
        bh=YTeAya3sAyksUTVeAFd2g0dgm0CJ8kwV1GO3dUbPplk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Ny3DUGBA4s30f60TxXPwnszhkld9uYfhdFwc0NDzXt5z5hTyY9ozd9PztLLvNSZST
         oVnV9SPBccKKm6AAk4U3PIA9UAMdtE1a6V3ZxeGrzjP6qrt8+4EQoBtl2DRhHqEzQo
         xDXxatjiJ+2rToHKB93j+l0rsr1icwxXRRrVwMb9pEcuHR239VB8/BqVNu4GVKh2ag
         huEjZ/m0hc34/Nmf1TFsqHDHK3bmP4611gJAohWM37xMii8QrZvJbJw6+/kOIucIl7
         DHNo4BI1j6PmT7d/1Qq8RXLkHDuLJU2HJdXBDL8La8sEDdQDN5SA8LuVikuOsivu5r
         sKrO7NP8C079g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7C24BE50D71;
        Thu, 29 Dec 2022 22:40:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] libbpf: Added the description of some API functions
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167235361550.16779.392269015773043979.git-patchwork-notify@kernel.org>
Date:   Thu, 29 Dec 2022 22:40:15 +0000
References: <20221224112058.12038-1-liuxin350@huawei.com>
In-Reply-To: <20221224112058.12038-1-liuxin350@huawei.com>
To:     Xin Liu <liuxin350@huawei.com>
Cc:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, yanan@huawei.com,
        wuchangye@huawei.com, xiesongyang@huawei.com,
        kongweibin2@huawei.com, zhangmingyi5@huawei.com
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

On Sat, 24 Dec 2022 19:20:58 +0800 you wrote:
> Currently, many API functions are not described in the document.
> I have tried to add the API description of the following four API
> functions:
>  libbpf_set_print
>  bpf_object__open
>  bpf_object__load
>  bpf_object__close
> 
> [...]

Here is the summary with links:
  - libbpf: Added the description of some API functions
    https://git.kernel.org/bpf/bpf-next/c/678a1c036199

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


