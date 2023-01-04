Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2971965DFA4
	for <lists+bpf@lfdr.de>; Wed,  4 Jan 2023 23:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239618AbjADWKe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Jan 2023 17:10:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240553AbjADWKd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Jan 2023 17:10:33 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759D813F61
        for <bpf@vger.kernel.org>; Wed,  4 Jan 2023 14:10:31 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id gh17so86083939ejb.6
        for <bpf@vger.kernel.org>; Wed, 04 Jan 2023 14:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ybjiAJeTDYY7UKh5PoepLQLgWxRMordpvLLfGbA0p6A=;
        b=Jkca7M3NDS5w9XbX3XoFushlrMNc4HGP82YLojTQRs2eRWPiIYVxyqlKJGkoR0W4Eu
         E5BfHNfPBN1x2HnAF2BizoPJHcOiFaBNQnA0BWJ1ymwcOMySb6vVw+OwjRMWOdtN10Kz
         IZDNG+J+IQePUIMOr37474bsPuRahQFjNGeipEtC3GSe67J9sBV1U/VDIaWAnhMf880W
         uRAz2SzeTUbMYGjPLhneZWFI41ONx0baMUdPtyvnWXWqtyTHKNlIwn025Veg0Fr1G0UA
         Oo5HPZjo6kOjfWkV3bdKVWESONFjSH4xe7lC1bHkTzGneuSRxhBwT/ceg1ihhN/a/WPt
         81qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ybjiAJeTDYY7UKh5PoepLQLgWxRMordpvLLfGbA0p6A=;
        b=Rxti2n7UPEQz+dFxl0EJsucW06P1hK5vM5WRgtc5plc0HO3dLw3U3RWN805+zoaseW
         Z3kyoIlCnXIysgYmib+4CDHjFNsu/dRdlWrKR2LJWw1UsGheCQa8rIBkuHUgTbDeENzs
         2QFdbncYVN+M6vWu0RxIrGrPeiCRQnsnllgAVBg6HiTtX1t6ASIPrVsSdVJqtLPRvIzO
         rsy7sybEkoVwdTlpvg2s7IPeaCbdaYpoDNFnfJpP2C0HTq7Pa574kxU3y+V+7YUoeL3L
         6HMuCULu6vDriuIt/AmblcsFHrsp5LQhWnObZM7wd9625zgxzhA64QKGU6wXOLRsSqPv
         UuPA==
X-Gm-Message-State: AFqh2koXIgtwWkAmyPPSvPyKs3uGazKUiA06V/4kVf05BpefScWPHqw5
        ep/Ge9L218emIYZISmPibWUsPRo2dISPaFK9UOQ=
X-Google-Smtp-Source: AMrXdXsZRLOpwgxLXd5SICVKUzNIztcr1PczRQH6DdikatviDBKgXT42DtGNUcQg6qoY+AsFZ4bjcgi13aCk3t/snXE=
X-Received: by 2002:a17:906:2ccc:b0:7f3:3b2:314f with SMTP id
 r12-20020a1709062ccc00b007f303b2314fmr3793513ejr.115.1672870229977; Wed, 04
 Jan 2023 14:10:29 -0800 (PST)
MIME-Version: 1.0
References: <20221231163122.1360813-1-eddyz87@gmail.com>
In-Reply-To: <20221231163122.1360813-1-eddyz87@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 4 Jan 2023 14:10:18 -0800
Message-ID: <CAEf4BzbNM_U4b3gi4AwiTV5GMXEsAsJx8sMVA32ijJRygrVpFg@mail.gmail.com>
Subject: Re: [RFC bpf-next 0/5] Support for BPF_ST instruction in LLVM C compiler
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Dec 31, 2022 at 8:31 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> BPF has two documented (non-atomic) memory store instructions:
>
> BPF_STX: *(size *) (dst_reg + off) = src_reg
> BPF_ST : *(size *) (dst_reg + off) = imm32
>
> Currently LLVM BPF back-end does not emit BPF_ST instruction and does
> not allow one to be specified as inline assembly.
>
> Recently I've been exploring ways to port some of the verifier test
> cases from tools/testing/selftests/bpf/verifier/*.c to use inline assembly
> and machinery provided in tools/testing/selftests/bpf/test_loader.c
> (which should hopefully simplify tests maintenance).
> The BPF_ST instruction is popular in these tests: used in 52 of 94 files.
>
> While it is possible to adjust LLVM to only support BPF_ST for inline
> assembly blocks it seems a bit wasteful. This patch-set contains a set
> of changes to verifier necessary in case when LLVM is allowed to
> freely emit BPF_ST instructions (source code is available here [1]).

Would we gate LLVM's emitting of BPF_ST for C code behind some new
cpu=v4? What is the benefit for compiler to start automatically emit
such instructions? Such thinking about logistics, if there isn't much
benefit, as BPF application owner I wouldn't bother enabling this
behavior risking regressions on old kernels that don't have these
changes.

So I feel like the biggest benefit is to be able to use this
instruction in embedded assembly, to make writing and maintaining
tests easier.

> The changes include:
>  - update to verifier.c:check_stack_write_*() functions to track
>    constant values spilled to stack via BPF_ST instruction in a same
>    way stack spills of known registers by BPF_STX are tracked;
>  - updates to verifier.c:convert_ctx_access() and it's callbacks to
>    handle BPF_ST instruction in a way similar to BPF_STX;
>  - some test adjustments and a few new tests.
>
> With the above changes applied and LLVM from [1] all test_verifier,
> test_maps, test_progs and test_progs-no_alu32 test cases are passing.
>
> When built using the LLVM version from [1] BPF programs generated for
> selftests and Cilium programs (taken from [2]) see certain reduction
> in size, e.g. below are total numbers of instructions for files with
> over 5K instructions:
>
> File                                    Insns   Insns   Insns   Diff
>                                         w/o     with    diff    pct
>                                         BPF_ST  BPF_ST
> cilium/bpf_host.o                       44620   43774   -846    -1.90%
> cilium/bpf_lxc.o                        36842   36060   -782    -2.12%
> cilium/bpf_overlay.o                    23557   23186   -371    -1.57%
> cilium/bpf_xdp.o                        26397   25931   -466    -1.77%
> selftests/core_kern.bpf.o               12359   12359    0       0.00%
> selftests/linked_list_fail.bpf.o        5501    5302    -199    -3.62%
> selftests/profiler1.bpf.o               17828   17709   -119    -0.67%
> selftests/pyperf100.bpf.o               49793   49268   -525    -1.05%
> selftests/pyperf180.bpf.o               88738   87813   -925    -1.04%
> selftests/pyperf50.bpf.o                25388   25113   -275    -1.08%
> selftests/pyperf600.bpf.o               78330   78300   -30     -0.04%
> selftests/pyperf_global.bpf.o           5244    5188    -56     -1.07%
> selftests/pyperf_subprogs.bpf.o         5262    5192    -70     -1.33%
> selftests/strobemeta.bpf.o              17154   16065   -1089   -6.35%
> selftests/test_verif_scale2.bpf.o       11337   11337    0       0.00%
>
> (Instructions are counted by counting the number of instruction lines
>  in disassembly).
>
> Is community interested in this work?
> Are there any omissions in my changes to the verifier?
>
> Known issue:
>
> There are two programs (one Cilium, one selftest) that exhibit
> anomalous increase in verifier processing time with this patch-set:
>
>  File                 Program                        Insns (A)  Insns (B)  Insns   (DIFF)
>  -------------------  -----------------------------  ---------  ---------  --------------
>  bpf_host.o           tail_ipv6_host_policy_ingress       1576       2403  +827 (+52.47%)
>  map_kptr.bpf.o       test_map_kptr                        400        475   +75 (+18.75%)
>  -------------------  -----------------------------  ---------  ---------  --------------
>
> These are under investigation.
>
> Thanks,
> Eduard
>
> [1] https://reviews.llvm.org/D140804
> [2] git@github.com:anakryiko/cilium.git
>
> Eduard Zingerman (5):
>   bpf: more precise stack write reasoning for BPF_ST instruction
>   selftests/bpf: check if verifier tracks constants spilled by
>     BPF_ST_MEM
>   bpf: allow ctx writes using BPF_ST_MEM instruction
>   selftests/bpf: test if pointer type is tracked for BPF_ST_MEM
>   selftests/bpf: don't match exact insn index in expected error message
>
>  kernel/bpf/cgroup.c                           |  49 +++++---
>  kernel/bpf/verifier.c                         | 102 +++++++++-------
>  net/core/filter.c                             |  72 ++++++------
>  .../selftests/bpf/prog_tests/log_fixup.c      |   2 +-
>  .../selftests/bpf/prog_tests/spin_lock.c      |   8 +-
>  .../bpf/verifier/bounds_mix_sign_unsign.c     | 110 ++++++++++--------
>  .../selftests/bpf/verifier/bpf_st_mem.c       |  29 +++++
>  tools/testing/selftests/bpf/verifier/ctx.c    |  11 --
>  tools/testing/selftests/bpf/verifier/unpriv.c |  23 ++++
>  9 files changed, 249 insertions(+), 157 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/verifier/bpf_st_mem.c
>
> --
> 2.39.0
>
