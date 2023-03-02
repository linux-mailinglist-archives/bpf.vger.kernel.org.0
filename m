Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D616A8C43
	for <lists+bpf@lfdr.de>; Thu,  2 Mar 2023 23:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjCBWzc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Mar 2023 17:55:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjCBWzc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Mar 2023 17:55:32 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADE02DE64
        for <bpf@vger.kernel.org>; Thu,  2 Mar 2023 14:55:30 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id g17so1319128lfv.4
        for <bpf@vger.kernel.org>; Thu, 02 Mar 2023 14:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677797729;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OOEnsBtLJDdZB5r7Clq3V3+saHw3yhefhVUXR6cNfkY=;
        b=nyOq0KdDfeFl21zHpPiU6W6vh1Ng36iWLOikcuk3MtIvc7yJfduy/FrDloW9pom84X
         OekMqzHr9FyZesb7Z0s4tHKGlxsq9Op785qstdX7E3M+s0cOFrjEsx7Z/yWnG/bO/9TU
         i5HLlJzNG6I8hZtDPBXPuGfbo57YLNRkfWF0vJ3HmUqZH+IB8aCVuJAHNWnev2FLfHfk
         2V6lzAsOmEPmin1s6VL110ZFfGhzA75wMuSkSCg1LqiDShSD8KhDQQ20cD/DQAw6bt7/
         +LQqGMAotCzupsfBz3w4WeGtv/bU8CnsVEx2QCgbSYwF7/ERAnL8Y5NCwciuPt8GAb7l
         Dh6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677797729;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OOEnsBtLJDdZB5r7Clq3V3+saHw3yhefhVUXR6cNfkY=;
        b=QQ4POkGsXQjjKjU7JHEWQUoSOp/pLrOqbsaTgtFeF8re4yFPi/p3rFJdWT3jexXYL1
         bAZcoa4PcVRqWgA5GmmUwlE0jPoY5ceoFLxYE0QPbGIBkz0VOJ+FLHhPWJ8cDPt/YwXn
         BLyZmLso5Ju9C3132RY+yDNv7lPPCff8LIVdrfc2GN41zIbtB7N8s1w8yfPrcy+euy27
         GUP5jTq7Rv1D/Wi30QN9cyO3XNEgfr9uZfSEBPKCWZHsIr2HEu16lt7sFpe5hTSAU4VU
         UyLsqVrG82h5t721bzbae01z/DwEAM/6U3XaWK+DdsUm6mZr3j0+vuKXHekwkeYqyj2Z
         vEww==
X-Gm-Message-State: AO0yUKXWtJtl3Tq8WlKqgF+mjZ6qo51O8i7gE8Pud8AvFW/a4YjApYSY
        ndaZEtqcY+NOuJqJBPlQnv3rLL4JbjgLXA==
X-Google-Smtp-Source: AK7set/XtwOlbyjC249K9dSUtU09O6rBoTYDm252xmL2TNNA84IMVjlyGlKkjSUg7aeGgGAyUK7H7A==
X-Received: by 2002:ac2:4855:0:b0:4e0:a426:6ddc with SMTP id 21-20020ac24855000000b004e0a4266ddcmr3347771lfy.0.1677797728739;
        Thu, 02 Mar 2023 14:55:28 -0800 (PST)
Received: from bigfoot.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id u27-20020a056512041b00b004db266f3978sm113840lfk.174.2023.03.02.14.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 14:55:28 -0800 (PST)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com, jose.marchesi@oracle.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 0/3] bpf: allow ctx writes using BPF_ST_MEM instruction
Date:   Fri,  3 Mar 2023 00:55:04 +0200
Message-Id: <20230302225507.3413720-1-eddyz87@gmail.com>
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

Eduard Zingerman (3):
  bpf: allow ctx writes using BPF_ST_MEM instruction
  selftests/bpf: test if pointer type is tracked for BPF_ST_MEM
  selftests/bpf: Disassembler tests for verifier.c:convert_ctx_access()

 kernel/bpf/cgroup.c                           |  49 +-
 kernel/bpf/verifier.c                         |  79 +-
 net/core/filter.c                             |  79 +-
 tools/testing/selftests/bpf/Makefile          |   2 +-
 tools/testing/selftests/bpf/disasm.c          |   1 +
 tools/testing/selftests/bpf/disasm.h          |   1 +
 .../selftests/bpf/prog_tests/ctx_rewrite.c    | 917 ++++++++++++++++++
 tools/testing/selftests/bpf/verifier/ctx.c    |  11 -
 tools/testing/selftests/bpf/verifier/unpriv.c |  23 +
 9 files changed, 1057 insertions(+), 105 deletions(-)
 create mode 120000 tools/testing/selftests/bpf/disasm.c
 create mode 120000 tools/testing/selftests/bpf/disasm.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c

-- 
2.39.1

