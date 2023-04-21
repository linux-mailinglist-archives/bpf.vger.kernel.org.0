Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B356EB25B
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 21:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233439AbjDUTk0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Apr 2023 15:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232480AbjDUTk0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Apr 2023 15:40:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFFC2137
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 12:40:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C244765292
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 19:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 29C2BC433D2;
        Fri, 21 Apr 2023 19:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682106024;
        bh=VM0vt4hpb/nIeOKefqkAhoyyeHrLh0sV7s6Mp4mRaEE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=WZ12ZuXdGdwWqN9YTWyTn58tm9Lm7nYCirQjw1FjzrhINnJm3o7ne6uepgAW0Y/WO
         UJEa5thA+9ZEnOMAGIPFc5zfFFZmFYBphSqL9lUAw9ipIJPCAISyWo2FdQtaUrWt8S
         tApVaxudO2tX3YVSh0vUi7hdo9MAkLkABPzRjqatBHAD/aR0Tj1qdbLE2RhdIKjjmq
         W5UMDxVR+hVS2LC6lvgfwUqtlOHVqoDeUKUcepP7UFUgR9nAme9wuxAWuWASdGZEdU
         hjkLN4wtODKynGoPApsFvM7iL4p7agAQrOQLDg2OvERN7dapf1ect4eY0yNXrMAyZH
         Y//r8HZy6o7MQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 06747E270DB;
        Fri, 21 Apr 2023 19:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 00/24] Second set of verifier/*.c migrated to inline
 assembly
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168210602402.3425.11823949766258477429.git-patchwork-notify@kernel.org>
Date:   Fri, 21 Apr 2023 19:40:24 +0000
References: <20230421174234.2391278-1-eddyz87@gmail.com>
In-Reply-To: <20230421174234.2391278-1-eddyz87@gmail.com>
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
        yhs@fb.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 21 Apr 2023 20:42:10 +0300 you wrote:
> This is a follow up for RFC [1]. It migrates a second batch of 23
> verifier/*.c tests to inline assembly and use of ./test_progs for
> actual execution. Link to the first batch is [2].
> 
> The migration is done by a python script (see [3]) with minimal manual
> adjustments.
> 
> [...]

Here is the summary with links:
  - [bpf-next,01/24] selftests/bpf: Add notion of auxiliary programs for test_loader
    https://git.kernel.org/bpf/bpf-next/c/63bb645b9da3
  - [bpf-next,02/24] selftests/bpf: verifier/bounds converted to inline assembly
    https://git.kernel.org/bpf/bpf-next/c/c92336559ac0
  - [bpf-next,03/24] selftests/bpf: verifier/bpf_get_stack converted to inline assembly
    https://git.kernel.org/bpf/bpf-next/c/965a3f913e72
  - [bpf-next,04/24] selftests/bpf: verifier/btf_ctx_access converted to inline assembly
    https://git.kernel.org/bpf/bpf-next/c/37467c79e16a
  - [bpf-next,05/24] selftests/bpf: verifier/ctx converted to inline assembly
    https://git.kernel.org/bpf/bpf-next/c/fcd36964f22b
  - [bpf-next,06/24] selftests/bpf: verifier/d_path converted to inline assembly
    https://git.kernel.org/bpf/bpf-next/c/608028024384
  - [bpf-next,07/24] selftests/bpf: verifier/direct_packet_access converted to inline assembly
    https://git.kernel.org/bpf/bpf-next/c/0a372c9c0812
  - [bpf-next,08/24] selftests/bpf: verifier/jeq_infer_not_null converted to inline assembly
    https://git.kernel.org/bpf/bpf-next/c/a5828e3154d1
  - [bpf-next,09/24] selftests/bpf: verifier/loops1 converted to inline assembly
    https://git.kernel.org/bpf/bpf-next/c/a6fc14dc5e8d
  - [bpf-next,10/24] selftests/bpf: verifier/lwt converted to inline assembly
    https://git.kernel.org/bpf/bpf-next/c/b427ca576f83
  - [bpf-next,11/24] selftests/bpf: verifier/map_in_map converted to inline assembly
    https://git.kernel.org/bpf/bpf-next/c/4a400ef9ba41
  - [bpf-next,12/24] selftests/bpf: verifier/map_ptr_mixing converted to inline assembly
    https://git.kernel.org/bpf/bpf-next/c/aee1779f0dec
  - [bpf-next,13/24] selftests/bpf: verifier/precise converted to inline assembly
    (no matching commit)
  - [bpf-next,14/24] selftests/bpf: verifier/prevent_map_lookup converted to inline assembly
    (no matching commit)
  - [bpf-next,15/24] selftests/bpf: verifier/ref_tracking converted to inline assembly
    https://git.kernel.org/bpf/bpf-next/c/8be632795996
  - [bpf-next,16/24] selftests/bpf: verifier/regalloc converted to inline assembly
    https://git.kernel.org/bpf/bpf-next/c/16a42573c253
  - [bpf-next,17/24] selftests/bpf: verifier/runtime_jit converted to inline assembly
    https://git.kernel.org/bpf/bpf-next/c/65222842ca04
  - [bpf-next,18/24] selftests/bpf: verifier/search_pruning converted to inline assembly
    https://git.kernel.org/bpf/bpf-next/c/034d9ad25db3
  - [bpf-next,19/24] selftests/bpf: verifier/sock converted to inline assembly
    https://git.kernel.org/bpf/bpf-next/c/426fc0e3fce2
  - [bpf-next,20/24] selftests/bpf: verifier/spin_lock converted to inline assembly
    https://git.kernel.org/bpf/bpf-next/c/f323a81806bd
  - [bpf-next,21/24] selftests/bpf: verifier/subreg converted to inline assembly
    https://git.kernel.org/bpf/bpf-next/c/81d1d6dd4037
  - [bpf-next,22/24] selftests/bpf: verifier/unpriv converted to inline assembly
    https://git.kernel.org/bpf/bpf-next/c/82887c2568e4
  - [bpf-next,23/24] selftests/bpf: verifier/value_illegal_alu converted to inline assembly
    https://git.kernel.org/bpf/bpf-next/c/efe25a330b10
  - [bpf-next,24/24] selftests/bpf: verifier/value_ptr_arith converted to inline assembly
    https://git.kernel.org/bpf/bpf-next/c/4db10a8243df

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


