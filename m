Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9724F4D91
	for <lists+bpf@lfdr.de>; Wed,  6 Apr 2022 03:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446416AbiDEXqD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 5 Apr 2022 19:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234081AbiDEVFt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 5 Apr 2022 17:05:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242C55621F
        for <bpf@vger.kernel.org>; Tue,  5 Apr 2022 13:30:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DC2C619A6
        for <bpf@vger.kernel.org>; Tue,  5 Apr 2022 20:30:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F0C9FC385A3;
        Tue,  5 Apr 2022 20:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649190614;
        bh=QHXQjHjr43fkURuRoqV/5ooRd/iaZWgiEwRhh3VtIwM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ucxjPfpwByIrS5YqvqERdW6clJqg7qjtGtJH6aIznlXd9Sn9GDSkRRUA9NT1tG+Aa
         6XTkIcnEf5K3RAvyXcwe9ZsWAuvLk+ng6RlzNaC2EmpKc3cjyxJjdnH800qkvU9tSb
         11ObZ6LUNBiPCIh0knqSzF8pJuRPitubeHliRTvF56YVmiuS4TnmRtVe6DCSoq8059
         LEygF4H9txC64xfquKaDdJHqRm01mEFOzMR7E+BI4QJNYG5sizOhZARxvh6wRBF1iK
         b53qyAquMlak0sawZugxrvmqU6d03a/vSHH7v4ZQXqS8I3zjYSyaSRv2GA/xrgKcp4
         r6rxVuCL2JrqQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BBE93E6D402;
        Tue,  5 Apr 2022 20:30:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 bpf-next 0/7] Add libbpf support for USDTs
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164919061375.1996.14109702912690500233.git-patchwork-notify@kernel.org>
Date:   Tue, 05 Apr 2022 20:30:13 +0000
References: <20220404234202.331384-1-andrii@kernel.org>
In-Reply-To: <20220404234202.331384-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, alan.maguire@oracle.com, davemarchevsky@fb.com,
        hengqi.chen@gmail.com
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

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 4 Apr 2022 16:41:55 -0700 you wrote:
> Add libbpf support for USDT (User Statically-Defined Tracing) probes.
> USDTs is important part of tracing, and BPF, ecosystem, widely used in
> mission-critical production applications for observability, performance
> analysis, and debugging.
> 
> And while USDTs themselves are pretty complicated abstraction built on top of
> uprobes, for end-users USDT is as natural a primitive as uprobes themselves.
> And thus it's important for libbpf to provide best possible user experience
> when it comes to build tracing applications relying on USDTs.
> 
> [...]

Here is the summary with links:
  - [v3,bpf-next,1/7] libbpf: add BPF-side of USDT support
    https://git.kernel.org/bpf/bpf-next/c/d72e2968fb25
  - [v3,bpf-next,2/7] libbpf: wire up USDT API and bpf_link integration
    https://git.kernel.org/bpf/bpf-next/c/2e4913e025fd
  - [v3,bpf-next,3/7] libbpf: add USDT notes parsing and resolution logic
    https://git.kernel.org/bpf/bpf-next/c/74cc6311cec9
  - [v3,bpf-next,4/7] libbpf: wire up spec management and other arch-independent USDT logic
    https://git.kernel.org/bpf/bpf-next/c/999783c8bbda
  - [v3,bpf-next,5/7] libbpf: add x86-specific USDT arg spec parsing logic
    https://git.kernel.org/bpf/bpf-next/c/4c59e584d158
  - [v3,bpf-next,6/7] selftests/bpf: add basic USDT selftests
    https://git.kernel.org/bpf/bpf-next/c/630301b0d59d
  - [v3,bpf-next,7/7] selftests/bpf: add urandom_read shared lib and USDTs
    https://git.kernel.org/bpf/bpf-next/c/00a0fa2d7d49

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


