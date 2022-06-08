Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA5AC543CD1
	for <lists+bpf@lfdr.de>; Wed,  8 Jun 2022 21:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235412AbiFHT1k (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Jun 2022 15:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233460AbiFHT1k (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Jun 2022 15:27:40 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183F215C8BF
        for <bpf@vger.kernel.org>; Wed,  8 Jun 2022 12:27:39 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id fu3so41876802ejc.7
        for <bpf@vger.kernel.org>; Wed, 08 Jun 2022 12:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JEPvf8mFBSvMJuGlNjwgV8uLkKEQIN3Rku1ABAF7IcU=;
        b=XAA6YIWp3bazblOPiZCcuwHHxO2JbY7pBpbqqhSBYAvIMZoXAMzvXDie0WndaZIgoh
         OxWZEekr2h6VCn8leDhnhNBUNUsWxMkquGLpTxZpyGX/imF2Sp+NS9UdiKyw96cuhHUA
         oKDgKUFodHB51/MnIvgY0uJh+DfvcIUWu3jS0iqcvRBYfRyAarUrFp8cnI6kOdhhcgOH
         iviMgrYketCInSOJQ2vO+Rg99cN8A+O4ewC7R45noPoKoQCoRKNrTB5uImymE6VR6r4r
         mVuo+zKdFcwlcbFvHpVknHJA7radhkK7bZSDi44JLOuwqwKr2yKc4uvXOR3WBMtw0t/1
         XLUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JEPvf8mFBSvMJuGlNjwgV8uLkKEQIN3Rku1ABAF7IcU=;
        b=U7wYJYQELF8VVkJeCor4fqrqrmNUxk+Xf/VHCIb07GtQ1UCrsj1l2n/wNZhtLco7Xc
         08r5dkItvmQr9VBjq5/AvwXYzKRES1FphpIYiHVffQMJqxZot8+YoDaP2G7BSgP5+zPF
         wBabSDql9vkL5AFpdwMrgw53arx00toGzn1vz4a9Y5HpYPHzA8CPKOhotVYzTLaiD/BZ
         2AGaBQyzwxOobz962YfLOvtrgdLl3MjGWzkvcbnWnu75KjFsvnQfwX3uvG3kkQ5NEzk/
         BoJtM4B5uy+7ACSufQC1au3LbwQVeFKm0YjOOKhOiynkuwJSXkQkr0BlRMKdQT8m8+GU
         1msw==
X-Gm-Message-State: AOAM530V4BLBRmCNynQSG03Bo77kleHX0us1/xxoNS5bleXt9c5Y7UcR
        RjciR4gex4O7etIFopw3E9/XXemlctY9MA==
X-Google-Smtp-Source: ABdhPJztiHx9NyfQAWyd+QD7y3SZvDlB5p/i9Zl4fEmtHA3Tco5HlfqBMcwFU8X8b3PMPA41ff3/jA==
X-Received: by 2002:a17:906:9c82:b0:6e1:1d6c:914c with SMTP id fj2-20020a1709069c8200b006e11d6c914cmr32670523ejc.769.1654716457220;
        Wed, 08 Jun 2022 12:27:37 -0700 (PDT)
Received: from localhost.localdomain (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id o9-20020a170906600900b006fec8e5b8a9sm9596730ejj.152.2022.06.08.12.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 12:27:36 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, song@kernel.org,
        joannelkoong@gmail.com
Cc:     eddyz87@gmail.com
Subject: [PATCH bpf-next v4 0/5] bpf_loop inlining
Date:   Wed,  8 Jun 2022 22:26:25 +0300
Message-Id: <20220608192630.3710333-1-eddyz87@gmail.com>
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
 kernel/bpf/verifier.c                         | 168 ++++++++-
 .../selftests/bpf/prog_tests/bpf_loop.c       |  62 ++++
 tools/testing/selftests/bpf/prog_tests/btf.c  |   1 -
 tools/testing/selftests/bpf/progs/bpf_loop.c  | 114 ++++++
 tools/testing/selftests/bpf/test_btf.h        |   2 +
 tools/testing/selftests/bpf/test_verifier.c   | 328 +++++++++++++++++-
 .../selftests/bpf/verifier/bpf_loop_inline.c  | 244 +++++++++++++
 10 files changed, 916 insertions(+), 27 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/verifier/bpf_loop_inline.c

-- 
2.25.1

