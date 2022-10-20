Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2AD8605444
	for <lists+bpf@lfdr.de>; Thu, 20 Oct 2022 02:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbiJTAA1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Oct 2022 20:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbiJTAA0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Oct 2022 20:00:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A664127BCE
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 17:00:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1D4D614FC
        for <bpf@vger.kernel.org>; Thu, 20 Oct 2022 00:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 564E0C433D7;
        Thu, 20 Oct 2022 00:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666224024;
        bh=N5fdBgw4chLndzNlvOZcCw0g8+R6uRTYt67bSwLof2c=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=MNAURyG55XbCQEy9S3fwosthGyFiQCNy+CGwUXq4ERTu3lrBbJea34L6KyaxQyBnP
         ZYxD6KhojHGOgwGqRMW+Xd6+ix3k5LnfErz0UVWiRYNR11soxua3JO7Gp/QXtqQCSl
         KOeA8NGrrfSZt4GwtskWMEV4ASKVGBSYbKmxTgeuSRg9A2MAWYkOgAltmsmkpMdMj1
         YB30UubMGsrg7qYnxmBJlv+g59tJET3rTbPA7fdWFv07bPxjfbtc3lWhU+f68HN4Af
         OwFA05Wf+UPHxnDMEM11wxSdJ2AEh0HBXfDUZle/NxvRjIN95d838jXf2KIzCMRU84
         ez/jtIWtUJBOw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 36CBFE29F37;
        Thu, 20 Oct 2022 00:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v5 0/3] bpf,x64: Use BMI2 for shifts
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166622402421.8286.13818852593779653906.git-patchwork-notify@kernel.org>
Date:   Thu, 20 Oct 2022 00:00:24 +0000
References: <20221007202348.1118830-1-jmeng@fb.com>
In-Reply-To: <20221007202348.1118830-1-jmeng@fb.com>
To:     Jie Meng <jmeng@fb.com>
Cc:     kpsingh@kernel.org, bpf@vger.kernel.org, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 7 Oct 2022 13:23:46 -0700 you wrote:
> With baseline x64 instruction set, shift count can only be an immediate
> or in %cl. The implicit dependency on %cl makes it necessary to shuffle
> registers around and/or add push/pop operations.
> 
> BMI2 provides shift instructions that can use any general register as
> the shift count, saving us instructions and a few bytes in most cases.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v5,1/3] bpf,x64: avoid unnecessary instructions when shift dest is ecx
    https://git.kernel.org/bpf/bpf-next/c/81b35e7cad79
  - [bpf-next,v5,2/3] bpf,x64: use shrx/sarx/shlx when available
    https://git.kernel.org/bpf/bpf-next/c/77d8f5d47bfb
  - [bpf-next,v5,3/3] bpf: add selftests for lsh, rsh, arsh with reg operand
    https://git.kernel.org/bpf/bpf-next/c/8662de232149

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


