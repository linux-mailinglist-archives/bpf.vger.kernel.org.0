Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F995372CB
	for <lists+bpf@lfdr.de>; Mon, 30 May 2022 00:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbiE2Whv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 29 May 2022 18:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiE2Whu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 29 May 2022 18:37:50 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B9F52503
        for <bpf@vger.kernel.org>; Sun, 29 May 2022 15:37:49 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id br17so14245214lfb.2
        for <bpf@vger.kernel.org>; Sun, 29 May 2022 15:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BMOQPy2NgaYKowF57vIoUbf4n1YoLIMDHXNxkRHwy6E=;
        b=bNR3pR0gVpbtOzzM50qZjsNsHxqR9wn768n6ekRic6sRhLR6zkLbRNM3MZOif3NoER
         3YgWB7QEVPh2KvK3/hZaBL7YEe9pDg65Hn4ld/lIrYSO/6Gi2YB+GClZzxU6qlIdsSNT
         Y2RSL7mGBhI+T7Z6JgoN3T7mTEQsb7q/Xp/P4VYosy6kTCF3h+d8AuwzowUaoag3l29G
         615/KjXo/VAjXskQQQhEiVd3q2jsnVYWv0HsXrttgvQnZIH1Bz/hmY6+t3qurG/f05Fw
         nYc4sYcD8WfXJFynyBhU69nMAgK3PsrgkaR/RSvKtThDqYZMY682WJ51qH0y8od8GlHA
         YAIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BMOQPy2NgaYKowF57vIoUbf4n1YoLIMDHXNxkRHwy6E=;
        b=ZtNgzC2fJ8ORu3FC99La4u0EIwkTiiw3U/aYEXBZhjOuFKDSUCJl3nKTztXZ+GU6SU
         bqmLS0Pmae3PqlWPSUU/kFND/G+urdN311sN2R5zuQd2wqGNSaPSzYJHN3iRSt8gvwlW
         R0DxDxz51T7mIVLKw8lppz+KgQc99Tm63s1Z0DSckzxFfC7RI9V5enEyrYc93e+BuAzC
         79SAqfR+yEQPTBZRapKFZ4xIfwUZgmMv+cjeW6Y7XIqju+Gj4bIUEba6qEzTQKpBiPu2
         f8Ljl+J8QoDaX9+Euu3FufD7KiDFCmaQd9nBVHHxbKl3tTankGyyAwmwp6k9y/yJIf8P
         mGUQ==
X-Gm-Message-State: AOAM531WxRl+hRUGYP7Wgo67LIVZtnK4YFN9BWGqBBBlqQbKMzh0R7tl
        JT2tpgLgziLZ2Ye7o438KeMCaJcKv90=
X-Google-Smtp-Source: ABdhPJyPoD39JqTbLOthDdGjICCIjPCsWl5awNSCoMFsvWYsfELpC/W8eyBRYKX5hyEvHB6AtF7Hsg==
X-Received: by 2002:a05:6512:3e26:b0:478:5972:54b7 with SMTP id i38-20020a0565123e2600b00478597254b7mr32178468lfv.646.1653863867036;
        Sun, 29 May 2022 15:37:47 -0700 (PDT)
Received: from localhost.localdomain (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id d8-20020ac24c88000000b0047255d211a7sm1962861lfl.214.2022.05.29.15.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 May 2022 15:37:46 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Cc:     eddyz87@gmail.com
Subject: [PATCH bpf-next v2 0/3] bpf_loop inlining
Date:   Mon, 30 May 2022 01:36:43 +0300
Message-Id: <20220529223646.862464-1-eddyz87@gmail.com>
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

The change is split in three parts:

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

Additional details are available in commit messages for each patch.
Hope you will find this useful.

Note: the newly added `bpf_loop/check_stack` test case in `test_progs`
currently fails in no_alu32 mode with error "BPF program is too
large". I'm still investigating this issue.  Nevertheless, I'm still
interested in overall feedback for the patch.

Best regards,
Eduard Zingerman

Changes since v1:
 - allow to use SKIP_INSNS in instruction pattern specification in
   test_verifier tests;
 - fix for a bug in spill offset assignement for loop vars when
   bpf_loop is located in a non-main function.

Eduard Zingerman (3):
  selftests/bpf: specify expected instructions in test_verifier tests
  selftests/bpf: allow BTF specs and func infos in test_verifier tests
  bpf: Inline calls to bpf_loop when callback is known

 include/linux/bpf_verifier.h                  |  16 +
 kernel/bpf/bpf_iter.c                         |   9 +-
 kernel/bpf/verifier.c                         | 184 +++++++++-
 .../selftests/bpf/prog_tests/bpf_loop.c       |  62 ++++
 tools/testing/selftests/bpf/prog_tests/btf.c  |   1 -
 tools/testing/selftests/bpf/progs/bpf_loop.c  | 122 +++++++
 tools/testing/selftests/bpf/test_btf.h        |   2 +
 tools/testing/selftests/bpf/test_verifier.c   | 338 +++++++++++++++++-
 .../selftests/bpf/verifier/bpf_loop_inline.c  | 244 +++++++++++++
 9 files changed, 951 insertions(+), 27 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/verifier/bpf_loop_inline.c

-- 
2.25.1

