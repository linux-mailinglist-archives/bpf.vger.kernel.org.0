Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF666C9211
	for <lists+bpf@lfdr.de>; Sun, 26 Mar 2023 03:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjCZBcP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 25 Mar 2023 21:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCZBcP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 25 Mar 2023 21:32:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81997D86
        for <bpf@vger.kernel.org>; Sat, 25 Mar 2023 18:32:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7432DB80768
        for <bpf@vger.kernel.org>; Sun, 26 Mar 2023 01:32:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 34CD2C4339B;
        Sun, 26 Mar 2023 01:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679794331;
        bh=Nw2khPvh0/NXyk0OYG7h3XcxgEeGTa46IZtKCQpVFDc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=U4YET9zKM0Vse6VcVOlYOJYCRUWOn6+66WULVAReE1WJ69qN9S+sQUuvqrgZNP986
         ok8FLi1MvyTNkXEbg/3/sjCDrl/TYsR1L59I1Qe60imqD9X52xgp8Ih4hjAYI7bcpv
         mHifUYECyZvmRRcyw3CVxd+T6ctBAGtdjuuLaVcI00sbPADS1c2iTSg94qfl67FBkj
         9bLeyPkRq1cJZa4hX/2sATLqzQ8B8EgNdw3BFy2bMIrbIOKzX74aKFczim9fXt9D65
         rSVHREVbuk3tGuwqqfIqOBKXbHmHCICRlh2j9s10U5rmWY0UfTXwcqC6+O8y64YdrQ
         a8QBtsc70Jtwg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1A970E52505;
        Sun, 26 Mar 2023 01:32:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 00/43] First set of verifier/*.c migrated to inline
 assembly
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167979433109.17761.17302808621381963629.git-patchwork-notify@kernel.org>
Date:   Sun, 26 Mar 2023 01:32:11 +0000
References: <20230325025524.144043-1-eddyz87@gmail.com>
In-Reply-To: <20230325025524.144043-1-eddyz87@gmail.com>
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
        yhs@fb.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 25 Mar 2023 04:54:41 +0200 you wrote:
> This is a follow up for RFC [1]. It migrates a first batch of 38
> verifier/*.c tests to inline assembly and use of ./test_progs for
> actual execution. The migration is done by a python script (see [2]).
> 
> Each migrated verifier/xxx.c file is mapped to progs/verifier_xxx.c
> plus an entry in the prog_tests/verifier.c. One patch per each file.
> 
> [...]

Here is the summary with links:
  - [bpf-next,01/43] selftests/bpf: Report program name on parse_test_spec error
    https://git.kernel.org/bpf/bpf-next/c/3e5329e193f4
  - [bpf-next,02/43] selftests/bpf: __imm_insn & __imm_const macro for bpf_misc.h
    https://git.kernel.org/bpf/bpf-next/c/207b1ba30191
  - [bpf-next,03/43] selftests/bpf: Unprivileged tests for test_loader.c
    https://git.kernel.org/bpf/bpf-next/c/1d56ade032a4
  - [bpf-next,04/43] selftests/bpf: Tests execution support for test_loader.c
    https://git.kernel.org/bpf/bpf-next/c/19a8e06f5f91
  - [bpf-next,05/43] selftests/bpf: prog_tests entry point for migrated test_verifier tests
    https://git.kernel.org/bpf/bpf-next/c/55108621a35e
  - [bpf-next,06/43] selftests/bpf: verifier/and.c converted to inline assembly
    https://git.kernel.org/bpf/bpf-next/c/9d0f1568ad5b
  - [bpf-next,07/43] selftests/bpf: verifier/array_access.c converted to inline assembly
    https://git.kernel.org/bpf/bpf-next/c/a3c830ae0209
  - [bpf-next,08/43] selftests/bpf: verifier/basic_stack.c converted to inline assembly
    https://git.kernel.org/bpf/bpf-next/c/0ccbe4956d6c
  - [bpf-next,09/43] selftests/bpf: verifier/bounds_deduction.c converted to inline assembly
    https://git.kernel.org/bpf/bpf-next/c/7605f94b3492
  - [bpf-next,10/43] selftests/bpf: verifier/bounds_mix_sign_unsign.c converted to inline assembly
    https://git.kernel.org/bpf/bpf-next/c/b14a702afd0d
  - [bpf-next,11/43] selftests/bpf: verifier/cfg.c converted to inline assembly
    https://git.kernel.org/bpf/bpf-next/c/2f2047c22cda
  - [bpf-next,12/43] selftests/bpf: verifier/cgroup_inv_retcode.c converted to inline assembly
    https://git.kernel.org/bpf/bpf-next/c/047687a7f494
  - [bpf-next,13/43] selftests/bpf: verifier/cgroup_skb.c converted to inline assembly
    https://git.kernel.org/bpf/bpf-next/c/b1b6372535c0
  - [bpf-next,14/43] selftests/bpf: verifier/cgroup_storage.c converted to inline assembly
    https://git.kernel.org/bpf/bpf-next/c/8f16f3c07e46
  - [bpf-next,15/43] selftests/bpf: verifier/const_or.c converted to inline assembly
    https://git.kernel.org/bpf/bpf-next/c/a2777eaad5d9
  - [bpf-next,16/43] selftests/bpf: verifier/ctx_sk_msg.c converted to inline assembly
    https://git.kernel.org/bpf/bpf-next/c/a58475a98903
  - [bpf-next,17/43] selftests/bpf: verifier/direct_stack_access_wraparound.c converted to inline assembly
    https://git.kernel.org/bpf/bpf-next/c/84988478fb2c
  - [bpf-next,18/43] selftests/bpf: verifier/div0.c converted to inline assembly
    https://git.kernel.org/bpf/bpf-next/c/01a0925531a4
  - [bpf-next,19/43] selftests/bpf: verifier/div_overflow.c converted to inline assembly
    https://git.kernel.org/bpf/bpf-next/c/9553de70a841
  - [bpf-next,20/43] selftests/bpf: verifier/helper_access_var_len.c converted to inline assembly
    https://git.kernel.org/bpf/bpf-next/c/b37d776b431e
  - [bpf-next,21/43] selftests/bpf: verifier/helper_packet_access.c converted to inline assembly
    https://git.kernel.org/bpf/bpf-next/c/fb179fe69e6a
  - [bpf-next,22/43] selftests/bpf: verifier/helper_restricted.c converted to inline assembly
    https://git.kernel.org/bpf/bpf-next/c/77aa2563cb44
  - [bpf-next,23/43] selftests/bpf: verifier/helper_value_access.c converted to inline assembly
    https://git.kernel.org/bpf/bpf-next/c/ecc424827b77
  - [bpf-next,24/43] selftests/bpf: verifier/int_ptr.c converted to inline assembly
    https://git.kernel.org/bpf/bpf-next/c/01481e67dd4d
  - [bpf-next,25/43] selftests/bpf: verifier/ld_ind.c converted to inline assembly
    https://git.kernel.org/bpf/bpf-next/c/e29787558066
  - [bpf-next,26/43] selftests/bpf: verifier/leak_ptr.c converted to inline assembly
    https://git.kernel.org/bpf/bpf-next/c/583c7ce5be09
  - [bpf-next,27/43] selftests/bpf: verifier/map_ptr.c converted to inline assembly
    https://git.kernel.org/bpf/bpf-next/c/caf345cf1207
  - [bpf-next,28/43] selftests/bpf: verifier/map_ret_val.c converted to inline assembly
    https://git.kernel.org/bpf/bpf-next/c/05e474ecbb56
  - [bpf-next,29/43] selftests/bpf: verifier/masking.c converted to inline assembly
    https://git.kernel.org/bpf/bpf-next/c/ade3f08fc236
  - [bpf-next,30/43] selftests/bpf: verifier/meta_access.c converted to inline assembly
    https://git.kernel.org/bpf/bpf-next/c/65428312e38d
  - [bpf-next,31/43] selftests/bpf: verifier/raw_stack.c converted to inline assembly
    https://git.kernel.org/bpf/bpf-next/c/5a77a01f3320
  - [bpf-next,32/43] selftests/bpf: verifier/raw_tp_writable.c converted to inline assembly
    https://git.kernel.org/bpf/bpf-next/c/18cdc2b531fb
  - [bpf-next,33/43] selftests/bpf: verifier/ringbuf.c converted to inline assembly
    https://git.kernel.org/bpf/bpf-next/c/b7e4203086eb
  - [bpf-next,34/43] selftests/bpf: verifier/spill_fill.c converted to inline assembly
    https://git.kernel.org/bpf/bpf-next/c/f4fe3cfe6c3a
  - [bpf-next,35/43] selftests/bpf: verifier/stack_ptr.c converted to inline assembly
    https://git.kernel.org/bpf/bpf-next/c/edff37b2f28f
  - [bpf-next,36/43] selftests/bpf: verifier/uninit.c converted to inline assembly
    https://git.kernel.org/bpf/bpf-next/c/ab839a581946
  - [bpf-next,37/43] selftests/bpf: verifier/value_adj_spill.c converted to inline assembly
    https://git.kernel.org/bpf/bpf-next/c/033914942da4
  - [bpf-next,38/43] selftests/bpf: verifier/value.c converted to inline assembly
    https://git.kernel.org/bpf/bpf-next/c/8f59e87a3bc6
  - [bpf-next,39/43] selftests/bpf: verifier/value_or_null.c converted to inline assembly
    https://git.kernel.org/bpf/bpf-next/c/d330528617b7
  - [bpf-next,40/43] selftests/bpf: verifier/var_off.c converted to inline assembly
    https://git.kernel.org/bpf/bpf-next/c/d15f5b68b63a
  - [bpf-next,41/43] selftests/bpf: verifier/xadd.c converted to inline assembly
    https://git.kernel.org/bpf/bpf-next/c/a8036aea2d4f
  - [bpf-next,42/43] selftests/bpf: verifier/xdp.c converted to inline assembly
    https://git.kernel.org/bpf/bpf-next/c/ffb515c933a9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


