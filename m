Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B161B54A0F7
	for <lists+bpf@lfdr.de>; Mon, 13 Jun 2022 23:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234130AbiFMVMP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Jun 2022 17:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352003AbiFMVME (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Jun 2022 17:12:04 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EE330573
        for <bpf@vger.kernel.org>; Mon, 13 Jun 2022 13:50:30 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id c4so10724335lfj.12
        for <bpf@vger.kernel.org>; Mon, 13 Jun 2022 13:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LjHDs/59Ta6qkMSEljslYGTubvFtzDi0GEJrq/rIkrI=;
        b=XH+0ZsreGPQQV1c0qSh7t7WlCXokEx1JQqnHqJFQju22RMtC47Vn7NpAidlunUC4oM
         dAMwh0F2kjwzXt4NaM1CjgPkQilAKXagoluzBFj3XKBRJmevXMeBWrFII+HRGEE0oZPA
         hnLIUwgxm6E2rGEhGJOtvFZKWIhIMhenwfFk9rAkPRYG2LZSxVhw4WU4IMPOis/RPqp0
         Mir3CKIO6mMrj4oCMP7/fzrgtxFXFY1ifnnOgRhbzSDwNMJZorT5YxOeO6DWl+6qIZOp
         LCtooc+tGf50yElBeO05WzWurYIirdhQ/rJx9FPG04wGioDuuqzSnQu055srUDxo7MkG
         vWTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LjHDs/59Ta6qkMSEljslYGTubvFtzDi0GEJrq/rIkrI=;
        b=VvcOueHIDZ1etvWYJgs8LAgMk1h9LyecEBNO8Qh7g6VJEM4huDH1S/nK5uED7hNxw2
         An5Nj85Opu+WWSLxyjr3t9sX69lql8ygS6FXyEt8KimS1R8KmHNAqBEPHhi9n8CnpaOf
         2H+pC67iUsnwHErJzYtMJepMbf0qQ4e5lQZZwDW2o6nXpjAIjpXPJRyThtSovm4c2cy7
         fdBKrjuKRO5fqRqFCI2tWmtc4//AdihoNYeo+QfZBP0GImdEERRel5tZCdjURFuBlyRx
         SwRgLJhBUOPsMe4j/DHzXCavpwjatNEdfBMddToNtoHCb7fxRXqG/i4/FnpoqqKtZbBY
         /TgA==
X-Gm-Message-State: AOAM532seZoQE7MgqEGKKIhI0gWQg/K7EQyAcuAorwBUBhUNzMmFGQua
        ghSO43i/eXyRVR3Gh8af2+7Xx1levx+lpw==
X-Google-Smtp-Source: AGRyM1thPLkZaVxI7wi+9TMto+vL6JOY43HAGS2MWemM7r/H6fX7VUuKX3/TV8gyEVkAfj2FBJLJCQ==
X-Received: by 2002:a05:6512:3c84:b0:478:ee3b:1cc4 with SMTP id h4-20020a0565123c8400b00478ee3b1cc4mr1000948lfv.179.1655153428844;
        Mon, 13 Jun 2022 13:50:28 -0700 (PDT)
Received: from localhost.localdomain (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id f2-20020a056512360200b004786eb19049sm1114763lfs.24.2022.06.13.13.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 13:50:27 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, song@kernel.org,
        joannelkoong@gmail.com
Cc:     eddyz87@gmail.com
Subject: [PATCH bpf-next v7 0/5] bpf_loop inlining
Date:   Mon, 13 Jun 2022 23:50:03 +0300
Message-Id: <20220613205008.212724-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Hi Everyone,

This is the next iteration of the patch. It includes changes suggested
by Song, Joanne and Alexei. Please find updated intro message and
change log below.

This patch implements inlining of calls to bpf_loop helper function
when bpf_loop's callback is statically known. E.g. the rewrite does
the following transformation during BPF program processing:

  bpf_loop(10, foo, NULL, 0);

 ->

  for (int i = 0; i < 10; ++i)
    foo(i, NULL);

The transformation leads to measurable latency change for simple
loops. Measurements using `benchs/run_bench_bpf_loop.sh` inside QEMU /
KVM on i7-4710HQ CPU show a drop in latency from 14 ns/op to 2 ns/op.

The change is split in five parts:

* Update to test_verifier.c to specify expected and unexpected
  instruction sequences. This allows to check BPF program rewrites
  applied by e.g. do_mix_fixups function.

* Update to test_verifier.c to specify BTF function infos and types
  per test case. This is necessary for tests that load sub-program
  addresses to a variable because of the checks applied by
  check_ld_imm function.

* The update to verifier.c that tracks state of the parameters for
  each bpf_loop call in a program and decides whether it could be
  replaced by a loop.

* A set of test cases for `test_verifier` that use capabilities added
  by the first two patches to verify instructions produced by inlining
  logic.

* Two test cases for `test_prog` to check that possible corner cases
  behave as expected.

Additional details are available in commit messages for each patch.

Changes since v6:
 - Return value of the `optimize_bpf_loop` function is no longer
   ignored. This is necessary to properly propagate -ENOMEM error.

Changes since v5:
 - Added function `loop_flag_is_zero` to skip a few checks in
   `update_loop_inline_state` when loop instruction is not fit for
   inline.

Changes since v4:
 - Added missing `static` modifier for `update_loop_inline_state` and
   `inline_bpf_loop` functions.
 - `update_loop_inline_state` updated for better readability.
 - Fields `initialized` and `fit_for_inline` of `struct
   bpf_loop_inline_state` are changed back from `bool` to bitfields.
 - Acks from Song Liu added to comments for patches 1/5, 2/5, 4/5,
   5/5.

Changes since v3:
 - Function `adjust_stack_depth_for_loop_inlining` is replaced by
   function `optimize_bpf_loop`. Function `optimize_bpf_loop` is
   responsible for both stack depth adjustment and call instruction
   replacement.
 - Changes in `do_misc_fixups` are reverted.
 - Changes in `adjust_subprog_starts_after_remove` are reverted and
   function `adjust_loop_inline_subprogno` is removed. This is
   possible because call to `optimize_bpf_loop` is placed before the
   dead code removal in `opt_remove_dead_code` (in contrast to the
   position of `do_misc_fixups` where inlining was done in v3).
 - Field `bpf_insn_aux_data.loop_inline_state` is now a part of
   anonymous union at the start of the `bpf_insn_aux_data`.
 - Data structure `bpf_loop_inline_state` is simplified to use single
   flag field `fit_for_inline` instead of separate fields
   `flags_is_zero` & `callback_is_constant`.
 - Macro definition `BPF_MAX_LOOPS` is moved from
   `include/linux/bpf_verifier.h` to `include/linux/bpf.h` to avoid
   include of `include/linux/bpf_verifier.h` in `bpf_iter.c`.
 - `inline_bpf_loop` changed back to use array initialization and hard
   coded offsets as in v2.
 - Style / formatting updates.

Changes since v2:
 - fix for `stack_check` test case in `test_progs-no_alu32`, all tests
   are passing now;
 - v2 3/3 patch is split in three parts:
   - kernel changes
   - test_verifier changes
   - test_prog changes
 - updated `inline_bpf_loop` in `verifier.c` to calculate each offset
   used in instructions to avoid "magic" numbers;
 - removed newline handling logic in `fail_log` branch of
   `do_single_test` in `test_verifier.c` to simplify the patch set;
 - styling fixes suggested in review for v2 of this patch set.

Changes since v1:
 - allow to use SKIP_INSNS in instruction pattern specification in
   test_verifier tests;
 - fix for a bug in spill offset assignement for loop vars when
   bpf_loop is located in a non-main function.

Eduard Zingerman (5):
  selftests/bpf: specify expected instructions in test_verifier tests
  selftests/bpf: allow BTF specs and func infos in test_verifier tests
  bpf: Inline calls to bpf_loop when callback is known
  selftests/bpf: BPF test_verifier selftests for bpf_loop inlining
  selftests/bpf: BPF test_prog selftests for bpf_loop inlining

 include/linux/bpf.h                           |   3 +
 include/linux/bpf_verifier.h                  |  12 +
 kernel/bpf/bpf_iter.c                         |   9 +-
 kernel/bpf/verifier.c                         | 175 +++++++++-
 .../selftests/bpf/prog_tests/bpf_loop.c       |  62 ++++
 tools/testing/selftests/bpf/prog_tests/btf.c  |   1 -
 tools/testing/selftests/bpf/progs/bpf_loop.c  | 114 ++++++
 tools/testing/selftests/bpf/test_btf.h        |   2 +
 tools/testing/selftests/bpf/test_verifier.c   | 328 +++++++++++++++++-
 .../selftests/bpf/verifier/bpf_loop_inline.c  | 244 +++++++++++++
 10 files changed, 923 insertions(+), 27 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/verifier/bpf_loop_inline.c

-- 
2.25.1

