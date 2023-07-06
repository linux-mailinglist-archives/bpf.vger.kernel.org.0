Return-Path: <bpf+bounces-4245-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA55749DEC
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 15:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55786281011
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 13:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565619445;
	Thu,  6 Jul 2023 13:38:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0828F77
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 13:38:44 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261B71BC2
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 06:38:28 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fbc5d5746cso7743635e9.2
        for <bpf@vger.kernel.org>; Thu, 06 Jul 2023 06:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1688650706; x=1691242706;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+p3fh1bulI7uRrakHuVLLqr4fMw88M+mn2ZkU+RTSPE=;
        b=GiqD2dFyEcnD/1cyCzlF64Mlxq5bvZI4L2eBPBrTQgFmV3OkGuYgGhCE2o0qqs1xyx
         WxtGnJlXAuvGip/yT9KcTMB9U0oT78cZwZuGf+EQkd074swIiE4SR7ZZzscBfbrJzyA/
         RewX7ss/qFso6UDAqdqOu0T3ZeY2h1ycr+gRp2jJ3dF0qKw5II0CPt/kjK1phVz6Yt0K
         Pilu0HunlZdwFbNOkvh3Mwm89n8KzrYz0pwtFNUMQtGNE3hNIgTIlM+RO5YgnQnIxInl
         ntTs5UqQ+pHX8GzGBq5MW+ZgVaLgwSGErcnFQ++q5y/t8Ult+Qdy+15OGXHoDfMlKa+V
         Cmzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688650706; x=1691242706;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+p3fh1bulI7uRrakHuVLLqr4fMw88M+mn2ZkU+RTSPE=;
        b=Q4BDT+vDzJ/g3Ld/9daJ2AL1PkEGpiH6WyUWXwdaA7uRBxSQJE3McRYplt6iyT2P/w
         aI+ubr/SGgVecA1q3jS8jJl25+y69eVU64Yms1x2RAaObdyUPdbU+gZiUQNpI5Mxzene
         pAtYE5NuudAS51bdrrAO0uOlWXiVtWHHjOjQ9OWNEmh8dudu+SVPqauG8l4lnucyoUSa
         FJ+m47nkgZaECSfw4z5eFtNXMm8kUvq7jFHloqCqcUYnFAIGg+DBUUHCXeIdFdetHst4
         Fy8yXEeKYgiJnCUv8i1i0/hdo8mQ5gJqB3UNjs6fqFg1R1WkB8+97HXEvl3Y1xl/xkcv
         08BA==
X-Gm-Message-State: ABy/qLYvMldCoKeg3vqCwW5DRsZNu8Rwh3CWEcK13eVEa6GJo3+n6d3s
	swtTeheRgZgfSaPXZR1lwncJjQ==
X-Google-Smtp-Source: APBJJlF2aW3SU/hJIo48sM/LDF1UJ2OXFqNYt6hkwNAKUwXT8B/pM2HY62fZ8c4myWyy8hOZGZeczw==
X-Received: by 2002:a1c:4b17:0:b0:3fb:b008:2003 with SMTP id y23-20020a1c4b17000000b003fbb0082003mr1525174wma.38.1688650706596;
        Thu, 06 Jul 2023 06:38:26 -0700 (PDT)
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id v10-20020a05600c470a00b003f9b3829269sm6754524wmo.2.2023.07.06.06.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 06:38:26 -0700 (PDT)
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
	Hou Tao <houtao1@huawei.com>,
	bpf@vger.kernel.org
Cc: Anton Protopopov <aspsk@isovalent.com>
Subject: [PATCH v5 bpf-next 0/5] bpf: add percpu stats for bpf_map
Date: Thu,  6 Jul 2023 13:39:27 +0000
Message-Id: <20230706133932.45883-1-aspsk@isovalent.com>
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
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
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

The reason for adding this functionality in our case (Cilium) is to get signals
about how full some heavy-used maps are and what the actual dynamic profile of
map capacity is. In the case of LRU maps this is impossible to get this
information anyhow else. The original presentation can be found here [1].

  [1] https://lpc.events/event/16/contributions/1368/

v4 -> v5:
* don't pass useless empty opts when creating a link, pass NULL (Hou)
* add a debug message (Hou)
* make code more readable (Alexei)
* remove the selftest which only checked that elem_count != NULL

v3 -> v4:
* fix selftests:
  * added test code for batch map operations
  * added a test for BPF_MAP_TYPE_HASH_OF_MAPS (Hou)
  * added tests for BPF_MAP_TYPE_LRU* with BPF_F_NO_COMMON_LRU (Hou)
  * map_info was called multiple times unnecessarily (Hou)
  * small fixes + some memory leaks (Hou)
* fixed wrong error path for freeing a non-prealloc map (Hou)
* fixed counters for batch delete operations (Hou)

v2 -> v3:
- split commits to better represent update logic (Alexei)
- remove filter from kfunc to allow all tracing programs (Alexei)
- extend selftests (Alexei)

v1 -> v2:
- make the counters generic part of struct bpf_map (Alexei)
- don't use map_info and /proc/self/fdinfo in favor of a kfunc (Alexei)

Anton Protopopov (5):
  bpf: add percpu stats for bpf_map elements insertions/deletions
  bpf: add a new kfunc to return current bpf_map elements count
  bpf: populate the per-cpu insertions/deletions counters for hashmaps
  bpf: make preloaded map iterators to display map elements count
  selftests/bpf: test map percpu stats

 include/linux/bpf.h                           |  30 +
 kernel/bpf/hashtab.c                          |  22 +-
 kernel/bpf/map_iter.c                         |  39 +-
 kernel/bpf/preload/iterators/iterators.bpf.c  |   9 +-
 .../iterators/iterators.lskel-little-endian.h | 526 +++++++++---------
 .../bpf/map_tests/map_percpu_stats.c          | 447 +++++++++++++++
 .../selftests/bpf/progs/map_percpu_stats.c    |  24 +
 7 files changed, 834 insertions(+), 263 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/map_tests/map_percpu_stats.c
 create mode 100644 tools/testing/selftests/bpf/progs/map_percpu_stats.c

-- 
2.34.1


