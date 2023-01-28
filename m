Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E0667FAD5
	for <lists+bpf@lfdr.de>; Sat, 28 Jan 2023 21:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbjA1UaV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 28 Jan 2023 15:30:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjA1UaU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 28 Jan 2023 15:30:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC731199EA;
        Sat, 28 Jan 2023 12:30:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 732A060C50;
        Sat, 28 Jan 2023 20:30:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CA153C433A0;
        Sat, 28 Jan 2023 20:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674937816;
        bh=46QGk4R7oBO0/uI3nu8ndxhN+tqx6JxIwIWC5Ee2Hw8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=SAxrYj7964WvJlTaGgiWJnqfz32dV21lO3ivuyLAfdOWxz+GeTnOQyTwQ8d5u88i6
         KXUCrHUx8+6b/WxZ6u3NSrVl04pBK0q4ludgzwwt4MLIg+Cv0fvvZ4lMmieNxy7ukt
         G1n57pJFqCWThWswXfyxhBY5bS+r8uZq2+p95COmVEkI5qarKYNFR2C/nTNjfHp9an
         t3Bguvq3hhX0uOjYqpzoOSqdJwAIHzZW55pcLmpuyLLbBXoev4382et2ko56ayz25/
         m58SdFez0EXCeizPoeTHr3bZVapCTYpaU8utwetR7EeCU9VBKglELdpHQRJa5zDK1J
         UUmjkhf6CT8zA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 91082F83ED3;
        Sat, 28 Jan 2023 20:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Build-time assert that cpumask offset is zero
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167493781658.31903.16536653287119334829.git-patchwork-notify@kernel.org>
Date:   Sat, 28 Jan 2023 20:30:16 +0000
References: <20230128141537.100777-1-void@manifault.com>
In-Reply-To: <20230128141537.100777-1-void@manifault.com>
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@meta.com, john.fastabend@gmail.com, kpsingh@kernel.org,
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

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 28 Jan 2023 08:15:37 -0600 you wrote:
> The first element of a struct bpf_cpumask is a cpumask_t. This is done
> to allow struct bpf_cpumask to be cast to a struct cpumask. If this
> element were ever moved to another field, any BPF program passing a
> struct bpf_cpumask * to a kfunc expecting a const struct cpumask * would
> immediately fail to load. Add a build-time assertion so this is
> assumption is captured and verified.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Build-time assert that cpumask offset is zero
    https://git.kernel.org/bpf/bpf-next/c/cb4a21ea592f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


