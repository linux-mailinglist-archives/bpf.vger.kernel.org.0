Return-Path: <bpf+bounces-76257-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5983CAC482
	for <lists+bpf@lfdr.de>; Mon, 08 Dec 2025 08:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2E2503004519
	for <lists+bpf@lfdr.de>; Mon,  8 Dec 2025 07:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5795A3112AD;
	Mon,  8 Dec 2025 06:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGpfGpd2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3245531062D
	for <bpf@vger.kernel.org>; Mon,  8 Dec 2025 06:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765175041; cv=none; b=qLpyjdiVbNL6sa2zcqGVMr7F9MQM51PjLVYR3wlGjVRkvqx/e9rWp7umNWnKg148tgDvKk1AKgpzCrRzWExTGQBWYxeXDnhJARfV5KKEbEIILupHWFzCeHwViT8abHFjq3qb6McHricvy3+ElxcLoyrWySWKk60LOn/D0ZdEK0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765175041; c=relaxed/simple;
	bh=no6pHFz6QV+m78OzRgE53QNCmkZ+S6j4qpLVgMCXMR8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DQZnLFgDLkZqtGU9+e+jDvWx/qtFXLVFVTU72/XlTrldqDb8Ems8rN26X41VdPuEo8+meF3O+4hcsTwvx8OVt+kUGSiediDlbWHCZP8F7d9oMiKy+Zl+bvIcYoqLVyjFcf2Qjhb4q8BXe7T0oYOTDcf4iKsqEIlXbmbRQyZ9bmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dGpfGpd2; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-29808a9a96aso43334005ad.1
        for <bpf@vger.kernel.org>; Sun, 07 Dec 2025 22:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765175039; x=1765779839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lsZYUYLhb/9jE26mC2NIN9XpXV+PxRfvNx9GWDHK/bw=;
        b=dGpfGpd2LsevmTtcuXZylEq/ThoV8X/GNU4ORG4SmBBR3sSCPBOZhdHLBfz5O+e1c8
         qfU6w0Q6F5TDH4XmU3vkdNCEAvlqrq9ZV+tVz7IhSSrdwctwrBEOZAiI7QOoGv3Snnz3
         Wqe39lmu6vyPwVkzBmZnWuRNDpeoXZ323wwyoK8vq22MGrtbHRjJZIzsMvpKqMHVsDgZ
         f2hAKsODyVBArFjr2Zoi2KFq+/GAxJW93uG3uus41VZgUdMb2WZxxceKVA7y/fsEZKkc
         ukbQJAfgX7aO+XtCVwR+TWJGoBj5bX8vRRhXVBe/uKNJ5diAvNlYDMbsdYbb9BY6vpje
         oavg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765175039; x=1765779839;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lsZYUYLhb/9jE26mC2NIN9XpXV+PxRfvNx9GWDHK/bw=;
        b=w8TYV6RePZXXbh5uJ994qvuRB1ybR3ElOIoUDjcSDYvuMePRlErzMaYbGyNXwHuueR
         jvrwQOTl957fzGwOjg2JtYy7v+9ZiRdgLSH30ggviE59phiP7N4uUDBVwSuIpUWbzdHf
         mo4xfVDmRjNcIdPr/7MnrqTtYEtDuIELMg22UuFhYM1ZwtHYd02YbwpWUod8xCc86s1q
         AL4hRSMyFAZn02xhtCIlA03QjwOPkP1z5qxchRmiQgHwHuXzr+eLbt6ceNG+JeyMSvxD
         kIj1wiwBfnnhbd1neO7tDL2vUWhpBow+T82h08GEw11i/VjIAPEOCIScGS0M2tyTJd1H
         TPSw==
X-Forwarded-Encrypted: i=1; AJvYcCVqgpegqiugncOgTOHPueqENR8lnkStIJlHYpIaxfCGd8xIBkTvmFFvWIqiORMKCJXI484=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/0asej2YypN6dWE5x0OD33DW9ao3T7D2ceeSu5PCxDL3wVeSc
	qDRd227By3cxkwOMwJQAFPBTkILLECGWS3stdxNKRr0aNzISpnLgDBkX
X-Gm-Gg: ASbGncvudnJY7K3cr6r/EAyKnTDx/h6LfuQdiP0HgeAsiiPe0MQq8T/400nhVAIRLDy
	gT+xavseFZLufY/jtCft2vZSKSLNQxk5jsn7LdDIAntAW+2m0ELAlDpFR6AqKuoB/ymCsMsXkj1
	ZnRQA3p+myf2hhXRaCfeVF1CQEMsHJl6iZ7Ju0KwanYfKr+9sO+aA5eJ7R4Has0YgYXz3M2oAsh
	W8xoyjHGbF9nAb03scMZ4qt+B9nfnS6SUWS8XaU5MKiuK4vvaqbqw25WoBek8KhURfq4m8CsryC
	2TmsOaE/xuAA0YjxBDcOnoLmqDNL2saVbHF+rF0CjmeWb4yhASiDrE68e/ZcArZ0e1WJ8vhc+MM
	n088SYS9nQMghu1jPdjhpHT7A9vTBXa9Zcp8iGO/n5LD/X39BSvS0La4OQHZc8I2s+lh3/Bz+cC
	hsRmA8yCHlNEflIQkzpNpFE6BecR4=
X-Google-Smtp-Source: AGHT+IHcU2NM/BZxkY0PLpjOya9dzoZ+GIOFa8kPlIVbMm+YYxQbG3Cdae5F6/OFcQvATZNgd1cBVg==
X-Received: by 2002:a17:902:cf08:b0:271:479d:3de2 with SMTP id d9443c01a7336-29df59a86fdmr53716655ad.13.1765175039214;
        Sun, 07 Dec 2025 22:23:59 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae49ca1esm112555855ad.2.2025.12.07.22.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Dec 2025 22:23:58 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: ast@kernel.org,
	andrii.nakryiko@gmail.com
Cc: eddyz87@gmail.com,
	zhangxiaoqin@xiaomi.com,
	ihor.solodrai@linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	pengdonglin <pengdonglin@xiaomi.com>
Subject: [PATCH bpf-next v9 00/10] Improve the performance of BTF type lookups with binary search
Date: Mon,  8 Dec 2025 14:23:43 +0800
Message-Id: <20251208062353.1702672-1-dolinux.peng@gmail.com>
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
v9:
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


pengdonglin (10):
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

 include/linux/btf.h                           |   1 +
 kernel/bpf/btf.c                              | 158 ++++++++-
 kernel/bpf/inode.c                            |  42 ++-
 kernel/bpf/verifier.c                         |   7 +-
 tools/bpf/resolve_btfids/main.c               |  68 ++++
 tools/lib/bpf/btf.c                           | 302 ++++++++++++++++--
 tools/lib/bpf/btf.h                           |  36 +++
 tools/lib/bpf/libbpf.map                      |   1 +
 .../selftests/bpf/prog_tests/btf_permute.c    | 228 +++++++++++++
 9 files changed, 766 insertions(+), 77 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_permute.c

-- 
2.34.1


