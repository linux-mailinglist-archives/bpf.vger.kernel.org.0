Return-Path: <bpf+bounces-70260-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CE8BB59C1
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 01:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C28119E844A
	for <lists+bpf@lfdr.de>; Thu,  2 Oct 2025 23:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9717228B7DA;
	Thu,  2 Oct 2025 23:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hsuUeCSZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CC128850E
	for <bpf@vger.kernel.org>; Thu,  2 Oct 2025 23:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759447493; cv=none; b=bjwaMNQe4O2jAb4ac9DO1DhklVaQfAtOgaiZA7XeSuSefXI65nT1SyW/xQxTW7vQUN1ESckI3b8Sx7vIyQE5AAhKTtc2m7I0kBqSlr8Efz7zKAG4afQPe6Pyga+AiWbA3+Vn26SL1z/JQ8PLLzEDFT4TS6pCpV/db2/co+kkVkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759447493; c=relaxed/simple;
	bh=kAFajq2w0NV2b6Vym16p2XjMatkmKm7VTqZX/umH5iA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lFoLlwK8ZvbZSJWIxD0PbM3evFquVXNPBOMaCODlUefPrRjYwrxKSo1/MksYj/3Gkrsfk/IAvvf3mRuwRROt67JdADtkosssknSwSqsNjJb2mYfQqO7dCalHDUiI6fQ6TdCy1CKGu4oKUn/VXYcLgL9AUFTxnuJtsQgCDp6vIT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hsuUeCSZ; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7811a02316bso1227580b3a.3
        for <bpf@vger.kernel.org>; Thu, 02 Oct 2025 16:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759447491; x=1760052291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5rTCZ2QULVi3uiI7GqChmfRdR4ph4yjk9K+npTqoJNw=;
        b=hsuUeCSZMvAuOvDALODvHpDV2rnM6d/Zx/yAaJJQ2BylO4LTrwii5f3XpbCNHkx7lN
         oDQ7SYUPbUyQvxa5+dVlxyFwWuAP3iUuQyD7Ezbk+CcbQVBLLoLZ3RmbZQAPjU9w0tLx
         RneONqb46wxjO0l9uv+bG/5oUAd26eoIEwQ+o56Y/bgnAONaneocgs+Hh40Rotk9Q9on
         SyUOY1szfthXVQwsq7Q1nWdvBD+3o/ZZqbAmGuDqsJte+FD7aUvnlyt5rXGx0/M7eHHS
         hNIrxYoFR82ETf3dZxDo20Gbjnat5YBTKLA1F2cyneWq4OdGlwuvBhU+LZRL4Key+F2o
         X5Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759447491; x=1760052291;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5rTCZ2QULVi3uiI7GqChmfRdR4ph4yjk9K+npTqoJNw=;
        b=YUBAIsxjkbhq5FHiZAqdgp3+8fIMQOpf/ww30sfoi9tdZsBAyLcT6mJm5r/L6iOaOb
         shTolu2Twn4ZladYBWIWMKsM1vp2sGko2jNIfp17YmEEHRqMu35Szdjbzzz1MTkTFSj9
         7tOvz4sIkks4C0spGnKzoy89esXJuABI8Uszx55VkexQvuiLw2j7P1qmj5zU2oHOCal7
         UYFZsWcKHctxshxOtgXR111Zs15qt7KUoOWg/PKfAeRgd36Aj+kR94L/H/G457GieUsv
         0UGb50WjEsMnuTY2S0tHSLOJQR1rCOmrCGvNBNOV4q3OvRYYULoqrXc35uRpet3L82tk
         hhXg==
X-Gm-Message-State: AOJu0YwwrysP7ubIHlFBuEoanhN92+XhsX/wdG5MeYiJFgR4DhL++4Vz
	k/KHH9kwI1YL/sLqdWAgcf+nLE45aTxrDP0QUpP/0PtdcU7YjuonJEBTF58+PA==
X-Gm-Gg: ASbGncvh6QYDGZEnAXcF2IkCfaIT+ZzBpjGOaKI3GPvrTLLs/qxxbM0QQ/PjJCc9ewZ
	K6TcbmG+lOKBrUtf8+XQnaX+8F/jCLKPSqrb9CcDu4vAUpabA1PVVvrxonGzbmCSb82u8xaTXJY
	P9IqCFRHl8GrpfW3tDmHslA7FQtr5UIsDstAAaPHxPSwOCI5GUxIeIsHK44Ucetr3qarFXKsKzs
	C5gJkDDrVhwztYOieuEjCzkur9K6yZhZJG0yc/xsPws5CttiMzUh+rdn7Pqolq4VEHoDLl0WOlo
	YEJdmNS6ZJXC5u+4Jmz3Y78tJMCUaIRec2gasDg7ISIoL0xLls2nqborrXckyM0dsvTcu5tWDpj
	XqFlLrS3MyOoKpg/VMYCnxbexFWfjy+ZHiCowBckZWp8zqPKHMBK6RAagQ/sf1IVRPPAzjqEqzq
	kBfYvJMLFH9qY=
X-Google-Smtp-Source: AGHT+IG4fA8XvNMbgoDrZY2PQgukTYexbYKtO5NB7VLBWjD2Whol8EIOUfAS6ZxGGhtX5I3zc02x7w==
X-Received: by 2002:a17:90b:4ac4:b0:32b:dfdb:b27f with SMTP id 98e67ed59e1d1-339c2797420mr1179040a91.17.1759447490890;
        Thu, 02 Oct 2025 16:24:50 -0700 (PDT)
Received: from localhost.localdomain ([2001:558:600a:7:f9d8:fc98:ee10:581e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339c4a49b1fsm162513a91.24.2025.10.02.16.24.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 02 Oct 2025 16:24:50 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: torvalds@linux-foundation.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org
Subject: [GIT PULL] BPF fixes for 6.18-rc1
Date: Thu,  2 Oct 2025 16:24:48 -0700
Message-Id: <20251002232448.57255-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit d3479214c05dbd07bc56f8823e7bd8719fcd39a9:

  Merge tag 'backlight-next-6.18' of git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight (2025-10-01 12:46:26 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

for you to fetch changes up to 63d2247e2e37d9c589a0a26aa4e684f736a45e29:

  libbpf: Fix missing #pragma in libbpf_utils.c (2025-10-02 14:33:57 -0700)

----------------------------------------------------------------
- Fix selftests/bpf (typo, conflicts) and unbreak BPF CI (Jiri Olsa)

- Remove linux/unaligned.h dependency for libbpf_sha256 (Andrii Nakryiko)
  and add a test (Eric Biggers)

- Reject negative offsets for ALU operations in the verifier (Yazhou Tang)
  and add a test (Eduard Zingerman)

- Skip scalar adjustment for BPF_NEG operation if destination register
  is a pointer (Brahmajit Das) and add a test (KaFai Wan)

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
----------------------------------------------------------------
Alexei Starovoitov (2):
      Merge branch 'bpf-fix-verifier-crash-on-bpf_neg-with-pointer-register'
      Merge branch 'libbpf-fix-libbpf_sha256-for-github-compatibility'

Andrii Nakryiko (5):
      libbpf: make libbpf_errno.c into more generic libbpf_utils.c
      libbpf: remove unused libbpf_strerror_r and STRERR_BUFSIZE
      libbpf: move libbpf_errstr() into libbpf_utils.c
      libbpf: move libbpf_sha256() implementation into libbpf_utils.c
      libbpf: remove linux/unaligned.h dependency for libbpf_sha256()

Brahmajit Das (1):
      bpf: Skip scalar adjustment for BPF_NEG if dst is a pointer

Eduard Zingerman (1):
      selftests/bpf: Add tests for rejection of ALU ops with negative offsets

Eric Biggers (1):
      selftests/bpf: Add test for libbpf_sha256()

Jiri Olsa (3):
      selftests/bpf: Fix open-coded gettid syscall in uprobe syscall tests
      selftests/bpf: Fix typo in subtest_basic_usdt after merge conflict
      selftests/bpf: Fix realloc size in bpf_get_addrs

KaFai Wan (1):
      selftests/bpf: Add test for BPF_NEG alu on CONST_PTR_TO_MAP

Tony Ambardar (1):
      libbpf: Fix missing #pragma in libbpf_utils.c

Yazhou Tang (1):
      bpf: Reject negative offsets for ALU ops

 kernel/bpf/verifier.c                              |   7 +-
 tools/lib/bpf/Build                                |   2 +-
 tools/lib/bpf/btf.c                                |   1 -
 tools/lib/bpf/btf_dump.c                           |   1 -
 tools/lib/bpf/elf.c                                |   1 -
 tools/lib/bpf/features.c                           |   1 -
 tools/lib/bpf/gen_loader.c                         |   3 +-
 tools/lib/bpf/libbpf.c                             | 101 ---------
 tools/lib/bpf/libbpf_errno.c                       |  75 ------
 tools/lib/bpf/libbpf_internal.h                    |  15 ++
 tools/lib/bpf/libbpf_utils.c                       | 252 +++++++++++++++++++++
 tools/lib/bpf/linker.c                             |   1 -
 tools/lib/bpf/relo_core.c                          |   1 -
 tools/lib/bpf/ringbuf.c                            |   1 -
 tools/lib/bpf/str_error.c                          | 104 ---------
 tools/lib/bpf/str_error.h                          |  19 --
 tools/lib/bpf/usdt.c                               |   1 -
 tools/testing/selftests/bpf/prog_tests/sha256.c    |  52 +++++
 .../selftests/bpf/prog_tests/uprobe_syscall.c      |   4 +-
 tools/testing/selftests/bpf/prog_tests/usdt.c      |   2 +-
 .../bpf/progs/verifier_value_illegal_alu.c         |  47 ++++
 tools/testing/selftests/bpf/trace_helpers.c        |   2 +-
 22 files changed, 376 insertions(+), 317 deletions(-)
 delete mode 100644 tools/lib/bpf/libbpf_errno.c
 create mode 100644 tools/lib/bpf/libbpf_utils.c
 delete mode 100644 tools/lib/bpf/str_error.c
 delete mode 100644 tools/lib/bpf/str_error.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sha256.c

