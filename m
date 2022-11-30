Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC15863E5A0
	for <lists+bpf@lfdr.de>; Thu,  1 Dec 2022 00:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbiK3XkU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Nov 2022 18:40:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiK3XkT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Nov 2022 18:40:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4B64B743
        for <bpf@vger.kernel.org>; Wed, 30 Nov 2022 15:40:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 64A13B81D76
        for <bpf@vger.kernel.org>; Wed, 30 Nov 2022 23:40:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1763BC433D7;
        Wed, 30 Nov 2022 23:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669851616;
        bh=RqRJxGGVeWGg+CXaHn8S+KeiKXgpyLzz6XKOb8/ASHk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=NyBhmA42VAEiY7J+5ww15TnJVmsKOecaUXuPiK7ZWhPsuzjUzrI0LWhRUzRSQaveO
         swA+PBNXdL2sR12snmCWJY22sF1wRwf8Z7SHQFWkglS45TmF/iUAZ3R3rzC51KCDeu
         EXuZhpJ69TXzHvJh0H+7XMJ2GF6yhdV1yGRCr4SoxK46zijce7aUXBXtj7m29b4odm
         iOEPrKKpFwq/Zdi/tYYxFRdmn+GpVe4bicxqJExY+MinhLcwsJykmICY8bizFj3UV3
         HlkOVxcTPuJuVpK1K+orfpKJpQ2UubyLLL1rwpIJ+KcilANUQoTZs6ENQmpcjpVIsO
         io8JKddNQktew==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F417EE29F38;
        Wed, 30 Nov 2022 23:40:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next] bpf: Tighten ptr_to_btf_id checks.
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166985161599.6527.16328632982595384770.git-patchwork-notify@kernel.org>
Date:   Wed, 30 Nov 2022 23:40:15 +0000
References: <20221125220617.26846-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20221125220617.26846-1-alexei.starovoitov@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     davem@davemloft.net, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@kernel.org, yhs@fb.com, bpf@vger.kernel.org,
        kernel-team@fb.com
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

On Fri, 25 Nov 2022 14:06:17 -0800 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> The networking programs typically don't require CAP_PERFMON, but through kfuncs
> like bpf_cast_to_kern_ctx() they can access memory through PTR_TO_BTF_ID. In
> such case enforce CAP_PERFMON.
> Also make sure that only GPL programs can access kernel data structures.
> All kfuncs require GPL already.
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next] bpf: Tighten ptr_to_btf_id checks.
    https://git.kernel.org/bpf/bpf-next/c/c67cae551f0d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


