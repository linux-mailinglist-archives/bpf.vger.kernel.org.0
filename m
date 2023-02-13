Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8BE5694082
	for <lists+bpf@lfdr.de>; Mon, 13 Feb 2023 10:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjBMJPR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Feb 2023 04:15:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbjBMJPP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Feb 2023 04:15:15 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04739B461
        for <bpf@vger.kernel.org>; Mon, 13 Feb 2023 01:15:11 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id eq11so11892789edb.6
        for <bpf@vger.kernel.org>; Mon, 13 Feb 2023 01:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jNqpDvHkzkygrZR2mXbHY//uA2yxXBPgg1aL8bgTRVg=;
        b=i9x6bLSl2MySJ6bgMFlaLhpR5oc4oYmFqUhCtBTRTL1XJ1gfh8Xk6fwC8ZZiMhhBDN
         RyfBlegtjqefkF07zi8dzA2or6MnFLyp0MF6loL2ZFzFAcPGDgjPkh6zJCl9+5dKIatT
         eICo+w17elTgqTQKjo8p9S47ypZroglsfUD1brL0sVfDUJMlPYGSMexvLk9YhaPsYVp/
         RQd0LqgZ8wHnDYaqGX7Z93x/pLNSBBbjT50ym2QQ0IAzWY6KsjRCto1Qe22Jhv8Bfm3R
         slSNMXTTFlre7qN41gyOQkb2+UNy0TbslEeNI1x1vcO2dZq8tjmHrm8S2GOdvfwm0zu6
         FZnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jNqpDvHkzkygrZR2mXbHY//uA2yxXBPgg1aL8bgTRVg=;
        b=gvogQZk7h9CtZ8/gk2iHhFj552Gu5OWRTBCVc3KaeuQcU37wOxST95l6+bfBQqdS9H
         twv4/4dINIpoJ4PZipn3rewnuyeoQvaQN/f6UuatEsJfe0dvjMZjerb4zTjERVuNEdQJ
         r8GGQZEeYZ0n5oLFeP/wkt/qb97V23LKZNw44G8sNc4onP+i8DXxeKWiPv8shC1VuIoD
         YwuZt/iCvkwtQkxRHKiy8pftuvlA7BRQoCRv4zLou131VYf+kaPBXroqBPrXBX+P08pK
         umOv51SaTt4VLx2d6A7dflzr0WJTXvFX8UuE4APcsBQ8aY4mTJ3RHTgjUsjYfeuzOvTI
         2Odw==
X-Gm-Message-State: AO0yUKXkAVSzC0sjuZ/JxhdttU/aaiH0hDvhir8b06HbQKAdjin+z/ZS
        jBzj99Q9gqKkPTodEBNnmzETyxuIfsqlgrqW9Bk=
X-Google-Smtp-Source: AK7set91MhUoJoJInCNkcRFhRuMqoD4gzUSA1W2PZa8mhJv1gDE8L1n+DE+KCu0WGhxjNZhy2J4/cw==
X-Received: by 2002:a50:d492:0:b0:4a2:4a89:2331 with SMTP id s18-20020a50d492000000b004a24a892331mr23424338edi.29.1676279710092;
        Mon, 13 Feb 2023 01:15:10 -0800 (PST)
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id f8-20020a50d548000000b004ab33d52d03sm5336587edj.22.2023.02.13.01.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 01:15:09 -0800 (PST)
From:   Anton Protopopov <aspsk@isovalent.com>
To:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     Anton Protopopov <aspsk@isovalent.com>
Subject: [PATCH bpf-next v2 0/7] New benchmark for hashmap lookups
Date:   Mon, 13 Feb 2023 09:15:12 +0000
Message-Id: <20230213091519.1202813-1-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a new benchmark for hashmap lookups and fix several typos.

In commit 3 I've patched the bench utility so that now command line options
can be reused by different benchmarks.

The benchmark itself is added in the last commit 7. I was using this benchmark
to test map lookup productivity when using a different hash function [1]. When
run with --quiet, the results can be easily plotted [2].  The results provided
by the benchmark look reasonable and match the results of my different
benchmarks (requiring to patch kernel to get actual statistics on map lookups).

Links:
  [1] https://fosdem.org/2023/schedule/event/bpf_hashing/
  [2] https://github.com/aspsk/bpf-bench/tree/master/hashmap-bench

Changes,
v1->v2:
- percpu_times_index[] is of wrong size (Martin)
- use base 0 for strtol (Andrii)
- just use -q without argument (Andrii)
- use less hacks when parsing arguments (Andrii)

Anton Protopopov (7):
  selftest/bpf/benchs: fix a typo in bpf_hashmap_full_update
  selftest/bpf/benchs: make a function static in bpf_hashmap_full_update
  selftest/bpf/benchs: enhance argp parsing
  selftest/bpf/benchs: remove an unused header
  selftest/bpf/benchs: make quiet option common
  selftest/bpf/benchs: print less if the quiet option is set
  selftest/bpf/benchs: Add benchmark for hashmap lookups

 tools/testing/selftests/bpf/Makefile          |   5 +-
 tools/testing/selftests/bpf/bench.c           |  59 +++-
 tools/testing/selftests/bpf/bench.h           |   2 +
 .../bpf/benchs/bench_bloom_filter_map.c       |   5 +
 .../benchs/bench_bpf_hashmap_full_update.c    |   5 +-
 .../bpf/benchs/bench_bpf_hashmap_lookup.c     | 283 ++++++++++++++++++
 .../selftests/bpf/benchs/bench_bpf_loop.c     |   1 +
 .../bpf/benchs/bench_local_storage.c          |   3 +
 .../bench_local_storage_rcu_tasks_trace.c     |  16 +-
 .../selftests/bpf/benchs/bench_ringbufs.c     |   4 +
 .../selftests/bpf/benchs/bench_strncmp.c      |   2 +
 .../run_bench_bpf_hashmap_full_update.sh      |   2 +-
 ...run_bench_local_storage_rcu_tasks_trace.sh |   2 +-
 .../selftests/bpf/progs/bpf_hashmap_lookup.c  |  63 ++++
 14 files changed, 420 insertions(+), 32 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_bpf_hashmap_lookup.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_hashmap_lookup.c

-- 
2.34.1

