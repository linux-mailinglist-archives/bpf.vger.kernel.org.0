Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36835A34D1
	for <lists+bpf@lfdr.de>; Sat, 27 Aug 2022 07:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245224AbiH0FUa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 27 Aug 2022 01:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344317AbiH0FUW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 27 Aug 2022 01:20:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CEB9140B1;
        Fri, 26 Aug 2022 22:20:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BE7C60F5B;
        Sat, 27 Aug 2022 05:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D8EC5C433B5;
        Sat, 27 Aug 2022 05:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661577619;
        bh=WM/UtiXaJRvo5BK8U3x/+ku9JCZkBnfpi3K6rAH7YuY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=IRSNao1B3h2B3eiGjs63i8+uxaNvvwL9jaYB0FI1jxqxBmPabI4u1WbffngC0s3Cu
         6YXpZHdxzO4tRtdYzBAF9eTnCRhF54s4e5S/Z7x8Ud7kHNifkxrN6ID4iWMFnarVVt
         Z0i3jsxmr/JubMMLRyTbHwATK7r8RUyWXcUHe+rp3xMDV5Hf87bJdnZHsiTk7OiDbm
         qxjiuow02Uw8f8xMEe0iSh2PhBmeWVHezR4ZE37c7blaHgRQ7IYiZ0P/fiNEsPF3Cn
         5SjWnFBz1U1mfPvcyCpdoW1eWrVJzZYDMdgDXrK/9M4Zb2izeFizCD/DVREvIMeeeK
         J69wdgxcxXV4w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B94CFE2A040;
        Sat, 27 Aug 2022 05:20:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3] bpf: Fix a few typos in BPF helpers documentation
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166157761975.880.10542151779398136572.git-patchwork-notify@kernel.org>
Date:   Sat, 27 Aug 2022 05:20:19 +0000
References: <20220825220806.107143-1-quentin@isovalent.com>
In-Reply-To: <20220825220806.107143-1-quentin@isovalent.com>
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        alx.manpages@gmail.com, jwilk@jwilk.net, brouer@redhat.com,
        linux-man@vger.kernel.org
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

On Thu, 25 Aug 2022 23:08:06 +0100 you wrote:
> Address a few typos in the documentation for the BPF helper functions.
> They were reported by Jakub [0], who ran spell checkers on the generated
> man page [1].
> 
> [0] https://lore.kernel.org/linux-man/d22dcd47-023c-8f52-d369-7b5308e6c842@gmail.com/T/#mb02e7d4b7fb61d98fa914c77b581184e9a9537af
> [1] https://lore.kernel.org/linux-man/eb6a1e41-c48e-ac45-5154-ac57a2c76108@gmail.com/T/#m4a8d1b003616928013ffcd1450437309ab652f9f
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3] bpf: Fix a few typos in BPF helpers documentation
    https://git.kernel.org/bpf/bpf-next/c/aa75622c3be4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


