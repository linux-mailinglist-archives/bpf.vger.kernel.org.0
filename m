Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A88076D3292
	for <lists+bpf@lfdr.de>; Sat,  1 Apr 2023 18:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjDAQUV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 1 Apr 2023 12:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjDAQUV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 1 Apr 2023 12:20:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D46AA5E1;
        Sat,  1 Apr 2023 09:20:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B81FEB80B53;
        Sat,  1 Apr 2023 16:20:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 71EC2C433EF;
        Sat,  1 Apr 2023 16:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680366017;
        bh=TfVkFAQrZRqszfcTd87B057fpnS2YlPX9AigM3sNpBk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=q0GXdfjk6CWtoXshR7/w9bTKsQqNd4ubmlT83L/igTvIwO8uc/6pf599oJkz4UmFr
         Dx35ia2gZEkuBlSVZ7G4Gbstk7RI3mM3roMPPuckEnONe0ke9hIJUeq+uQYNtGoFTS
         D0iQcCaF/1RnPzQbTGVUvOocv0ZicUa0ukS+RMDpMZB5mLb7Maa9EVk2TsEHJxmpyu
         ORjwHvCs2XrpMSteibrC1ZV2j/+OpDIxyUt0WxeYS9VyPX1JahD4Cz3Q9Kz/K4xQMa
         pbZrfzGG+x7BDanUOprgtszG726+Q6YdNAhef9KNpjVO3QbWJbMThJkDLMxHJJR42L
         bcnZ50JQfyZ0A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4B207E21EDD;
        Sat,  1 Apr 2023 16:20:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/3] Enable RCU semantics for task kptrs
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168036601729.14852.14484701453991641814.git-patchwork-notify@kernel.org>
Date:   Sat, 01 Apr 2023 16:20:17 +0000
References: <20230331195733.699708-1-void@manifault.com>
In-Reply-To: <20230331195733.699708-1-void@manifault.com>
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 31 Mar 2023 14:57:30 -0500 you wrote:
> In commit 22df776a9a86 ("tasks: Extract rcu_users out of union"), the
> 'refcount_t rcu_users' field was extracted out of a union with the
> 'struct rcu_head rcu' field. This allows us to use the field for
> refcounting struct task_struct with RCU protection, as the RCU callback
> no longer flips rcu_users to be nonzero after the callback is scheduled.
> 
> This patch set leverages this to do a few things:
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/3] bpf: Make struct task_struct an RCU-safe type
    https://git.kernel.org/bpf/bpf-next/c/d02c48fa1139
  - [bpf-next,v2,2/3] bpf: Remove now-defunct task kfuncs
    https://git.kernel.org/bpf/bpf-next/c/f85671c6ef46
  - [bpf-next,v2,3/3] bpf,docs: Update documentation to reflect new task kfuncs
    https://git.kernel.org/bpf/bpf-next/c/db9d479ab59b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


