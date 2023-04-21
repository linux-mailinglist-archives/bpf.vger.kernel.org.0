Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C34C46EB0D6
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 19:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbjDURnS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Apr 2023 13:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjDURnD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Apr 2023 13:43:03 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCFB212C
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 10:42:46 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-2fa0ce30ac2so1877747f8f.3
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 10:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682098965; x=1684690965;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k08t90CYZaW68Q0+dmsO/WPAZmdOjdnr+Cd6irwemTU=;
        b=rTTeGzDVboNCYsKoZV+h4gcupcyuFfqAJd6T7vVGoFOLgpvkYQ9cv57fLXcFopp+Vi
         ydGsmBH0qfz0c+V26KlyuqaIDlzoDPY4cgIGdTiOmFMTKGbgrq6zzIOVCmsQ+4nnvmVq
         521MufP3+bp7EYAqb0Atm/J90UMfLj298hZbou0/3kOC64zsWWz1bxfX3gSPtPdDGKJK
         rDJJJvK00l3xRchI1Cx4vMlOVoI6MES/p2+YMQtnVX6ge3TMdkG1IPt3y1GKDFeYt2Br
         ecfqB77d5enYrh2oSndVvoXlWCVJY7QG3e7WtPP/1kWI9u10xGqB02GomHzEgewMmyld
         ZOVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682098965; x=1684690965;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k08t90CYZaW68Q0+dmsO/WPAZmdOjdnr+Cd6irwemTU=;
        b=Mv3yCBj2722yS3ABv/Dk9fZByDFdq25e+R7KqXBo10nLnIsQkGy98Bmjbm1LHMhBR3
         xNuXp9ca1ShWHCKESuXtoL7o5yWDS0qjzfX64D94ZnZQmrIorwVt+JT4a3Y8eA8nyLWt
         jP2w8xqzt9M/dnlffGtxpvmF51px12k1xuzIb8xHeJbzEAZgppTWh/pDOXGrZFoetvba
         ziigYiCEbdZpxfVEWg3DmUs1DM7NoIzSp1sCeMCuET7EDe8Jzl8Oh5Lnoid3no0uIEg3
         DpkuWq5+TIVV1qwSiR8ogD2ZB9ptYOZYhde8soE6IKxgTvTDnahy8jMREJ/OxgBEiNVD
         jDmg==
X-Gm-Message-State: AAQBX9e/VYpkq3z3n5QV3vQk4FGm1cs10+ie9csQXm2QIwjhdVCos3Ui
        liqCImBjFhLyrjCr12TtMUgaJ3xYHsoBOw==
X-Google-Smtp-Source: AKy350ZJWcXRzxOUEDUeArPJykYKzQG7VRkHTOm0AKALDyJ/QRTkT3+Fq6yMEbC7MnvIVTMUNMVsjA==
X-Received: by 2002:a5d:51d1:0:b0:2f8:ba03:6dec with SMTP id n17-20020a5d51d1000000b002f8ba036decmr4663519wrv.20.1682098964640;
        Fri, 21 Apr 2023 10:42:44 -0700 (PDT)
Received: from bigfoot.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id f4-20020a0560001b0400b002ffbf2213d4sm4849933wrz.75.2023.04.21.10.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 10:42:44 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 00/24] Second set of verifier/*.c migrated to inline assembly
Date:   Fri, 21 Apr 2023 20:42:10 +0300
Message-Id: <20230421174234.2391278-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This is a follow up for RFC [1]. It migrates a second batch of 23
verifier/*.c tests to inline assembly and use of ./test_progs for
actual execution. Link to the first batch is [2].

The migration is done by a python script (see [3]) with minimal manual
adjustments.

Each migrated verifier/xxx.c file is mapped to progs/verifier_xxx.c
plus an entry in the prog_tests/verifier.c. One patch per each file.

The first patch in a series adds a notion of auxiliary programs to
test_loader. This is necessary to support tests that use
BPF_MAP_TYPE_PROG_ARRAY maps. Programs marked as auxiliary are always
loaded but are not treated as a separate tests.

The main differences compared to the previous batch:
- Tests that use pseudo call instruction are migrated,
  called functions are translated as below:

    static __naked __noinline __attribute__((used))
    void bounded_recursion__1(void)
    {
    	asm volatile (...);
    }
    
  Pseudo call in the inline assembly looks as follows:

    __naked void bounded_recursion(void)
    {
        asm volatile ("                                 \
        r1 = 0;                                         \
        call bounded_recursion__1;                      \
        exit;                                           \
    "   ::: __clobber_all);
    }
    
  Interestingly enough, callee declaration does not have to precede
  caller definition when used from inline assembly.

- Tests that specify .expected_attach_type are migrated using
  corresponding SEC annotations. For example, the following test
  specification:

    {
            "reference tracking: ...",
            .insns = { ... },
            .prog_type = BPF_PROG_TYPE_LSM,
            .kfunc = "bpf",
            .expected_attach_type = BPF_LSM_MAC,
            .flags = BPF_F_SLEEPABLE,
            ...
    },
    
  Becomes:

    SEC("lsm.s/bpf")
    __description("reference tracking: ...")
    __success
    __naked void acquire_release_user_key_reference(void) { ... }
    
- Tests that use BPF_MAP_TYPE_PROG_ARRAY are migrated, the definitions
  of map and dummy programs that populate it are repeated in each test.

There `__imm_insn` macro had to be used in a few tests because of the
limitations of clang BPF inline assembler:
- For BPF_ST_MEM instruction in verifier_precise.c and verifier_unpriv.c;
- For BPF_LD_IND with three arguments in verifier_ref_tracking.c.

Migrated tests could be selected for execution using the following filter:

  ./test_progs -a verifier_*

While reviewing the changes I noticed the following irregularities in
the original tests:
- verifier_sock.c:
  Tests "bpf_sk_select_reuseport(ctx, sockhash, &key, flags)"
    and "bpf_sk_select_reuseport(ctx, sockmap, &key, flags)"
  have identical bodies.
- unpriv.c:
  Despite the name of the file, 12 tests defined in it have program
  types that are not considered for unprivileged execution by
  test_verifier (e.g. BPF_PROG_TYPE_TRACEPOINT).

Modifications were applied for the following tests:
- loop1.c:

  Some of the tests have .retval field specified, but program type is
  BPF_PROG_TYPE_TRACEPOINT, which does not support BPF_PROG_TEST_RUN
  command, for these tests
  - either program type is changed to "xdp", which supports
    BPF_PROG_TEST_RUN;
  - or retval tag is removed, if test run result is not actually
    predictable (e.g. depends on bpf_get_prandom_u32()).
- unpriv.c:
  This file is split in two parts:
  - progs/verifier_unpriv.c
  - progs/verifier_unpriv_perf.c
  First part requires inclusion of filter.h,
  second part requires inclusion of vmlinux.h.
- value_ptr_arith.c:
  "sanitation: alu with different scalars 2" and
  "sanitation: alu with different scalars 3"
  are modified to avoid retval "-EINVAL * 2" which cannot be encoded
  as a type tag.
  
Additional details are in the relevant commit messages.

[1] RFC
    https://lore.kernel.org/bpf/20230123145148.2791939-1-eddyz87@gmail.com/
[2] First batch of migrated tests
    https://lore.kernel.org/bpf/20230325025524.144043-1-eddyz87@gmail.com/
[3] Migration tool
    https://github.com/eddyz87/verifier-tests-migrator

Eduard Zingerman (24):
  selftests/bpf: Add notion of auxiliary programs for test_loader
  selftests/bpf: verifier/bounds converted to inline assembly
  selftests/bpf: verifier/bpf_get_stack converted to inline assembly
  selftests/bpf: verifier/btf_ctx_access converted to inline assembly
  selftests/bpf: verifier/ctx converted to inline assembly
  selftests/bpf: verifier/d_path converted to inline assembly
  selftests/bpf: verifier/direct_packet_access converted to inline
    assembly
  selftests/bpf: verifier/jeq_infer_not_null converted to inline
    assembly
  selftests/bpf: verifier/loops1 converted to inline assembly
  selftests/bpf: verifier/lwt converted to inline assembly
  selftests/bpf: verifier/map_in_map converted to inline assembly
  selftests/bpf: verifier/map_ptr_mixing converted to inline assembly
  selftests/bpf: verifier/precise converted to inline assembly
  selftests/bpf: verifier/prevent_map_lookup converted to inline
    assembly
  selftests/bpf: verifier/ref_tracking converted to inline assembly
  selftests/bpf: verifier/regalloc converted to inline assembly
  selftests/bpf: verifier/runtime_jit converted to inline assembly
  selftests/bpf: verifier/search_pruning converted to inline assembly
  selftests/bpf: verifier/sock converted to inline assembly
  selftests/bpf: verifier/spin_lock converted to inline assembly
  selftests/bpf: verifier/subreg converted to inline assembly
  selftests/bpf: verifier/unpriv converted to inline assembly
  selftests/bpf: verifier/value_illegal_alu converted to inline assembly
  selftests/bpf: verifier/value_ptr_arith converted to inline assembly

 .../selftests/bpf/prog_tests/verifier.c       |   80 +-
 tools/testing/selftests/bpf/progs/bpf_misc.h  |    6 +
 .../selftests/bpf/progs/verifier_bounds.c     | 1076 ++++++++++++
 .../bpf/progs/verifier_bpf_get_stack.c        |  124 ++
 .../bpf/progs/verifier_btf_ctx_access.c       |   32 +
 .../selftests/bpf/progs/verifier_ctx.c        |  221 +++
 .../selftests/bpf/progs/verifier_d_path.c     |   48 +
 .../bpf/progs/verifier_direct_packet_access.c |  803 +++++++++
 .../bpf/progs/verifier_jeq_infer_not_null.c   |  213 +++
 .../selftests/bpf/progs/verifier_loops1.c     |  259 +++
 .../selftests/bpf/progs/verifier_lwt.c        |  234 +++
 .../selftests/bpf/progs/verifier_map_in_map.c |  142 ++
 .../bpf/progs/verifier_map_ptr_mixing.c       |  265 +++
 .../selftests/bpf/progs/verifier_precise.c    |  269 +++
 .../bpf/progs/verifier_prevent_map_lookup.c   |   65 +
 .../bpf/progs/verifier_ref_tracking.c         | 1495 +++++++++++++++++
 .../selftests/bpf/progs/verifier_regalloc.c   |  364 ++++
 .../bpf/progs/verifier_runtime_jit.c          |  360 ++++
 .../bpf/progs/verifier_search_pruning.c       |  339 ++++
 .../selftests/bpf/progs/verifier_sock.c       |  980 +++++++++++
 .../selftests/bpf/progs/verifier_spin_lock.c  |  533 ++++++
 .../selftests/bpf/progs/verifier_subreg.c     |  673 ++++++++
 .../selftests/bpf/progs/verifier_unpriv.c     |  726 ++++++++
 .../bpf/progs/verifier_unpriv_perf.c          |   34 +
 .../bpf/progs/verifier_value_illegal_alu.c    |  149 ++
 .../bpf/progs/verifier_value_ptr_arith.c      | 1423 ++++++++++++++++
 tools/testing/selftests/bpf/test_loader.c     |   89 +-
 tools/testing/selftests/bpf/verifier/bounds.c |  884 ----------
 .../selftests/bpf/verifier/bpf_get_stack.c    |   87 -
 .../selftests/bpf/verifier/btf_ctx_access.c   |   25 -
 tools/testing/selftests/bpf/verifier/ctx.c    |  186 --
 tools/testing/selftests/bpf/verifier/d_path.c |   37 -
 .../bpf/verifier/direct_packet_access.c       |  710 --------
 .../bpf/verifier/jeq_infer_not_null.c         |  174 --
 tools/testing/selftests/bpf/verifier/loops1.c |  206 ---
 tools/testing/selftests/bpf/verifier/lwt.c    |  189 ---
 .../selftests/bpf/verifier/map_in_map.c       |   96 --
 .../selftests/bpf/verifier/map_ptr_mixing.c   |  100 --
 .../testing/selftests/bpf/verifier/precise.c  |  219 ---
 .../bpf/verifier/prevent_map_lookup.c         |   29 -
 .../selftests/bpf/verifier/ref_tracking.c     | 1082 ------------
 .../testing/selftests/bpf/verifier/regalloc.c |  277 ---
 .../selftests/bpf/verifier/runtime_jit.c      |  231 ---
 .../selftests/bpf/verifier/search_pruning.c   |  266 ---
 tools/testing/selftests/bpf/verifier/sock.c   |  706 --------
 .../selftests/bpf/verifier/spin_lock.c        |  447 -----
 tools/testing/selftests/bpf/verifier/subreg.c |  533 ------
 tools/testing/selftests/bpf/verifier/unpriv.c |  562 -------
 .../bpf/verifier/value_illegal_alu.c          |   95 --
 .../selftests/bpf/verifier/value_ptr_arith.c  | 1140 -------------
 50 files changed, 10974 insertions(+), 8309 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_bounds.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_bpf_get_stack.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_btf_ctx_access.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_ctx.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_d_path.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_direct_packet_access.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_jeq_infer_not_null.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_loops1.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_lwt.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_map_in_map.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_map_ptr_mixing.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_precise.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_prevent_map_lookup.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_ref_tracking.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_regalloc.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_runtime_jit.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_search_pruning.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_sock.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_spin_lock.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_subreg.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_unpriv.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_unpriv_perf.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_value_illegal_alu.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_value_ptr_arith.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/bounds.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/bpf_get_stack.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/btf_ctx_access.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/ctx.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/d_path.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/direct_packet_access.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/jeq_infer_not_null.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/loops1.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/lwt.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/map_in_map.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/map_ptr_mixing.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/precise.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/prevent_map_lookup.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/ref_tracking.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/regalloc.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/runtime_jit.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/search_pruning.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/sock.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/spin_lock.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/subreg.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/unpriv.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/value_illegal_alu.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/value_ptr_arith.c

-- 
2.40.0

