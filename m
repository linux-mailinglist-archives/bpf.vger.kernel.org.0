Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E98B65C0566
	for <lists+bpf@lfdr.de>; Wed, 21 Sep 2022 19:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiIURkR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Sep 2022 13:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiIURkQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Sep 2022 13:40:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A2E9AFB3;
        Wed, 21 Sep 2022 10:40:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A91A63190;
        Wed, 21 Sep 2022 17:40:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A64E5C433B5;
        Wed, 21 Sep 2022 17:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663782014;
        bh=ptgeVycCndSfgArMWQbv9V7R5LzLzdkAMJOx51U/KJU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Ha6lqux/QDTac0QuBAjYyRwBZ+g3qb9RehOFvPOU5zoLl0z4J4ilGtRVYrMNB/Txo
         LzROpf82XmtvEiYuG5B8guUqmI0CdWquh5DfV12K14Z/SE8KaSsi/SjWbAwmT8hhFo
         IvdKyJnWZokD9bHAEO64KwBX6eoXtBxCFHwVrWGS6M15MQajz5T7l73x9yvlgc4ctj
         mPt8yrTCSvD5OvgYpD0HP7ZsOadRRDo88F4D5UJ+40fRPSUSLhYFV3W8ZQurIpXTbB
         +rE17Ui1Lq0AySJUbPiIRYhHkWGG1jG4D1+GrKq2oKJ7o0jLKSx02sU2tbkqtJlwY9
         OzxD2zKgmiGbA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8605EE4D03E;
        Wed, 21 Sep 2022 17:40:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -next] bpf: simplify code in btf_parse_hdr
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166378201454.22118.6841562925667328899.git-patchwork-notify@kernel.org>
Date:   Wed, 21 Sep 2022 17:40:14 +0000
References: <20220917084248.3649-1-williamsukatube@163.com>
In-Reply-To: <20220917084248.3649-1-williamsukatube@163.com>
To:     None <williamsukatube@163.com>
Cc:     martin.lau@linux.dev, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org
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

On Sat, 17 Sep 2022 16:42:48 +0800 you wrote:
> From: William Dean <williamsukatube@163.com>
> 
> It could directly return 'btf_check_sec_info' to simplify code.
> 
> Signed-off-by: William Dean <williamsukatube@163.com>
> ---
>  kernel/bpf/btf.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> [...]

Here is the summary with links:
  - [-next] bpf: simplify code in btf_parse_hdr
    https://git.kernel.org/bpf/bpf-next/c/3a74904ceff3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


