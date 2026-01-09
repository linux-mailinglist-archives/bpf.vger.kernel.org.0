Return-Path: <bpf+bounces-78314-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 80381D0A594
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 14:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DE6C314E8D0
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 13:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A804235B149;
	Fri,  9 Jan 2026 13:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cIeOLeMd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158D835B139
	for <bpf@vger.kernel.org>; Fri,  9 Jan 2026 13:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767963612; cv=none; b=kWZTTOqWe4TNGxrVdFLDy8lJa21wxbAhCYEpZarxntb1xhvS9JiEws6SD3ou5IEycqT7R0Z39+jIygDN/sHY2jS8Mk/Y6GSh8SG6uTG3MHdrgEizMD64/7E1eoJkxPH5WZs4WNIQ2H5xz3HsCYPFa9BoHInUoFPM+btNtNoJza8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767963612; c=relaxed/simple;
	bh=ONYPdO0oI4IQBNojYDHFrlpYRDHKceOUA21unSYU4sc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Vnd5b22a1w/87TzH7JTVSo7o820805+UuZfl2CmSHsBlRU56ei90xyFwSKKWcAL2lZHPa52K4F4XqA32dZ/k3brGIjYumDdDdEce5EXa202OB/df+iAy6s8f3hog5oGM8gcmDlWOwHdmmF04H9zd5Czgf6wO3drVVPzRbQ+faVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cIeOLeMd; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a2ea96930cso30511895ad.2
        for <bpf@vger.kernel.org>; Fri, 09 Jan 2026 05:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767963609; x=1768568409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DqTEFv3iEfrbQjWUf/LvglJZxV3WM/6ZgOIEMLmAOkc=;
        b=cIeOLeMdBMHhjyWBt3swhzL4cFwrHHFAf/mJK+8FJMd/pYsgylrb75Md0iKGmtjGT7
         bRAmZauRKAszYYjmJmlqPICxN5THrcGGJ6JdGwMVmAW32AEMGmFtbTw2mcZ6a8JhKyoA
         GGrdxRmi1uFAbfcotjlt2wjRnHDUP2BgDc17zNnwixRKS/dePi0duY4zOGz1MPlIqEU6
         dUhtXWo975MMlvqPlVVmLmMOVsTIFXMEGp6kOWSvz8L7i5+ktc6H8z4LhQn4rue+8pHG
         mUjshl0olSM71bD+okegb83CqWc/M4RQ400SAgDIlv029BQWrO+xpKhQMfKEf27kzMCM
         QvGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767963609; x=1768568409;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DqTEFv3iEfrbQjWUf/LvglJZxV3WM/6ZgOIEMLmAOkc=;
        b=VwVeILEdmG4lWU2P1HlYArPUoqRx/l/BVKvsK2gf0AtUjQGjuh4xdP/D7ED1lO19CO
         uTLoYN4nHwfZAannVoHZTDmmc5uI5EteLFrDzs+lA0y8Nk4wcoFxnAlgG3j/DvSmEqeB
         XqVHrIab6fgSzXeK0N+SPTF+RsoJwWOGGI3H2+/skJfrm/s9y2AKJOVLTZQEeOh8JWWz
         mYAu4QCi7EfMF3OcDSWd9Htps7Agt5rMlIHqiMdzpBQET+0//SC3Ky8F7qmCxBHP/ItG
         FOH+z5I1DNJ2r93wP11AItYSVxsYEfvqWTITvcEZpXivWFEM402b0ei88beZcnBTeA9w
         Be1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUl7M2AnYnT2ok6txDBV/iyjWOQqx2HPAbyhaZ8qWk2Ttlmf4CSBQ/8dRgdjK7VHLzI6Y4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa+OcA068xqo+sW9nzkXlrVd7JSlTgiiircrAR5EzOVRocrDr0
	yD20Et1z5nVjHUja0dYSO3phi66QcbpViBvpDNb+nDiqidqcn7KMWIBE
X-Gm-Gg: AY/fxX6ljpVvCDdXMV6C8Ht3QGIDgGoE7PMTL4dYjBz6RKBpIBdzlPaqESvuwLwwVEF
	QtVt5hYjqv/kfDLZEDw+szEfu4EvAn+sdlbgjxlz7qmQnQmUX9QLG90S0hrtq+iVGxREfFBNZfO
	WZxGLRdorBtSWtytmtPrjVbheY5qJo8GRe8+7UkFgYPn27leatOG++o6spObqiYt5h9dfMX/wTg
	gi2JcijL0PZ23Wgw+MS6SETFLCUKSCt8O8ZEhC+n+DFLIVkzkubESfa+SXQhO9h3ctNOdPgcyf1
	PxPqqIbKIkYFLotstSKGx+cw4UsxUmag5sVboXxOaHsNM/yt4YEd98CMWKe8MHR9Ek3Hxq6Lyat
	ESlhVL/+QTwZmBFGSHeOPw1gGA+We6oJbZWV9yRlZVw4VGjS9XcvRL6Agj4u7U7+YpZAq2bRj9a
	BR3bYUY+xVye3StVbQK17N6U/E63A=
X-Google-Smtp-Source: AGHT+IGvVgzurJmJBd4MSK31YuP+2+7S5NrO2pJ8y77RFx440Mv8avf69aS9nv5oE0Lheg8IDfRRPg==
X-Received: by 2002:a17:903:240d:b0:2a0:f469:1f5f with SMTP id d9443c01a7336-2a3ee47d198mr93051645ad.13.1767963609308;
        Fri, 09 Jan 2026 05:00:09 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3c3a328sm104927325ad.4.2026.01.09.05.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 05:00:08 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: ast@kernel.org,
	andrii.nakryiko@gmail.com,
	eddyz87@gmail.com
Cc: zhangxiaoqin@xiaomi.com,
	ihor.solodrai@linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Donglin Peng <pengdonglin@xiaomi.com>
Subject: [PATCH bpf-next v12 00/11] Improve the performance of BTF type lookups with binary search
Date: Fri,  9 Jan 2026 20:59:52 +0800
Message-Id: <20260109130003.3313716-1-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Donglin Peng <pengdonglin@xiaomi.com>

The series addresses the performance limitations of linear search in large
BTFs by:
1. Adding BTF permutation support
2. Using resolve_btfids to sort BTF during the build phase
3. Checking BTF sorting
4. Using binary search when looking up types

Patch #1 introduces an interface for btf__permute in libbpf to relay out BTF.
Patch #2 adds test cases to validate the functionality of btf__permute in base
and split BTF scenarios.
Patch #3 introduces a new phase in the resolve_btfids tool to sort BTF by name
in ascending order.
Patches #4-#7 implement the sorting check and binary search.
Patches #8-#10 optimize type lookup performance of some functions by skipping
anonymous types or invoking btf_find_by_name_kind.
Patch #11 refactors the code by calling str_is_empty.

Here is a simple performance test result [1] for lookups to find 87,584 named
types in vmlinux BTF:

./vmtest.sh -- ./test_progs -t btf_permute/perf -v

Results:
| Condition          | Lookup Time | Improvement  |
|--------------------|-------------|--------------|
| Unsorted (Linear)  |  36,534 ms  | Baseline     |
| Sorted (Binary)    |      15 ms  | 2437x faster |

The binary search implementation reduces lookup time from 36.5 seconds to 15
milliseconds, achieving a **2437x** speedup for large-scale type queries.

Changelog:
v12:
- Set the start_id to 1 instead of btf->start_id in the btf__find_by_name (AI)

v11:
- Link: https://lore.kernel.org/bpf/20260108031645.1350069-1-dolinux.peng@gmail.com/
- PATCH #1: Modify implementation of btf__permute: id_map[0] must be 0 for base BTF (Andrii)
- PATCH #3: Refactor the code (Andrii)
- PATCH #4~8:
  - Revert to using the binary search in v7 to simplify the code (Andrii)
  - Refactor the code of btf_check_sorted (Andrii, Eduard)
  - Rename sorted_start_id to named_start_id
  - Rename btf_sorted_start_id to btf_named_start_id, and add comments (Andrii, Eduard)

v10:
- Link: https://lore.kernel.org/all/20251218113051.455293-1-dolinux.peng@gmail.com/
- Improve btf__permute() documentation (Eduard)
- Fall back to linear search when locating anonymous types (Eduard)
- Remove redundant NULL name check in libbpf's linear search path (Eduard)
- Simplify btf_check_sorted() implementation (Eduard)
- Treat kernel modules as unsorted by default
- Introduce btf_is_sorted and btf_sorted_start_id for clarity (Eduard)
- Fix optimizations in btf_find_decl_tag_value() and btf_prepare_func_args()
  to support split BTF
- Remove linear search branch in determine_ptr_size()
- Rebase onto Ihor's v4 patch series [4]

v9:
- Link: https://lore.kernel.org/bpf/20251208062353.1702672-1-dolinux.peng@gmail.com/
- Optimize the performance of the function determine_ptr_size by invoking
  btf__find_by_name_kind
- Optimize the performance of btf_find_decl_tag_value/btf_prepare_func_args/
  bpf_core_add_cands by skipping anonymous types
- Rebase the patch series onto Ihor's v3 patch series [3]

v8
- Link: https://lore.kernel.org/bpf/20251126085025.784288-1-dolinux.peng@gmail.com/
- Remove the type dropping feature of btf__permute (Andrii)
- Refactor the code of btf__permute (Andrii, Eduard)
- Make the self-test code cleaner (Eduard)
- Reconstruct the BTF sorting patch based on Ihor's patch series [2]
- Simplify the sorting logic and place anonymous types before named types
  (Andrii, Eduard)
- Optimize type lookup performance of two kernel functions
- Refactoring the binary search and type lookup logic achieves a 4.2%
  performance gain, reducing the average lookup time (via the perf test
  code in [1] for 60,995 named types in vmlinux BTF) from 10,217 us (v7) to
  9,783 us (v8).

v7:
- Link: https://lore.kernel.org/all/20251119031531.1817099-1-dolinux.peng@gmail.com/
- btf__permute API refinement: Adjusted id_map and id_map_cnt parameter
  usage so that for base BTF, id_map[0] now contains the new id of original
  type id 1 (instead of VOID type id 0), improving logical consistency
- Selftest updates: Modified test cases to align with the API usage changes
- Refactor the code of resolve_btfids

v6:
- Link: https://lore.kernel.org/all/20251117132623.3807094-1-dolinux.peng@gmail.com/
- ID Map-based reimplementation of btf__permute (Andrii)
- Build-time BTF sorting using resolve_btfids (Alexei, Eduard)
- Binary search method refactoring (Andrii)
- Enhanced selftest coverage

v5:
- Link: https://lore.kernel.org/all/20251106131956.1222864-1-dolinux.peng@gmail.com/
- Refactor binary search implementation for improved efficiency
  (Thanks to Andrii and Eduard)
- Extend btf__permute interface with 'ids_sz' parameter to support
  type dropping feature (suggested by Andrii). Plan subsequent reimplementation of
  id_map version for comparative analysis with current sequence interface
- Add comprehensive test coverage for type dropping functionality
- Enhance function comment clarity and accuracy

v4:
- Link: https://lore.kernel.org/all/20251104134033.344807-1-dolinux.peng@gmail.com/
- Abstracted btf_dedup_remap_types logic into a helper function (suggested by Eduard).
- Removed btf_sort.c and implemented sorting separately for libbpf and kernel (suggested by Andrii).
- Added test cases for both base BTF and split BTF scenarios (suggested by Eduard).
- Added validation for name-only sorting of types (suggested by Andrii)
- Refactored btf__permute implementation to reduce complexity (suggested by Andrii)
- Add doc comments for btf__permute (suggested by Andrii)

v3:
- Link: https://lore.kernel.org/all/20251027135423.3098490-1-dolinux.peng@gmail.com/
- Remove sorting logic from libbpf and provide a generic btf__permute() interface (suggested
  by Andrii)
- Omitted the search direction patch to avoid conflicts with base BTF (suggested by Eduard).
- Include btf_sort.c directly in btf.c to reduce function call overhead

v2:
- Link: https://lore.kernel.org/all/20251020093941.548058-1-dolinux.peng@gmail.com/
- Moved sorting to the build phase to reduce overhead (suggested by Alexei).
- Integrated sorting into btf_dedup_compact_and_sort_types (suggested by Eduard).
- Added sorting checks during BTF parsing.
- Consolidated common logic into btf_sort.c for sharing (suggested by Alan).

v1:
- Link: https://lore.kernel.org/all/20251013131537.1927035-1-dolinux.peng@gmail.com/

[1] https://github.com/pengdonglin137/btf_sort_test
[2] https://lore.kernel.org/bpf/20251126012656.3546071-1-ihor.solodrai@linux.dev/
[3] https://lore.kernel.org/bpf/20251205223046.4155870-1-ihor.solodrai@linux.dev/
[4] https://lore.kernel.org/bpf/20251218003314.260269-1-ihor.solodrai@linux.dev/

Donglin Peng (11):
  libbpf: Add BTF permutation support for type reordering
  selftests/bpf: Add test cases for btf__permute functionality
  tools/resolve_btfids: Support BTF sorting feature
  libbpf: Optimize type lookup with binary search for sorted BTF
  libbpf: Verify BTF sorting
  btf: Optimize type lookup with binary search
  btf: Verify BTF sorting
  bpf: Skip anonymous types in type lookup for performance
  bpf: Optimize the performance of find_bpffs_btf_enums
  libbpf: Optimize the performance of determine_ptr_size
  btf: Refactor the code by calling str_is_empty

 include/linux/btf.h                           |   1 +
 kernel/bpf/btf.c                              | 143 ++++++++-
 kernel/bpf/inode.c                            |  42 +--
 kernel/bpf/verifier.c                         |   7 +-
 tools/bpf/resolve_btfids/main.c               |  64 ++++
 tools/lib/bpf/btf.c                           | 296 +++++++++++++++---
 tools/lib/bpf/btf.h                           |  42 +++
 tools/lib/bpf/libbpf.c                        |   4 +-
 tools/lib/bpf/libbpf.map                      |   1 +
 .../selftests/bpf/prog_tests/btf_permute.c    | 244 +++++++++++++++
 10 files changed, 746 insertions(+), 98 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_permute.c

-- 
2.34.1


