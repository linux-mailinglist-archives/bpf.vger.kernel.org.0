Return-Path: <bpf+bounces-18475-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4913D81AD94
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 04:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED4841F23CE6
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 03:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485D85239;
	Thu, 21 Dec 2023 03:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3Gpq08q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9936F5247
	for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 03:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5cd82917ecfso279024a12.0
        for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 19:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703129938; x=1703734738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8cD5LCv7nI5vS50d2r3ZWe88e1Sl9N63c+YLqHV9c8Q=;
        b=I3Gpq08qal3Ar1n4CTaKvCfmur1lHSTQ958P+FJiWmwjQTTMqblXqoXz7vFs3Bjq51
         4CKe5Gvo+oTHiJSgYvty9/zcR1vux2PvVk+cwn5zcoUMmzf9yO4jwAgzMLTOmdWfkYaM
         +aFG2Ptv6YUburUcxqxkkVeeGzuwDqnbDxAHDGVpWRDtbw0/WseAPB3rK+qlUS8L6mBt
         TtbcPX6LZejokeInfoFnAIQxaA5tqDljtdoKe23zOCgogBo0qnM+33VTnio5y9FG+ApN
         L0dYixjMaWVOY4OEQUxsuCE3Ql4Ef1Wtxm052yZZQEVubEJv/jN9VdoEH7vxmSinot9J
         14CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703129938; x=1703734738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8cD5LCv7nI5vS50d2r3ZWe88e1Sl9N63c+YLqHV9c8Q=;
        b=Dkbhw1VLPpIzlCzjQzIaR0dt1c2XNuiZLeLMypYYyeY1w18PF2t1obvfixkwfr9FS+
         Cwot+DrJ0Txs/6n1W7oxGVhmSD1qq5bzG9arBikEssXYiHH3dktrIFfXu0r+rZeeMpe/
         q8awt5VW6x/s0MwiOk2woI0CGmRfVxcQGDOG3Mh4UCoAn9j9Ztv2DFvKumse70cm7x9l
         kMHZQ/QOXyq54YvWj3jEdFfmVT0u8QpEw/1q07cwvOJd1wUDD4kl5PRf92OJooota1I9
         0Mum0zXsmBcLmt2MGA2h3pSvfxQk/ajHnOT7CJXpkl978db61R7aduWxDtOzzXJIOXo2
         BpFw==
X-Gm-Message-State: AOJu0YxyWI+eazxcrxbLsXF47eN8IQEdBMErtn2mFLf5oRIYXQxSWc0U
	PTQ7jhj+qcKGUkGXNbFIEhg=
X-Google-Smtp-Source: AGHT+IEXgNzMlFqrsO2fabCtGZ5upw+rFN6W+Zrmsu2r0GXsyipSbdfZ5+UHsSmhyI2w7VNeWEEpxQ==
X-Received: by 2002:a05:6a20:6225:b0:18a:db41:bd0a with SMTP id p37-20020a056a20622500b0018adb41bd0amr637334pze.39.1703129937837;
        Wed, 20 Dec 2023 19:38:57 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::4:ec38])
        by smtp.gmail.com with ESMTPSA id c11-20020a631c0b000000b005b6c1972c99sm507252pgc.7.2023.12.20.19.38.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 20 Dec 2023 19:38:57 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: daniel@iogearbox.net
Cc: andrii@kernel.org,
	martin.lau@kernel.org,
	dxu@dxuuu.xyz,
	memxor@gmail.com,
	john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2 bpf-next 0/5] bpf: volatile compare
Date: Wed, 20 Dec 2023 19:38:49 -0800
Message-Id: <20231221033854.38397-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

v1->v2:
Fixed issues pointed out by Daniel, added more tests, attempted to convert profiler.c,
but barrier_var() wins vs bpf_cmp(). To be investigated.
Patches 1-4 are good to go, but 5 needs more work.

Alexei Starovoitov (5):
  selftests/bpf: Attempt to build BPF programs with -Wsign-compare
  bpf: Introduce "volatile compare" macro
  selftests/bpf: Convert exceptions_assert.c to bpf_cmp
  selftests/bpf: Remove bpf_assert_eq-like macros.
  selftests/bpf: Attempt to convert profiler.c to bpf_cmp.

 tools/testing/selftests/bpf/Makefile          |   1 +
 .../testing/selftests/bpf/bpf_experimental.h  | 194 ++++--------------
 .../bpf/progs/bpf_iter_bpf_percpu_hash_map.c  |   2 +-
 .../selftests/bpf/progs/bpf_iter_task_vmas.c  |   2 +-
 .../selftests/bpf/progs/bpf_iter_tasks.c      |   2 +-
 .../selftests/bpf/progs/bpf_iter_test_kern4.c |   2 +-
 .../progs/cgroup_getset_retval_setsockopt.c   |   2 +-
 .../selftests/bpf/progs/cgrp_ls_sleepable.c   |   2 +-
 .../selftests/bpf/progs/cpumask_success.c     |   2 +-
 .../testing/selftests/bpf/progs/exceptions.c  |  20 +-
 .../selftests/bpf/progs/exceptions_assert.c   |  80 ++++----
 tools/testing/selftests/bpf/progs/iters.c     |   4 +-
 .../selftests/bpf/progs/iters_task_vma.c      |   3 +-
 .../selftests/bpf/progs/linked_funcs1.c       |   2 +-
 .../selftests/bpf/progs/linked_funcs2.c       |   2 +-
 .../testing/selftests/bpf/progs/linked_list.c |   2 +-
 .../selftests/bpf/progs/local_storage.c       |   2 +-
 tools/testing/selftests/bpf/progs/lsm.c       |   2 +-
 .../selftests/bpf/progs/normal_map_btf.c      |   2 +-
 .../selftests/bpf/progs/profiler.inc.h        |  71 ++-----
 tools/testing/selftests/bpf/progs/profiler2.c |   1 +
 tools/testing/selftests/bpf/progs/profiler3.c |   1 +
 .../selftests/bpf/progs/sockopt_inherit.c     |   2 +-
 .../selftests/bpf/progs/sockopt_multi.c       |   2 +-
 .../selftests/bpf/progs/sockopt_qos_to_cc.c   |   2 +-
 .../testing/selftests/bpf/progs/test_bpf_ma.c |   2 +-
 .../bpf/progs/test_core_reloc_kernel.c        |   2 +-
 .../bpf/progs/test_core_reloc_module.c        |   8 +-
 .../selftests/bpf/progs/test_fsverity.c       |   2 +-
 .../bpf/progs/test_skc_to_unix_sock.c         |   2 +-
 .../bpf/progs/test_xdp_do_redirect.c          |   2 +-
 31 files changed, 146 insertions(+), 279 deletions(-)

-- 
2.34.1


