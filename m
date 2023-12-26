Return-Path: <bpf+bounces-18679-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F1581E926
	for <lists+bpf@lfdr.de>; Tue, 26 Dec 2023 20:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05D201F21B8E
	for <lists+bpf@lfdr.de>; Tue, 26 Dec 2023 19:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4B1184F;
	Tue, 26 Dec 2023 19:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G418fi3g"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5CF17F8
	for <bpf@vger.kernel.org>; Tue, 26 Dec 2023 19:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6d9bd63ec7fso295941b3a.2
        for <bpf@vger.kernel.org>; Tue, 26 Dec 2023 11:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703617913; x=1704222713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7SJiXmYd44gQs7eQ4xBaaxnCCTgtuotcIBr48lBMwS8=;
        b=G418fi3gZYbGb0PCVwCN+USgy8BQVF7fjACqTm4Hs1yxLrC9/6iWxfdFS1H0ZJDmRu
         0nhiq1SPmHdFtzHotUdx6Oy6I18BHCke037Fk4el04mb5ByZBqUeTEGWb8kC2ExKFXkt
         AA/UPDNw52KMdiW+9GAXXWGiCMQqLX0g90p82X19Zr6zyU767iUMyeMiDtbcBCwr4eVp
         S8cqNtPJ91/U3JGOEPrfiEfs0HR9ZupgwP/I9f92C6roOfL4L+swSGGT3jm+illvWzwG
         QW+7i1fk2fdNmnXFGuKP3/15vLs5razu2MQK7uNAhbmYCq7nsZcPg5T3LSghh11HU/4/
         yvTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703617913; x=1704222713;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7SJiXmYd44gQs7eQ4xBaaxnCCTgtuotcIBr48lBMwS8=;
        b=KRopabXOdpyhNsG9D67dYEB5RRuOkq/1PIwIHHNQjoHYrRXJCxZTn6K2m+0HrPTwGS
         GzsG4IWpuR9ulXiF48aB6uP2lSnOxFt6FHDrJh6l8AOZjm8ouo3UcaBC9RwRZHeBUztO
         dbRlQk6DyG4MgFC4cmdospKOeBe2A1GVAG2jXMu9TSUNxRBbQcyf6sgwW2JjpIxud8JZ
         7+YVeCzqE7HdmXOArIZFhpUwpQ2yvaRilW5crZT8fSn+oywAnam3sjiXuS+LPpkRyWgR
         QgT3SEmr+Jzb+22nVze24J7MDl7oAU3lk9+1p9KaQz6/dD/CvWKDE11bO4xwUFp6oUVG
         EDeg==
X-Gm-Message-State: AOJu0Yz2RRY5JjFIcv9OOi/rU7d0cQ1DiDsRvY7BLEGoANO0IWblJy4O
	seDIqxbvVgIHv1YHnqE7D2rna3as76Y=
X-Google-Smtp-Source: AGHT+IG1AdtfGyybuUBMl1wd/yC/+yJR1eAfrPWpFzMDttuNp1b1ce0ohMBtKRai0Bv01uInN6L20g==
X-Received: by 2002:aa7:8ecf:0:b0:6d9:a811:98bf with SMTP id b15-20020aa78ecf000000b006d9a81198bfmr1604113pfr.31.1703617912517;
        Tue, 26 Dec 2023 11:11:52 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:500::4:bc9b])
        by smtp.gmail.com with ESMTPSA id t13-20020a62ea0d000000b006d638fd230bsm10340882pfh.93.2023.12.26.11.11.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 26 Dec 2023 11:11:51 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	dxu@dxuuu.xyz,
	memxor@gmail.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kernel-team@fb.com
Subject: [PATCH v3 bpf-next 0/6] bpf: volatile compare
Date: Tue, 26 Dec 2023 11:11:42 -0800
Message-Id: <20231226191148.48536-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

v2->v3:
Debugged profiler.c regression. It was caused by basic block layout.
Introduce bpf_cmp_likely() and bpf_cmp_unlikely() macros.
Debugged redundant <<=32, >>=32 with u32 variables. Added cast workaround.

v1->v2:
Fixed issues pointed out by Daniel, added more tests, attempted to convert profiler.c,
but barrier_var() wins vs bpf_cmp(). To be investigated.
Patches 1-4 are good to go, but 5 needs more work.

Alexei Starovoitov (6):
  selftests/bpf: Attempt to build BPF programs with -Wsign-compare
  bpf: Introduce "volatile compare" macros
  selftests/bpf: Convert exceptions_assert.c to bpf_cmp
  selftests/bpf: Remove bpf_assert_eq-like macros.
  bpf: Add bpf_nop_mov() asm macro.
  selftests/bpf: Convert profiler.c to bpf_cmp.

 tools/testing/selftests/bpf/Makefile          |   1 +
 .../testing/selftests/bpf/bpf_experimental.h  | 224 ++++++------------
 .../bpf/progs/bpf_iter_bpf_percpu_hash_map.c  |   2 +-
 .../selftests/bpf/progs/bpf_iter_task_vmas.c  |   2 +-
 .../selftests/bpf/progs/bpf_iter_tasks.c      |   2 +-
 .../selftests/bpf/progs/bpf_iter_test_kern4.c |   2 +-
 .../progs/cgroup_getset_retval_setsockopt.c   |   2 +-
 .../selftests/bpf/progs/cgrp_ls_sleepable.c   |   2 +-
 .../selftests/bpf/progs/cpumask_success.c     |   2 +-
 .../testing/selftests/bpf/progs/exceptions.c  |  20 +-
 .../selftests/bpf/progs/exceptions_assert.c   |  80 +++----
 tools/testing/selftests/bpf/progs/iters.c     |   4 +-
 .../selftests/bpf/progs/iters_task_vma.c      |   3 +-
 .../selftests/bpf/progs/linked_funcs1.c       |   2 +-
 .../selftests/bpf/progs/linked_funcs2.c       |   2 +-
 .../testing/selftests/bpf/progs/linked_list.c |   2 +-
 .../selftests/bpf/progs/local_storage.c       |   2 +-
 tools/testing/selftests/bpf/progs/lsm.c       |   2 +-
 .../selftests/bpf/progs/normal_map_btf.c      |   2 +-
 .../selftests/bpf/progs/profiler.inc.h        |  68 ++----
 .../selftests/bpf/progs/sockopt_inherit.c     |   2 +-
 .../selftests/bpf/progs/sockopt_multi.c       |   2 +-
 .../selftests/bpf/progs/sockopt_qos_to_cc.c   |   2 +-
 .../testing/selftests/bpf/progs/test_bpf_ma.c |   2 +-
 .../bpf/progs/test_core_reloc_kernel.c        |   2 +-
 .../bpf/progs/test_core_reloc_module.c        |   8 +-
 .../selftests/bpf/progs/test_fsverity.c       |   2 +-
 .../bpf/progs/test_skc_to_unix_sock.c         |   2 +-
 .../bpf/progs/test_xdp_do_redirect.c          |   2 +-
 29 files changed, 173 insertions(+), 277 deletions(-)

-- 
2.34.1


