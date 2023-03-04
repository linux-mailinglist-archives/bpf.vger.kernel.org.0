Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B976AA72E
	for <lists+bpf@lfdr.de>; Sat,  4 Mar 2023 02:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjCDBPQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Mar 2023 20:15:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjCDBPB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Mar 2023 20:15:01 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846211204F
        for <bpf@vger.kernel.org>; Fri,  3 Mar 2023 17:14:10 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id a32so4097468ljr.9
        for <bpf@vger.kernel.org>; Fri, 03 Mar 2023 17:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677892378;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/6gN6/lyeJiHM9dOj6hHsrPDbRC+6DyAWeFyJPpt7jQ=;
        b=XhdtBRn6mPbFk1U1/aJ/R6BBj6WKmv33vdlMEJ0cZxs2zsOpP2RQ4QRnybC7IJaV9P
         dS9gPPOF4uZAgGEIvTBPEh73kiAJ2ZcpsyKssn3uzG7qA7rlvOmLALQUEdOGRhIUnJ6s
         kw7CGRfUVdd8kGuW1/v+PgBSKvanXahxXOTP5ZkcCP52+LSx/gwJ6VnDQjZ97PiMnGqQ
         9j/ktS/cXmWk3E4IvZ2pcxC5r8fqGgPEkrSe4RuVEdPiiFpmIiJM0pUk2hQUFPA91rFV
         2EbdbI25eykdE0rQluOaH0sVWvxInbb0nQldTtKs3Da27+ErZ9+TrQn2X/c3DnE2zdWC
         CHDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677892378;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/6gN6/lyeJiHM9dOj6hHsrPDbRC+6DyAWeFyJPpt7jQ=;
        b=CUUr7E4pHsGP5niqOI+fECcy27T38mkhCb4bgUZVlJQ7+OEIl5CCxHHKEJYIAs9rUJ
         MKmWzb7l7ZNLqpQFTeML9JVVg80Y54v+QAqqtTZftHk0i6DD03Xlo4p3HRiGW0uvKYdD
         f/5sIg2AiMy0/un6JEIrSTsUwdTZhqZjQqTitT6R2xwnW4foHaagwJpv7KAHlXCrEwmY
         ZuBHAYs+kOIaxEdZ3S5fWqhBkUjVT8sCE1y2EKzBQMwxUWGSi+xolIWOFbnv3q5iOG5G
         yRpLNnlRu+RYac47zTGGS0LQEyl8I9qn4Vr17ZiF/oBKcpeX+wJ+z727wX/+b+MkE1wq
         5bXQ==
X-Gm-Message-State: AO0yUKVQkNTSOBfXyUoPxgowLlEEyG0cq2Mj2UKQp7evX/uxxGCOuKVS
        aIZ4xyAYV2u824wAiaNPuX8SxQxJI0AGww==
X-Google-Smtp-Source: AK7set+s6BR3gKCM3YtrnPWBb8dBDhBq3FSpf9PFZf37yRcsIYmmTyVeIN+dYAdyIB1/2OorVQUDtA==
X-Received: by 2002:a2e:be9f:0:b0:28e:a8aa:6f95 with SMTP id a31-20020a2ebe9f000000b0028ea8aa6f95mr1569449ljr.8.1677892378004;
        Fri, 03 Mar 2023 17:12:58 -0800 (PST)
Received: from bigfoot.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id x7-20020a05651c104700b00295b588d21dsm569609ljm.49.2023.03.03.17.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 17:12:57 -0800 (PST)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 0/3] bpf: allow ctx writes using BPF_ST_MEM instruction
Date:   Sat,  4 Mar 2023 03:12:44 +0200
Message-Id: <20230304011247.566040-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.39.1
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

Changes v1 -> v2, suggested by Alexei:
- Resolved conflict with recent commit:
  6fcd486b3a0a ("bpf: Refactor RCU enforcement in the verifier");
- Variable `ctx_access` removed in function `convert_ctx_accesses()`;
- Macro `BPF_COPY_STORE` renamed to `BPF_EMIT_STORE` and fixed to
  correctly extract original store instruction class from code.
  
Original message follows:

The function verifier.c:convert_ctx_access() applies some rewrites to BPF
instructions that read from or write to the BPF program context.
For example, the write instruction for the `struct bpf_sockopt::retval`
field:

    *(u32 *)(r1 + offsetof(struct bpf_sockopt, retval)) = r2

Is transformed to:

    *(u64 *)(r1 + offsetof(struct bpf_sockopt_kern, tmp_reg)) = r9
    r9 = *(u64 *)(r1 + offsetof(struct bpf_sockopt_kern, current_task))
    r9 = *(u64 *)(r9 + offsetof(struct task_struct, bpf_ctx))
    *(u32 *)(r9 + offsetof(struct bpf_cg_run_ctx, retval)) = r2
    r9 = *(u64 *)(r1 + offsetof(struct bpf_sockopt_kern, tmp_reg))
    
Currently, the verifier only supports such transformations for LDX
(memory-to-register read) and STX (register-to-memory write) instructions.
Error is reported for ST instructions (immediate-to-memory write).
This is fine because clang does not currently emit ST instructions.

However, new `-mcpu=v4` clang flag is planned, which would allow to emit
ST instructions (discussed in [1]).

This patch-set adjusts the verifier to support ST instructions in
`verifier.c:convert_ctx_access()`.

The patches #1 and #2 were previously shared as part of RFC [2]. The
changes compared to that RFC are:
- In patch #1, a bug in the handling of the
  `struct __sk_buff::queue_mapping` field was fixed.
- Patch #3 is added, which is a set of disassembler-based test cases for
  context access rewrites. The test cases cover all fields for which the
  handling code is modified in patch #1.

[1] Propose some new instructions for -mcpu=v4
    https://lore.kernel.org/bpf/4bfe98be-5333-1c7e-2f6d-42486c8ec039@meta.com/
[2] RFC Support for BPF_ST instruction in LLVM C compiler
    https://lore.kernel.org/bpf/20221231163122.1360813-1-eddyz87@gmail.com/
[3] v1
    https://lore.kernel.org/bpf/20230302225507.3413720-1-eddyz87@gmail.com/

Eduard Zingerman (3):
  bpf: allow ctx writes using BPF_ST_MEM instruction
  selftests/bpf: test if pointer type is tracked for BPF_ST_MEM
  selftests/bpf: Disassembler tests for verifier.c:convert_ctx_access()

 kernel/bpf/cgroup.c                           |  49 +-
 kernel/bpf/verifier.c                         | 110 +--
 net/core/filter.c                             |  79 +-
 tools/testing/selftests/bpf/Makefile          |   2 +-
 tools/testing/selftests/bpf/disasm.c          |   1 +
 tools/testing/selftests/bpf/disasm.h          |   1 +
 .../selftests/bpf/prog_tests/ctx_rewrite.c    | 917 ++++++++++++++++++
 tools/testing/selftests/bpf/verifier/ctx.c    |  11 -
 tools/testing/selftests/bpf/verifier/unpriv.c |  23 +
 9 files changed, 1069 insertions(+), 124 deletions(-)
 create mode 120000 tools/testing/selftests/bpf/disasm.c
 create mode 120000 tools/testing/selftests/bpf/disasm.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c

-- 
2.39.1

