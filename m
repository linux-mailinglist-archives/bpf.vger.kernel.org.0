Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAE8A68A002
	for <lists+bpf@lfdr.de>; Fri,  3 Feb 2023 18:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbjBCRKW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Feb 2023 12:10:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbjBCRKW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Feb 2023 12:10:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB721E2A8;
        Fri,  3 Feb 2023 09:10:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EB738B82B69;
        Fri,  3 Feb 2023 17:10:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 94F42C4339B;
        Fri,  3 Feb 2023 17:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675444218;
        bh=Lc8NBVtIgoOB6hZSbFKyiIR44HSS+0RVfc5tRCfB04A=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=B4prKb1Vsv1QGR3b+OvIV1egZOWdM1VpL9Pa6b++ig1Zvi0/Gjjvgkr7m0j8VqKlZ
         G+n5fKgZS25nFJhF1Yw0Ntx37UcC6sT/NEtqkXvyC3egCtwxemBeupPts1PRU/JZRB
         IyGO98dx6zpWXkUKYoEFWa5mBPTmeN50sCl+iqsWpj5HRW5m/QuNHN0dg6sJBvBLV+
         xjpsrO7ZIgwXe0wFyr9fQY3piTxSHGEZVQ+ROPMtotmmh7DVxQ7hYfDDh60uRP645L
         we+s3ptEEIsYvSJunsQPmQPTthU0NvggWgCxqAvEYt6Iibpfl9Z0QrUjYBaZmeMe7h
         LTVzWvl5fyp/g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7AA17E270C5;
        Fri,  3 Feb 2023 17:10:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3] bpf/docs: Document kfunc lifecycle / stability
 expectations
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167544421849.11975.17490109682248659493.git-patchwork-notify@kernel.org>
Date:   Fri, 03 Feb 2023 17:10:18 +0000
References: <20230203155727.793518-2-void@manifault.com>
In-Reply-To: <20230203155727.793518-2-void@manifault.com>
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@meta.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        toke@redhat.com, corbet@lwn.net, linux-doc@vger.kernel.org,
        brouer@redhat.com, bagasdotme@gmail.com, linux-api@vger.kernel.org
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
by Alexei Starovoitov <ast@kernel.org>:

On Fri,  3 Feb 2023 09:57:27 -0600 you wrote:
> BPF kernel <-> kernel API stability has been discussed at length over
> the last several weeks and months. Now that we've largely aligned over
> kfuncs being the way forward, and BPF helpers being considered
> functionally frozen, it's time to document the expectations for kfunc
> lifecycles and stability so that everyone (BPF users, kfunc developers,
> and maintainers) are all aligned, and have a crystal-clear understanding
> of the expectations surrounding kfuncs.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3] bpf/docs: Document kfunc lifecycle / stability expectations
    https://git.kernel.org/bpf/bpf-next/c/16c294a6aad8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


