Return-Path: <bpf+bounces-55303-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C33A7B68A
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 05:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B66EF17B3CA
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 03:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BE84315A;
	Fri,  4 Apr 2025 03:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGXzCiRt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B9884D34
	for <bpf@vger.kernel.org>; Fri,  4 Apr 2025 03:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743735756; cv=none; b=BZG/FbuRJZwdKYUHmNCzCKi6Mmifr068+27Z82b3ow9Rf70GmMqt5ghpE1XEG5s6jZUWwTNvaQ1PUBORyWS9kVfIvBQImTXcmqsV10aRA2i6TU6zM9kcVL+1e834hH7afRuZvrRPsLMye6Jh0TAo64Y7pAhew62Wj6YvfYGc6bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743735756; c=relaxed/simple;
	bh=xW9fvGngFVBQ2G2zezuS/QC/cMPQB9rMIV+c0sfQXrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qk03nfyi0UHjT78yokS9CsZhINmZfJVavDC67UuGBud2zXKEYBgrfrVgRpfv6pq6Zh9MlsY8cafs5B6C8UKB838DMoI0TrpdEGyUA2sM6WN56KkdonRP0CvrSoGmRVYnfLow+Wh/WHDoBr8q6frsKEgJd4COw2YLc6a9lP7FFLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CGXzCiRt; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-736c3e7b390so1491154b3a.2
        for <bpf@vger.kernel.org>; Thu, 03 Apr 2025 20:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743735754; x=1744340554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XJhmjo6w/e/TUlScG2gbMvQUNrBq1CNXsxg7XvXF1iI=;
        b=CGXzCiRtbd+R0JeRrC8+NAV6pvapx/W2yXcu8bJ+iiE+zHVpLzdyKAcqtOjDCy/Tn1
         Xokbp2J2EXdQwzccSgt6ABvE71qNshb1LvovXvRNImkKT+84BwcF0U5nF/MqRPmcUKyF
         944VAQesSrWPU9rmMf++z1nVSg3YHO+hWoii+HQ+QphIe2HxVgql1iaVNlre4OmrN0z/
         uIXL/mWi2ixvDUnKp67OpnbPqM45yrKVCGFouuka1MCeSUYUo2/Zi9h9fiS+BsHUqKx/
         gXDzP0M7sMWTfNsirIGyC5Bn3xq+fMFDmBrc+fv9G776erCuk90Gi4UBshy7SL1wOdIl
         Eisg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743735754; x=1744340554;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XJhmjo6w/e/TUlScG2gbMvQUNrBq1CNXsxg7XvXF1iI=;
        b=c0zDA+xVITJqcBdXlKHmywwcV9NbqkLGXElYES42U/XC9rQXPYz96kdE26X21knlNR
         +0lx5U6dx5e5Oo/DJpNOEnWtjUnTwRGEImxChjS13khwnyW/6Qd0mDLWOzl8AoLkPCD1
         P5wWpuOpt95Ef9XY8b3LWnAfnrbhPljtFDju2tWw0OlOKcMklLhpYAYR2LPuQymstEXg
         5xMr82JbGVB7g4MCM95E1wI8OanISqJr0pGlWBXk30ykxFHDXE45yx066NbgYTMRyGra
         N0dYmVB5/NeQDTPjHvJL6WZ4zCqvDkfpeKg4UTUAf2lhvJMlc+9yTJyDjVMNi+At8yyI
         XzRQ==
X-Gm-Message-State: AOJu0YwHcBuO81A062efmRrrLs182dM74c+mgUL7ZvEy5cUz6gD5J+n7
	6k7L5EIMNKJ6gPNyzKmpjfKwF0VeuY2I2YIyAtxEZgL8BoyzE6iOjDDdqQ==
X-Gm-Gg: ASbGncuQO8iNhK/Y0ZldEzOBYocY67vsqs563f8tPxXPooQvSYCKf3XSbC5rU5ZXocE
	CpSu2XU3RamwpCy07HnHHul0m4Up7mewPog8bJ4DghLkHjmL0Vszp4L7bn5Jfk4BUwKuMyzGOse
	eCTVhkmSVoKHv2TYCUNdzhLWmJS2cT4FVxTKZtvVFOvaILwja8lvgutyDURSk1ut/GUjT2ZyvfX
	XId/hCKep2TTYH3TynXnLDK/VPjC2DgysMRWu40KugZjWXD7cc+uzI8YVhTBW0jmW35mTSjrsfZ
	d7SdLOss4laHutnK86Ep1KaDu6sn2/0ORgeyb+qTd21Q1SScabxR6i7b1DEUieuCncv0LCu6gvx
	s89IUOtlyBeTA91rRFtI=
X-Google-Smtp-Source: AGHT+IGADsrzTu1I5qq0/mYj1sVda4kD9bGrswnMi0uGV3tdOoM08IWknxHrF2HbFYN0KW5ZZAgjgQ==
X-Received: by 2002:a05:6a00:179e:b0:735:d89c:4b9f with SMTP id d2e1a72fcca58-739e6e6fb3cmr1602270b3a.0.1743735754071;
        Thu, 03 Apr 2025 20:02:34 -0700 (PDT)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739d9ea0791sm2262954b3a.110.2025.04.03.20.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 20:02:33 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	tj@kernel.org,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [RFC PATCH v2 0/4] uptr KV store
Date: Thu,  3 Apr 2025 20:02:23 -0700
Message-ID: <20250404030227.2690759-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

* Overview *

The uptr KV store implements a key-value store based on existing bpf
features with one small change to the bpf verifier code. A motivation of
this work is to make rolling out a new bpf program with changes to map
value layouts easier. Currently, there is not a simple and easy way to do
it. One may try to create a new map that has the new map value layout,
copy old values into the new one, and then starts the new program.
However, this process is not trivial to automate. uptr KV store provides
an alternative to this. By replacing a structure in a map with the use of
KV store with multiple key-value pairs, changing map layout becomes just
adding/deleting key-value pairs. In addition, by maintaining a manifest
of key-value pairs, the roll out process can be more easily automated.

* Design & implementation *

- User space and bpf API

  The uptr KV store provides basic user space and bpf APIs (get/set/
  delete). In addition, there are APIs for managing space that are only
  provided to the user space. It is assume that all keys are known
  before deploying a bpf program. To use it, the user space program first
  needs to initialize the KV store by calling kv_store_init() with a
  list of key-value pairs, or initializes all key-value pairs using
  kv_store_set(). Then, the bpf program and user space program can start
  using the KV store. When rolling out a new bpf program, user space
  program can update the KV store with the updated list of key-value pairs
  by calling kv_store_update(). It will delete keys no longer exist, set
  new keys and update values. The example can be found in patch 4.

- Single global map lookup in KV store bpf API

  A use case of the KV store is to store per-task attributes (e.g., an 
  experiment flag, the priority of the task, etc.). While the KV store is
  not intended to be used as part of the data path, making it performant
  is a design goal so that it can be use in bpf programs sitting in some
  relatively hot paths. To achieve this, a key is to keep map lookups as
  little as possible. The current implementation only requires one task
  local storage lookup during one program invocation. Then, get/set/delete
  only involves memory accesses in the uptr regions in the task local
  storage.

  The uptr KV store mainly consists of two uptr regions, metadata and data.
  The metadata is an array of metadata indexed by key, where each metadata
  contains the page index and page offset and the size of the key-value
  pair. The data region are pages allocated on-demand for storing values,
  and one page is allocated initially.

  If using string key is desired, the metadata can be moved to a bpf
  hashmap indexed with string keys. However, this will add one hashmap
  lookup to every basic KV store operation.

- 1K max int keys; 1B - 4KB value

  The KV store is indexed by integer keys and the maximum number of keys
  supported is 1K. This is limited by the maximum number of metadata as
  shown below that can be stored in a 4KB uptr metadata array. The largest
  size of a value is also bound to 4KB for the same reason.

  struct kv_store_meta {
        __u32 page_off:12;
        __u32 size:12;
        __u32 init:1;
  }

- Growable storage backed by uptr

  To be able to accommodate future storage space needed for new key-value
  pairs or temporarily storing old and new key-value pairs at the same
  time during transition, the KV store is growable. This is possible as
  the KV store leverages uptr, which can be allocated in user space on
  demand.

- Variable-size data copy with dynptr

  get/set involves copying variable-size data between uptr region and
  stack. Since llvm does not support emitting bytecode for memcpy with
  variable size, byte-by-byte copy in a for loop needs to be used.
  This can be improved by using dynptr. Please refer to the patch 1 for
  details.


Changelog:
v1 -> v2
- Miscellaneous bug fixes
- Fix workarounds in bpf APIs
- Reduce 8 x 4K data pages to just one to save lookup time
- Only use dynptr for reading/writing value size other than 1, 4, 8
- Introduce kv_pairs, a list of key-value pairs, for initializing and
  updating kv_store
- Allocate just enough memory for metadata/data if kv_pairs is provided.
  Otherwise, create a 16-key, 256-byte value storage kv_store
- Change the second example to show how to manage kv_store from the
  user space

Amery Hung (4):
  bpf: Allow creating dynptr from uptr
  selftests/bpf: Implement basic uptr KV store
  selftests/bpf: Test basic uptr KV store APIs from user space and bpf
  selftests/bpf: Test updating KV store layout when rolling out new prog

 include/uapi/linux/bpf.h                      |   4 +-
 kernel/bpf/verifier.c                         |   3 +-
 .../bpf/prog_tests/test_uptr_kv_store.c       | 259 ++++++++++++++
 .../selftests/bpf/prog_tests/uptr_kv_store.c  | 329 ++++++++++++++++++
 .../selftests/bpf/prog_tests/uptr_kv_store.h  | 103 ++++++
 .../selftests/bpf/progs/test_uptr_kv_store.c  |  44 +++
 .../bpf/progs/test_uptr_kv_store_v1.c         |  44 +++
 .../selftests/bpf/progs/uptr_kv_store.h       | 127 +++++++
 .../selftests/bpf/test_uptr_kv_store_common.h |  22 ++
 .../selftests/bpf/uptr_kv_store_common.h      |  37 ++
 10 files changed, 970 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_uptr_kv_store.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/uptr_kv_store.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/uptr_kv_store.h
 create mode 100644 tools/testing/selftests/bpf/progs/test_uptr_kv_store.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_uptr_kv_store_v1.c
 create mode 100644 tools/testing/selftests/bpf/progs/uptr_kv_store.h
 create mode 100644 tools/testing/selftests/bpf/test_uptr_kv_store_common.h
 create mode 100644 tools/testing/selftests/bpf/uptr_kv_store_common.h

-- 
2.47.1


