Return-Path: <bpf+bounces-78191-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7219D00D38
	for <lists+bpf@lfdr.de>; Thu, 08 Jan 2026 04:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BA686300307F
	for <lists+bpf@lfdr.de>; Thu,  8 Jan 2026 03:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07634279DAB;
	Thu,  8 Jan 2026 03:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qhw+O/Ya"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF53F1FF5E3
	for <bpf@vger.kernel.org>; Thu,  8 Jan 2026 03:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767842215; cv=none; b=TLPIfksJ9mEPE1jdBzcEuzRNLtZGDtf6eExhghaIuX44TP7uc5+DqLHvbMEk9B3D+oWCHhd+bckGOwhxtRuansrCjwZdlcR9JFXtp33+kXuK8vqFrANlwOMr5L7rTxoJ0kmDewm2QX+gQnF5X+jvsZU0F7vBuVR9GVhQU4no55M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767842215; c=relaxed/simple;
	bh=/YFoSyUjs5bD+/Y5VdZ1T5rQ7gIWrMuQd8IcCRoqEnc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J4VVkeoameR2WWHjHpX9TusBIGl0sDeERpJCLPqH1VVe66cldk/JiDQNUBUal1qWchRayhpu5JhaaNHx2ElHhvehFgQGOzRFlg3AryiBho/IH6KMnyxzvb4UsgtWP0k88GMaR8PErCBE05GxOA9V+gF9NAubOlyIZaqhQYkEEFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qhw+O/Ya; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7aab061e7cbso3007061b3a.1
        for <bpf@vger.kernel.org>; Wed, 07 Jan 2026 19:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767842213; x=1768447013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xxFhutl2oHOHq5rqyty4oHx6se5JmQANi3FKuiF+KbY=;
        b=Qhw+O/Yag810MJd8oIVrJkGvqBwTQVMgv48k73jRcpsU9IZ4q7/p6Xn17neRTXTM7o
         n0OVKuW0IMZ4vZDMx7NkAUqFY1+xFF9Vajvt1FcbOR1Ika/X4Y2VnlZOuDyZTvHXsGYR
         1Mp/OarCesbNi/y6yX7slBMQnot33K6RLFd4KD4CIkVdOPTigBmlcrB+bbZxfB/pUjfG
         hO0FsnCNytZ9gLdBiEnX8XUeUBTtk/R86bWWYYOQ/3cE4KBa8l9wn+M0iUALWH+UgnJi
         Qzd5aeSH8bPQ/Q1SY0EJPacqDNVos0E3Myk9O7584U6ItMDP99DSbQJRiqNuGE5pTSa0
         53Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767842213; x=1768447013;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xxFhutl2oHOHq5rqyty4oHx6se5JmQANi3FKuiF+KbY=;
        b=VsC4dc8uQVeTRi+Gw1EA+961ZVvvdvhBwLkkhRn1QTphG84StC0PhGJKyXHM7aVhHJ
         ZbHCt8dr0krDTeOpxzvyALeEjoZODsxzxsvd/vK9YRmGhqRZkvSSv3Bxx007nGgYvKEo
         y5nkL3Gf7wrVS7I1iW4tpx/VKxLXIn0WmOiKwgtIZrRKf99Gi7uGGdMtmpiT4Ijg9CX8
         xCrm6N9Nl7HtfVOvlgLor5F5N8rBUWL7PfW4URx4O6LoAKSEHTwnrqaRf4JWeEApqcav
         RnCR+FKQfLg8GwBlqYGFJfCJQYSBStDwRPwrw4wBT4GVig7rWowQCp9rKXw2X3zv53dm
         KbVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEP5zmyTZXoBbGS56DPrEY/ydeDsEbRrLGihsSE7qyKWdoWb8sexgV8FzkQnDHh89h15s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw5fDQAt+gs7PL0lmY38tvs6OC2oy3WS/KSDWTR4xhrcTdMrQQ
	PT4Q8EstrYJoKLJt/95Lh1+d0kseaC6GXOdSRhFEg+z90HrgdxpmbNxk
X-Gm-Gg: AY/fxX40ngKBdC1+lQyVZjzHNrT4orUsroOcSNwuKk7wyOA+rnuIpSUaMFpKmNSJnZ7
	xmhpjpBAQ+GYiiCk1V+0RFWS0/Mfrw8Vg5s1I1F8vonQ5LWfA5/ldGPw7R4Ucg6iwAb4vG8LfD8
	XOgPca88rmT9wwnpcjq3VmHkRWf9gYmi4YWReLG0eU6m8Kj0AUniPaHzE2KUFV7dQ0lgCFpvfif
	KcVvsPpyqzNNNmKkljoke7vttn8jYmYTYdz+JGXNyfRBr8b1J5eDnHKBpTmg32f2eGC+ffulxfu
	khQtZ1J2yyy1y86Xooc5h3SzHy3cuY4jJJ9xADP4G10SU0LwJWq3hK/Ta53IU2OQNbSFHtPA1k2
	9CFtvS+tU4kUGAJ/GsTYQkJRfipN2vupA/TyjPI8/u8zeeRZjaWeHjznFPMwiHbWn50wokg9nDZ
	AfD7/Hg608XYYP6lp7SVwXnLoygXvKCTxBakSrwg==
X-Google-Smtp-Source: AGHT+IE4R3f6As98S6/xqrtAtQ5kxnEaw51TwT7IllO6CVfi77GjBuf5laZ3GIX8jjOHo4OBvgUInA==
X-Received: by 2002:a05:6a00:3391:b0:7b8:ac7f:5968 with SMTP id d2e1a72fcca58-81b7de5db9bmr4069157b3a.24.1767842213097;
        Wed, 07 Jan 2026 19:16:53 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c5de655bsm6134860b3a.60.2026.01.07.19.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 19:16:52 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: ast@kernel.org,
	andrii.nakryiko@gmail.com,
	eddyz87@gmail.com
Cc: zhangxiaoqin@xiaomi.com,
	ihor.solodrai@linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Donglin Peng <pengdonglin@xiaomi.com>
Subject: [PATCH bpf-next v11 00/11] Improve the performance of BTF type lookups with binary search
Date: Thu,  8 Jan 2026 11:16:34 +0800
Message-Id: <20260108031645.1350069-1-dolinux.peng@gmail.com>
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
v11:
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


