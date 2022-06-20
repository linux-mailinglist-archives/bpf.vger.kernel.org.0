Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C36A552869
	for <lists+bpf@lfdr.de>; Tue, 21 Jun 2022 01:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241672AbiFTXyl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Jun 2022 19:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239638AbiFTXyk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Jun 2022 19:54:40 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C057113D12
        for <bpf@vger.kernel.org>; Mon, 20 Jun 2022 16:54:38 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id fu3so24071339ejc.7
        for <bpf@vger.kernel.org>; Mon, 20 Jun 2022 16:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mCMCWpJ7kvfb1lmZWPLDlA81tRfDKgHfwd/xKqa4BQk=;
        b=X81H511bje5F6b4sWl+DiEj0/OaA+7pksq+2T4tThfWHvPD+247bt7m+vvp3B51g5E
         Upk36L85ui4FDoTt1RHlSbILW7QUYIUJLj61NHNpiCnTab42sJkQ604HRLPdnH1J0Vua
         ZA5ID7QLEWcIZJh9pwl4jIDyJsEarDImw3XIdvjeUbSNa2ieb4X433T/upiRCEEWily2
         yts9LnV1CprzvcRnt2274sS0SYHiVhaZF7Oj1yw8wc/31rcYnUkuQyne/Xt1RnJTQt0f
         O4pFIWdqDgL3U2DVG8VjfexTftwp23CL9+xMvoBjlEzZrrEkZiGHS8VgEObAoXm//AzT
         KjQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mCMCWpJ7kvfb1lmZWPLDlA81tRfDKgHfwd/xKqa4BQk=;
        b=RQw9rW71h7eZ/JXQLqYnOo+cuns8gu2OVusMxkNtsVN/ty3ZBXTA4Sq0+Ra4nhcv5z
         YFIYKKNDn1oCIah0BKfko2fhxdY3xVyJBVDhfdl7QdSRgNPdIH7z0/vUUilFGCq0o4c3
         N1gPTxYguaV4pwvPfCw2jA9JACfqw7+8C8hh3+Tk0Vnf2HISMnzeXnNy4DF0328bF6c6
         BoIB6o++hcTNBvTFsCrCyrgiiUDkNOxhG9PnwspP21zL5AabTDWOpQUlNkncAnkmE7ZI
         TgVM35NVE2h4aEejCz3D9iCWeMo9B9fcElgiXYN5X429wyf+8L6W7bLmnswhXns/Ynsc
         kk2Q==
X-Gm-Message-State: AJIora9lGQTO4nbcu0WytLTLeOUN2gPrUWfjLIjvTbon9V0/wBsATClI
        NRD2r2tiOyrxAPpQUrY3aAHAYaZphjMGcP9E
X-Google-Smtp-Source: AGRyM1tlJAoUnY8L6G9b5Ps2AUOctDZqY1u83jTrtYZj0EUDcujYNix91vxDD0RqFI1TegQGFSU1KQ==
X-Received: by 2002:a17:906:a10e:b0:6f3:e70b:b572 with SMTP id t14-20020a170906a10e00b006f3e70bb572mr22246896ejy.546.1655769276914;
        Mon, 20 Jun 2022 16:54:36 -0700 (PDT)
Received: from localhost.localdomain (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id e21-20020a056402105500b004356d08bbbasm7078560edu.40.2022.06.20.16.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 16:54:35 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, song@kernel.org,
        joannelkoong@gmail.com
Cc:     eddyz87@gmail.com
Subject: [PATCH bpf-next v8 0/5] bpf_loop inlining
Date:   Tue, 21 Jun 2022 02:53:39 +0300
Message-Id: <20220620235344.569325-1-eddyz87@gmail.com>
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

Changes since v7:
 - Call to `mark_chain_precision` is added in `loop_flag_is_zero` to
   avoid potential issues with state pruning and precision tracking.
 - `flags non-zero` test_verifier test case is updated to have two
   execution paths reaching `bpf_loop` call, one with flags = 0,
   another with flags = 1. Potentially this test case should be able
   to show that call to `mark_chain_precision` is necessary in
   `loop_flag_is_zero` but not at the moment. Please refer to
   discussion for [PATCH bpf-next v7 3/5] for additional details.
 - `stack_depth_extra` computation is updated to guarantee that R6, R7
   and R8 offsets are always aligned on 8 byte boundary.
 - `stack locations for loop vars` test_verifier test case updated to
   show that R6, R7, R8 offsets are indeed aligned when function stack
   depth is not a multiple of 8.
 - I removed Song Liu's ACK from commit message for [PATCH bpf-next v8
   4/5] because I updated the patch. (Please let me know if I had to
   keep the ACK tag).

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
 kernel/bpf/verifier.c                         | 180 +++++++++-
 .../selftests/bpf/prog_tests/bpf_loop.c       |  62 ++++
 tools/testing/selftests/bpf/prog_tests/btf.c  |   1 -
 tools/testing/selftests/bpf/progs/bpf_loop.c  | 114 ++++++
 tools/testing/selftests/bpf/test_btf.h        |   2 +
 tools/testing/selftests/bpf/test_verifier.c   | 328 +++++++++++++++++-
 .../selftests/bpf/verifier/bpf_loop_inline.c  | 252 ++++++++++++++
 10 files changed, 936 insertions(+), 27 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/verifier/bpf_loop_inline.c

-- 
2.25.1

