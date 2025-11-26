Return-Path: <bpf+bounces-75550-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF53C88BF5
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 09:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 31004345CF2
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 08:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAC031AF24;
	Wed, 26 Nov 2025 08:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dbyaEBvs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3809F31A808
	for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 08:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764147034; cv=none; b=a8zkbdJ/fBzR45ohIPSdQ2duLJYggj+8u4BOJc5j9k6E058dnLrn+yiLWEhPV3COMObdgwwGf/pB+dNwYb1QK9OaC7p+XcIRIfuaEIKioZ5BgCBJ21kkEgR+765tMO6VDDgw0FEwPQ7ft5oIC82I52/ojzw2GzLlSc6y/TeQT+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764147034; c=relaxed/simple;
	bh=evRz1+RSm19y+i3oY7bdpBtGC57ReMDJiKJsw3sQlM0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N9XLZDWXn692nOyKumt6QS3q2377ydtaXnGnRKm6d1DzJ7B+3ehQljOEryzvE+llMPcd/RLQCPFP2CKMEvfqJ7Vwooh4XbllCc8eY+8F7kr9ZVvyyhLUsLzVuQ4X2kTkimW/t5O646W/IsCoXhEKFe7AXgm0DcdzZR8gv1q+OdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dbyaEBvs; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7a9cdf62d31so7754801b3a.3
        for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 00:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764147032; x=1764751832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BxNPd6xRith5Tmbdr3Wot2eK29BxDgV+As0Pvo83p7s=;
        b=dbyaEBvs9sQs4p4BAcalyfiJRwv+fJo6/Byitwms7jvG8lph03fptcGSv7+hS/mmV1
         7Z6VSwOZTQXCWpANavbHtuVeoQJq3QgKwFYO+76ychExOvj5l55znoeVLbYcFgbVpL7H
         mR8SPxCfZk5EaaphpB1eH5YNtEvI/ZayjhNmfoCtM5fbej0juHa3wb6QQy5l1edupGIf
         kdpBNVyZCPAsl+/OD8+G6kD2peu82YukJouN+WpNmdQvd1Z6TZGxSqWishhoY884hXIp
         ypXH81TNXTTfyEnSmj8GTGINUrXCQFj/3s6RV6zeP+RaenTiV84uERhZQCkntEE42r+k
         26eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764147032; x=1764751832;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BxNPd6xRith5Tmbdr3Wot2eK29BxDgV+As0Pvo83p7s=;
        b=QyotVAEEmzaJmxSZGcxOkUHRWH7omxuNa5oUuWlPOSPPSASMw05JSnqdlaxQtU3gf/
         N/U9S1ojWo/8qVIGZETG+aAw3rQ++Qf7BvKmAyJsOt28rbzBzFloi2Ep/1YJ9GGDetwF
         oPoM9mNr3X/FeeuaY5bD9NuRApfSxeUyNjCspkf6DdKpsTCeYr0v2wJ+MaDBs4ooejmU
         wb7F6LnyyvwFmWMEWJGFEf0G9SGzqwRkh6mU8SwO8Xn9HkR9e0VxXeYmFNbMdaHgNKaV
         OsJpTGHuz34AIsJZCRfNzsLjTcSlaLvJqGe+G4hia35v3431AdgHF51pjfndieYYTix8
         1+9g==
X-Forwarded-Encrypted: i=1; AJvYcCU7+B5aUjPQqqjigTDzLZU6mAI50S/OFqQaD1nZDVTdlsh6y3Nox/tJWgBIi62iudrQ6uM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZo0I3PsYggKiu4TIbuvfurRgwByEW0MNBPpiPLGRFQMfZyCz5
	y5yBhNqsjH7M2MsSOB32rDXBW7BiGJg1V3sEe857v8CQUcAZmoQzDQ5aZb6/mYU5Ka4=
X-Gm-Gg: ASbGncsV8Gp3dJMRG9unRUi84tePm3Mt4qle+I4gsZ7Ay+kvTgSf87Gph4bzO5vSt72
	Smlc4Yi0WLirXsKnA/Iruw6rGnpTMNdmBJQGc8nAV/7Zsyjb+cP5TtOIqbMlqmgtHIsc3WSlIKC
	Jf3ORnOF+IVKhXtcoc5ty80SA9TISMB8bNwtugwSH6xgXis26Th50jBxEEqN590tIF4c773eOmM
	9+bT19/tIqJ+9uKexgYeoITrvMJqCbxTH6MntYtbQxLS2zzI3fHoWWpS6Jzdu+faMhunLKjfims
	DK57gJWBkp2i2KlfLOVPrZzF5OrztDQY4qA9pMvfv/uRlftHXTPbJ6M/8eqT0uKqXqZZNvPPT9F
	iSFEjJTo7TXBvX7WmmmdaBLXHIKhl00m5lRr8GRjMeO1Auf/76uH9wsp51AQkFaTD8Fy3Bw9QuK
	LWn0Xj76IVCOGUPU/UygHcW0IGWG8=
X-Google-Smtp-Source: AGHT+IGwLyfOcKohWhkx4wsLXmUqJy8CxtZzVuBRUWq8FkbjIG+P5Po6itxt7NmRJiyuHIpiKAEfBw==
X-Received: by 2002:a05:6a00:10c6:b0:7aa:d1d4:bb68 with SMTP id d2e1a72fcca58-7c58e112cb4mr17344571b3a.20.1764147032313;
        Wed, 26 Nov 2025 00:50:32 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f023fd82sm20885721b3a.42.2025.11.26.00.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 00:50:31 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: ast@kernel.org,
	andrii.nakryiko@gmail.com
Cc: eddyz87@gmail.com,
	zhangxiaoqin@xiaomi.com,
	ihor.solodrai@linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	pengdonglin <pengdonglin@xiaomi.com>
Subject: [RFC bpf-next v8 0/9] Improve the performance of BTF type lookups with binary search
Date: Wed, 26 Nov 2025 16:50:16 +0800
Message-Id: <20251126085025.784288-1-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: pengdonglin <pengdonglin@xiaomi.com>

This patch series introduces significant performance improvements (~2855x)
for BTF type lookups by implementing type permutation and binary search
optimizations.

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
Patches #8-#9 optimize type lookup performance of two kernel functions.

Here is a simple performance result [1] to find 60,995 named types in vmlinux
BTF:
./vmtest.sh -- ./test_progs -t btf_permute/perf -v

Results:
| Condition          | Lookup Time | Improvement  |
|--------------------|-------------|--------------|
| Unsorted (Linear)  | 27,697.4 ms | Baseline     |
| Sorted (Binary)    |      9.7 ms | 2855x faster |

The binary search implementation reduces lookup time from 27.7 seconds to 9.7
milliseconds, achieving a **2855x** speedup for large-scale type queries.

Changelog:
v8:  
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

pengdonglin (9):
  libbpf: Add BTF permutation support for type reordering
  selftests/bpf: Add test cases for btf__permute functionality
  tools/resolve_btfids: Support BTF sorting feature
  libbpf: Optimize type lookup with binary search for sorted BTF
  libbpf: Verify BTF Sorting
  btf: Optimize type lookup with binary search
  btf: Verify BTF Sorting
  bpf: Optimize the performance of find_btf_percpu_datasec
  bpf: Optimize the performance of find_bpffs_btf_enums

 include/linux/btf.h                           |   1 +
 kernel/bpf/btf.c                              | 148 +++++++++-
 kernel/bpf/inode.c                            |  42 ++-
 kernel/bpf/verifier.c                         |   7 +-
 tools/bpf/resolve_btfids/main.c               |  68 +++++
 tools/lib/bpf/btf.c                           | 260 ++++++++++++++++--
 tools/lib/bpf/btf.h                           |  36 +++
 tools/lib/bpf/libbpf.map                      |   1 +
 .../selftests/bpf/prog_tests/btf_permute.c    | 228 +++++++++++++++
 9 files changed, 733 insertions(+), 58 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_permute.c

-- 
2.34.1


