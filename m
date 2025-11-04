Return-Path: <bpf+bounces-73432-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BE690C31445
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 14:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 82EF44F6CA0
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 13:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F4F328B5F;
	Tue,  4 Nov 2025 13:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G9BPDFR7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1499B322A1D
	for <bpf@vger.kernel.org>; Tue,  4 Nov 2025 13:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762263642; cv=none; b=i52vkDXYN/WYhQUqc1Nf+FVm991a8wsQ9dLREinhcF1KJVu49o+RiIjWxhYwc6LeW4+9qokpcH1OLwhJqbU6KmWKop6o+MOiOsbZjXidkU2yww9dl45M78Yw7savGetFDeWDiZidQf9Vd23/QT3ltXCZHIbwPEYC7bWKYZ8YY9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762263642; c=relaxed/simple;
	bh=ZhjBl+UBjHacxZXf4ZcMtkjefM4tVboDQltonLi33ow=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DBELw65kUFVNDyvAn/RCu3ouTG48cnvkN/vyvq1QPPWSu3mwgIxG67n00dvsq+MJsHilGHaRzXjWHHlFZ3DfRp1crwamXsSYovNZCMV4+alwUt6GmtNjSmhGJP8KLREQ8pyKHs14u4k8AIrFZkEJ1wDaT0jq47zEmWfyKbV4W60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G9BPDFR7; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-340c39ee02dso2857408a91.1
        for <bpf@vger.kernel.org>; Tue, 04 Nov 2025 05:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762263640; x=1762868440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SF3OZOyoceOibm03NP3Mih92U39NdJi9E+pazzkoq2c=;
        b=G9BPDFR7bKNidfzIsfafycLyO2S7Oko6O+NIfydCu6jaOPEFXaC6rRjCYCBFWtHvG6
         6wDb4aZel0BCAfWJrxoIVbC2B7gMphG1fi4wNfeb7nYwFXMaw6/I61AOBCYdeuy6NcNA
         Z1IqG7pBuwGevZuJADP8qttDaT5Mw7y1WuGXSOCFvKu/1WCMzQox53fdjRKMmHUvTBY3
         BIWgEGnWJjpQqjuEHgExrnNfd1XLU/cnOv93MTbH7gp3UNEmqd9MAeseMCTGyGfpPUZ/
         rhUMDPYviO85eONOhaAW9J4JJpzBt7UISgZSKXWxHob+l1y0uJWkSSD5aFsgSGmKxmyY
         rBlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762263640; x=1762868440;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SF3OZOyoceOibm03NP3Mih92U39NdJi9E+pazzkoq2c=;
        b=PdqWQGBvXhZuxzRz4JnunFTzFm84+toZpdvo+Cil28uwx5sRFZqjiNsCCZPgLLv/LH
         yZQZj6ULKxwGuh2KuK0a5jxKCOZb98VN7oRLl6z841v+yBebiVjZxkARTxLIv+Tu/VeX
         vyaiqCadc3uaE+Am4c5o+TT67gz4k+nM8j0Uw0clfTSsFRzBXhO3AZJsxsp7tEsLGcYS
         h2wD8ieK9KxrAvEDfOzEOJWN+ns5cxESWopSi0he5eMtjlSBFg29plqmFj9B/GxpsT0j
         XshZcDLny0tze4sL04moYfMpIZ8QjHud7OGMhq5DHt9MhGUdpCOM302FKJavwMj6v090
         dp4g==
X-Forwarded-Encrypted: i=1; AJvYcCWKUKWavRjFIEpXIpNC9pw9sBVcp8mKLYOUNDExN/es+DTeqHoihXxRcoF1IvpjHmtFWT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYamBlgXSjctAKrHV+GfYIyK0XrqpKmmHW/oQbeVA6vnI5bz8C
	530sq7WeplpW2iVBsjBVKuDaW5obObEAHjzHRLVMXsBb3PoMN0OqYyo0tlD3PziNmZc=
X-Gm-Gg: ASbGnct7UMIznGV2l9veeAlhAK2e8YbGrGyXhROzq3xs5KoIn0ANOX4I/wwKmVHEtgF
	ti39bi9O3vV64ZA6RLLKwNBcPqmaY84rmlYdRitULtbIEv4h+vOm+0xY7MvnxOGuBfCw1Bs/4u3
	kLfz6mObpoUtdABeg5MG1YMsvN+0n8EC2pb7xmrqI1v3Qqm+2nuNn2wF197lV3O1m9KfU+hK1rq
	MqnvuiFrfi9czG08cNzLxlbtv1ODwCsFN+KgmiuIHD7PBZcmqWEJ1SWGEfab/Ks75f9O6Idgjm1
	RUc2GJwyQ7vwEX4C//B5Oh4Gm7P0K+ASi9HWl2e+zXUOrbgktg0lJfH6N7tSg3Yx3DfAcyY5UDf
	TTMen1C93US97LulrLet53TSxvNAUQblyISgkdMukUqMkNR8o3gqX0BtQJ9BH+gNzlkOmV95Fjm
	Mm+IUr2gaeb612Ixvn
X-Google-Smtp-Source: AGHT+IHkPgcIAhbCrLMveJbJmdTx49ld7p3N4G/OD0oa66daars4gmXhdApmDvDeB8mUNmklnMQj7A==
X-Received: by 2002:a17:90b:1dc6:b0:33b:b020:597a with SMTP id 98e67ed59e1d1-34082f051b4mr21249866a91.0.1762263640230;
        Tue, 04 Nov 2025 05:40:40 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba1f87a7287sm2499238a12.31.2025.11.04.05.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 05:40:39 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: ast@kernel.org
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Donglin Peng <dolinux.peng@gmail.com>
Subject: [RFC PATCH v4 0/7] libbpf: BTF performance optimizations with permutation and binary search
Date: Tue,  4 Nov 2025 21:40:26 +0800
Message-Id: <20251104134033.344807-1-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series introduces significant performance improvements for BTF
type lookups by implementing type permutation and binary search optimizations.

## Overview

The series addresses the performance limitations of linear search in large
BTF instances by:

1. Adding BTF permutation support - Allows rearranging BTF types
2. Implementing binary search optimization - Dramatically improves lookup
   performance for sorted BTF types

## Key Changes

### Patch 1: libbpf: Extract BTF type remapping logic into helper function
- Refactors existing code to eliminate duplication
- Improves modularity and maintainability
- Prepares foundation for permutation functionality

### Patch 2: libbpf: Add BTF permutation support for type reordering
- Introduces `btf__permute()` API for in-place type rearrangement
- Handles both main BTF and extension data
- Maintains type reference consistency after permutation

### Patch 3: libbpf: Optimize type lookup with binary search for sorted BTF
- Implements binary search algorithm for sorted BTF instances
- Maintains linear search fallback for compatibility
- Significant performance improvement for large BTF with sorted types

### Patch 4: libbpf: Implement lazy sorting validation for binary search optimization
- Adds on-demand sorting verification
- Caches results for efficient repeated lookups

### Patch 5: btf: Optimize type lookup with binary search
- Ports binary search optimization to kernel-side BTF implementation
- Maintains full backward compatibility

### Patch 6: btf: Add lazy sorting validation for binary search
- Implements kernel-side lazy sorting detection
- Mirrors user-space implementation for consistency

### Patch 7: selftests/bpf: Add test cases for btf__permute functionality
- Validates both base BTF and split BTF scenarios

## Performance Impact Analysis

Repo: https://github.com/pengdonglin137/btf_sort_test

### 1. Sorting Validation Overhead
Test Environment: Local KVM virtual machine
Results:
- Total BTF types: 143,467
- Sorting validation time: 1.451 ms

*Note: This represents the maximum observed overhead during initial BTF loading.*

### 2. Lookup Performance Comparison
Test Case: Locate all 58,718 named types in vmlinux BTF
Methodology:
./vmtest.sh -- ./test_progs -t btf_permute/perf -v

Results:
| Condition          | Lookup Time | Improvement |
|--------------------|-------------|-------------|
| Unsorted (Linear)  | 17,282 ms   | Baseline    |
| Sorted (Binary)    | 19 ms       | 909x faster |

Analysis:
The binary search implementation reduces lookup time from 17.3 seconds to 19 milliseconds,
achieving a **909x** speedup for large-scale type queries.

## Changelog
v4:
- Abstracted btf_dedup_remap_types logic into a helper function (suggested by Eduard).
- Removed btf_sort.c and implemented sorting separately for libbpf and kernel (suggested by Andrii).
- Added test cases for both base BTF and split BTF scenarios (suggested by Eduard).
- Added validation for name-only sorting of types (suggested by Andrii)
- Refactored btf__permute implementation to reduce complexity (suggested by Andrii)
- Add doc comments for btf__permute (suggested by Andrii)

v3:
https://lore.kernel.org/all/20251027135423.3098490-1-dolinux.peng@gmail.com/
- Remove sorting logic from libbpf and provide a generic btf__permute() interface (suggested
  by Andrii)
- Omitted the search direction patch to avoid conflicts with base BTF (suggested by Eduard).
- Include btf_sort.c directly in btf.c to reduce function call overhead

v2:
https://lore.kernel.org/all/20251020093941.548058-1-dolinux.peng@gmail.com/
- Moved sorting to the build phase to reduce overhead (suggested by Alexei).
- Integrated sorting into btf_dedup_compact_and_sort_types (suggested by Eduard).
- Added sorting checks during BTF parsing.
- Consolidated common logic into btf_sort.c for sharing (suggested by Alan).

v1:
https://lore.kernel.org/all/20251013131537.1927035-1-dolinux.peng@gmail.com/

Donglin Peng (7):
  libbpf: Extract BTF type remapping logic into helper function
  libbpf: Add BTF permutation support for type reordering
  libbpf: Optimize type lookup with binary search for sorted BTF
  libbpf: Implement lazy sorting validation for binary search
    optimization
  btf: Optimize type lookup with binary search
  btf: Add lazy sorting validation for binary search
  selftests/bpf: Add test cases for btf__permute functionality

 kernel/bpf/btf.c                              | 177 ++++++-
 tools/lib/bpf/btf.c                           | 436 +++++++++++++++---
 tools/lib/bpf/btf.h                           |  34 ++
 tools/lib/bpf/libbpf.map                      |   1 +
 tools/lib/bpf/libbpf_internal.h               |   1 +
 .../selftests/bpf/prog_tests/btf_permute.c    | 142 ++++++
 6 files changed, 728 insertions(+), 63 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_permute.c

-- 
2.34.1


