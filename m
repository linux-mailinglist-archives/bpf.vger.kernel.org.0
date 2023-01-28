Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F293067FAF9
	for <lists+bpf@lfdr.de>; Sat, 28 Jan 2023 21:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjA1Uu0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 28 Jan 2023 15:50:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjA1UuZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 28 Jan 2023 15:50:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1FA10A8A
        for <bpf@vger.kernel.org>; Sat, 28 Jan 2023 12:50:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DF378B80C0A
        for <bpf@vger.kernel.org>; Sat, 28 Jan 2023 20:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8C348C433D2;
        Sat, 28 Jan 2023 20:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674939021;
        bh=H3PVqe99UO0RFvltUI92HCDQfw/b/QEVS7rrfJ69tLs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=g5ziABJVSm1xpT6JrwM+IpHbLr/KpeCfwynZkQsUsVIEW3UHYwKFV7S4ZTik/xNWT
         hSFWeZb90mliHO/3o58WNJcfr8oUlebFjGFtgrdmSFzga8bb12xKp3DpZUp+ziJvAx
         GCl8R3OJmzbd4kR2gVBUyPbwyyL2EE2P9JilfpUa34GB+hnzKoaGTQmwFMA5m6hbN7
         RRO+k26kGXQvgppBCfVToTTyZxXREG8XdwIaKL7LizgYYjSEOcnXITgTTP5PoDsr4K
         meFTgN48wNYgUfwPTtgIYHCcfBI91Lprjr2PnYVn1Ee16tAtwGllKeT1VDM10K9Vn2
         srWZHjwpp/OwA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 67319E54D2D;
        Sat, 28 Jan 2023 20:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 00/31] Support bpf trampoline for s390x
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167493902139.8808.2500727230403968304.git-patchwork-notify@kernel.org>
Date:   Sat, 28 Jan 2023 20:50:21 +0000
References: <20230128000650.1516334-1-iii@linux.ibm.com>
In-Reply-To: <20230128000650.1516334-1-iii@linux.ibm.com>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        bpf@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 28 Jan 2023 01:06:19 +0100 you wrote:
> v1: https://lore.kernel.org/bpf/20230125213817.1424447-1-iii@linux.ibm.com/#t
> v1 -> v2:
> - Fix core_read_macros, sk_assign, test_profiler, test_bpffs (24/31;
>   I'm not quite happy with the fix, but don't have better ideas),
>   and xdp_synproxy. (Andrii)
> - Prettify liburandom_read and verify_pkcs7_sig fixes. (Andrii)
> - Fix bpf_usdt_arg using barrier_var(); prettify barrier_var(). (Andrii)
> - Change BPF_MAX_TRAMP_LINKS to enum and query it using BTF. (Andrii)
> - Improve bpf_jit_supports_kfunc_call() description. (Alexei)
> - Always check sign_extend() return value.
> - Cc: Alexander Gordeev.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,01/31] bpf: Use ARG_CONST_SIZE_OR_ZERO for 3rd argument of bpf_tcp_raw_gen_syncookie_ipv{4,6}()
    https://git.kernel.org/bpf/bpf-next/c/bf3849755ac6
  - [bpf-next,v2,02/31] bpf: Change BPF_MAX_TRAMP_LINKS to enum
    https://git.kernel.org/bpf/bpf-next/c/390a07a921b3
  - [bpf-next,v2,03/31] selftests/bpf: Query BPF_MAX_TRAMP_LINKS using BTF
    https://git.kernel.org/bpf/bpf-next/c/8fb9fb2f1728
  - [bpf-next,v2,04/31] selftests/bpf: Fix liburandom_read.so linker error
    https://git.kernel.org/bpf/bpf-next/c/b14b01f281f7
  - [bpf-next,v2,05/31] selftests/bpf: Fix symlink creation error
    https://git.kernel.org/bpf/bpf-next/c/6eab2370d142
  - [bpf-next,v2,06/31] selftests/bpf: Fix kfree_skb on s390x
    https://git.kernel.org/bpf/bpf-next/c/31da9be64a11
  - [bpf-next,v2,07/31] selftests/bpf: Set errno when urand_spawn() fails
    https://git.kernel.org/bpf/bpf-next/c/804acdd251e8
  - [bpf-next,v2,08/31] selftests/bpf: Fix decap_sanity_ns cleanup
    https://git.kernel.org/bpf/bpf-next/c/98e13848cf43
  - [bpf-next,v2,09/31] selftests/bpf: Fix verify_pkcs7_sig on s390x
    https://git.kernel.org/bpf/bpf-next/c/56e1a5048319
  - [bpf-next,v2,10/31] selftests/bpf: Fix xdp_do_redirect on s390x
    https://git.kernel.org/bpf/bpf-next/c/06c1865b0b0c
  - [bpf-next,v2,11/31] selftests/bpf: Fix cgrp_local_storage on s390x
    https://git.kernel.org/bpf/bpf-next/c/06cea99e683c
  - [bpf-next,v2,12/31] selftests/bpf: Check stack_mprotect() return value
    https://git.kernel.org/bpf/bpf-next/c/2934565f04fd
  - [bpf-next,v2,13/31] selftests/bpf: Increase SIZEOF_BPF_LOCAL_STORAGE_ELEM on s390x
    https://git.kernel.org/bpf/bpf-next/c/80a611904eef
  - [bpf-next,v2,14/31] selftests/bpf: Add a sign-extension test for kfuncs
    https://git.kernel.org/bpf/bpf-next/c/be6b5c10ecc4
  - [bpf-next,v2,15/31] selftests/bpf: Fix test_lsm on s390x
    https://git.kernel.org/bpf/bpf-next/c/207612eb12b9
  - [bpf-next,v2,16/31] selftests/bpf: Fix test_xdp_adjust_tail_grow2 on s390x
    https://git.kernel.org/bpf/bpf-next/c/26e8a0149479
  - [bpf-next,v2,17/31] selftests/bpf: Fix vmlinux test on s390x
    https://git.kernel.org/bpf/bpf-next/c/d504270a233d
  - [bpf-next,v2,18/31] selftests/bpf: Fix sk_assign on s390x
    (no matching commit)
  - [bpf-next,v2,19/31] selftests/bpf: Fix xdp_synproxy/tc on s390x
    https://git.kernel.org/bpf/bpf-next/c/438a2edf26b7
  - [bpf-next,v2,20/31] selftests/bpf: Fix profiler on s390x
    https://git.kernel.org/bpf/bpf-next/c/1b5e38532581
  - [bpf-next,v2,21/31] libbpf: Simplify barrier_var()
    https://git.kernel.org/bpf/bpf-next/c/e85465e420be
  - [bpf-next,v2,22/31] libbpf: Fix unbounded memory access in bpf_usdt_arg()
    https://git.kernel.org/bpf/bpf-next/c/25c76ed42821
  - [bpf-next,v2,23/31] libbpf: Fix BPF_PROBE_READ{_STR}_INTO() on s390x
    https://git.kernel.org/bpf/bpf-next/c/42fae973c2b1
  - [bpf-next,v2,24/31] bpf: iterators: Split iterators.lskel.h into little- and big- endian versions
    https://git.kernel.org/bpf/bpf-next/c/0f0e5f5bd506
  - [bpf-next,v2,25/31] bpf: btf: Add BTF_FMODEL_SIGNED_ARG flag
    https://git.kernel.org/bpf/bpf-next/c/49f67f393ff2
  - [bpf-next,v2,26/31] s390/bpf: Fix a typo in a comment
    https://git.kernel.org/bpf/bpf-next/c/07dcbd7325ce
  - [bpf-next,v2,27/31] s390/bpf: Add expoline to tail calls
    (no matching commit)
  - [bpf-next,v2,28/31] s390/bpf: Implement bpf_arch_text_poke()
    (no matching commit)
  - [bpf-next,v2,29/31] s390/bpf: Implement arch_prepare_bpf_trampoline()
    (no matching commit)
  - [bpf-next,v2,30/31] s390/bpf: Implement bpf_jit_supports_subprog_tailcalls()
    (no matching commit)
  - [bpf-next,v2,31/31] s390/bpf: Implement bpf_jit_supports_kfunc_call()
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


