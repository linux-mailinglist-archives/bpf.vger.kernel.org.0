Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98FA968E327
	for <lists+bpf@lfdr.de>; Tue,  7 Feb 2023 22:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjBGVub (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Feb 2023 16:50:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjBGVuW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Feb 2023 16:50:22 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D000D9EF4;
        Tue,  7 Feb 2023 13:50:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B4348CE1DDE;
        Tue,  7 Feb 2023 21:50:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BE525C4339B;
        Tue,  7 Feb 2023 21:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675806617;
        bh=KTTbZ5BnYJb/zfCqW8eyLI+b2ugGmk6RjmJzPv8XacE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=cNPpcBVPq243DhnW7RJOpsoIWgWbgk4+lrGddYl+tPD2LXaqXww7JrwP4NP6wTDtB
         jcE/aZkZNynV9A0Xhir4MZGWovUxFmiX86uOERt1jFfG0+DgDUx4lHNUzFSpqnBxUp
         /9u292SO+B/Gs8A8H/3NqY0zM9H8TCErHXPBiwfO2dw7WViqS8w+00XtbNZqYmWbUC
         AOOnnyUIaNLlM5fS7/EiCAG45eY28i2/0c11LqX+wzKd0k5Qe/EAl4+ehX89bhhg5k
         NF94vJ7Q+c8474uVvy2QoeCIwSN7ZwN+7ELMHY+fVHMfrf3EOhnane7bRkUnlMQq0Q
         PtNeuMdaz07vw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A5E81E21ECB;
        Tue,  7 Feb 2023 21:50:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] tools/resolve_btfids: Tidy HOST_OVERRIDES
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167580661767.11027.16226467160781330499.git-patchwork-notify@kernel.org>
Date:   Tue, 07 Feb 2023 21:50:17 +0000
References: <20230202224253.40283-1-irogers@google.com>
In-Reply-To: <20230202224253.40283-1-irogers@google.com>
To:     Ian Rogers <irogers@google.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, connoro@google.com,
        nathan@kernel.org, memxor@gmail.com, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu,  2 Feb 2023 14:42:53 -0800 you wrote:
> Don't set EXTRA_CFLAGS to HOSTCFLAGS, ensure CROSS_COMPILE isn't
> passed through.
> 
> This patch is based on top of:
> https://lore.kernel.org/bpf/20230202112839.1131892-1-jolsa@kernel.org/
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> 
> [...]

Here is the summary with links:
  - [v1] tools/resolve_btfids: Tidy HOST_OVERRIDES
    https://git.kernel.org/bpf/bpf-next/c/e0975ab92f24

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


