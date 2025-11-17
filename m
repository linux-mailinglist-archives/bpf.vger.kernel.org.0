Return-Path: <bpf+bounces-74734-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 85AA3C6459A
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 14:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5326F4EBF63
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 13:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9203321C7;
	Mon, 17 Nov 2025 13:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLoxWCOi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31BD3321B4
	for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 13:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763385992; cv=none; b=BEierYk5puJfFzh26B+okT3+Gw196ZWAq/i9gWwfJ04ZeLqI6GcRSH0LqqOAP0Wb+ulgtiCl+8gjGCUCum6zVrkYUb5puHacg9LJZJte3L0IT9AcGpzUA0RMkqqRkkmudTLuVYRDnDMq79ZRWBnaIc14CE3msHsr4SOeI8E/21k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763385992; c=relaxed/simple;
	bh=FdhscpdMwQS8oFm0RXktIHfFKrq5xHRHjn+cNoyJAW8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nr6KoFp/ATXgKABRrde83jO2H0WtFZJ0hhZST3Kd2OlidrPZxQ6bTXFbj41Zx2dKkiq51fbVD10i6jz9ZUyULqwAH0xcF1T1PdteS8NDze1Fq0KfYVFkm8tkkH7CVIwOJnuZOTbt9j+oSlRmIHN5SpIghBNvk7C4YlPfQUXSqss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZLoxWCOi; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-341988c720aso3599595a91.3
        for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 05:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763385990; x=1763990790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fytBOGpV+wgxdC8XBxGlNBNVjGNrTYHvrfpJ7uW2nqc=;
        b=ZLoxWCOitpGM4YCM8+yB5rEzUVbnJ09ytbAtQJq0XX/vFe/Chm/G7lHeiwqLh7z6XW
         nIJuUyvnZyYCtUm0k9RirW5LmOMWj0UxevtsTiLAYLs5JRn3asmjLAlHVdlTFGSGTxeq
         Vh6+WiO+M0fXk+ggDN1cbGDA5QPAGvBdR/gqDkSl1LjSgCZX/Q2c9fL88Mv3Du9nNfLi
         0nwz5IMSlj2htvLpWiVEPCnj1TSXKROeDrE+O7oHtE/WkQMyv7T1/OkveXPlDKZAG97U
         l23iDMwoSwfBSgn05+Fr8Znp1bkDJklag+OMJN3N3DizfD5RxXue1DhE11Ze5iopOXil
         oGxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763385990; x=1763990790;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fytBOGpV+wgxdC8XBxGlNBNVjGNrTYHvrfpJ7uW2nqc=;
        b=Y5Qpfy9eH/Gpai0fbTiAjAJ1q5/F3GRr4RvACr5OHyZB5byYumvyDXqEZlsYaz0fqK
         +QOHd4/T7MFOGAxihU6SBUb+KsoGV9Y5xjbB3mgl6HmLHIAulH/mV6HEk/hMPqzNcOG9
         82/areJeKFWAe1e1hyriI+cl4a8VEU9qBFKOAcki10q12OSzMRZ5Eh4BfEpvbh7nC3z+
         ZmZDx77pNOrL8uhYlgi4v+jBiuW05Lpgg1hLuiwDtnE/ossgKDWadJX14HR+ey3/qFQv
         zAaQOM2Otbci+GqxJa8oKV2corVXBsgoXX8N8cceWRUfCOT9MhVhG8vXCBpU/TVY5Xro
         OW6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWIk1sZebQlHs7NnYxnvdMtsob5s/9j9UBjlxm2l7gJXnJ5Y+n8f+P1ROz0fq0dsxmE5Tg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwExERhDKr6Fi+shehmUkpKJ25jvF86GJd85v/1LbO6Udpye/Bi
	QRlxANG4oOlz6ayIT8PCEwSYxIJC8IZLEEEgIPPqWFyTizUdk3BQOUz5
X-Gm-Gg: ASbGncsvL2lvkeG1Ah6ujnHoQXOO2Wxy+pvFKa2YsLGY4zFGK9vx4oVKCZEXIF3cf4c
	XgplSfeuv3+N8yPvvul8e/ZP3IGInijaKg6T2LRHYpNGRh7sVEYDy9e4LJcaNGM3v4ghInY7vDF
	RINyk+OgnsV0paK8J3TEy/l3+4eMFdvnWVtHOr1TJiOd+mjFEEvxvAgY5VPM3/ZCKCpJv5T7kwB
	IONloOudjI2DzedHARW7Owv2v7Ia9x0fEWksxQJ0gCEreyD/8ZAVWfQu9u7m+gVLT7o9kXrvyMc
	0AaUG7wZjY4cAAKeZ9bLyeX+PYozQ5iAWpyKm4lBrYCaCgnRf1N2Lg3BG1eNAW+xuSucs40ves/
	HaXwAXe/O759iArEkd6rhdo1YSBMscO82DLIO232HnqaM3MNLLdhelw3K5wbT78a86aGbLW4Zcc
	KcJXH1Ac+8HFKv4zHkIbiqj7Q9bzw=
X-Google-Smtp-Source: AGHT+IGzVP3SMvbeXB00GsSDjJNgXNmg7r6LQijVUlFZVz8zZiKgYJJiEJuzHHsCVw0RCLw02zVuqg==
X-Received: by 2002:a17:90b:2d05:b0:32e:a10b:ce33 with SMTP id 98e67ed59e1d1-343fa6326e0mr13739338a91.21.1763385989897;
        Mon, 17 Nov 2025 05:26:29 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b924cd89bcsm13220953b3a.15.2025.11.17.05.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 05:26:28 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: ast@kernel.org
Cc: eddyz87@gmail.com,
	andrii.nakryiko@gmail.com,
	zhangxiaoqin@xiaomi.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Donglin Peng <pengdonglin@xiaomi.com>
Subject: [RFC PATCH v6 0/7] BTF performance optimizations with permutation and binary search
Date: Mon, 17 Nov 2025 21:26:16 +0800
Message-Id: <20251117132623.3807094-1-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Donglin Peng <pengdonglin@xiaomi.com>

This patch series introduces significant performance improvements (~1785x) for BTF
type lookups by implementing type permutation and binary search optimizations.

## Overview

The series addresses the performance limitations of linear search in large
BTF instances by:

1. Adding BTF permutation support
2. Sorting BTF during the building phase
3. Implementing binary search optimization

## Key Changes

### Patch 1: libbpf: Add BTF permutation support for type reordering
- Introduces btf__permute interface for BTF type reorganization

### Patch 2: selftests/bpf: Add test cases for btf__permute functionality
- Validates functionality across both base BTF and split BTF scenarios

### Patch 3: tools/resolve_btfids: Add --btf_sort option for BTF name sorting
- Implements BTF sorting via resolve_btfids during build process

### Patch 4: libbpf: Optimize type lookup with binary search for sorted BTF
- Implements binary search algorithm for sorted BTF instances
- Maintains linear search fallback for backward compatibility

### Patch 5: libbpf: Implement sorting validation for binary search optimization
- Adds sorting validation during BTF parsing

### Patch 6: btf: Optimize type lookup with binary search
- Ports binary search optimization to kernel-side BTF implementation

### Patch 7: btf: Add sorting validation for binary search
- Implements named type counting for vmlinux and kernel module BTF sorting validation

## Performance Impact Analysis

Repo: https://github.com/pengdonglin137/btf_sort_test

### Lookup Performance Comparison
Test Case: Locate all 58,718 named types in vmlinux BTF
Methodology:
./vmtest.sh -- ./test_progs -t btf_permute/perf -v

Results:
| Condition          | Lookup Time | Improvement  |
|--------------------|-------------|--------------|
| Unsorted (Linear)  | 16,666.5 ms | Baseline     |
| Sorted (Binary)    |      9.3 ms | 1785x faster |

Analysis:
The binary search implementation reduces lookup time from 16.7 seconds to 9.3 milliseconds,
achieving a **1785x** speedup for large-scale type queries.

## Changelog
v6:
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


Donglin Peng (7):
  libbpf: Add BTF permutation support for type reordering
  selftests/bpf: Add test cases for btf__permute functionality
  tools/resolve_btfids: Add --btf_sort option for BTF name sorting
  libbpf: Optimize type lookup with binary search for sorted BTF
  libbpf: Implement BTF type sorting validation for binary search
    optimization
  btf: Optimize type lookup with binary search
  btf: Add sorting validation for binary search

 kernel/bpf/btf.c                              | 147 +++-
 scripts/Makefile.btf                          |   2 +
 scripts/Makefile.modfinal                     |   1 +
 scripts/link-vmlinux.sh                       |   1 +
 tools/bpf/resolve_btfids/main.c               | 203 ++++++
 tools/lib/bpf/btf.c                           | 353 +++++++++-
 tools/lib/bpf/btf.h                           |  43 ++
 tools/lib/bpf/libbpf.map                      |   1 +
 .../selftests/bpf/prog_tests/btf_permute.c    | 632 ++++++++++++++++++
 9 files changed, 1351 insertions(+), 32 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_permute.c

-- 
2.34.1


