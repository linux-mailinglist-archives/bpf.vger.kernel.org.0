Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD4F5FDDD7
	for <lists+bpf@lfdr.de>; Thu, 13 Oct 2022 18:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiJMQAZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Oct 2022 12:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiJMQAX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Oct 2022 12:00:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CACE379EC6
        for <bpf@vger.kernel.org>; Thu, 13 Oct 2022 09:00:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 543AEB81F2C
        for <bpf@vger.kernel.org>; Thu, 13 Oct 2022 16:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DEE85C433C1;
        Thu, 13 Oct 2022 16:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665676820;
        bh=IVvqQT3Em4JkPwDvERwYLExpHwN48JOfwLFCHouAbaI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Nr/qaZlm6Nw7hJ2kfuPNPlIhMNYIXXNso5eO2j0iDsjplPmm2cYyceFBRMi7SpGX0
         YZMkhWB4V2O7yAQzd7L7KU5S5+yxwTuFKwmgz706ShIYOLEXhlfz7l4rpo3D7NU+aq
         S2UHrJzJ6J4vMI1CHAr7eW0YZQe8PBsFBQB38M/jD0RLRuo2XR7TFZurCrHwn3YV7H
         1bulJ2XrnuhP3bVt0RdDTPgKglvQkXTikNhZpFDz6YUu/LckAswxga3N5c+d6+SwI7
         C192TPK2VAxG8c5ot7fwgCuuyR9cDL1p/E7F9kgHdVPlKSZZ/LeQ7228MtI2iG0lcX
         qM/VQmprFRArg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B78A8E29F31;
        Thu, 13 Oct 2022 16:00:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/3] libbpf: fix fuzzer-reported issues
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166567681973.4134.13920189690256469312.git-patchwork-notify@kernel.org>
Date:   Thu, 13 Oct 2022 16:00:19 +0000
References: <20221012022353.7350-1-shung-hsi.yu@suse.com>
In-Reply-To: <20221012022353.7350-1-shung-hsi.yu@suse.com>
To:     Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 12 Oct 2022 10:23:50 +0800 you wrote:
> Hi, this patch set fixes several fuzzer-reported issues of libbpf when
> dealing with (malformed) BPF object file:
> 
> - patch #1 fix out-of-bound heap write reported by oss-fuzz (currently
>   incorrectly marked as fixed)
> 
> - patch #2 and #3 fix null-pointer dereference found by locally-run
>   fuzzer.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/3] libbpf: use elf_getshdrnum() instead of e_shnum
    https://git.kernel.org/bpf/bpf-next/c/ea306bb65ff8
  - [bpf-next,v2,2/3] libbpf: deal with section with no data gracefully
    https://git.kernel.org/bpf/bpf-next/c/662e24598d8c
  - [bpf-next,v2,3/3] libbpf: fix null-pointer dereference in find_prog_by_sec_insn()
    https://git.kernel.org/bpf/bpf-next/c/79d0ca2d19bf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


