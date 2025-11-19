Return-Path: <bpf+bounces-75034-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E6898C6C968
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 04:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C58CA4F3FA4
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 03:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04942ECE92;
	Wed, 19 Nov 2025 03:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VwxoJgIK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DAD2E9ED8
	for <bpf@vger.kernel.org>; Wed, 19 Nov 2025 03:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763522502; cv=none; b=ALCJZ83Crz+7ljnhxIa6wpdQ8Uz4Zi53QDjxqjIjo3NPgM7JUPSkxWkI9ojLfa2tRIoGkoGmd5hBny7RqOXqVjcweGeT0X5axrRE8uOa2z2DUu/C8UwP/mYfaA5ViG/5me2kK19WpKAp5b263dJnjfeNVEqrs+CrNVqodrnmi0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763522502; c=relaxed/simple;
	bh=543xNuQ5ESQ8ZZZQaE4nvKuREmCYpQmYoWdxt6lCw94=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AjJppfihWkIkACZ3EG7SL7LmlZKD+DlRJdpNla3rnwMjyT5Jo1KfJdu8H4LjUff6Wk8F1TFbeOWq2+AepDO/bEPKUrQKzHpkdcMH8XLHyJa3I+Rp6GZxtvw942jooK8esO2tGOarhEEzKxAmOOASFv4adKSajaXEROJHeprF/G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VwxoJgIK; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-298039e00c2so78882665ad.3
        for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 19:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763522500; x=1764127300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nC2tHRx0ZLt59JPprv9De3BTLn0v9fWRDIOj8N34AP8=;
        b=VwxoJgIKgH+Fo6MNt/fv1tjtTR/kzVNw2/Rt49e7julKilJ8NvM4xnO1DpUJR9mJN1
         awjPUKEAd4pn3HfjKGkACLDk10nwNzL+hyXJrpu9dXxxYhgUkyKKZ5/m06iNwEcnaA33
         O3QwysUukVbGhgzA2obRaQ5d+cv50kyPxGqMvDptk0VGiRNuEGlM//xrbdU24jmbVjCg
         V8kfBT/tg68hEvxglFarSVzjhmN9psz7vezMGIPXN5gKSigNgmsohdNk3HBjiz2qIy0G
         D4qNNA0Ql7cmBnNQgxc4ENTNNy0NV29sBdy47iEQ0X6u1+1VHTvM5XzXZsfx9NCbqKe3
         oAQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763522500; x=1764127300;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nC2tHRx0ZLt59JPprv9De3BTLn0v9fWRDIOj8N34AP8=;
        b=CCxbzAz+CJSM+6ldPJjOp9wzHXpmXUMWcNIJF3DyLp9ULSDusNNYx4HOpNb0bO7ov1
         UCv8geoj2sppZ5xV1dWUidfcWIJq7mdpJtz7eK7m6whJMkTKEuJaBvXrfuCYOVSq+6Ht
         fNLNMPwx97hL+tgqZoEImEHEE8egq+lyTTzWsV/5MuzCfNB5K9CoeCmhPXpEAaJ7Cq2h
         S6J4aEM0j/eQAYy3mfTcTBBOcJgcKWSXGbiSztv66dfDeLBj2FuiZMCk9jgGexqWPdWW
         1QLWNe1AEzEvT/1nKq9qEBzpRaNcwih7Apsfgkux7L2JeOrr/iEt7C/cKu5rmNVuMMfT
         nfWw==
X-Forwarded-Encrypted: i=1; AJvYcCXFJaonywOQl12fz8g5HUDHfkpvayPxHUqVkt/ZYRZtJ2AsoQtDn4ei4mmkmhYJHLrdfDI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMyGLvEQTJNAMIRApz5exXzrmtXyAmmeR35ON5Ut3Qr/eO6RsE
	5bgy8NbECGKSy4jrEmkwKGRW9sa6d4DMzJf3Zkee+W/ufjYUNLIOE845
X-Gm-Gg: ASbGncuCCEw0t6k3s04J8246hcuLKd1d6h8g+m+i1vXUcy5eZg/9ivA+ao36YuGInEw
	lUN7MIkGkNr7m+DUPA2a9HCErfGFQ0r1+Cs3aPPuqGFjQi8SfU0GOrsHhVx5zDaMFC4tzHQExMN
	BrMvKaY6ffIcM490No4tBV6ksHaFogsQzi41D3EkpTwiPX1uxxZJaMfLi49bQQL+Ife9/p10Ee9
	mTIad3d+QfSMEM2yTC79w7SSdGMCqwPXIYIcePek5aH+Ot4OdLApTdR3uUMWQc71mtbS0H/L8EY
	iPckzJvnlLktlPoofqkq8Mhd8daMsFrS8vmwdrXWMjV2zbWn3CQoWWbIgPtdpcuOLzsyNdw6Jmf
	kwjM91zSAUB/tt6EGxbJeNsfkm7NQtM00Q1NQV3/Y2Aot87Rk1hiXL426CA2VKSw9yjBf9JEpCt
	Ly2GjJHz6/z/lfm46uEGVL2Hpm7jg=
X-Google-Smtp-Source: AGHT+IE6rHsygd+SRqt5Yz4nAIYKE+0nE3S2/0YP8VczcgK7JK1GPuValQJU/z3lWsvQd+zHcDyAxg==
X-Received: by 2002:a17:902:f705:b0:296:4d61:6cdb with SMTP id d9443c01a7336-2986a6f5360mr215227655ad.27.1763522499764;
        Tue, 18 Nov 2025 19:21:39 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2bed5asm188352485ad.88.2025.11.18.19.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 19:21:38 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: ast@kernel.org,
	andrii.nakryiko@gmail.com
Cc: eddyz87@gmail.com,
	zhangxiaoqin@xiaomi.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	pengdonglin <pengdonglin@xiaomi.com>
Subject: [RFC PATCH v7 0/7] Improve the performance of BTF type lookups with binary search
Date: Wed, 19 Nov 2025 11:15:24 +0800
Message-Id: <20251119031531.1817099-1-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: pengdonglin <pengdonglin@xiaomi.com>

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
v7:
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

Donglin Peng (7):
  libbpf: Add BTF permutation support for type reordering
  selftests/bpf: Add test cases for btf__permute functionality
  tools/resolve_btfids: Add --btf_sort option for BTF name sorting
  libbpf: Optimize type lookup with binary search for sorted BTF
  libbpf: Implement BTF type sorting validation for binary search
    optimization
  btf: Optimize type lookup with binary search
  btf: Add sorting validation for binary search

 kernel/bpf/btf.c                              | 147 ++++-
 scripts/Makefile.btf                          |   2 +
 scripts/Makefile.modfinal                     |   1 +
 scripts/link-vmlinux.sh                       |   1 +
 tools/bpf/resolve_btfids/main.c               | 200 ++++++
 tools/lib/bpf/btf.c                           | 327 +++++++++-
 tools/lib/bpf/btf.h                           |  43 ++
 tools/lib/bpf/libbpf.map                      |   1 +
 .../selftests/bpf/prog_tests/btf_permute.c    | 608 ++++++++++++++++++
 9 files changed, 1298 insertions(+), 32 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_permute.c

-- 
2.34.1


