Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5491253CB59
	for <lists+bpf@lfdr.de>; Fri,  3 Jun 2022 16:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbiFCOLu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Jun 2022 10:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbiFCOLt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Jun 2022 10:11:49 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91ACD3A4
        for <bpf@vger.kernel.org>; Fri,  3 Jun 2022 07:11:47 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id o29-20020a05600c511d00b00397697f172dso5100096wms.0
        for <bpf@vger.kernel.org>; Fri, 03 Jun 2022 07:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wmosa5M9gozZUwu3ZI5FRLlkbBorYD5sDJWINF1Q2fA=;
        b=dLMEBddwj3W3yxzJUvsFTPFMDGRYoo+u6Py9W9cyMxiW2giVqfwAWIw3AyGu3hP7Ix
         ZEUYhvJqeMNRuZMySyWwvUKxtsXx0H9b6BxSsAncFkIv+yl9AaXXH0FwuLgcqyRpVz2S
         kiwTO2j/UJdqGO5EDrMW0OXjdDGDXHCHPna5otlg5krKvacaASee32hbRgCL9IRdZalE
         iN5r80/lCdFRoPMT7skBNSTAABA2hVA0X9GaYXciQZiTBdjUn5/lSFZKRsr2DWhGNnI6
         c+xvRTgPXT9+O0e9Piuc5G/Y7y40OyZEVJY1l3jkH/5x9/ZlavdqsoqdlBDSG+nBAZ16
         U8Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wmosa5M9gozZUwu3ZI5FRLlkbBorYD5sDJWINF1Q2fA=;
        b=a4zTL4HZtMFcoBaboOdwLNWBO1nF35/J0jG4y6SRlU+NIDANXG+mQliVzg4qM4VtKF
         1nzQCpc6Yq6GPGPw/gCRu8stsAC1RFyuTfffshhZ+N908Dz1B4xEYTsZ/r8wpZvFSb9y
         d484Pach/NaT6UPyBcRfpHHwLOVIVYlP4oIfoxG+AS+coeJh72gcnZYKCvAvZCItNOL+
         fsuPV3tx+HHfCIBr83aIvXBGfqnflEvIXaTPGXBrESuWbHbhz48zR7+14ixYy8r3rdce
         hMMvvx5/FRHaOC8AqQEpavAAv0V/3NDhj9w525xpi5DtkV9O2pf2J9438NtNfQplaBFz
         Dheg==
X-Gm-Message-State: AOAM533VadwAU07RWHPGZpdmixWXjn85j17tDDjUSyDpFd5tuE4NUcl/
        dFRX12H6E6SCFWmDIAzcQ7sr4QvAClgn8g==
X-Google-Smtp-Source: ABdhPJwv/nMHcT08H8nWiusq7UCfZLNen5/xDGKI1AZeBOWdvN3y2i2tWo1mRw7Iy+5GXQueYqAC0A==
X-Received: by 2002:a05:600c:4e88:b0:394:8835:2220 with SMTP id f8-20020a05600c4e8800b0039488352220mr8837544wmq.140.1654265505405;
        Fri, 03 Jun 2022 07:11:45 -0700 (PDT)
Received: from localhost.localdomain (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id x8-20020adff0c8000000b00210a6bd8019sm7163633wro.8.2022.06.03.07.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 07:11:44 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, song@kernel.org
Cc:     eddyz87@gmail.com
Subject: [PATCH bpf-next v3 0/5] bpf_loop inlining
Date:   Fri,  3 Jun 2022 17:10:42 +0300
Message-Id: <20220603141047.2163170-1-eddyz87@gmail.com>
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

This is the next iteration of the patch. Please find updated intro
message and change log below.

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
  applied by do_mix_fixups function.

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

 include/linux/bpf_verifier.h                  |  16 +
 kernel/bpf/bpf_iter.c                         |   9 +-
 kernel/bpf/verifier.c                         | 199 ++++++++++-
 .../selftests/bpf/prog_tests/bpf_loop.c       |  61 ++++
 tools/testing/selftests/bpf/prog_tests/btf.c  |   1 -
 tools/testing/selftests/bpf/progs/bpf_loop.c  | 114 +++++++
 tools/testing/selftests/bpf/test_btf.h        |   2 +
 tools/testing/selftests/bpf/test_verifier.c   | 316 +++++++++++++++++-
 .../selftests/bpf/verifier/bpf_loop_inline.c  | 244 ++++++++++++++
 9 files changed, 935 insertions(+), 27 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/verifier/bpf_loop_inline.c

-- 
2.25.1

