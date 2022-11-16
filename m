Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6844A62B2E3
	for <lists+bpf@lfdr.de>; Wed, 16 Nov 2022 06:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbiKPFlD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Nov 2022 00:41:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbiKPFku (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Nov 2022 00:40:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C7B3F054;
        Tue, 15 Nov 2022 21:40:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 16E47B81BE9;
        Wed, 16 Nov 2022 05:40:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AF05BC433C1;
        Wed, 16 Nov 2022 05:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668577215;
        bh=F38dFjqJDcoLpdOda+PXzyV5DZdiSNt5Faoasudbz3Q=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=HAGQO9SXKxDi8Wn5MBsSBO+Benuz3raIwB1lt36MYgab2aMe29kCaFvziYbPmvluO
         UNKJAMyDlUefrkdwjToJc5snW2Vuzvt5QTigqqYtaylWkmPE40XC3UL+hLGZNWsJ1c
         cY7tVSC5ftqvlgWeA/FRJY2M0+Y/fdN8vbu9vQZ6Ocz6Hc/EzQS9Duo4wQHX3kl5nh
         59HDMVLMZg5NrnvOwCgODtyJXbOpZDXyaY0Jkq4mGaJQKp3/jkGnT8Ad1qM6Y6p06p
         2x3c3m5SZ/+SDIxQou0qTj0xqIbdETLTZqCIGsEx7EZYKCyjtJyoYJe8pBcmVI4+5N
         KORmc1NnH00Vw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8D84AE270C0;
        Wed, 16 Nov 2022 05:40:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] bpftool: Check argc first before "file" in
 do_batch()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166857721556.26805.8214958255421796262.git-patchwork-notify@kernel.org>
Date:   Wed, 16 Nov 2022 05:40:15 +0000
References: <1668517207-11822-1-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1668517207-11822-1-git-send-email-yangtiezhu@loongson.cn>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     quentin@isovalent.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Tue, 15 Nov 2022 21:00:07 +0800 you wrote:
> If the parameters for batch are more than 2, check argc first can
> return immediately, no need to use is_prefix() to check "file" with
> a little overhead and then check argc, it is better to check "file"
> only when the parameters for batch are 2.
> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] bpftool: Check argc first before "file" in do_batch()
    https://git.kernel.org/bpf/bpf-next/c/df9c41e9db2d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


