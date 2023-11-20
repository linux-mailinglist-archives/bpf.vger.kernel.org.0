Return-Path: <bpf+bounces-15440-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 891257F2110
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 00:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 337EF2827F5
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 23:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478663AC0A;
	Mon, 20 Nov 2023 23:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hi707uTI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89173C9
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 15:00:01 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-50930f126b1so6415119e87.3
        for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 15:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700521199; x=1701125999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y+YqI0ZnJEoSYT1UK+8Sa10zjOBhT+B+isq/zGJ1Xp4=;
        b=hi707uTIi5KXJbPs0Ni+uEe3OoK/CuV5XSBDmX/CK0YLsJZYYrsTa+5iywvjcEb44w
         VN++xPAaIxXG7zU000nwWA8oMHRfEpiXF0K9DIjT87/FHkXm29sJD1MvxACAYm1yVTNv
         cokKh1aMsa74dT7miLc0d2DfeqD45rWRAaA76VmpEeIqM/o7iZw3+vE4nfic91lrPysp
         jgajBN1Yi8YSa6065IJMqPptKDSNKJEG3Otaex4w6/0bpQ+fZZ/sxUr2S/QqT6rOSZX9
         GyUO+agfsI5qyFYd0ggF7f2EFFVxkNR2ReaGLpNB1D50dNtsspRSG7gKlzbzq1fwPRz1
         AHuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700521199; x=1701125999;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y+YqI0ZnJEoSYT1UK+8Sa10zjOBhT+B+isq/zGJ1Xp4=;
        b=tJ2tu8hXa5sSXLn6F95REChnOIkLutWHbEJfcpga9lxyO39kBkVwaPgwYx4H1IniJb
         zTQQWGK1pGdTd2oxZZ07gwc5xyD9NMx1bw9qxm4EfpMHgGz8fGbINVwrTr5mzXEW/Ywp
         FOIbgqfNTIMSkvb7IK5e9ubY8Z19yyP3MnYsTIn0pMTD62MMKg09bqZMoc4DAw3Nrwud
         7MmxY/zdou/UXv4/vD1+m23C3/fw8fDRfORnxmhTGgcflZ2/wCYWGq1rc29bEcxsV9WV
         DY9Vd4Fa1luMlLMMkEPpH4XwPGR8A7BfhqZW+s6Lql0k+kYNKjmnMcizAumJgSvMBoBv
         RV8w==
X-Gm-Message-State: AOJu0Yxw6ESB+zvoNddLDLTIEfhrYgDqtcgT+EYCgrKaRyvTlm2m42Fy
	FpN8IBDLDlwGvI7yQWJyRTylVhULmfsMQg==
X-Google-Smtp-Source: AGHT+IFVHChI4SSs6oHiwr/zDdvDCIEB57YdLzFjAM4bBMDzXHW8n2JlP3ZClMaJzNY1z+kvjIcdcA==
X-Received: by 2002:a2e:b54e:0:b0:2c5:2423:e225 with SMTP id a14-20020a2eb54e000000b002c52423e225mr5546617ljn.6.1700521198472;
        Mon, 20 Nov 2023 14:59:58 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id a9-20020a170906468900b009fd6a22c2e9sm1968039ejr.138.2023.11.20.14.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 14:59:57 -0800 (PST)
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
Subject: [PATCH bpf v3 00/11] verify callbacks as if they are called unknown number of times
Date: Tue, 21 Nov 2023 00:59:34 +0200
Message-ID: <20231120225945.11741-1-eddyz87@gmail.com>
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
 kernel/bpf/verifier.c                         | 400 ++++++++++++------
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/bpf_loop_bench.c      |  13 +-
 tools/testing/selftests/bpf/progs/cb_refs.c   |   1 +
 .../selftests/bpf/progs/exceptions_fail.c     |   2 +
 .../testing/selftests/bpf/progs/strobemeta.h  |  78 ++--
 .../bpf/progs/verifier_iterating_callbacks.c  | 242 +++++++++++
 .../bpf/progs/verifier_subprog_precision.c    |  86 +++-
 .../selftests/bpf/progs/xdp_synproxy_kern.c   |  84 ++--
 10 files changed, 707 insertions(+), 217 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c

-- 
2.42.1


