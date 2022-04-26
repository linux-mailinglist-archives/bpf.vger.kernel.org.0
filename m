Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D310B50EF39
	for <lists+bpf@lfdr.de>; Tue, 26 Apr 2022 05:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243080AbiDZDdw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Apr 2022 23:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241637AbiDZDda (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Apr 2022 23:33:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1223A218F
        for <bpf@vger.kernel.org>; Mon, 25 Apr 2022 20:30:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 25A79B81C06
        for <bpf@vger.kernel.org>; Tue, 26 Apr 2022 03:30:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DB218C385AA;
        Tue, 26 Apr 2022 03:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650943813;
        bh=qfbGCtcNjO3C424FYqhHFo96zxapyD00RmOGJW1E//8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=WkbikMJQrhxSVgjfccgOda2rGWkzMBwfLVEnYs17u4PS1emslS32M5a8zOVURJcg9
         aTad8KhICcTEckSqx2eQjuQR8CABlGvjqin28thi3CGT+tvpcs6PfTNW3nrFWH+bLI
         Eq7BJ5OzdAv22pVzQXGO28/LeKxp5L7fOn9yINztywozDerv0M2BXtHEh5Pc+uWWHd
         9Cm5EV1ur5ucxvSkas4rnfXccmnvV7loB19pNUxT1uBA51EdYkHqbseWN52B+pLnsI
         sk8yDx06FCCsrB/zcgqPg6JcqA4MRPK2Hy/Yre1sc0WxHqOr3aMpuYyBzoJhBjElr0
         RwwLxabreo+ug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B13A5F67CA0;
        Tue, 26 Apr 2022 03:30:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v6 00/13] Introduce typed pointer support in BPF maps
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165094381372.16200.4266574915609138516.git-patchwork-notify@kernel.org>
Date:   Tue, 26 Apr 2022 03:30:13 +0000
References: <20220424214901.2743946-1-memxor@gmail.com>
In-Reply-To: <20220424214901.2743946-1-memxor@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, joannelkoong@gmail.com, toke@redhat.com,
        brouer@redhat.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Mon, 25 Apr 2022 03:18:48 +0530 you wrote:
> This set enables storing pointers of a certain type in BPF map, and extends the
> verifier to enforce type safety and lifetime correctness properties.
> 
> The infrastructure being added is generic enough for allowing storing any kind
> of pointers whose type is available using BTF (user or kernel) in the future
> (e.g. strongly typed memory allocation in BPF program), which are internally
> tracked in the verifier as PTR_TO_BTF_ID, but for now the series limits them to
> two kinds of pointers obtained from the kernel.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v6,01/13] bpf: Allow storing unreferenced kptr in map
    https://git.kernel.org/bpf/bpf-next/c/61df10c7799e
  - [bpf-next,v6,02/13] bpf: Tag argument to be released in bpf_func_proto
    https://git.kernel.org/bpf/bpf-next/c/8f14852e8911
  - [bpf-next,v6,03/13] bpf: Allow storing referenced kptr in map
    https://git.kernel.org/bpf/bpf-next/c/c0a5a21c25f3
  - [bpf-next,v6,04/13] bpf: Prevent escaping of kptr loaded from maps
    https://git.kernel.org/bpf/bpf-next/c/6efe152d4061
  - [bpf-next,v6,05/13] bpf: Adapt copy_map_value for multiple offset case
    https://git.kernel.org/bpf/bpf-next/c/4d7d7f69f4b1
  - [bpf-next,v6,06/13] bpf: Populate pairs of btf_id and destructor kfunc in btf
    https://git.kernel.org/bpf/bpf-next/c/5ce937d613a4
  - [bpf-next,v6,07/13] bpf: Wire up freeing of referenced kptr
    https://git.kernel.org/bpf/bpf-next/c/14a324f6a67e
  - [bpf-next,v6,08/13] bpf: Teach verifier about kptr_get kfunc helpers
    https://git.kernel.org/bpf/bpf-next/c/a1ef19599652
  - [bpf-next,v6,09/13] bpf: Make BTF type match stricter for release arguments
    https://git.kernel.org/bpf/bpf-next/c/2ab3b3808eb1
  - [bpf-next,v6,10/13] libbpf: Add kptr type tag macros to bpf_helpers.h
    https://git.kernel.org/bpf/bpf-next/c/ef89654f2bc7
  - [bpf-next,v6,11/13] selftests/bpf: Add C tests for kptr
    https://git.kernel.org/bpf/bpf-next/c/2cbc469a6fc3
  - [bpf-next,v6,12/13] selftests/bpf: Add verifier tests for kptr
    https://git.kernel.org/bpf/bpf-next/c/05a945deefaa
  - [bpf-next,v6,13/13] selftests/bpf: Add test for strict BTF type check
    https://git.kernel.org/bpf/bpf-next/c/792c0a345f0e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


