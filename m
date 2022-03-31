Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6496A4EE498
	for <lists+bpf@lfdr.de>; Fri,  1 Apr 2022 01:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238040AbiCaXWB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 31 Mar 2022 19:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbiCaXWB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 31 Mar 2022 19:22:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C9F49685
        for <bpf@vger.kernel.org>; Thu, 31 Mar 2022 16:20:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 804DB61706
        for <bpf@vger.kernel.org>; Thu, 31 Mar 2022 23:20:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CA2C7C340F0;
        Thu, 31 Mar 2022 23:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648768811;
        bh=38ok4/O7BR7OMjh9nnY3Oapm6xh8XbE7wIqrso63dik=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=oWAdQQJ6ko6JgOZ25qqUJAe1ZwbTDDHnZ+Y9wu5U6pN31Iy2Tiwl085IVjise7hqC
         +s2PlJ8wpytS1l3bq2xRj7fPVK4A1eIoYaToLT58nnBjocFKF/sSHN9ALQTGNiUnT9
         JPD61fKfOJykOS4L/H6u8a4VpRx5JkLknbccZa+h8QQ5BJS+dA7kgRgZM35oF8Ssja
         TkMpjY4tUOZdRg29RtjeBA4faP040ui3TofskRu36A3+QcxUACsGMfjK9xpogj8ioN
         qZdal9A5QhDqj2QJVvV9l0wcw0ijoD7TB2G+IVwb/V9NLEbb8KuyBvebss5Q7HYlvx
         LSK5PyIlMsl0w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AE57EEAC09B;
        Thu, 31 Mar 2022 23:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -next v5 0/5] bpf,
 arm64: Optimize BPF store/load using arm64 str/ldr(immediate)
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164876881170.25543.2692947593544294416.git-patchwork-notify@kernel.org>
Date:   Thu, 31 Mar 2022 23:20:11 +0000
References: <20220321152852.2334294-1-xukuohai@huawei.com>
In-Reply-To: <20220321152852.2334294-1-xukuohai@huawei.com>
To:     Xu Kuohai <xukuohai@huawei.com>
Cc:     bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, will@kernel.org, daniel@iogearbox.net,
        ast@kernel.org, zlim.lnx@gmail.com, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, jthierry@redhat.com,
        mark.rutland@arm.com, houtao1@huawei.com, tabba@google.com,
        james.morse@arm.com
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
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon, 21 Mar 2022 11:28:47 -0400 you wrote:
> The current BPF store/load instruction is translated by the JIT into two
> instructions. The first instruction moves the immediate offset into a
> temporary register. The second instruction uses this temporary register
> to do the real store/load.
> 
> In fact, arm64 supports addressing with immediate offsets. So This series
> introduces optimization that uses arm64 str/ldr instruction with immediate
> offset when the offset fits.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v5,1/5] arm64: insn: add ldr/str with immediate offset
    https://git.kernel.org/bpf/bpf-next/c/30c90f6757a7
  - [bpf-next,v5,2/5] bpf, arm64: Optimize BPF store/load using arm64 str/ldr(immediate offset)
    https://git.kernel.org/bpf/bpf-next/c/7db6c0f1d8ee
  - [bpf-next,v5,3/5] bpf, arm64: adjust the offset of str/ldr(immediate) to positive number
    https://git.kernel.org/bpf/bpf-next/c/5b3d19b9bd40
  - [bpf-next,v5,4/5] bpf/tests: Add tests for BPF_LDX/BPF_STX with different offsets
    https://git.kernel.org/bpf/bpf-next/c/f516420f683d
  - [bpf-next,v5,5/5] bpf, arm64: add load store test case for tail call
    https://git.kernel.org/bpf/bpf-next/c/38608ee7b690

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


