Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2320F677E69
	for <lists+bpf@lfdr.de>; Mon, 23 Jan 2023 15:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbjAWOwO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Jan 2023 09:52:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbjAWOwN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Jan 2023 09:52:13 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34451D93F
        for <bpf@vger.kernel.org>; Mon, 23 Jan 2023 06:52:11 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id fl11-20020a05600c0b8b00b003daf72fc844so10812521wmb.0
        for <bpf@vger.kernel.org>; Mon, 23 Jan 2023 06:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q3OrtXsARJ9D0shiGqdjvNPiR8zum9ju5k0riWnYxI4=;
        b=n1V4JQFYuiUKizeTVt2sU11ZtW+vAZVNNVvjofOraUrwozmP6yqP3Gj+Yywm18tuOM
         ihiMoiDZQYtnuqUCJc5ETJvNIP8fnRdIvgOJXG+d5ZXXqSwkW/qPO0x5SlA12+3Hgxq2
         00mDLDCGtwfsdx5nzqpZRRutBuTtVCOp8ZYvs+51PBCEIPLPGla1+33nTSybtj9WTO2a
         oZtllVd5CkK8HkPjJOmbabJaGq6MSggVeOhGwI04K+nWhYM6ZwHqp22swEdywWkTMdIU
         ij3Q0LT5KZlmjW01OXL6WfhEO3Vtcih0zw+RJSEhNufOYFT+0BaScZjdD6EXvXqL1/jB
         YKXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q3OrtXsARJ9D0shiGqdjvNPiR8zum9ju5k0riWnYxI4=;
        b=RpUhfk65v6S01LkDuezrvekBzOtCmPO7ZKhLu0ZhvmYgGPLhliRarP4p+bvyyeu8v+
         l1YkvW0w6udiNSILNu4FsjLMHkjnuUbSw7dQaMA53Ne2ceLsDzmlOuKRjuTfrgBR80E8
         f67hGIRt3CIyRvvnDZeBN0CbVl0w4m6pRHrwpF+UAFWZ9UGgGF6j/HLknmR3M8P+n6b+
         6ZCf1gkojYKdxPQkf2lvqumJdQ6N6lyoHDiw4V6i5hfmc8O/9BKxf9YGXoPAqgCznCxN
         PbdTbtbpnnhf5D9a/XdXf2sNMgDU6C3KtSAQS2u6e/5mOfReQM4wAHxSx6ixJABMdADA
         RjNA==
X-Gm-Message-State: AFqh2ko2DueLB0f9Ty8Oluqs2j+qN4pMVaS6jMEGys3aCK2byggwZWxw
        RDAg6RSVrqz7PDdPLMSn0qKWOcPAMXQ=
X-Google-Smtp-Source: AMrXdXtvjCiX1SOuDZweax64pS3Offwaa+Glm+d9KN0MSHv3TLManFp+fZeigeysPp0lhexuU2mUPg==
X-Received: by 2002:a1c:4c0a:0:b0:3db:210:6a24 with SMTP id z10-20020a1c4c0a000000b003db02106a24mr23137195wmf.8.1674485530034;
        Mon, 23 Jan 2023 06:52:10 -0800 (PST)
Received: from pluto.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id c7-20020a05600c0a4700b003d1e1f421bfsm11999649wmq.10.2023.01.23.06.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 06:52:09 -0800 (PST)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com, Eduard Zingerman <eddyz87@gmail.com>
Subject: [RFC bpf-next 0/5] test_verifier tests migration to inline assembly
Date:   Mon, 23 Jan 2023 16:51:43 +0200
Message-Id: <20230123145148.2791939-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

As a part of the discussion started in [2] I developed a script [1]
that can convert tests specified in test_verifier.c format to inline
BPF assembly compatible for use with test_loader.c.

For example, test definition like below:

{
        "invalid and of negative number",
        .insns = {
        BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
        BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
        BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
        BPF_LD_MAP_FD(BPF_REG_1, 0),
        BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
        BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
        BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_0, 0),
        BPF_ALU64_IMM(BPF_AND, BPF_REG_1, -4),
        BPF_ALU64_IMM(BPF_LSH, BPF_REG_1, 2),
        BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
        BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, offsetof(struct test_val, foo)),
        BPF_EXIT_INSN(),
        },
        .fixup_map_hash_48b = { 3 },
        .errstr = "R0 max value is outside of the allowed memory range",
        .result = REJECT,
        .flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
},

Is converted to:

struct test_val { ... };

struct { ...} map_hash_48b SEC(".maps");

__description("invalid and of negative number")
__failure __msg("R0 max value is outside of the allowed memory range")
__failure_unpriv
__flag(BPF_F_ANY_ALIGNMENT)
SEC("socket")
__naked void invalid_and_of_negative_number(void)

{
        asm volatile (
"       r1 = 0;                                         \n\
        *(u64*)(r10 - 8) = r1;                          \n\
        r2 = r10;                                       \n\
        r2 += -8;                                       \n\
        r1 = %[map_hash_48b] ll;                        \n\
        call %[bpf_map_lookup_elem];                    \n\
        if r0 == 0 goto l0_%=;                          \n\
        r1 = *(u8*)(r0 + 0);                            \n\
        r1 &= -4;                                       \n\
        r1 <<= 2;                                       \n\
        r0 += r1;                                       \n\
        r1 = %[test_val_foo_offset];                    \n\
        *(u64*)(r0 + 0) = r1;                           \n\
l0_%=:                                                  \n\
        exit;                                           \n\
"       :
        : [test_val_foo_offset]"i"(offsetof(struct test_val, foo)),
          __imm(bpf_map_lookup_elem),
          __imm_addr(map_hash_48b)
        : __clobber_all);
}

The script introduces labels for gotos and calls, immediate values for
complex expressions like `offsetof(...)', takes care of map
instructions patching, inserts map declarations used in the test,
transfers comments from test, test fields and instructions. There are
some issues with BPF_ST_MEM instruction support as described in [4],
thus the script replaces such instructions with pairs of MOV/STX_MEM
instructions.

This patch-set introduces changes necessary for test_loader.c and
includes migration of a single test from test_verifier to test_progs
format, here are descriptions for individual patches:

1. "Support custom per-test flags and multiple expected messages"
   This patch was shared by Andrii Nakryiko [3], it adds capability
   to specify flags required by the BPF program.

2. "Unprivileged tests for test_loader.c"
   Extends test_loader.c by capability to load test programs in
   unprivileged mode and specify separate test outcomes for
   privileged and unprivileged modes.
   
   Note: for a reason I do not understand I had to use different set
   of capabilities compared to test_verifier:
   - test_verifier: CAP_NET_ADMIN, CAP_PERFMON, CAP_BPF;
   - test_loader  : CAP_SYS_ADMIN, CAP_PERFMON, CAP_BPF.
   
3. "Generate boilerplate code for test_loader-based tests"
   Extends selftests/bpf Makefile to automatically generate
   prog_tests/tests.h entry that uses test_loader for progs/*.c
   BPF programs if special marker is present.
   
4. "__imm_insn macro to embed raw insns in inline asm"
   This macro can be generated by migration script for instructions
   that cannot be expressed in inline assembly, e.g. invalid instructions.
   
5. "convert jeq_infer_not_null tests to inline assembly"
   Shows an example of the test migration.
   The test was updated slightly after automatic translation:
   - unnecessary comments removed;
   - functions renamed;
   - some labels renamed.

The migration script has some limitations:
- Technical, test features that are not yet supported:
  - few instructions like BPF_ENDIAN;
  - macro like BPF_SK_LOOKUP or BPF_LD_MAP_VALUE;
  - program types like BPF_PROG_TYPE_CGROUP_SOCK_ADDR and
    BPF_PROG_TYPE_TRACING;
  - tests that specify fields 'expected_attach_type' or 'insn_processed';
  - a few tests expose complex structure that could not be
    automatically migrated, e.g.: 'atomic_fetch', 'lwt',
    'bpf_loop_inline'.
- Tests that use .run field cannot be migrated as test_loader.c tests.
- Tests with generated bodies, e.g. test_verifier.c:bpf_fill_scale()
  cannot be migrated as test_loader.c tests.
- LLVM related:
  - BPF_ST instruction is not supported by LLVM BPF assembly yet
    (I'll take care of it);
  - Issues with parsing of some assembly instructions like
    "r0 = cmpxchg_64(r10 - 8, r0, r5)"
    (I'll take care of it);
- libbpf related:
  - libbpf does not support call instructions within a single
    function, e.g.:

      0: r1 = 1
      1: r2 = 2
      2: call 1
      3: exit
      4: r0 = r1
      5: r0 += r2
      6: exit
      
    This pattern is common in verifier tests, I see two possible
    mitigation:
    (a) use an additional libbpf flag to allow such code;
    (b) extend migration script to split such code in several functions.
    I like (a) more.

  - libbpf does not allow empty programs.

All in all the current script stats are as follows:
- 62 out of 93 files from progs/*.c can be converted w/o warnings;
- 55 converted files could be compiled;
- 40 pass testing, 15 fail.

By submitting this RFC I seek the following feedback:
- is community interested in such migration?
- if yes, should I pursue partial or complete tests migration?
- in case of partial migration which tests should be prioritized?
- should I offer migrated tests one by one or in big butches?

Thanks,
Eduard

[1] https://github.com/eddyz87/verifier-tests-migrator
[2] https://lore.kernel.org/bpf/CAEf4BzYPsDWdRgx+ND1wiKAB62P=WwoLhr2uWkbVpQfbHqi1oA@mail.gmail.com/
[3] https://lore.kernel.org/bpf/CAEf4BzZH0ZxorCi7nPDbRqSK9f+410RooNwNJGwfw8=0a5i1nw@mail.gmail.com/
[4] https://lore.kernel.org/bpf/20221231163122.1360813-1-eddyz87@gmail.com/

Andrii Nakryiko (1):
  selftests/bpf: support custom per-test flags and multiple expected
    messages

Eduard Zingerman (4):
  selftests/bpf: unprivileged tests for test_loader.c
  selftests/bpf: generate boilerplate code for test_loader-based tests
  selftests/bpf: __imm_insn macro to embed raw insns in inline asm
  selftests/bpf: convert jeq_infer_not_null tests to inline assembly

 tools/testing/selftests/bpf/Makefile          |  41 +-
 tools/testing/selftests/bpf/autoconf_helper.h |   9 +
 .../selftests/bpf/prog_tests/.gitignore       |   1 +
 .../bpf/prog_tests/jeq_infer_not_null.c       |   9 -
 tools/testing/selftests/bpf/progs/bpf_misc.h  |  49 +++
 .../selftests/bpf/progs/jeq_infer_not_null.c  | 186 +++++++++
 .../bpf/progs/jeq_infer_not_null_fail.c       |   1 +
 tools/testing/selftests/bpf/test_loader.c     | 370 +++++++++++++++---
 tools/testing/selftests/bpf/test_progs.h      |   1 +
 tools/testing/selftests/bpf/test_verifier.c   |  25 +-
 tools/testing/selftests/bpf/unpriv_helpers.c  |  26 ++
 tools/testing/selftests/bpf/unpriv_helpers.h  |   7 +
 .../bpf/verifier/jeq_infer_not_null.c         | 174 --------
 13 files changed, 625 insertions(+), 274 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/autoconf_helper.h
 delete mode 100644 tools/testing/selftests/bpf/prog_tests/jeq_infer_not_null.c
 create mode 100644 tools/testing/selftests/bpf/progs/jeq_infer_not_null.c
 create mode 100644 tools/testing/selftests/bpf/unpriv_helpers.c
 create mode 100644 tools/testing/selftests/bpf/unpriv_helpers.h
 delete mode 100644 tools/testing/selftests/bpf/verifier/jeq_infer_not_null.c

-- 
2.39.0

