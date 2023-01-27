Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9114667ED3B
	for <lists+bpf@lfdr.de>; Fri, 27 Jan 2023 19:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234892AbjA0SPx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Jan 2023 13:15:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234152AbjA0SPu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 13:15:50 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C44C87161
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 10:15:12 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id v13so5447443eda.11
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 10:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wCdr9XgpV/TtRB2gbEnJDhOoDA9hdYNcxPOVyX+Gx4I=;
        b=pIcJB56jYqzBr1+lJGOoGrVaucvY0fVtWaGVeQEPh+qZXdRXrjQorWU2Tlk8Zc1UGI
         0D8jKTrJe17EKNR6JlRnG1qDK08Qvww3A+FthpM4isNVaHURD69CPE/07Azd62wfAZ9R
         Dk5RooYO91UohuUzarLETuPV0P7VkjMYnYytpR6Dx5PYFlTVGJIaEEfIcLvaydfxMQkr
         lA+8u+GH413mWiCOJfQ1YM0MYXdKAhvFtHrxDERfghMJ8TCuY3J28t3AFraMODBJfTra
         CWuKdZdKvMh9Pkqi5zlD5exa4KT34jFNO21wfzRCCCVmNiMJhpbETWeid135tV8OOaKJ
         f4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wCdr9XgpV/TtRB2gbEnJDhOoDA9hdYNcxPOVyX+Gx4I=;
        b=zMPVymJImVg6umw7JL8a15fnRoioB5V4QyfBUUBh45BXWLzO2+fgNj0w/Ax+Zkepgi
         syzLrU1YEthqSQs9yJVY2seBMD6Bwo9EeDAY0en3WF3dbLM+nLuBMi+70EobEZyO2xP3
         f3gyITNBVQUyrbnkKxSCZcjZCA2RBO3KbM/rPJ25MBj+Sq3kVMq+9SxPMvOJO4/Yp4rm
         fUwhP0/DaabP89arnxhyISn6r7EinhTpd+X8teTYR+V2dNxLh5ISsyJ86oSB6QMf7Uc5
         GHmG2p4fTsHcoM9lGRzvAKzflHZCWUhaZJidY2bIT+fzpXiwzf+tXI2lHUirqELUEVmw
         Zisg==
X-Gm-Message-State: AFqh2kp46GMI+BwMbWze0jLZEaGXR9sAiI5s5Rx8BXRGoUYT62DgLiF7
        m0MMJyCACc4k2xNlIOAngeWJWxgV6pnuq6kCtSM=
X-Google-Smtp-Source: AMrXdXsMdjbnlaoonNvvA4UUSH4pDrU4/h+b4bwZ8Rc6Luvb+XUA6Av8ZJRlgD4uy/M6frtBakZnyw==
X-Received: by 2002:aa7:c994:0:b0:499:bf81:be6 with SMTP id c20-20020aa7c994000000b00499bf810be6mr45290903edt.37.1674843284899;
        Fri, 27 Jan 2023 10:14:44 -0800 (PST)
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a16-20020aa7d910000000b00463bc1ddc76sm2639651edr.28.2023.01.27.10.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 10:14:44 -0800 (PST)
From:   Anton Protopopov <aspsk@isovalent.com>
To:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     Anton Protopopov <aspsk@isovalent.com>
Subject: [PATCH bpf-next 0/6] New benchmark for hashmap lookups
Date:   Fri, 27 Jan 2023 18:14:51 +0000
Message-Id: <20230127181457.21389-1-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a new benchmark for hashmap lookups and fix several typos. See individual
commits for descriptions.

One thing to mention here is that in commit 3 I've patched bench so that now
command line options can be reused by different benchmarks.

The benchmark itself is added in the last commit 6. I am using this benchmark
to test map lookup productivity when using a different hash function (see
https://fosdem.org/2023/schedule/event/bpf_hashing/). The results provided by
the benchmark look reasonable and match the results of my different benchmarks
(requiring to patch kernel to get actual statistics on map lookups).

Anton Protopopov (6):
  selftest/bpf/benchs: fix a typo in bpf_hashmap_full_update
  selftest/bpf/benchs: make a function static in bpf_hashmap_full_update
  selftest/bpf/benchs: enhance argp parsing
  selftest/bpf/benchs: make quiet option common
  selftest/bpf/benchs: print less if the quiet option is set
  selftest/bpf/benchs: Add benchmark for hashmap lookups

 tools/testing/selftests/bpf/Makefile          |   5 +-
 tools/testing/selftests/bpf/bench.c           | 126 +++++++-
 tools/testing/selftests/bpf/bench.h           |  24 ++
 .../bpf/benchs/bench_bloom_filter_map.c       |   6 -
 .../benchs/bench_bpf_hashmap_full_update.c    |   4 +-
 .../bpf/benchs/bench_bpf_hashmap_lookup.c     | 277 ++++++++++++++++++
 .../selftests/bpf/benchs/bench_bpf_loop.c     |   4 -
 .../bpf/benchs/bench_local_storage.c          |   5 -
 .../bench_local_storage_rcu_tasks_trace.c     |  20 +-
 .../selftests/bpf/benchs/bench_ringbufs.c     |   8 -
 .../selftests/bpf/benchs/bench_strncmp.c      |   4 -
 .../run_bench_bpf_hashmap_full_update.sh      |   2 +-
 .../selftests/bpf/progs/bpf_hashmap_lookup.c  |  61 ++++
 13 files changed, 486 insertions(+), 60 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_bpf_hashmap_lookup.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_hashmap_lookup.c

-- 
2.34.1

