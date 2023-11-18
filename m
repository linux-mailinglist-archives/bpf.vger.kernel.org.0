Return-Path: <bpf+bounces-15281-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5727EFCF3
	for <lists+bpf@lfdr.de>; Sat, 18 Nov 2023 02:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5B8EB20B27
	for <lists+bpf@lfdr.de>; Sat, 18 Nov 2023 01:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04746110C;
	Sat, 18 Nov 2023 01:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ig6H6B9G"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C58AD79
	for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 17:34:08 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-5094cb3a036so3820223e87.2
        for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 17:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700271246; x=1700876046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pihGi/vPQR0VfAmtQvVQ2ZNidR8XzZq5eJAmI4p3c+U=;
        b=ig6H6B9GfcyR/yQoM4+tpgNiPttOX7NpWNJeyC9frXL7z0s64z2zbcWTUPnb98y2Wu
         CrpYQNlCCIdGPBYTCnRWT3PMzmfzZQpCA2BSWsw7n+hDQ+n7V9YJE7j/ud4zi1lXgoCz
         7Rz8qNNtgLaLhH+xvqh/eMRkFoJSeWSn/dqWcN2zYsx68yVL93kG0dPpvUW/dfoRWwLN
         d+J3TT99gWcX98Cc7Ra44Lx5EMcdD40Mx4CQTIbD/8RznZQcL2E9q1JaYz+Wpfgh7po4
         lG6mQR2GxxRpDw/ycADSoZpno+HnIj+LyPjl6IirwVReO8CacghXnmYHocvUwAQJJQxb
         e7Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700271246; x=1700876046;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pihGi/vPQR0VfAmtQvVQ2ZNidR8XzZq5eJAmI4p3c+U=;
        b=Kae45PlzqLYhMy9gpBv+6GmIqCU6SPSBpIxKmLGUWB7dz4hH08u7+v7EzPuBg9aB7j
         maptTM94Zn5lEs8y7lRWtwjf1ABWBmv3TZfxNdWeRiY+6Fa0u1577s1odssfJQQcIbAk
         6XBWo6IJYD2PcW7xIb3nF97IsjMHUKpcbdnVw8Epd2QOUL0KEhqKQtS/jnCfeTF+mVWx
         BTzV6RX3Sv+JYAzhrSuV+xmsBH2unqYiqo6kocaH9YWwvXGX8y2E7jJm5tUk4SuuGFNu
         X4vkQ8WabofFZFg8H738mEn8a51BqART4OocBQzfowE1NgTLgw0IKS/Fdh/eRiZiBDQG
         qvcw==
X-Gm-Message-State: AOJu0YzTDPVnHFc/FT5PTeizFF4sQI5c2k8/uP+8YBqlTpuMN83sJnZK
	8yCchGHNZ/11YkNiC0hhJEj6x0oyUtqQnA==
X-Google-Smtp-Source: AGHT+IGWLygOfY6Ey79gowomZiUhEeobP34ive+BHjycKMQl2oPNhTnqRHSUnnktybEC/61P74FAGQ==
X-Received: by 2002:a05:6512:1056:b0:50a:a006:77bc with SMTP id c22-20020a056512105600b0050aa00677bcmr1019431lfb.58.1700271245737;
        Fri, 17 Nov 2023 17:34:05 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id v27-20020a170906489b00b009d2eb40ff9dsm1359284ejq.33.2023.11.17.17.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 17:34:05 -0800 (PST)
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
Subject: [PATCH bpf v2 00/11] verify callbacks as if they are called unknown number of times
Date: Sat, 18 Nov 2023 03:33:44 +0200
Message-ID: <20231118013355.7943-1-eddyz87@gmail.com>
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

Changelog V1 [3] -> V2, changes suggested by Andrii:
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

 include/linux/bpf_verifier.h                  |  14 +
 kernel/bpf/verifier.c                         | 395 ++++++++++++------
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/bpf_loop_bench.c      |  13 +-
 tools/testing/selftests/bpf/progs/cb_refs.c   |   1 +
 .../selftests/bpf/progs/exceptions_fail.c     |   2 +
 .../testing/selftests/bpf/progs/strobemeta.h  |  78 ++--
 .../bpf/progs/verifier_iterating_callbacks.c  | 250 +++++++++++
 .../bpf/progs/verifier_subprog_precision.c    |  80 +++-
 .../selftests/bpf/progs/xdp_synproxy_kern.c   |  84 ++--
 10 files changed, 702 insertions(+), 217 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c

-- 
2.42.1


