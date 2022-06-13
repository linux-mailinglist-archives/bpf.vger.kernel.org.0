Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0914B549C00
	for <lists+bpf@lfdr.de>; Mon, 13 Jun 2022 20:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344898AbiFMSoZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Jun 2022 14:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345445AbiFMSnd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Jun 2022 14:43:33 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7380FF77
        for <bpf@vger.kernel.org>; Mon, 13 Jun 2022 08:02:21 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id a2so9312479lfg.5
        for <bpf@vger.kernel.org>; Mon, 13 Jun 2022 08:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4WKyGrf0mo0OgQShBnc8Zv5TVj5kESxWU/mbfCBYVJk=;
        b=JBkLR6Jmsa3yTSF2dkRwone/J1qoIpHkoUfb69YIcTrjgSJlLfdJxHQl8+PDz2oKp9
         Dzh1t8aB6VAkPhM491D1kPboxqh+htXf5qU+lGTxMu6x95RZLSyzwHUXtlCZa7NqKVtU
         7DCBo90UjnwbLm/X5gx6DHiHyWkctx+3l0hXd+NZ9MDHKerUBmWnxcz88FqiqXyEFiZp
         4NKVn4qw9QwzMWI30ErM1smmkZRRin5802kmbRM+bVgLGrIQADHGYlHdw8xcijQ5v1c9
         8e0vwE7uY32Aw30+jeY2mvlCfJNnwjjEWMt3Mfbxj+LURDC30TLTYSt2FyAoBKD1TZJv
         2XgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4WKyGrf0mo0OgQShBnc8Zv5TVj5kESxWU/mbfCBYVJk=;
        b=aDhHj6QTJEyyDPJ/Kp5y4A3Cv+KsfeCXpJsZIxzHZL4xDtCJfjcr//mOrJphmmkibZ
         FGeJT7SbAwDENbDe/dkr8CgqJUTmYdcUG0WBSzbuoao98R05rggE9ysdv85LvRSD6+Zf
         b0cMPwQSaHGDwJQLhxzpvaromujnWnfR+OI0jKX+ag2XLyoaG4vWigNRwwpIonIv/8Fk
         PDdA5tK1KMsvYHW5bx0EQMQwRreIXriymqvMNMk5Eo26KZilFbrfIEF0K8+woxLvbWM0
         S9lFsXNibfP2dxNaZhHq+6EbQgR2q83ikBlRylJjmyTlsgp40DP/MnYAM3N//Qff+FqF
         xNEw==
X-Gm-Message-State: AJIora8v9hgBFHAJ886pBNw8J3N3VWbLhilLjwUAvjeFBO4rBHFPKtEY
        4UGhv69dpxgvSd23q3pxvsdiYHJ2d/8OEg==
X-Google-Smtp-Source: AGRyM1sBhPwGf7QzwOBrB8kpJVgtgn+sx3ncwKLik1nkXNirzQTt6ijxYT0LrQMunS9CmTGQC7rJrw==
X-Received: by 2002:ac2:442d:0:b0:478:ed89:927f with SMTP id w13-20020ac2442d000000b00478ed89927fmr166329lfl.545.1655132539252;
        Mon, 13 Jun 2022 08:02:19 -0700 (PDT)
Received: from localhost.localdomain (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id a9-20020ac25e69000000b0047910511c23sm1021362lfr.45.2022.06.13.08.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 08:02:18 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, song@kernel.org,
        joannelkoong@gmail.com
Cc:     eddyz87@gmail.com
Subject: [PATCH bpf-next v6 0/5] bpf_loop inlining
Date:   Mon, 13 Jun 2022 18:01:36 +0300
Message-Id: <20220613150141.169619-1-eddyz87@gmail.com>
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

