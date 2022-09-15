Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95AA25B9847
	for <lists+bpf@lfdr.de>; Thu, 15 Sep 2022 11:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiIOJyq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Sep 2022 05:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbiIOJxv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Sep 2022 05:53:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2AF9A999
        for <bpf@vger.kernel.org>; Thu, 15 Sep 2022 02:51:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71CD1621E9
        for <bpf@vger.kernel.org>; Thu, 15 Sep 2022 09:50:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CF21FC433D7;
        Thu, 15 Sep 2022 09:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663235417;
        bh=81V8oelQhYy0cdVqMdO4pk6fSB/T4TGx6QtgB5Rni3E=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=cF/9UZLXohLVZk7FRtRK5Xepmd3fj9LJXovkbqDtQeYbfrUq6HyFkyC7xgUEhTb//
         A1CIM4qRP4oIyvnkbqIo29a1xxwWwSr7q1ckf+rHH2Ng3mDWpplhl0DUev+faAH5w8
         lC3cWl7pnwEH4o6u70ruo/jejFlb52LMyvBJPqWUb9zji5L3sNoAOQ5oWvhPJwVfof
         NnhJbkhdi/2bbI0p1A+rM1EYwPbrns+JE5B7fAFWW29uLM0kiEFg2nwcN/yFenHjKP
         lO7NCeCDXTt9kKLw3Ok/yn5VuVZDmTGLj2oNV8A+UBgRT2rK5vZPFC2hNBmYgqi4CU
         G87AO6RCe/vbA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B6C2BC73FFC;
        Thu, 15 Sep 2022 09:50:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Add verifier check for BPF_PTR_POISON retval
 and arg
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166323541774.450.15044586916058194279.git-patchwork-notify@kernel.org>
Date:   Thu, 15 Sep 2022 09:50:17 +0000
References: <20220912154544.1398199-1-davemarchevsky@fb.com>
In-Reply-To: <20220912154544.1398199-1-davemarchevsky@fb.com>
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kernel-team@fb.com, memxor@gmail.com
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

On Mon, 12 Sep 2022 08:45:44 -0700 you wrote:
> BPF_PTR_POISON was added in commit c0a5a21c25f37 ("bpf: Allow storing
> referenced kptr in map") to denote a bpf_func_proto btf_id which the
> verifier will replace with a dynamically-determined btf_id at verification
> time.
> 
> This patch adds verifier 'poison' functionality to BPF_PTR_POISON in
> order to prepare for expanded use of the value to poison ret- and
> arg-btf_id in ongoing work, namely rbtree and linked list patchsets
> [0, 1]. Specifically, when the verifier checks helper calls, it assumes
> that BPF_PTR_POISON'ed ret type will be replaced with a valid type before
> - or in lieu of - the default ret_btf_id logic. Similarly for arg btf_id.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Add verifier check for BPF_PTR_POISON retval and arg
    https://git.kernel.org/bpf/bpf-next/c/47e34cb74d37

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


