Return-Path: <bpf+bounces-62449-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34143AF9CA5
	for <lists+bpf@lfdr.de>; Sat,  5 Jul 2025 01:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43FC94867EE
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 23:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD98C28C864;
	Fri,  4 Jul 2025 23:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxYAQqfC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D752CCDB
	for <bpf@vger.kernel.org>; Fri,  4 Jul 2025 23:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751670247; cv=none; b=MQDr0MEasZH4pcOvxJZYd0nlJ8eU3L5yodo+GfJNwkJ+in3yi7+kmqqRlzK7lsFC7t5rg/ocQvmL0fvFMcgFIDA+cS/Z9d6gEPu0kOCkvUAB0AeYTtT0Sy4i52todKU1NYq0d0GaX4WmE7efFluRbBDAwrkbFHzDWl++xBviH+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751670247; c=relaxed/simple;
	bh=F5UQ5Ng0U0nUOTuPSN7ZH3GWOetGBct9+/r3+sQ/Zhk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t2Tdb5yWpgou/B+lX1hyt4s7RNYeGY1ya8Z7COAnuMMSQdcC5cM1lZNF2vQmjMCy9GJxzjYcsCEBdRslCcO/FG9KaXbfCxelPZM9m/6fFCzOuxVnHAFNvnxtgY9EjUXuICf5lotiE38uEUd5UPqpXs9GCaK+cED6DANurib8y0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kxYAQqfC; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-235f9ea8d08so12298255ad.1
        for <bpf@vger.kernel.org>; Fri, 04 Jul 2025 16:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751670245; x=1752275045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ACvlk+vv2V+ANo5UgzIlsAia2+Z7enw1B4P8HpMcK5I=;
        b=kxYAQqfCeMz/dX4KdD821qsbl+E3rIPoZkIADf9v9WVtA5OS8HJnGLShc3fm7YJFzb
         iGxBnNPTqxr+L5mtNo6xAzemh0jpbKHm9C/1yZV8YNiUPbfawtF80iaYM0irj1lkHosu
         wzPf3b7XqXsRzB1qsmR6bJX7bbhDON7GGQFfYIx4f9bHTodDd2tAl8yGoB75AmjO9B9C
         sWkVsysDTgiLFQXf70AXw8CkQB0aEDcZY/e2jVXOAEwNRyTXFofqu41t0wxuF6jD4vVM
         a2pB90PvlYPKA74qHCpZ4ld2Kkc3L0oWEVbIhPYIJgWytlNVkjj/YcIq9Nz7bsNBOfEg
         m6vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751670245; x=1752275045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ACvlk+vv2V+ANo5UgzIlsAia2+Z7enw1B4P8HpMcK5I=;
        b=Zp4oxDkyLYicqocIA56lhjbifpLmQXsVIaBFDlWZvMT6Y7e7wMDQ+GicW2OIokBG+j
         +n/DcOGTwfzKjswa6hBo4khm3fekudTXjW1bh5sshsmONgyyYnBMoGNYL/Ob8k5y0Axx
         Ici4+OpgkdJao9Kc/9zvRxeOunvBu9F228NPIQmy6TPdv7EtiDvRPslvTI09XKAMvIWn
         2XaTYoHzcbHHyaTi9oGMJOO1xKdYkeMxSMCpsfDci+skbK1tMe2CPVpGOl+qR5lA0rxE
         eNiAu7HK8TQ9GFVC8mKPRspQrnO1Sow97d7Nnq8Y7sbBWHOdGmbre4DKHjSeyzv677Tl
         BcRg==
X-Gm-Message-State: AOJu0YwcjyV/iQyxCaMaLgiAKbD5g0BsXgUbXFe1AO7MbhB6/7na2glM
	uJV4sU0UjQlbRYcNXzy9sexODpr9M+U3bldBrqszQtsh0ZusS8+Z2NHNCAdP2w==
X-Gm-Gg: ASbGncvgNug4lYInadDYn4Fh1VthNPXMhAw14UnporD1YpsVy1Iii7k7U28R1zIWmT6
	l/v2gmfyBS7xQV+HeRC+V1byrATbVnXLeuGJFEHtMV2XBPQ6iddUtazhrkYD8ujkhBjXUUGTZLN
	Pe2bGHBxKsQoCxS5NLFPyWC4MbjCIqB+BQEAsY4MfeFKTprZDP0yTalwWJJkpg3yxIqPIsBqj7P
	gW9GjN8aEy6KsnbqpmfgVMgcYgZSgti8d0ANtLPdN8YH9/3U+cxgRj4vWV078tHysNTu38MU9xb
	DSxhL9TBPFOIinoVGbknVJZ1JNoTyu9vgGWWoblEj3nNQIUCoquJEZuO7A==
X-Google-Smtp-Source: AGHT+IHuDEybpav6BT+HmiDtou0XKz3ZRfnvv0PGHmIUJia+OtjOZXde80ukLhzTNS2+nDYEF0f9eg==
X-Received: by 2002:a17:902:e5c3:b0:234:a139:11fb with SMTP id d9443c01a7336-23c91007432mr3789945ad.27.1751670244778;
        Fri, 04 Jul 2025 16:04:04 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38f879d040sm1764447a12.44.2025.07.04.16.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 16:04:04 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 0/8] bpf: additional use-cases for untrusted PTR_TO_MEM
Date: Fri,  4 Jul 2025 16:03:46 -0700
Message-ID: <20250704230354.1323244-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch set introduces two usability enhancements leveraging
untrusted pointers to mem:
- When reading a pointer field from a PTR_TO_BTF_ID, the resulting
  value is now assumed to be PTR_TO_MEM|MEM_RDONLY|PTR_UNTRUSTED
  instead of SCALAR_VALUE, provided the pointer points to a primitive
  type.
- __arg_untrusted attribute for global function parameters,
  allowed for pointer arguments of both structural and primitive
  types:
  - For structural types, the attribute produces
    PTR_TO_BTF_ID|PTR_UNTRUSTED.
  - For primitive types, it yields
    PTR_TO_MEM|MEM_RDONLY|PTR_UNTRUSTED.

Here are examples enabled by the series:

  struct foo {
    int *arr;
  };
  ...
  p = bpf_core_cast(..., struct foo);
  bpf_for(i, 0, ...) {
    ... p->arr[i] ...       // load at any offset is allowed
  }

  int memcmp(void *a __arg_untrusted, void *b __arg_untrusted, size_t n) {
    bpf_for(i, 0, n)
      if (a[i] - b[i])      // load at any offset is allowed
        return ...;
    return 0;
  }

The patch-set was inspired by Anrii's series [1]. The goal of that
series was to define a generic global glob_match function, capable to
accept any pointer type:

  __weak int glob_match(const char *pat, const char *str);

  char filename_glob[32];

  void foo(...) {
    ...
    task = bpf_get_current_task_btf();
    filename = task->mm->exe_file->f_path.dentry->d_name.name;
    ... match_glob(filename_glob,  // pointer to map value
                   filename) ...   // scalar
  }

At the moment, there is no straightforward way to express such a
function. This patch-set makes it possible to define it as follows:

  __weak int glob_match(const char *pat __arg_untrusted,
                        const char *str __arg_untrusted);

[1] https://github.com/anakryiko/linux/tree/bpf-mem-cast

Changelog:
v1: https://lore.kernel.org/bpf/20250702224209.3300396-1-eddyz87@gmail.com/
v1 -> v2:
- Added safety check in btf_prepare_func_args() to ensure that only
  struct or primitive types could be combined with __arg_untrusted
  (Alexei).
- Removed unnecessary 'continue' btf_check_func_arg_match() (Alexei).
- Added test cases for __arg_untrusted pointers to enum and
  __arg_untrusted combined with non-kernel type (Kumar).
- Added acks from Kumar.

Eduard Zingerman (8):
  bpf: make makr_btf_ld_reg return error for unexpected reg types
  bpf: rdonly_untrusted_mem for btf id walk pointer leafs
  selftests/bpf: ptr_to_btf_id struct walk ending with primitive pointer
  bpf: attribute __arg_untrusted for global function parameters
  libbpf: __arg_untrusted in bpf_helpers.h
  selftests/bpf: test cases for __arg_untrusted
  bpf: support for void/primitive __arg_untrusted global func params
  selftests/bpf: tests for __arg_untrusted void * global func params

 include/linux/btf.h                           |   1 +
 kernel/bpf/btf.c                              |  57 +++++++-
 kernel/bpf/verifier.c                         |  77 +++++++---
 tools/lib/bpf/bpf_helpers.h                   |   1 +
 .../selftests/bpf/prog_tests/linked_list.c    |   2 +-
 .../bpf/progs/mem_rdonly_untrusted.c          |  31 ++++
 .../bpf/progs/verifier_global_ptr_args.c      | 134 ++++++++++++++++++
 7 files changed, 274 insertions(+), 29 deletions(-)

-- 
2.49.0


