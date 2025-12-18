Return-Path: <bpf+bounces-76970-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 80720CCB9E3
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 12:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 56CBC301BCA7
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 11:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D17131A577;
	Thu, 18 Dec 2025 11:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MvRAW2rU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6439D31A04F
	for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 11:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766057474; cv=none; b=DYt4OwkMy7L5vWfZ/eZvKWLTTSf+r3GPOS0YXjFhepw9nVx8kgC4bcMJ77X41iMBmCqH/D40innEu53cKgvz5TMUZUWUog8Len1JKhgOWjpo0UtdjMDJfJkJ6U43TRKen/YXSEb6MdINU2DsZO8YlM5KxC0BMpUNUx+gL1LWEsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766057474; c=relaxed/simple;
	bh=o4+L3KbuDhqvDnvN3BPEu5klLwjDn/64GjkLoRAYfhg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HtoNsn9X7iwUxnE8yTrXsjp215ZHUWs+Az6xRwbWTfG9KdyKCbt1mu1VD88NYSgkQakQJjKqJwCI0ugpdR6dp6lONc7ok9N2RlC1IMtWJ088IVThRZgwxeJ5nnH2xARLjIg/38w64WjAdRNZj0KrZqwRNyEiw7Ez/aHgRhkqR40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MvRAW2rU; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-34c2f52585fso450029a91.1
        for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 03:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766057470; x=1766662270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Km+xebCPtKJz02ZfAL7/mj1J5oAF6lnyqXk4Am86Vjo=;
        b=MvRAW2rUiYUrT/zuQ88Q5eHfMZYWIlWDf+l8a59o6eHHn8UFxS4qHVKIAcD/GCzvwc
         ZLnhHaBeVzBPdlhjIzMh3LcRVKGKn4VGw2MEmzEw8cxhT6pUcTLV9Eb1hc+ofBqo/JyN
         /wM+YqNm2KO7ZYHJUeaflJeW3B5nKyv02GHAHT6ftgKRFA+PkiJvGwCTmlVZkHTILI65
         Qn9v5ubuA11k4l+6nqCGy5kbmt/K8bdZaawoIRNdkOLMKrWvkV5yZAb7NuIWy34u7stR
         CJrxFpaxHA7o0uxJtMjIzzpLqgO8a47Pg8zXF8vD+ooycXas5O8kq8GdChTz0BCFjioc
         YMUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766057471; x=1766662271;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Km+xebCPtKJz02ZfAL7/mj1J5oAF6lnyqXk4Am86Vjo=;
        b=Ev6PijJST9E3jG12+glJibFMBp9rU2QhElL2GmDSvtRd+HrVh6Xm7zqxgfsFixKuh5
         q7AHu66tWUfUyTsQ4Va1PMLceocn7hviXhUygFn12QL50p/cCUCVuBwXvfp91XD89XVu
         xjVddPrVLmAolxysfBYBlMOJE6dJGQ7P9Ni/enbV/tJ+p7lcuMFyJm7W2xR5y3uPabp0
         HsUmcqUFb9asFn58MimX+61xudPLvIZPkNyL9j3/ZT7GkKmZw+tADMZVSbnvlnDC14DU
         +HMo2EgS2hur9BwzAFYYaKai7Y3b3QoLN96sCzB5PHOpK+Kucn+5utz2n0Jp7OnfVr9c
         67Ww==
X-Forwarded-Encrypted: i=1; AJvYcCWGwvveV1iCUaAPcg5MRyTNUGdxw9fGtjgUSxv+dS1RYODVifZ6Bp7gCQodjaptDF8M3o0=@vger.kernel.org
X-Gm-Message-State: AOJu0YznpYmO7bcpmWLcTEOJ4d26DL9S5UmHz6UtEPRkCVNXeLfAnuZv
	zoVryZiIJSHiuh15YYDJ6mdHyX5lH2+nfThXujOGPVuvNGWtJSNzcr0X
X-Gm-Gg: AY/fxX5MyZWp7bUk94+3+NfEax952QGKgyRmTYQ7b/M1FUYY1LxZGlSqlSUkf/qAafb
	LvjGRJpZlOgObihjP88najbENlgBGLanz5krg02i9M1vSHopMT+Sjp46D7khJJD83SaN36wyDKE
	ktHJYWtJXMNnXCnVTMWgRq9P/96C6juEtN43TWn9/EOs9iXPV9K9bd3stYgem6OreX0Vz16SNeF
	LfxYtbKayQpPrAV+MH01QQpyK51MehYe90c1Z13T+nMEfbtppEXzThVmRGzjmoRcb73YVAQNIoo
	yRV2/39/Cbx1BRjCfXnRvsUMicTV6/Dasr1kjGiObwXHMrxfSSk52Iqs/xdM8x9PJW8dDGQzLNC
	snpl8qXilm4Ij2FoyjhjXbxcv1Sfnw3GpkaJV0pfcFO0qieeTRM9HljqeBQng5nYIRUecQIuX2p
	i5g1+Ag1xS6IEApFURbpE7VqMUMLA=
X-Google-Smtp-Source: AGHT+IFp6W0UWPNSPV4XakFVJSSfQ5VmAbXAuGETnPd02bc6AjkL5rLrAQVp5qb5KNMVME54KRejaQ==
X-Received: by 2002:a17:90b:3dcc:b0:32c:2cd:4d67 with SMTP id 98e67ed59e1d1-34abe3ff96emr19231677a91.13.1766057470507;
        Thu, 18 Dec 2025 03:31:10 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e70d4f887sm2328237a91.3.2025.12.18.03.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 03:31:09 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: ast@kernel.org,
	andrii.nakryiko@gmail.com,
	eddyz87@gmail.com
Cc: zhangxiaoqin@xiaomi.com,
	ihor.solodrai@linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	pengdonglin <pengdonglin@xiaomi.com>
Subject: [PATCH bpf-next v10 00/13] Improve the performance of BTF type lookups with binary search
Date: Thu, 18 Dec 2025 19:30:38 +0800
Message-Id: <20251218113051.455293-1-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: pengdonglin <pengdonglin@xiaomi.com>

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
Patches #11-#12 introduce btf_is_sorted and btf_sorted_start_id for clarity.
Patch #13 refactors the code by calling str_is_empty.

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
v10:
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

pengdonglin (13):
  libbpf: Add BTF permutation support for type reordering
  selftests/bpf: Add test cases for btf__permute functionality
  tools/resolve_btfids: Support BTF sorting feature
  libbpf: Optimize type lookup with binary search for sorted BTF
  libbpf: Verify BTF Sorting
  btf: Optimize type lookup with binary search
  btf: Verify BTF Sorting
  bpf: Skip anonymous types in type lookup for performance
  bpf: Optimize the performance of find_bpffs_btf_enums
  libbpf: Optimize the performance of determine_ptr_size
  libbpf: Add btf_is_sorted and btf_sorted_start_id helpers to refactor
    the code
  btf: Add btf_is_sorted to refactor the code
  btf: Refactor the code by calling str_is_empty

 include/linux/btf.h                           |   2 +
 kernel/bpf/btf.c                              | 170 +++++++++-
 kernel/bpf/inode.c                            |  42 ++-
 kernel/bpf/verifier.c                         |   7 +-
 tools/bpf/resolve_btfids/main.c               |  68 ++++
 tools/lib/bpf/btf.c                           | 321 +++++++++++++++---
 tools/lib/bpf/btf.h                           |  36 ++
 tools/lib/bpf/libbpf.c                        |   4 +-
 tools/lib/bpf/libbpf.map                      |   1 +
 tools/lib/bpf/libbpf_internal.h               |   2 +
 .../selftests/bpf/prog_tests/btf_permute.c    | 228 +++++++++++++
 11 files changed, 786 insertions(+), 95 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_permute.c

-- 
2.34.1


