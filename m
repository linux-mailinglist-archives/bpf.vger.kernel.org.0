Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B2C6BD96E
	for <lists+bpf@lfdr.de>; Thu, 16 Mar 2023 20:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjCPTkc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Mar 2023 15:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbjCPTk2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Mar 2023 15:40:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E886E501A;
        Thu, 16 Mar 2023 12:40:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B4E2CB82337;
        Thu, 16 Mar 2023 19:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5A566C433EF;
        Thu, 16 Mar 2023 19:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678995619;
        bh=Qcoo2uEzbR3flQDWPx87j79lDDvXg34p78x3IbEnKZs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Am/bqP/1TZ3JuqywZ99Au3X1apqokjFsBlsSQMhXQDvaGj+c1vGHTZTisuoRsv4TB
         JDc96h+55kJinZCyygZtEfCt8ae2el/16Tc/AK9CoAIkmmRwEHjLy8Dz3g9JsInu1e
         s10AtDAa4lxYP5u6w8tuDR3cDR8bDzLDR79niu8oRVQia5HqRir8drSQqvqOvPqzIP
         OEpoOUO4anjg7sVRPtPX0PqWC9vmf3a6WvgLlLQXqzYHpYiE+55CkmjPrjVglTmn7M
         OafiDTHuaGjORhHVDKWwZfWNs0WZNwOZhTPhCIz6VM8A8lxQGY6tNzYJBxy2MS3oo9
         g0GO/V8794JNg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2FF33E66CBB;
        Thu, 16 Mar 2023 19:40:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/5] Make struct bpf_cpumask RCU safe
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167899561918.25671.10670272982001703575.git-patchwork-notify@kernel.org>
Date:   Thu, 16 Mar 2023 19:40:19 +0000
References: <20230316054028.88924-1-void@manifault.com>
In-Reply-To: <20230316054028.88924-1-void@manifault.com>
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 16 Mar 2023 00:40:23 -0500 you wrote:
> The struct bpf_cpumask type is currently not RCU safe. It uses the
> bpf_mem_cache_{alloc,free}() APIs to allocate and release cpumasks, and
> those allocations may be reused before an RCU grace period has elapsed.
> We want to be able to enable using this pattern in BPF programs:
> 
> private(MASK) static struct bpf_cpumask __kptr *global;
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/5] bpf: Free struct bpf_cpumask in call_rcu handler
    https://git.kernel.org/bpf/bpf-next/c/77473d1a962f
  - [bpf-next,v2,2/5] bpf: Mark struct bpf_cpumask as rcu protected
    https://git.kernel.org/bpf/bpf-next/c/63d2d83d21a6
  - [bpf-next,v2,3/5] bpf/selftests: Test using global cpumask kptr with RCU
    https://git.kernel.org/bpf/bpf-next/c/a5a197df58c4
  - [bpf-next,v2,4/5] bpf: Remove bpf_cpumask_kptr_get() kfunc
    https://git.kernel.org/bpf/bpf-next/c/1b403ce77dfb
  - [bpf-next,v2,5/5] bpf,docs: Remove bpf_cpumask_kptr_get() from documentation
    https://git.kernel.org/bpf/bpf-next/c/fec2c6d14fd5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


