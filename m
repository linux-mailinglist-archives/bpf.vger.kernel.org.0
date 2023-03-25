Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1260B6C8A5B
	for <lists+bpf@lfdr.de>; Sat, 25 Mar 2023 03:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjCYCzz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Mar 2023 22:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjCYCzz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Mar 2023 22:55:55 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B231D15CBB
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:55:52 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id m6-20020a05600c3b0600b003ee6e324b19so2001207wms.1
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679712951;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=91xLV0ON/5lnkS3eAR2hwixWiggrIqRku3RaBzf2ZbM=;
        b=qoRE/AZPAep/jTkxROZE5OIIac7jWilXiTE2+0Xhcezg7b7JIS4PUywAJ2wueBHbVu
         jhaAQPEjdKR7BubQkq9hJ+1bJ8jdeeiOPGvAP9QsL65gIW3OaoOzZzPBML1USxtgd322
         U4z38UaM18m5lNmpwnb+ulotHYm0ChQFtQU1USixJ/DwG/b++xwa95KojcUtlCpxCUAe
         w2plbTm70H8eZ4cr2z3nGOsWCkU0cQ+MIZ/MphmTUNtoB0iDrKOuyrXqf36N+mGqPhFo
         Sq52G3gHIW38qGMi0+mA5Ouda/OdrzfF1voFvCuUxlr5NiYNU2pWdmw9XKZkzVpq/LXt
         0vOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679712951;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=91xLV0ON/5lnkS3eAR2hwixWiggrIqRku3RaBzf2ZbM=;
        b=4jNHBEODtn5DlRWSxoL1PW+vQFTr2c3ncQf898gO5Dc1JwHZiZGGaVcCCYpEovyZwc
         xrySNakNalQRkM+YdnUdHdy4tQBnKo3LHkzwF3sI8asG9IYuS3k0waECFZn8JzBDpPa0
         TGwTjhnEHgdMZLrwPsJPufQBcsib3xDPy6DKjLqhYVIhjyEnxjKW971cWfweUQnbesf8
         06BCjROdowYR9E8CM7Fwbs0WNlFo9AyqK7CcBDh3Qp9LxA9LKDtptbiVp8p2nkucNCsT
         PjIHZxDW4Lnkzde+gqCG4ymsgLMZ1Q1CMgm890EulGMWU8NT9czuH7SeJkt3UTZSFeVu
         +YVA==
X-Gm-Message-State: AO0yUKW4a4UGgUtyK7ILGs5S/9MoJMFFimT98d9XQuT3sZD/tHrZBuju
        TGSF9kn0Zm09s6wprppv7Ovgyuz0kdU=
X-Google-Smtp-Source: AK7set/pGaI+sXTxvOjHr9tLIa4teTvX8DTP7aS1YtT0S/EAx7gkYbbkCDcKN/mZMVZuWO4ljaLkGw==
X-Received: by 2002:a7b:c8c4:0:b0:3ed:ce6f:e86e with SMTP id f4-20020a7bc8c4000000b003edce6fe86emr3814046wml.23.1679712950686;
        Fri, 24 Mar 2023 19:55:50 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id m1-20020a05600c4f4100b003ee1e07a14asm1428724wmq.45.2023.03.24.19.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 19:55:49 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 00/43] First set of verifier/*.c migrated to inline assembly
Date:   Sat, 25 Mar 2023 04:54:41 +0200
Message-Id: <20230325025524.144043-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This is a follow up for RFC [1]. It migrates a first batch of 38
verifier/*.c tests to inline assembly and use of ./test_progs for
actual execution. The migration is done by a python script (see [2]).

Each migrated verifier/xxx.c file is mapped to progs/verifier_xxx.c
plus an entry in the prog_tests/verifier.c. One patch per each file.

A few patches at the beginning of the patch-set extend test_loader
with necessary functionality, mainly:
- support for tests execution in unprivileged mode;
- support for test runs for test programs.

Migrated tests could be selected for execution using the following filter:

  ./test_progs -a verifier_*
  
An example of the migrated test:

  SEC("xdp")
  __description("XDP pkt read, pkt_data' > pkt_end, corner case, good access")
  __success __retval(0) __flag(BPF_F_ANY_ALIGNMENT)
  __naked void end_corner_case_good_access_1(void)
  {
          asm volatile ("                                 \
          r2 = *(u32*)(r1 + %[xdp_md_data]);              \
          r3 = *(u32*)(r1 + %[xdp_md_data_end]);          \
          r1 = r2;                                        \
          r1 += 8;                                        \
          if r1 > r3 goto l0_%=;                          \
          r0 = *(u64*)(r1 - 8);                           \
  l0_%=:  r0 = 0;                                         \
          exit;                                           \
  "       :
          : __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
            __imm_const(xdp_md_data_end, offsetof(struct xdp_md, data_end))
          : __clobber_all);
  }

Changes compared to RFC:
- test_loader.c is extended to support test program runs;
- capabilities handling now matches behavior of test_verifier;
- BPF_ST_MEM instructions are automatically replaced by BPF_STX_MEM
  instructions to overcome current clang limitations;
- tests styling updates according to RFC feedback;
- 38 migrated files are included instead of 1.

I used the following means for testing:
- migration tool itself has a set of self-tests;
- migrated tests are passing;
- manually compared each old/new file side-by-side.

While doing side-by-side comparison I've noted a few defects in the
original tests:
- and.c:
  - One of the jump targets is off by one;
  - BPF_ST_MEM wrong OFF/IMM ordering;
- array_access.c:
  - BPF_ST_MEM wrong OFF/IMM ordering;
- value_or_null.c:
  - BPF_ST_MEM wrong OFF/IMM ordering.

These defects would be addressed separately.

[1] RFC
    https://lore.kernel.org/bpf/20230123145148.2791939-1-eddyz87@gmail.com/
[2] Migration tool
    https://github.com/eddyz87/verifier-tests-migrator

Eduard Zingerman (43):
  selftests/bpf: Report program name on parse_test_spec error
  selftests/bpf: __imm_insn & __imm_const macro for bpf_misc.h
  selftests/bpf: Unprivileged tests for test_loader.c
  selftests/bpf: Tests execution support for test_loader.c
  selftests/bpf: prog_tests entry point for migrated test_verifier tests
  selftests/bpf: verifier/and.c converted to inline assembly
  selftests/bpf: verifier/array_access.c converted to inline assembly
  selftests/bpf: verifier/basic_stack.c converted to inline assembly
  selftests/bpf: verifier/bounds_deduction.c converted to inline
    assembly
  selftests/bpf: verifier/bounds_mix_sign_unsign.c converted to inline
    assembly
  selftests/bpf: verifier/cfg.c converted to inline assembly
  selftests/bpf: verifier/cgroup_inv_retcode.c converted to inline
    assembly
  selftests/bpf: verifier/cgroup_skb.c converted to inline assembly
  selftests/bpf: verifier/cgroup_storage.c converted to inline assembly
  selftests/bpf: verifier/const_or.c converted to inline assembly
  selftests/bpf: verifier/ctx_sk_msg.c converted to inline assembly
  selftests/bpf: verifier/direct_stack_access_wraparound.c converted to
    inline assembly
  selftests/bpf: verifier/div0.c converted to inline assembly
  selftests/bpf: verifier/div_overflow.c converted to inline assembly
  selftests/bpf: verifier/helper_access_var_len.c converted to inline
    assembly
  selftests/bpf: verifier/helper_packet_access.c converted to inline
    assembly
  selftests/bpf: verifier/helper_restricted.c converted to inline
    assembly
  selftests/bpf: verifier/helper_value_access.c converted to inline
    assembly
  selftests/bpf: verifier/int_ptr.c converted to inline assembly
  selftests/bpf: verifier/ld_ind.c converted to inline assembly
  selftests/bpf: verifier/leak_ptr.c converted to inline assembly
  selftests/bpf: verifier/map_ptr.c converted to inline assembly
  selftests/bpf: verifier/map_ret_val.c converted to inline assembly
  selftests/bpf: verifier/masking.c converted to inline assembly
  selftests/bpf: verifier/meta_access.c converted to inline assembly
  selftests/bpf: verifier/raw_stack.c converted to inline assembly
  selftests/bpf: verifier/raw_tp_writable.c converted to inline assembly
  selftests/bpf: verifier/ringbuf.c converted to inline assembly
  selftests/bpf: verifier/spill_fill.c converted to inline assembly
  selftests/bpf: verifier/stack_ptr.c converted to inline assembly
  selftests/bpf: verifier/uninit.c converted to inline assembly
  selftests/bpf: verifier/value_adj_spill.c converted to inline assembly
  selftests/bpf: verifier/value.c converted to inline assembly
  selftests/bpf: verifier/value_or_null.c converted to inline assembly
  selftests/bpf: verifier/var_off.c converted to inline assembly
  selftests/bpf: verifier/xadd.c converted to inline assembly
  selftests/bpf: verifier/xdp.c converted to inline assembly
  selftests/bpf: verifier/xdp_direct_packet_access.c converted to inline
    assembly

 tools/testing/selftests/bpf/Makefile          |   10 +-
 tools/testing/selftests/bpf/autoconf_helper.h |    9 +
 .../selftests/bpf/prog_tests/verifier.c       |  106 +
 tools/testing/selftests/bpf/progs/bpf_misc.h  |   42 +
 .../selftests/bpf/progs/verifier_and.c        |  107 +
 .../bpf/progs/verifier_array_access.c         |  529 +++++
 .../bpf/progs/verifier_basic_stack.c          |  100 +
 .../bpf/progs/verifier_bounds_deduction.c     |  171 ++
 .../progs/verifier_bounds_mix_sign_unsign.c   |  554 ++++++
 .../selftests/bpf/progs/verifier_cfg.c        |  100 +
 .../bpf/progs/verifier_cgroup_inv_retcode.c   |   89 +
 .../selftests/bpf/progs/verifier_cgroup_skb.c |  227 +++
 .../bpf/progs/verifier_cgroup_storage.c       |  308 +++
 .../selftests/bpf/progs/verifier_const_or.c   |   82 +
 .../selftests/bpf/progs/verifier_ctx_sk_msg.c |  228 +++
 .../verifier_direct_stack_access_wraparound.c |   56 +
 .../selftests/bpf/progs/verifier_div0.c       |  213 ++
 .../bpf/progs/verifier_div_overflow.c         |  144 ++
 .../progs/verifier_helper_access_var_len.c    |  825 ++++++++
 .../bpf/progs/verifier_helper_packet_access.c |  550 ++++++
 .../bpf/progs/verifier_helper_restricted.c    |  279 +++
 .../bpf/progs/verifier_helper_value_access.c  | 1245 ++++++++++++
 .../selftests/bpf/progs/verifier_int_ptr.c    |  157 ++
 .../selftests/bpf/progs/verifier_ld_ind.c     |  110 ++
 .../selftests/bpf/progs/verifier_leak_ptr.c   |   92 +
 .../selftests/bpf/progs/verifier_map_ptr.c    |  159 ++
 .../bpf/progs/verifier_map_ret_val.c          |  110 ++
 .../selftests/bpf/progs/verifier_masking.c    |  410 ++++
 .../bpf/progs/verifier_meta_access.c          |  284 +++
 .../selftests/bpf/progs/verifier_raw_stack.c  |  371 ++++
 .../bpf/progs/verifier_raw_tp_writable.c      |   50 +
 .../selftests/bpf/progs/verifier_ringbuf.c    |  131 ++
 .../selftests/bpf/progs/verifier_spill_fill.c |  374 ++++
 .../selftests/bpf/progs/verifier_stack_ptr.c  |  484 +++++
 .../selftests/bpf/progs/verifier_uninit.c     |   61 +
 .../selftests/bpf/progs/verifier_value.c      |  158 ++
 .../bpf/progs/verifier_value_adj_spill.c      |   78 +
 .../bpf/progs/verifier_value_or_null.c        |  288 +++
 .../selftests/bpf/progs/verifier_var_off.c    |  349 ++++
 .../selftests/bpf/progs/verifier_xadd.c       |  124 ++
 .../selftests/bpf/progs/verifier_xdp.c        |   24 +
 .../progs/verifier_xdp_direct_packet_access.c | 1722 +++++++++++++++++
 tools/testing/selftests/bpf/test_loader.c     |  536 ++++-
 tools/testing/selftests/bpf/test_verifier.c   |   25 +-
 tools/testing/selftests/bpf/unpriv_helpers.c  |   26 +
 tools/testing/selftests/bpf/unpriv_helpers.h  |    7 +
 tools/testing/selftests/bpf/verifier/and.c    |   68 -
 .../selftests/bpf/verifier/array_access.c     |  379 ----
 .../selftests/bpf/verifier/basic_stack.c      |   64 -
 .../selftests/bpf/verifier/bounds_deduction.c |  136 --
 .../bpf/verifier/bounds_mix_sign_unsign.c     |  411 ----
 tools/testing/selftests/bpf/verifier/cfg.c    |   73 -
 .../bpf/verifier/cgroup_inv_retcode.c         |   72 -
 .../selftests/bpf/verifier/cgroup_skb.c       |  197 --
 .../selftests/bpf/verifier/cgroup_storage.c   |  220 ---
 .../testing/selftests/bpf/verifier/const_or.c |   60 -
 .../selftests/bpf/verifier/ctx_sk_msg.c       |  181 --
 .../verifier/direct_stack_access_wraparound.c |   40 -
 tools/testing/selftests/bpf/verifier/div0.c   |  184 --
 .../selftests/bpf/verifier/div_overflow.c     |  110 --
 .../bpf/verifier/helper_access_var_len.c      |  650 -------
 .../bpf/verifier/helper_packet_access.c       |  460 -----
 .../bpf/verifier/helper_restricted.c          |  196 --
 .../bpf/verifier/helper_value_access.c        |  953 ---------
 .../testing/selftests/bpf/verifier/int_ptr.c  |  161 --
 tools/testing/selftests/bpf/verifier/ld_ind.c |   72 -
 .../testing/selftests/bpf/verifier/leak_ptr.c |   67 -
 .../testing/selftests/bpf/verifier/map_ptr.c  |   99 -
 .../selftests/bpf/verifier/map_ret_val.c      |   65 -
 .../testing/selftests/bpf/verifier/masking.c  |  322 ---
 .../selftests/bpf/verifier/meta_access.c      |  235 ---
 .../selftests/bpf/verifier/raw_stack.c        |  305 ---
 .../selftests/bpf/verifier/raw_tp_writable.c  |   35 -
 .../testing/selftests/bpf/verifier/ringbuf.c  |   95 -
 .../selftests/bpf/verifier/spill_fill.c       |  345 ----
 .../selftests/bpf/verifier/stack_ptr.c        |  359 ----
 tools/testing/selftests/bpf/verifier/uninit.c |   39 -
 tools/testing/selftests/bpf/verifier/value.c  |  104 -
 .../selftests/bpf/verifier/value_adj_spill.c  |   43 -
 .../selftests/bpf/verifier/value_or_null.c    |  220 ---
 .../testing/selftests/bpf/verifier/var_off.c  |  291 ---
 tools/testing/selftests/bpf/verifier/xadd.c   |   97 -
 tools/testing/selftests/bpf/verifier/xdp.c    |   14 -
 .../bpf/verifier/xdp_direct_packet_access.c   | 1468 --------------
 84 files changed, 11994 insertions(+), 9000 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/autoconf_helper.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/verifier.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_and.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_array_access.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_basic_stack.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_bounds_deduction.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_bounds_mix_sign_unsign.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_cfg.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_cgroup_inv_retcode.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_cgroup_skb.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_cgroup_storage.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_const_or.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_ctx_sk_msg.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_direct_stack_access_wraparound.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_div0.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_div_overflow.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_helper_access_var_len.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_helper_packet_access.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_helper_restricted.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_helper_value_access.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_int_ptr.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_ld_ind.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_leak_ptr.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_map_ptr.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_map_ret_val.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_masking.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_meta_access.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_raw_stack.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_raw_tp_writable.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_ringbuf.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_spill_fill.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_stack_ptr.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_uninit.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_value.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_value_adj_spill.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_value_or_null.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_var_off.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_xadd.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_xdp.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_xdp_direct_packet_access.c
 create mode 100644 tools/testing/selftests/bpf/unpriv_helpers.c
 create mode 100644 tools/testing/selftests/bpf/unpriv_helpers.h
 delete mode 100644 tools/testing/selftests/bpf/verifier/and.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/array_access.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/basic_stack.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/bounds_deduction.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/bounds_mix_sign_unsign.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/cfg.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/cgroup_inv_retcode.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/cgroup_skb.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/cgroup_storage.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/const_or.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/ctx_sk_msg.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/direct_stack_access_wraparound.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/div0.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/div_overflow.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/helper_access_var_len.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/helper_packet_access.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/helper_restricted.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/helper_value_access.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/int_ptr.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/ld_ind.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/leak_ptr.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/map_ptr.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/map_ret_val.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/masking.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/meta_access.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/raw_stack.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/raw_tp_writable.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/ringbuf.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/spill_fill.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/stack_ptr.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/uninit.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/value.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/value_adj_spill.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/value_or_null.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/var_off.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/xadd.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/xdp.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/xdp_direct_packet_access.c

-- 
2.40.0

