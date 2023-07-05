Return-Path: <bpf+bounces-4072-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E07F27488CC
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 18:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C45A280351
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 16:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194C8125DF;
	Wed,  5 Jul 2023 16:01:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC11125CC
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 16:01:12 +0000 (UTC)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BBC81FD5
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 09:00:41 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3110ab7110aso7744565f8f.3
        for <bpf@vger.kernel.org>; Wed, 05 Jul 2023 09:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1688572838; x=1691164838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=epU7XgsuaSJ3kpzdGFBQVoENJfvR/GugCr7egSIrf7E=;
        b=gYdbzmK/NvU1R9gNVFU2sRs0mzKfOulE00G9WQ+58k1DPGdRkAKcJmt1YngStdmaCj
         HtsEl8Kxo21tH2CPPNz/1VfR4ChyScrnpbkXxlYKwnUVuR7B7OlTZXF+n2A2UAxu3mjZ
         1pJmS5ZP3XCkyVckcN2w7eUlIhcTRoEGfkagWi54kI5UAv0WQJxY7spMpdT2KDWxGv4t
         t8XccMbusw1Lyq7vqi7So/GulLrvY7b2yrhsAddgHZIQx7jlOMjftkwUou/WTTf/ly5s
         8cpb3KEr6+GEJIQNWBDH9MdEr8ePWfi7hHeOqYNQZkeqDiJkYmmpzEOImQUf83QEeqLJ
         YTjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688572838; x=1691164838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=epU7XgsuaSJ3kpzdGFBQVoENJfvR/GugCr7egSIrf7E=;
        b=fg6yMbwOl+pPKQNZcIvnSY7FO9PRRxyWDGX3M9s0G1OSfvbVtQJWCQH1j4+JrtNZWk
         Fjbf8kiIUKbEW4O7X8R8j236mXNJDhMSqmGea9vqrJaP30elBUalizk172o2Yp2OtKeP
         NmpIlGS1nWTjK96e+YpX2q6kBFFJQHEVl5jhkhj5fkagAIHnAPRZ6obRShmllIKKfSnE
         ZtEd3C3JY1Z3yxGfKeFNkDeqi3qK4FU/QvCIvhb7F542iUN8a1jv+zt4uUXhclGq5ysM
         +i3zrOXg3agclnbhd3wbE/qbsiL5vnJFTsVX6DzFeZMRO5RdDsOVg1gCy5Lbpx2pli+k
         pbRA==
X-Gm-Message-State: ABy/qLY/gL9k+LxOQROnNCujblktKYa4erheQWIfmufZf9lTAnUxb3sN
	4HkzV3n60gN95+jxLz5ICANBMg==
X-Google-Smtp-Source: APBJJlE0s1jFz5S7n4ZJSxYsFoPLieaJruugEW2mTJCyl/Gaw6zZ1mRRINWaSXCCTngA3IG7bm0tNw==
X-Received: by 2002:a5d:674d:0:b0:314:13d8:8ae7 with SMTP id l13-20020a5d674d000000b0031413d88ae7mr14278637wrw.26.1688572838340;
        Wed, 05 Jul 2023 09:00:38 -0700 (PDT)
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id w10-20020adfec4a000000b00314172ba213sm16861950wrn.108.2023.07.05.09.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 09:00:37 -0700 (PDT)
From: Anton Protopopov <aspsk@isovalent.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org
Cc: Anton Protopopov <aspsk@isovalent.com>
Subject: [PATCH v4 bpf-next 0/6] bpf: add percpu stats for bpf_map
Date: Wed,  5 Jul 2023 16:01:33 +0000
Message-Id: <20230705160139.19967-1-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This series adds a mechanism for maps to populate per-cpu counters on
insertions/deletions. The sum of these counters can be accessed by a new kfunc
from map iterator and tracing programs.

The following patches are present in the series:

  * Patch 1 adds a generic per-cpu counter to struct bpf_map
  * Patch 2 adds a new kfunc to access the sum of per-cpu counters
  * Patch 3 utilizes this mechanism for hash-based maps
  * Patch 4 extends the preloaded map iterator to dump the sum
  * Patch 5 adds a self-test for the change
  * Patch 6 patches map_ptr selftest to check that elem_count was initialized

The reason for adding this functionality in our case (Cilium) is to get signals
about how full some heavy-used maps are and what the actual dynamic profile of
map capacity is. In the case of LRU maps this is impossible to get this
information anyhow else. The original presentation can be found here [1].

  [1] https://lpc.events/event/16/contributions/1368/

v3 -> v4:
* fix selftests:
  * added test code for batch map operations
  * added a test for BPF_MAP_TYPE_HASH_OF_MAPS (Hao)
  * added tests for BPF_MAP_TYPE_LRU* with BPF_F_NO_COMMON_LRU (Hao)
  * map_info was called multiple times unnecessarily (Hao)
  * small fixes + some memory leaks (Hao)
* fixed wrong error path for freeing a non-prealloc map (Hao)
* fixed counters for batch delete operations (Hao)

v2 -> v3:
- split commits to better represent update logic (Alexei)
- remove filter from kfunc to allow all tracing programs (Alexei)
- extend selftests (Alexei)

v1 -> v2:
- make the counters generic part of struct bpf_map (Alexei)
- don't use map_info and /proc/self/fdinfo in favor of a kfunc (Alexei)

Anton Protopopov (6):
  bpf: add percpu stats for bpf_map elements insertions/deletions
  bpf: add a new kfunc to return current bpf_map elements count
  bpf: populate the per-cpu insertions/deletions counters for hashmaps
  bpf: make preloaded map iterators to display map elements count
  selftests/bpf: test map percpu stats
  selftests/bpf: check that ->elem_count is non-zero for the hash map

 include/linux/bpf.h                           |  30 +
 kernel/bpf/hashtab.c                          |  23 +-
 kernel/bpf/map_iter.c                         |  39 +-
 kernel/bpf/preload/iterators/iterators.bpf.c  |   9 +-
 .../iterators/iterators.lskel-little-endian.h | 526 +++++++++---------
 .../bpf/map_tests/map_percpu_stats.c          | 450 +++++++++++++++
 .../selftests/bpf/progs/map_percpu_stats.c    |  24 +
 .../selftests/bpf/progs/map_ptr_kern.c        |   3 +
 8 files changed, 841 insertions(+), 263 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/map_tests/map_percpu_stats.c
 create mode 100644 tools/testing/selftests/bpf/progs/map_percpu_stats.c

-- 
2.34.1


