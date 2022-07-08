Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A4E56AF5F
	for <lists+bpf@lfdr.de>; Fri,  8 Jul 2022 02:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236756AbiGHAUR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Jul 2022 20:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236022AbiGHAUQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Jul 2022 20:20:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C19A6EEA1
        for <bpf@vger.kernel.org>; Thu,  7 Jul 2022 17:20:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EC558B824A6
        for <bpf@vger.kernel.org>; Fri,  8 Jul 2022 00:20:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B00C1C341C0;
        Fri,  8 Jul 2022 00:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657239613;
        bh=dtp+OlmQ++gTz5TG/JLZTy2A9Rp/uDVLS2T4UFVFSH8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=uoVcjI6lJMYBBlzscWMNGDUUCHcz9w03Av1Wg3bxj1HU7Sb7ocGvSZ9mq5GP5qoPR
         l09e8znJmkcS1yLZBjSpae/6dsEgbcoR3grDljL9dKxOiq1EkQ89rzKeizsM/hUZ6x
         /gV1FJ0T8JtoZhWi/1y9lHL+x8lvcyPcGR9uRDfCU7jdbzD8C8zaC6lehkEJSmJ5sk
         vEqc1Bzo4f1xaG+4qCIpAZ1H+/cRtohAo9Hgy20d0UkL+pKlX4+ATlrMJ/7V13oS1Z
         I0gYzAaznOpy4vnXRY/4YqkEGgcwAS9c9U+5+Jl38aVoAFaU/9tAWo1Xyy/jFuyMYl
         He3VRonLMXPmg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9413AE45BDC;
        Fri,  8 Jul 2022 00:20:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v1] bpf: Add flags arg to bpf_dynptr_read and
 bpf_dynptr_write APIs
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165723961360.9316.6321891348330915795.git-patchwork-notify@kernel.org>
Date:   Fri, 08 Jul 2022 00:20:13 +0000
References: <20220706232547.4016651-1-joannelkoong@gmail.com>
In-Reply-To: <20220706232547.4016651-1-joannelkoong@gmail.com>
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        ast@kernel.org
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed,  6 Jul 2022 16:25:47 -0700 you wrote:
> Commit 13bbbfbea759 ("bpf: Add bpf_dynptr_read and bpf_dynptr_write")
> added the bpf_dynptr_write and bpf_dynptr_read APIs.
> 
> However, it will be useful for some dynptr types to pass in flags as
> well (eg when writing to a skb, the user may like to invalidate the
> hash or recompute the checksum).
> 
> [...]

Here is the summary with links:
  - [bpf-next,v1] bpf: Add flags arg to bpf_dynptr_read and bpf_dynptr_write APIs
    https://git.kernel.org/bpf/bpf/c/59018468b631

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


