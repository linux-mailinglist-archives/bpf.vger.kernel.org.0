Return-Path: <bpf+bounces-15482-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E736C7F2396
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 03:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14B091C218F2
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 02:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF5C134C6;
	Tue, 21 Nov 2023 02:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+bDKI3t"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA3E85
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 18:07:21 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9ae2cc4d17eso683394566b.1
        for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 18:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700532439; x=1701137239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rlz7TJu/1e4RvwVwvQLQxxnBPl5H5tAuxuV6+rqQp6s=;
        b=g+bDKI3tSFfhuOXIlImJ9Plq5gADY/usT97yFu6XagWixbYvNbeYaBy/zeC03zRi+N
         oIQJrPzxUPZy5LcCV+QZv2A4FO7g844xPDzgA0xdwj+6B4ATXlmF7NzqL0Pnls9mVK0H
         gXOmpWSr8zN+ixDA2YZaodJ6pz+Jy5+/dFpBzCtcPF7uxHZTWFvwCsBO4ULvXO9DQ2N4
         zMbRU1ZOsptnwk2fSGGKXuiG3NuPnkMABgY+AbghicQpfxgortUJhU3hGSvELePpby3L
         ygotYnIIU3xFzgRusKRQTrXWACzVmJhRxxXkc4jDoE2rzu6fnrkUCrfwsKMpxuQPaP+G
         xyEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700532439; x=1701137239;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rlz7TJu/1e4RvwVwvQLQxxnBPl5H5tAuxuV6+rqQp6s=;
        b=X+qZoVklJFemoedJrvwbTSyaVxAI+N3MjSM0M93KbunPOp9gISxp6twlBasWNnvk4d
         xGxsqEhpaawn9TlcXTM1aBKnQWZxIcKNlwD5a7AYdYYulAVhBVmTc8tXPg/9cQ2+dguO
         //eLTMYSLCR2h9D7W4ScToMbQw0VGlCXCgFIWfa6B9pZPpk/tMkUsdsKOPy1aeOavqIA
         BHSj+2qcnj9fWULZTqpsh2PIZhVxJEteEu1VPr9tsJSEkB5sxrcPv+HVtQq29gbDWgtU
         Stl0a/uFFFYV9+3KBZ7L0RHATkkwwJeMkTbgZfRNZXB8wVEo0QuzWLhxxeQu1YYbWvZ2
         M10Q==
X-Gm-Message-State: AOJu0Yy+SfVC2JN5lVolqWsG+kAcqcynBHR4NlDEx1mAoIwMMIsKvFPr
	WiF4ZYZtcJWiu2mM1Ru8Q5qlO1rbTmy23Q==
X-Google-Smtp-Source: AGHT+IHvt0kHiLjXbgM/hEVM14UU/OFW4TrG9IOYJ9vb1eEW3NSBv+3p2FedyBei48Mbe/VMQHJ4gw==
X-Received: by 2002:a17:906:c34f:b0:9e6:b696:4bd0 with SMTP id ci15-20020a170906c34f00b009e6b6964bd0mr5779968ejb.74.1700532438988;
        Mon, 20 Nov 2023 18:07:18 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id ha7-20020a170906a88700b009fc990d9edbsm2426668ejb.192.2023.11.20.18.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 18:07:17 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	memxor@gmail.com,
	awerner32@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf v4 00/11] verify callbacks as if they are called unknown number of times
Date: Tue, 21 Nov 2023 04:06:50 +0200
Message-ID: <20231121020701.26440-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series updates verifier logic for callback functions handling.
Current master simulates callback body execution exactly once,
which leads to verifier not detecting unsafe programs like below:

    static int unsafe_on_zero_iter_cb(__u32 idx, struct num_context *ctx)
    {
        ctx->i = 0;
        return 0;
    }
    
    SEC("?raw_tp")
    int unsafe_on_zero_iter(void *unused)
    {
        struct num_context loop_ctx = { .i = 32 };
        __u8 choice_arr[2] = { 0, 1 };
    
        bpf_loop(100, unsafe_on_zero_iter_cb, &loop_ctx, 0);
        return choice_arr[loop_ctx.i];
    }
    
This was reported previously in [0].
The basic idea of the fix is to schedule callback entry state for
verification in env->head until some identical, previously visited
state in current DFS state traversal is found. Same logic as with open
coded iterators, and builds on top recent fixes [1] for those.

The series is structured as follows:
- patches #1,2,3 update strobemeta, xdp_synproxy selftests and
  bpf_loop_bench benchmark to allow convergence of the bpf_loop
  callback states;
- patches #4,5 just shuffle the code a bit;
- patch #6 is the main part of the series;
- patch #7 adds test cases for #6;
- patch #8 extend patch #6 with same speculative scalar widening
  logic, as used for open coded iterators;
- patch #9 adds test cases for #8;
- patch #10 extends patch #6 to track maximal number of callback
  executions specifically for bpf_loop();
- patch #11 adds test cases for #10.

Veristat results comparing this series to master+patches #1,2,3 using selftests
show the following difference:

File                       Program        States (A)  States (B)  States (DIFF)
-------------------------  -------------  ----------  ----------  -------------
bpf_loop_bench.bpf.o       benchmark               1           2  +1 (+100.00%)
pyperf600_bpf_loop.bpf.o   on_event              322         407  +85 (+26.40%)
strobemeta_bpf_loop.bpf.o  on_event              113         151  +38 (+33.63%)
xdp_synproxy_kern.bpf.o    syncookie_tc          341         291  -50 (-14.66%)
xdp_synproxy_kern.bpf.o    syncookie_xdp         344         301  -43 (-12.50%)

Veristat results comparing this series to master using Tetragon BPF
files [2] also show some differences.
States diff varies from +2% to +15% on 23 programs out of 186,
no new failures.

Changelog:
- V3 [5] -> V4, changes suggested by Andrii:
  - validate mark_chain_precision() result in patch #10;
  - renaming s/cumulative_callback_depth/callback_unroll_depth/.
- V2 [4] -> V3:
  - fixes in expected log messages for test cases:
    - callback_result_precise;
    - parent_callee_saved_reg_precise_with_callback;
    - parent_stack_slot_precise_with_callback;
  - renamings (suggested by Alexei):
    - s/callback_iter_depth/cumulative_callback_depth/
    - s/is_callback_iter_next/calls_callback/
    - s/mark_callback_iter_next/mark_calls_callback/
  - prepare_func_exit() updated to exit with -EFAULT when
    callee->in_callback_fn is true but calls_callback() is not true
    for callsite;
  - test case 'bpf_loop_iter_limit_nested' rewritten to use return
    value check instead of verifier log message checks
    (suggested by Alexei).
- V1 [3] -> V2, changes suggested by Andrii:
  - small changes for error handling code in __check_func_call();
  - callback body processing log is now matched in relevant
    verifier_subprog_precision.c tests;
  - R1 passed to bpf_loop() is now always marked as precise;
  - log level 2 message for bpf_loop() iteration termination instead of
    iteration depth messages;
  - __no_msg macro removed;
  - bpf_loop_iter_limit_nested updated to avoid using __no_msg;
  - commit message for patch #3 updated according to Alexei's request.

[0] https://lore.kernel.org/bpf/CA+vRuzPChFNXmouzGG+wsy=6eMcfr1mFG0F3g7rbg-sedGKW3w@mail.gmail.com/
[1] https://lore.kernel.org/bpf/20231024000917.12153-1-eddyz87@gmail.com/
[2] git@github.com:cilium/tetragon.git
[3] https://lore.kernel.org/bpf/20231116021803.9982-1-eddyz87@gmail.com/T/#t
[4] https://lore.kernel.org/bpf/20231118013355.7943-1-eddyz87@gmail.com/T/#t
[5] https://lore.kernel.org/bpf/20231120225945.11741-1-eddyz87@gmail.com/T/#t

Eduard Zingerman (11):
  selftests/bpf: track tcp payload offset as scalar in xdp_synproxy
  selftests/bpf: track string payload offset as scalar in strobemeta
  selftests/bpf: fix bpf_loop_bench for new callback verification scheme
  bpf: extract __check_reg_arg() utility function
  bpf: extract setup_func_entry() utility function
  bpf: verify callbacks as if they are called unknown number of times
  selftests/bpf: tests for iterating callbacks
  bpf: widening for callback iterators
  selftests/bpf: test widening for iterating callbacks
  bpf: keep track of max number of bpf_loop callback iterations
  selftests/bpf: check if max number of bpf_loop iterations is tracked

 include/linux/bpf_verifier.h                  |  16 +
 kernel/bpf/verifier.c                         | 402 ++++++++++++------
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/bpf_loop_bench.c      |  13 +-
 tools/testing/selftests/bpf/progs/cb_refs.c   |   1 +
 .../selftests/bpf/progs/exceptions_fail.c     |   2 +
 .../testing/selftests/bpf/progs/strobemeta.h  |  78 ++--
 .../bpf/progs/verifier_iterating_callbacks.c  | 242 +++++++++++
 .../bpf/progs/verifier_subprog_precision.c    |  86 +++-
 .../selftests/bpf/progs/xdp_synproxy_kern.c   |  84 ++--
 10 files changed, 709 insertions(+), 217 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c

-- 
2.42.1


