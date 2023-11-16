Return-Path: <bpf+bounces-15136-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7807ED930
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 03:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67D2D1F232A6
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 02:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F333FFF;
	Thu, 16 Nov 2023 02:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WezPm2Av"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53DD5A3
	for <bpf@vger.kernel.org>; Wed, 15 Nov 2023 18:18:32 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9f2a53704aaso39403766b.3
        for <bpf@vger.kernel.org>; Wed, 15 Nov 2023 18:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700101110; x=1700705910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ezVViSOAq77e0ddqGy3axH1cFjo8LgEm7t6RACJUqM4=;
        b=WezPm2Avj5wdVdK+BKjODmUKb6WjHraixU/aM/ajLt57iEnyxL1qHTAiEuHvQQISCe
         gg6ewJZBehlBRCq6mlzOQnOH/V0mxXJ6eAEOWH6soQr+R0GE5amN7XdwI2vSNWk9ny2v
         YRyxg+jIiwTQPc3kJ43QYTn6urQhelIdJyJrSFdrjxgQUP5iC8ahnjOnCjyHGCREuEC1
         CaJv87wzwArH0nRnjoQVphjrvuJXrlk3tRivqGWzyhM75DKEa4kxeizWiUeTqbjCvmnU
         5+96mwTQM90vK9DhDvYERjn8tfQnibWTNbr9EEab7p5JRJWI1In4Uh0S+qVghbQyl2jL
         JjBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700101110; x=1700705910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ezVViSOAq77e0ddqGy3axH1cFjo8LgEm7t6RACJUqM4=;
        b=t5XehRbH15RVjf5VShSxVDHjiCGWclCiEQhwXqhXGWukzxssCiHYTwZ3+9oGyiA2qC
         gG+YuQ3z1nUZfngwCwfTO2mkz5k0AutqMU1X5Q+wlMVXZ67HwaqG1Tew3EaTN1xbhg8Q
         XL23ZHkQOBiNTaLFZEuezbNHozGosOE4/SJarm9gdeQeGNHOGbBLn4rxP0Sn7X+wprE5
         tC2H8cUuolnryoq7HT95ZHp0PWXy/cyIopxplhvnclVCOe/AdUJ6MNfkpjCwU5kopv9q
         3lbdJMFZSDk6mb3TJzHkNIHx2uh9Vy31+5OMjD3bGPbAUc8oIdFFw7VXg6cVe088AAkJ
         Rp3w==
X-Gm-Message-State: AOJu0YyqMrw0PSkmHw7qh7DSmkzqAISQyowsUrhQ4O3GQe3XmedQ2dEN
	ioow6RxiT0Gg1QnfSTLcEWM3q5bDgt1t/A==
X-Google-Smtp-Source: AGHT+IF6aT19tTWewoJK67/KHWrmS2N9Xf0BRt0e+H54knGMNac4p9JRdGTsyPaF8P2Sn3FBDOODGQ==
X-Received: by 2002:a17:906:f29a:b0:9b6:aac1:6fa5 with SMTP id gu26-20020a170906f29a00b009b6aac16fa5mr11529810ejb.55.1700101110146;
        Wed, 15 Nov 2023 18:18:30 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id ay1-20020a170906d28100b009dd606ce80fsm7774064ejb.31.2023.11.15.18.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 18:18:29 -0800 (PST)
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
Subject: [PATCH bpf 00/12] verify callbacks as if they are called unknown number of times
Date: Thu, 16 Nov 2023 04:17:51 +0200
Message-ID: <20231116021803.9982-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.42.0
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
- patch #11 extends test_load based tests infra with __not_msg() macro;
- patch #12 adds test cases for #10 (and uses __not_msg() from #11).

Veristat results comparing this series to master+patches #1,2,3 using selftests
show the following difference:

File                       Program        States (A)  States (B)  States (DIFF)
-------------------------  -------------  ----------  ----------  -------------
bpf_loop_bench.bpf.o       benchmark               1           2  +1 (+100.00%)
pyperf600_bpf_loop.bpf.o   on_event              136         219  +83 (+61.03%)
strobemeta_bpf_loop.bpf.o  on_event              113         152  +39 (+34.51%)
xdp_synproxy_kern.bpf.o    syncookie_tc          341         298  -43 (-12.61%)
xdp_synproxy_kern.bpf.o    syncookie_xdp         344         301  -43 (-12.50%)

Veristat results comparing this series to master using Tetragon BPF
files [2] also show some differences.
States diff varies from +2% to +15% on 23 programs out of 186,
no new failures.

[0] https://lore.kernel.org/bpf/CA+vRuzPChFNXmouzGG+wsy=6eMcfr1mFG0F3g7rbg-sedGKW3w@mail.gmail.com/
[1] https://lore.kernel.org/bpf/20231024000917.12153-1-eddyz87@gmail.com/
[2] git@github.com:cilium/tetragon.git

Eduard Zingerman (12):
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
  selftests/bpf: add __not_msg annotation for test_loader based tests
  selftests/bpf: check if max number of bpf_loop iterations is tracked

 include/linux/bpf_verifier.h                  |  14 +
 kernel/bpf/verifier.c                         | 381 ++++++++++++------
 .../selftests/bpf/prog_tests/cb_refs.c        |   4 +-
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/bpf_loop_bench.c      |  13 +-
 tools/testing/selftests/bpf/progs/bpf_misc.h  |   9 +
 tools/testing/selftests/bpf/progs/cb_refs.c   |   1 +
 .../selftests/bpf/progs/exceptions_fail.c     |   2 +
 .../testing/selftests/bpf/progs/strobemeta.h  |  78 ++--
 .../bpf/progs/verifier_iterating_callbacks.c  | 234 +++++++++++
 .../bpf/progs/verifier_subprog_precision.c    |  22 +-
 .../selftests/bpf/progs/xdp_synproxy_kern.c   |  84 ++--
 tools/testing/selftests/bpf/test_loader.c     |  82 ++--
 13 files changed, 691 insertions(+), 235 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c

-- 
2.42.0


