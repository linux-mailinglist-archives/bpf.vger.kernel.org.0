Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4830158A415
	for <lists+bpf@lfdr.de>; Fri,  5 Aug 2022 02:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234555AbiHEAKS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Aug 2022 20:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiHEAKS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Aug 2022 20:10:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E83C38AA
        for <bpf@vger.kernel.org>; Thu,  4 Aug 2022 17:10:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 911EAB82771
        for <bpf@vger.kernel.org>; Fri,  5 Aug 2022 00:10:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 49118C433D6;
        Fri,  5 Aug 2022 00:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659658213;
        bh=rq0Hhe00QJ7XwzQg89OdzlJFcBWCS7sJ9xiGQ1FRNDk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=fAtH0SBkKsdW2Jj8euYdTDUvwKCrJRwRHOgiFp5z70A3THkW2vwYiOc9oRk+Vvk8h
         GQ/rVhXy/tnSPnq4ZImqOPOuPSdmOn3kbvnFnfz8mW0Vo88GZ1R2zbFSZXU0d0l4D4
         c6GR9nUIEWWFewWJjqGcoWFAaixvLSVfySNKhLqktGk1uU9An1awqrkhHyd1F+94Wo
         JCzhy+qrQanxYR7tr3wuFUx9/C9xJhVGdQAwj2pPTqa7igUQYhEHqZbgZH9NhKiQZU
         0IcSK9pVu/MQz4LGUz+X19oTbI1NqiJYkH/6CGjC1QsreFoL2Gmb4DRak32hD1UYxo
         +H3QVMdNGkZ4g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2C913C43140;
        Fri,  5 Aug 2022 00:10:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] BPF: Fix potential bad pointer dereference in
 bpf_sys_bpf()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165965821317.31973.11949497927884411626.git-patchwork-notify@kernel.org>
Date:   Fri, 05 Aug 2022 00:10:13 +0000
References: <20220729201713.88688-1-jinghao@linux.ibm.com>
In-Reply-To: <20220729201713.88688-1-jinghao@linux.ibm.com>
To:     Jinghao Jia <jinghao@linux.ibm.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, martin.lau@linux.dev, song@kernel.org,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        mvle@us.ibm.com, jinghao7@illinois.edu
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 29 Jul 2022 20:17:13 +0000 you wrote:
> The bpf_sys_bpf() helper function allows an eBPF program to load another
> eBPF program from within the kernel. In this case the argument union
> bpf_attr pointer (as well as the insns and license pointers inside) is a
> kernel address instead of a userspace address (which is the case of a
> usual bpf() syscall). To make the memory copying process in the syscall
> work in both cases, bpfptr_t was introduced to wrap around the pointer
> and distinguish its origin. Specifically, when copying memory contents
> from a bpfptr_t, a copy_from_user() is performed in case of a userspace
> address and a memcpy() is performed for a kernel address.
> 
> [...]

Here is the summary with links:
  - [v2] BPF: Fix potential bad pointer dereference in bpf_sys_bpf()
    https://git.kernel.org/bpf/bpf/c/e2dcac2f58f5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


